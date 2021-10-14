// type assert explicitly for typescript
export default function assert(condition: any, msg?: string): asserts condition {
  if (!condition) {
    throw new Error(`assert(): ${msg || 'assertion failed'}`);
  }
}
