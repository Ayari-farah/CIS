/** ML API uses placeholders like "none" / "pending" when no trained model is available. */
export function isMeaningfulModelVersion(v: string | undefined | null): boolean {
  if (v == null || typeof v !== 'string') {
    return false;
  }
  const t = v.trim().toLowerCase();
  return t !== '' && t !== 'none' && t !== 'pending';
}
