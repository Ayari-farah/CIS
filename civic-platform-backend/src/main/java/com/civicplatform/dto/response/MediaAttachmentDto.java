package com.civicplatform.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MediaAttachmentDto {

    private Long id;
    /** IMAGE or VIDEO */
    private String kind;
    /** Relative API path, e.g. /posts/1/attachments/2 */
    private String url;
}
