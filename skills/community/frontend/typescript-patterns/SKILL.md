---
name: typescript-patterns
description: Advanced TypeScript design patterns and type-level programming techniques. Covers utility types, discriminated unions, builder patterns, type guards, branded types, and more. Use when writing complex TypeScript code or designing type-safe APIs.
---

# TypeScript Advanced Patterns

This skill covers advanced TypeScript patterns for building type-safe, maintainable applications.

## When to Use This Skill

Use this skill when the user:

- Needs help with complex TypeScript types
- Wants to design a type-safe API
- Asks about discriminated unions or type guards
- Needs to create utility types
- Wants to implement common design patterns in TypeScript
- Is working with generics and conditional types

## Discriminated Unions

Use discriminated unions for state machines and action handling:

```typescript
type AsyncState<T> =
  | { status: 'idle' }
  | { status: 'loading' }
  | { status: 'success'; data: T }
  | { status: 'error'; error: Error }

function renderState<T>(state: AsyncState<T>) {
  switch (state.status) {
    case 'idle':
      return 'Ready'
    case 'loading':
      return 'Loading...'
    case 'success':
      return `Data: ${state.data}`
    case 'error':
      return `Error: ${state.error.message}`
  }
}
```

## Type Guards

```typescript
interface Dog {
  kind: 'dog'
  bark(): void
}

interface Cat {
  kind: 'cat'
  meow(): void
}

type Animal = Dog | Cat

function isDog(animal: Animal): animal is Dog {
  return animal.kind === 'dog'
}

function handleAnimal(animal: Animal) {
  if (isDog(animal)) {
    animal.bark() // TypeScript knows it's a Dog
  } else {
    animal.meow() // TypeScript knows it's a Cat
  }
}
```

## Branded Types

Prevent accidental mixing of structurally identical types:

```typescript
type Brand<T, B extends string> = T & { __brand: B }

type UserId = Brand<string, 'UserId'>
type OrderId = Brand<string, 'OrderId'>

function createUserId(id: string): UserId {
  return id as UserId
}

function createOrderId(id: string): OrderId {
  return id as OrderId
}

function getUser(id: UserId) { /* ... */ }
function getOrder(id: OrderId) { /* ... */ }

const userId = createUserId('u-123')
const orderId = createOrderId('o-456')

getUser(userId)    // OK
// getUser(orderId) // Compile error!
```

## Builder Pattern

```typescript
class QueryBuilder<T extends Record<string, unknown>> {
  private filters: Partial<T> = {}
  private sortField?: keyof T
  private sortOrder: 'asc' | 'desc' = 'asc'
  private limitValue?: number

  where<K extends keyof T>(field: K, value: T[K]): this {
    this.filters[field] = value
    return this
  }

  orderBy(field: keyof T, order: 'asc' | 'desc' = 'asc'): this {
    this.sortField = field
    this.sortOrder = order
    return this
  }

  limit(n: number): this {
    this.limitValue = n
    return this
  }

  build() {
    return {
      filters: this.filters,
      sort: this.sortField
        ? { field: this.sortField, order: this.sortOrder }
        : undefined,
      limit: this.limitValue,
    }
  }
}

interface User {
  name: string
  age: number
  role: 'admin' | 'user'
}

const query = new QueryBuilder<User>()
  .where('role', 'admin')
  .where('age', 30)
  .orderBy('name', 'desc')
  .limit(10)
  .build()
```

## Utility Types Cookbook

```typescript
// Make specific fields required
type RequireFields<T, K extends keyof T> = T & Required<Pick<T, K>>

// Deep partial
type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P]
}

// Extract function parameter types
type FirstParam<F> = F extends (first: infer A, ...rest: any[]) => any
  ? A
  : never

// Strict omit (ensures key exists)
type StrictOmit<T, K extends keyof T> = Pick<T, Exclude<keyof T, K>>

// Record with specific value type per key
type TypedRecord<K extends string, V extends Record<K, unknown>> = {
  [P in K]: V[P]
}
```

## Exhaustive Checks

```typescript
function assertNever(value: never): never {
  throw new Error(`Unexpected value: ${value}`)
}

type Shape = 'circle' | 'square' | 'triangle'

function getArea(shape: Shape): number {
  switch (shape) {
    case 'circle':
      return Math.PI * 10 * 10
    case 'square':
      return 10 * 10
    case 'triangle':
      return (10 * 10) / 2
    default:
      return assertNever(shape)
  }
}
```
