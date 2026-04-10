package com.civicplatform.service.impl;

import com.civicplatform.entity.User;
import com.civicplatform.enums.Badge;
import com.civicplatform.enums.UserType;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.EnumMap;
import java.util.List;
import java.util.Locale;

@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {

    private static final float PAGE_W = 595f;
    private static final float PAGE_H = 842f;
    private static final float MARGIN = 40f;
    private static final float HEADER_H = 60f;
    private static final float FOOTER_H = 28f;
    /** Match structured metrics export (A4 user report). */
    private static final float ROW_H = 20f;
    private static final float SECTION_TITLE_H = 26f;
    private static final float SECTION_GAP = 16f;
    private static final float[] SECTION_BAR_FILL = {0.90f, 0.95f, 0.93f};
    private static final float[] SECTION_BAR_STROKE = {0.55f, 0.75f, 0.68f};
    private static final float[] SECTION_TEXT = {0.04f, 0.32f, 0.22f};
    private static final float[] TABLE_HEADER_BG = {0.04f, 0.42f, 0.31f};
    private static final float[] ZEBRA_A = {1f, 1f, 1f};
    private static final float[] ZEBRA_B = {0.945f, 0.957f, 0.976f};
    private static final float[] GRID_STROKE = {0.80f, 0.82f, 0.85f};
    private static final float[] BODY_TEXT = {0.18f, 0.20f, 0.24f};
    /** ID, full name, username, email, created at */
    private static final float[] COL_WIDTHS = {38f, 132f, 88f, 198f, 74f};
    private static final float Y_FLOOR = FOOTER_H + 28f;

    private final UserRepository userRepository;

    private static String pdfSafe(String s) {
        if (s == null) {
            return "";
        }
        String t = s.replace('\u2192', '-').replace('\u2014', '-').replace('\u2013', '-');
        StringBuilder out = new StringBuilder(t.length());
        for (int i = 0; i < t.length(); i++) {
            char c = t.charAt(i);
            out.append(c <= 0xFF ? c : '?');
        }
        return out.toString();
    }

    @Override
    public byte[] generateReport(LocalDate from, LocalDate to, UserType type, String format) {
        if (from.isAfter(to)) {
            throw new IllegalStateException("Invalid date range: 'from' must be before or equal to 'to'");
        }
        String f = format != null ? format.trim().toLowerCase(Locale.ROOT) : "";
        if (!"pdf".equals(f) && !"csv".equals(f)) {
            throw new IllegalStateException("Format must be 'pdf' or 'csv'");
        }

        LocalDateTime fromDt = from.atStartOfDay();
        LocalDateTime toDt = to.atTime(23, 59, 59, 999_999_999);
        List<User> users = userRepository.findByDateRangeAndType(fromDt, toDt, type);

        if ("csv".equals(f)) {
            return generateCsv(users, from, to, type);
        }
        return generatePdf(users, from, to, type);
    }

    private record GroupedUsers(EnumMap<UserType, List<User>> byType, List<User> unknownType) {}

    private GroupedUsers groupUsersByType(List<User> users) {
        EnumMap<UserType, List<User>> map = new EnumMap<>(UserType.class);
        for (UserType ut : UserType.values()) {
            map.put(ut, new ArrayList<>());
        }
        List<User> unknown = new ArrayList<>();
        for (User u : users) {
            if (u.getUserType() == null) {
                unknown.add(u);
            } else {
                map.get(u.getUserType()).add(u);
            }
        }
        Comparator<User> byId = Comparator.comparing(User::getId, Comparator.nullsLast(Long::compareTo));
        for (List<User> list : map.values()) {
            list.sort(byId);
        }
        unknown.sort(byId);
        return new GroupedUsers(map, unknown);
    }

    private byte[] generateCsv(List<User> users, LocalDate from, LocalDate to, UserType type) {
        String typeLabel = type != null ? type.name() : "ALL";
        String today = LocalDate.now().toString();
        StringBuilder sb = new StringBuilder();
        sb.append("Civic Platform - User activity report\n");
        sb.append("Period: ").append(from).append(" to ").append(to).append('\n');
        sb.append("Type filter: ").append(typeLabel).append('\n');
        sb.append("Generated on: ").append(today).append('\n');
        sb.append("Total records: ").append(users.size()).append('\n');
        sb.append('\n');

        GroupedUsers grouped = groupUsersByType(users);
        sb.append("Columns: ID, Full name, Username, Email, Registered at\n\n");

        for (UserType ut : UserType.values()) {
            List<User> list = grouped.byType().get(ut);
            if (list == null || list.isEmpty()) {
                continue;
            }
            sb.append("=== ").append(ut.name()).append(" (").append(list.size()).append(") ===\n");
            sb.append("ID,Full name,Username,Email,Registered at\n");
            for (User u : list) {
                sb.append(csvCell(u.getId())).append(',');
                sb.append(csvCell(fullName(u))).append(',');
                sb.append(csvCell(u.getUserName())).append(',');
                sb.append(csvCell(u.getEmail())).append(',');
                sb.append(csvCell(u.getCreatedAt() != null ? u.getCreatedAt().toString() : ""));
                sb.append('\n');
            }
            sb.append('\n');
        }
        if (!grouped.unknownType().isEmpty()) {
            sb.append("=== UNSPECIFIED TYPE (").append(grouped.unknownType().size()).append(") ===\n");
            sb.append("ID,Full name,Username,Email,Registered at\n");
            for (User u : grouped.unknownType()) {
                sb.append(csvCell(u.getId())).append(',');
                sb.append(csvCell(fullName(u))).append(',');
                sb.append(csvCell(u.getUserName())).append(',');
                sb.append(csvCell(u.getEmail())).append(',');
                sb.append(csvCell(u.getCreatedAt() != null ? u.getCreatedAt().toString() : ""));
                sb.append('\n');
            }
        }
        EnumMap<Badge, Integer> badgeDist = new EnumMap<>(Badge.class);
        for (Badge b : Badge.values()) {
            badgeDist.put(b, 0);
        }
        for (User u : users) {
            Badge b = u.getBadge() != null ? u.getBadge() : Badge.NONE;
            badgeDist.merge(b, 1, Integer::sum);
        }
        sb.append('\n');
        sb.append(formatBadgesInlineLine(badgeDist)).append('\n');
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private static String csvCell(Object value) {
        String s = value == null ? "" : String.valueOf(value);
        if (s.contains(",") || s.contains("\"") || s.contains("\n") || s.contains("\r")) {
            return "\"" + s.replace("\"", "\"\"") + "\"";
        }
        return s;
    }

    private byte[] generatePdf(List<User> users, LocalDate from, LocalDate to, UserType type) {
        try {
            return generatePdfInternal(users, from, to, type);
        } catch (IOException e) {
            throw new IllegalStateException("Failed to generate report PDF", e);
        }
    }

    private byte[] generatePdfInternal(List<User> users, LocalDate from, LocalDate to, UserType type) throws IOException {
        PDType1Font bold = new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD);
        PDType1Font regular = new PDType1Font(Standard14Fonts.FontName.HELVETICA);
        GroupedUsers grouped = groupUsersByType(users);

        try (PDDocument doc = new PDDocument();
             ByteArrayOutputStream out = new ByteArrayOutputStream()) {

            int[] pageNum = {0};

            if (users.isEmpty()) {
                PDPage page = new PDPage(new PDRectangle(PAGE_W, PAGE_H));
                doc.addPage(page);
                pageNum[0]++;
                try (PDPageContentStream cs = new PDPageContentStream(doc, page)) {
                    drawPageHeader(cs, bold, type, pageNum[0]);
                    drawReportMeta(cs, regular, from, to, users.size(), true);
                    float y = PAGE_H - HEADER_H - 100f;
                    cs.setNonStrokingColor(0.392f, 0.455f, 0.545f);
                    cs.beginText();
                    cs.setFont(regular, 12f);
                    cs.newLineAtOffset(MARGIN, y);
                    cs.showText(pdfSafe("No users registered in this period for the selected filter."));
                    cs.endText();
                    drawPageFooter(cs, regular, pageNum[0]);
                }
            } else {
                PDPage page = new PDPage(new PDRectangle(PAGE_W, PAGE_H));
                doc.addPage(page);
                pageNum[0]++;
                PdfState st = new PdfState();
                st.cs = new PDPageContentStream(doc, page);
                drawPageHeader(st.cs, bold, type, pageNum[0]);
                drawReportMeta(st.cs, regular, from, to, users.size(), true);
                st.y = PAGE_H - HEADER_H - 118f;

                for (UserType ut : UserType.values()) {
                    List<User> sectionUsers = grouped.byType().get(ut);
                    if (sectionUsers == null || sectionUsers.isEmpty()) {
                        continue;
                    }
                    st = writeUserTypeSection(doc, st, bold, regular, type, pageNum, ut, sectionUsers);
                }
                if (!grouped.unknownType().isEmpty()) {
                    st = writeUserTypeSection(doc, st, bold, regular, type, pageNum, null, grouped.unknownType());
                }

                drawPageFooter(st.cs, regular, pageNum[0]);
                st.cs.close();

                pageNum[0]++;
                PDPage summaryPage = new PDPage(new PDRectangle(PAGE_W, PAGE_H));
                doc.addPage(summaryPage);
                try (PDPageContentStream cs2 = new PDPageContentStream(doc, summaryPage)) {
                    drawPageHeader(cs2, bold, type, pageNum[0]);
                    drawSummaryPage(cs2, bold, regular, users);
                    drawPageFooter(cs2, regular, pageNum[0]);
                }
            }

            doc.save(out);
            return out.toByteArray();
        }
    }

    private static final class PdfState {
        PDPageContentStream cs;
        float y;
    }

    /**
     * Writes one user-type block (or unknown if {@code ut} is null). Handles pagination.
     */
    private PdfState writeUserTypeSection(PDDocument doc, PdfState state, PDType1Font bold, PDType1Font regular,
                                          UserType filterType, int[] pageNum, UserType ut, List<User> sectionUsers)
            throws IOException {
        PDPageContentStream cs = state.cs;
        float y = state.y;
        String sectionLabel = ut != null ? ut.name() : "UNSPECIFIED TYPE";

        if (y < Y_FLOOR + SECTION_TITLE_H + ROW_H + ROW_H) {
            drawPageFooter(cs, regular, pageNum[0]);
            cs.close();
            PDPage page = new PDPage(new PDRectangle(PAGE_W, PAGE_H));
            doc.addPage(page);
            pageNum[0]++;
            cs = new PDPageContentStream(doc, page);
            drawPageHeader(cs, bold, filterType, pageNum[0]);
            drawContinuationBanner(cs, regular);
            y = PAGE_H - HEADER_H - 48f;
        }

        y = drawSectionTitle(cs, bold, sectionLabel, sectionUsers.size(), y);
        y -= 6f;
        drawUserTableHeader(cs, bold, y);
        y -= ROW_H;

        int rowIdx = 0;
        for (User u : sectionUsers) {
            if (y < Y_FLOOR + ROW_H) {
                drawPageFooter(cs, regular, pageNum[0]);
                cs.close();
                PDPage page = new PDPage(new PDRectangle(PAGE_W, PAGE_H));
                doc.addPage(page);
                pageNum[0]++;
                cs = new PDPageContentStream(doc, page);
                drawPageHeader(cs, bold, filterType, pageNum[0]);
                drawContinuationBanner(cs, regular);
                y = PAGE_H - HEADER_H - 48f;
                y = drawSectionTitle(cs, bold, sectionLabel + " (continued)", sectionUsers.size(), y);
                y -= 6f;
                drawUserTableHeader(cs, bold, y);
                y -= ROW_H;
            }
            drawUserDataRow(cs, regular, u, y, rowIdx % 2 == 0);
            y -= ROW_H;
            rowIdx++;
        }
        y -= SECTION_GAP;
        PdfState out = new PdfState();
        out.cs = cs;
        out.y = y;
        return out;
    }

    private void drawContinuationBanner(PDPageContentStream cs, PDType1Font regular) throws IOException {
        cs.setNonStrokingColor(0.55f, 0.58f, 0.62f);
        cs.beginText();
        cs.setFont(regular, 10f);
        cs.newLineAtOffset(MARGIN, PAGE_H - HEADER_H - 28f);
        cs.showText(pdfSafe("Report continued"));
        cs.endText();
    }

    private float drawSectionTitle(PDPageContentStream cs, PDType1Font bold, String title, int count, float y)
            throws IOException {
        float titleBottom = y - SECTION_TITLE_H;
        cs.setNonStrokingColor(SECTION_BAR_FILL[0], SECTION_BAR_FILL[1], SECTION_BAR_FILL[2]);
        cs.addRect(MARGIN, titleBottom, PAGE_W - 2 * MARGIN, SECTION_TITLE_H);
        cs.fill();
        cs.setStrokingColor(SECTION_BAR_STROKE[0], SECTION_BAR_STROKE[1], SECTION_BAR_STROKE[2]);
        cs.setLineWidth(0.75f);
        cs.addRect(MARGIN, titleBottom, PAGE_W - 2 * MARGIN, SECTION_TITLE_H);
        cs.stroke();
        cs.setNonStrokingColor(SECTION_TEXT[0], SECTION_TEXT[1], SECTION_TEXT[2]);
        cs.beginText();
        cs.setFont(bold, 11f);
        cs.newLineAtOffset(MARGIN + 10f, titleBottom + 9f);
        cs.showText(pdfSafe(title + "  -  " + count + " user(s)"));
        cs.endText();
        return titleBottom - 6f;
    }

    private float[] columnBoundaryXs() {
        float[] xs = new float[6];
        xs[0] = MARGIN;
        for (int i = 0; i < 5; i++) {
            xs[i + 1] = xs[i] + COL_WIDTHS[i];
        }
        return xs;
    }

    /** Dark green header row, white labels, grid lines (matches metrics export). */
    private void drawUserTableHeader(PDPageContentStream cs, PDType1Font bold, float topY) throws IOException {
        float bottom = topY - ROW_H;
        float tableW = PAGE_W - 2 * MARGIN;
        cs.setNonStrokingColor(TABLE_HEADER_BG[0], TABLE_HEADER_BG[1], TABLE_HEADER_BG[2]);
        cs.addRect(MARGIN, bottom, tableW, ROW_H);
        cs.fill();
        float[] xs = columnBoundaryXs();
        for (int i = 1; i <= 4; i++) {
            cs.setStrokingColor(GRID_STROKE[0], GRID_STROKE[1], GRID_STROKE[2]);
            cs.setLineWidth(0.4f);
            cs.moveTo(xs[i], bottom);
            cs.lineTo(xs[i], topY);
            cs.stroke();
        }
        String[] headers = {"ID", "Full name", "Username", "Email", "Registered"};
        float x = MARGIN;
        cs.setNonStrokingColor(1f, 1f, 1f);
        for (int i = 0; i < 5; i++) {
            cs.beginText();
            cs.setFont(bold, 9f);
            cs.newLineAtOffset(x + 4f, bottom + 6f);
            cs.showText(pdfSafe(headers[i]));
            cs.endText();
            x += COL_WIDTHS[i];
        }
        cs.setStrokingColor(0.55f, 0.70f, 0.62f);
        cs.setLineWidth(0.75f);
        cs.addRect(MARGIN, bottom, tableW, ROW_H);
        cs.stroke();
    }

    private void drawUserDataRow(PDPageContentStream cs, PDType1Font regular, User u, float rowTop, boolean zebraA)
            throws IOException {
        float bottom = rowTop - ROW_H;
        float tableW = PAGE_W - 2 * MARGIN;
        float[] fill = zebraA ? ZEBRA_A : ZEBRA_B;
        cs.setNonStrokingColor(fill[0], fill[1], fill[2]);
        cs.addRect(MARGIN, bottom, tableW, ROW_H);
        cs.fill();
        float[] xs = columnBoundaryXs();
        for (int i = 1; i <= 4; i++) {
            cs.setStrokingColor(GRID_STROKE[0], GRID_STROKE[1], GRID_STROKE[2]);
            cs.setLineWidth(0.4f);
            cs.moveTo(xs[i], bottom);
            cs.lineTo(xs[i], rowTop);
            cs.stroke();
        }
        cs.setStrokingColor(GRID_STROKE[0], GRID_STROKE[1], GRID_STROKE[2]);
        cs.setLineWidth(0.4f);
        cs.addRect(MARGIN, bottom, tableW, ROW_H);
        cs.stroke();

        String fullName = fullName(u);
        String email = u.getEmail() != null ? u.getEmail() : "";
        String created = u.getCreatedAt() != null
                ? u.getCreatedAt().format(DateTimeFormatter.ofPattern("dd/MM/yyyy", Locale.ENGLISH))
                : "";

        float fs = 9f;
        float x = MARGIN;
        String[] cells = {
                pdfSafe(String.valueOf(u.getId())),
                pdfSafe(fullName),
                pdfSafe(u.getUserName()),
                pdfSafe(email),
                pdfSafe(created)
        };
        for (int i = 0; i < 5; i++) {
            cs.setNonStrokingColor(BODY_TEXT[0], BODY_TEXT[1], BODY_TEXT[2]);
            cs.beginText();
            cs.setFont(regular, fs);
            cs.newLineAtOffset(x + 4f, bottom + 6f);
            cs.showText(ellipsize(regular, fs, cells[i], COL_WIDTHS[i] - 6f));
            cs.endText();
            x += COL_WIDTHS[i];
        }
    }

    private static String ellipsize(PDType1Font font, float size, String text, float maxW) throws IOException {
        if (text == null) {
            return "";
        }
        String ellipsis = "...";
        float ew = font.getStringWidth(ellipsis) / 1000f * size;
        if (font.getStringWidth(text) / 1000f * size <= maxW) {
            return text;
        }
        String t = text;
        while (t.length() > 0 && font.getStringWidth(t) / 1000f * size > maxW - ew) {
            t = t.substring(0, t.length() - 1);
        }
        return t + ellipsis;
    }

    private static String fullName(User u) {
        String fn = u.getFirstName() != null ? u.getFirstName() : "";
        String ln = u.getLastName() != null ? u.getLastName() : "";
        String c = (fn + " " + ln).trim();
        return c.isEmpty() ? (u.getUserName() != null ? u.getUserName() : "") : c;
    }

    private void drawPageHeader(PDPageContentStream cs, PDType1Font bold, UserType type, int pageNum) throws IOException {
        cs.setNonStrokingColor(0.06f, 0.45f, 0.32f);
        cs.addRect(0, PAGE_H - HEADER_H, PAGE_W, HEADER_H);
        cs.fill();

        cs.setNonStrokingColor(1f, 1f, 1f);
        String left = "Civic Platform";
        float fs = 14f;
        cs.beginText();
        cs.setFont(bold, fs);
        cs.newLineAtOffset(MARGIN, PAGE_H - HEADER_H / 2f - fs / 3f);
        cs.showText(pdfSafe(left));
        cs.endText();

        String typeOrAll = type != null ? type.name() : "ALL";
        String right = "User activity — " + typeOrAll;
        String rightPdf = pdfSafe(right);
        float rw = bold.getStringWidth(rightPdf) / 1000f * fs;
        cs.beginText();
        cs.setFont(bold, fs);
        cs.newLineAtOffset(PAGE_W - MARGIN - rw, PAGE_H - HEADER_H / 2f - fs / 3f);
        cs.showText(rightPdf);
        cs.endText();
    }

    private void drawReportMeta(PDPageContentStream cs, PDType1Font regular, LocalDate from, LocalDate to,
                                int count, boolean drawMeta) throws IOException {
        if (!drawMeta) {
            return;
        }
        float y = PAGE_H - HEADER_H - 28f;
        cs.setNonStrokingColor(0.392f, 0.455f, 0.545f);
        float fs = 11f;
        cs.beginText();
        cs.setFont(regular, fs);
        cs.newLineAtOffset(MARGIN, y);
        cs.showText(pdfSafe("Period: " + from + " to " + to));
        cs.endText();
        y -= 16f;
        cs.beginText();
        cs.setFont(regular, fs);
        cs.newLineAtOffset(MARGIN, y);
        cs.showText(pdfSafe("Generated: " + LocalDate.now()));
        cs.endText();
        y -= 16f;
        cs.beginText();
        cs.setFont(regular, fs);
        cs.newLineAtOffset(MARGIN, y);
        cs.showText(pdfSafe("Total users in this export: " + count));
        cs.endText();
    }

    private void drawPageFooter(PDPageContentStream cs, PDType1Font regular, int pageNum) throws IOException {
        cs.setStrokingColor(GRID_STROKE[0], GRID_STROKE[1], GRID_STROKE[2]);
        cs.setLineWidth(0.5f);
        cs.moveTo(0, FOOTER_H);
        cs.lineTo(PAGE_W, FOOTER_H);
        cs.stroke();
        cs.setNonStrokingColor(0.94f, 0.96f, 0.98f);
        cs.addRect(0, 0, PAGE_W, FOOTER_H);
        cs.fill();
        float fs = 8.5f;
        String left = "Civic Platform — Confidential user activity export";
        cs.setNonStrokingColor(0.45f, 0.48f, 0.52f);
        cs.beginText();
        cs.setFont(regular, fs);
        cs.newLineAtOffset(MARGIN, 10f);
        cs.showText(pdfSafe(left));
        cs.endText();
        String right = "Page " + pageNum;
        float rw = regular.getStringWidth(right) / 1000f * fs;
        cs.beginText();
        cs.setFont(regular, fs);
        cs.newLineAtOffset(PAGE_W - MARGIN - rw, 10f);
        cs.showText(right);
        cs.endText();
    }

    private static final float TWO_COL_HEADER_H = 22f;
    private static final float TWO_COL_ROW_H = 20f;

    /**
     * Same visual pattern as metrics PDF: pale section bar, dark green table header, zebra rows, borders.
     */
    private float drawTwoColumnSectionTable(PDPageContentStream cs, PDType1Font bold, PDType1Font regular,
                                          float yTop, String sectionTitle,
                                          String col1Header, String col2Header, String[][] rows) throws IOException {
        float titleBottom = yTop - SECTION_TITLE_H;
        cs.setNonStrokingColor(SECTION_BAR_FILL[0], SECTION_BAR_FILL[1], SECTION_BAR_FILL[2]);
        cs.addRect(MARGIN, titleBottom, PAGE_W - 2 * MARGIN, SECTION_TITLE_H);
        cs.fill();
        cs.setStrokingColor(SECTION_BAR_STROKE[0], SECTION_BAR_STROKE[1], SECTION_BAR_STROKE[2]);
        cs.setLineWidth(0.75f);
        cs.addRect(MARGIN, titleBottom, PAGE_W - 2 * MARGIN, SECTION_TITLE_H);
        cs.stroke();
        cs.setNonStrokingColor(SECTION_TEXT[0], SECTION_TEXT[1], SECTION_TEXT[2]);
        cs.beginText();
        cs.setFont(bold, 11f);
        cs.newLineAtOffset(MARGIN + 10f, titleBottom + 9f);
        cs.showText(pdfSafe(sectionTitle));
        cs.endText();

        float tableTop = titleBottom - 6f;
        float tableW = PAGE_W - 2 * MARGIN;
        float c1w = tableW * 0.58f;
        float xSplit = MARGIN + c1w;

        float hdrBottom = tableTop - TWO_COL_HEADER_H;
        cs.setNonStrokingColor(TABLE_HEADER_BG[0], TABLE_HEADER_BG[1], TABLE_HEADER_BG[2]);
        cs.addRect(MARGIN, hdrBottom, tableW, TWO_COL_HEADER_H);
        cs.fill();
        cs.setNonStrokingColor(1f, 1f, 1f);
        cs.beginText();
        cs.setFont(bold, 10f);
        cs.newLineAtOffset(MARGIN + 8f, hdrBottom + 7f);
        cs.showText(pdfSafe(col1Header));
        cs.endText();
        cs.beginText();
        cs.setFont(bold, 10f);
        cs.newLineAtOffset(xSplit + 8f, hdrBottom + 7f);
        cs.showText(pdfSafe(col2Header));
        cs.endText();
        cs.setStrokingColor(0.55f, 0.70f, 0.62f);
        cs.setLineWidth(0.5f);
        cs.moveTo(xSplit, hdrBottom);
        cs.lineTo(xSplit, tableTop);
        cs.stroke();

        float rowTop = hdrBottom;
        for (int i = 0; i < rows.length; i++) {
            float rb = rowTop - TWO_COL_ROW_H;
            boolean zebra = i % 2 == 0;
            cs.setNonStrokingColor(zebra ? 0.99f : 0.96f, zebra ? 0.99f : 0.97f, zebra ? 1f : 0.985f);
            cs.addRect(MARGIN, rb, tableW, TWO_COL_ROW_H);
            cs.fill();
            cs.setStrokingColor(GRID_STROKE[0], GRID_STROKE[1], GRID_STROKE[2]);
            cs.setLineWidth(0.4f);
            cs.addRect(MARGIN, rb, tableW, TWO_COL_ROW_H);
            cs.stroke();
            cs.setStrokingColor(GRID_STROKE[0], GRID_STROKE[1], GRID_STROKE[2]);
            cs.moveTo(xSplit, rb);
            cs.lineTo(xSplit, rowTop);
            cs.stroke();

            cs.setNonStrokingColor(BODY_TEXT[0], BODY_TEXT[1], BODY_TEXT[2]);
            cs.beginText();
            cs.setFont(regular, 9.5f);
            cs.newLineAtOffset(MARGIN + 8f, rb + 6f);
            cs.showText(pdfSafe(rows[i][0]));
            cs.endText();
            cs.beginText();
            cs.setFont(bold, 9.5f);
            cs.newLineAtOffset(xSplit + 8f, rb + 6f);
            cs.showText(pdfSafe(rows[i][1]));
            cs.endText();
            rowTop = rb;
        }

        float tableBottom = rowTop;
        cs.setStrokingColor(0.45f, 0.50f, 0.55f);
        cs.setLineWidth(1f);
        cs.addRect(MARGIN, tableBottom, tableW, tableTop - tableBottom);
        cs.stroke();

        return tableBottom - 18f;
    }

    private void drawSummaryPage(PDPageContentStream cs, PDType1Font bold, PDType1Font regular, List<User> users)
            throws IOException {
        float y = PAGE_H - HEADER_H - 28f;

        int total = users.size();
        long amb = users.stream().filter(u -> u.getUserType() == UserType.AMBASSADOR).count();
        long don = users.stream().filter(u -> u.getUserType() == UserType.DONOR).count();
        long cit = users.stream().filter(u -> u.getUserType() == UserType.CITIZEN).count();
        long part = users.stream().filter(u -> u.getUserType() == UserType.PARTICIPANT).count();

        EnumMap<Badge, Integer> dist = new EnumMap<>(Badge.class);
        for (Badge b : Badge.values()) {
            dist.put(b, 0);
        }
        for (User u : users) {
            Badge b = u.getBadge() != null ? u.getBadge() : Badge.NONE;
            dist.merge(b, 1, Integer::sum);
        }

        String[][] roleRows = {
                {"Total users in export", String.valueOf(total)},
                {"Ambassadors", String.valueOf(amb)},
                {"Donors", String.valueOf(don)},
                {"Citizens", String.valueOf(cit)},
                {"Participants", String.valueOf(part)}
        };
        y = drawTwoColumnSectionTable(cs, bold, regular, y, "Summary — users by role", "Metric", "Count", roleRows);

        String[][] badgeRows = new String[Badge.values().length][2];
        int bi = 0;
        for (Badge b : Badge.values()) {
            badgeRows[bi][0] = b.name();
            badgeRows[bi][1] = String.valueOf(dist.get(b));
            bi++;
        }
        y = drawTwoColumnSectionTable(cs, bold, regular, y, "Summary — badges in this export", "Badge", "Count", badgeRows);
        drawBadgeInlineRollup(cs, regular, y, dist);
    }

    /**
     * One-line rollup: {@code Badges in this export - PLATINUM: 0 | GOLD: 0 | SILVER: 0 | BRONZE: 1 | NONE: 11}
     */
    private static String formatBadgesInlineLine(EnumMap<Badge, Integer> dist) {
        return "Badges in this export - PLATINUM: " + dist.get(Badge.PLATINUM)
                + " | GOLD: " + dist.get(Badge.GOLD)
                + " | SILVER: " + dist.get(Badge.SILVER)
                + " | BRONZE: " + dist.get(Badge.BRONZE)
                + " | NONE: " + dist.get(Badge.NONE);
    }

    private void drawBadgeInlineRollup(PDPageContentStream cs, PDType1Font regular, float yTop,
                                     EnumMap<Badge, Integer> dist) throws IOException {
        float barH = 28f;
        float barBottom = yTop - barH;
        float w = PAGE_W - 2 * MARGIN;
        cs.setNonStrokingColor(0.93f, 0.97f, 0.95f);
        cs.addRect(MARGIN, barBottom, w, barH);
        cs.fill();
        cs.setStrokingColor(SECTION_BAR_STROKE[0], SECTION_BAR_STROKE[1], SECTION_BAR_STROKE[2]);
        cs.setLineWidth(0.75f);
        cs.addRect(MARGIN, barBottom, w, barH);
        cs.stroke();
        cs.setNonStrokingColor(BODY_TEXT[0], BODY_TEXT[1], BODY_TEXT[2]);
        cs.beginText();
        cs.setFont(regular, 9f);
        cs.newLineAtOffset(MARGIN + 10f, barBottom + 9f);
        cs.showText(pdfSafe(formatBadgesInlineLine(dist)));
        cs.endText();
    }
}
