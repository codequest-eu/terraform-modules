export function escapeId(value: string) {
  return `"${value.replace(/"/g, '""')}"`
}
