---
name: code-reviewer
description: Automated code review assistant that checks for common issues including security vulnerabilities, performance anti-patterns, code style violations, and maintainability concerns. Use when reviewing pull requests or auditing code quality.
---

# Code Review Assistant

This skill helps you perform thorough code reviews by checking for common issues across security, performance, maintainability, and best practices.

## When to Use This Skill

Use this skill when the user:

- Asks for a code review of their changes
- Wants to check code quality before a PR
- Needs help identifying potential bugs
- Asks about code review best practices
- Wants to establish code review guidelines for a team

## Review Checklist

### Security

- [ ] No hardcoded secrets, API keys, or passwords
- [ ] Input validation on all user inputs
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (output encoding)
- [ ] CSRF tokens where needed
- [ ] Proper authentication/authorization checks
- [ ] Sensitive data not logged
- [ ] Dependencies scanned for vulnerabilities

### Performance

- [ ] No N+1 query patterns
- [ ] Proper database indexing
- [ ] Pagination for list endpoints
- [ ] Expensive operations are cached
- [ ] No memory leaks (event listeners, intervals cleaned up)
- [ ] Lazy loading for heavy modules
- [ ] Avoid unnecessary re-renders (React)

### Code Quality

- [ ] Functions are small and focused (single responsibility)
- [ ] No duplicate code (DRY principle)
- [ ] Meaningful variable and function names
- [ ] Proper error handling with specific error types
- [ ] Edge cases are handled
- [ ] No commented-out code
- [ ] Type safety (no `any` in TypeScript)

### Maintainability

- [ ] Code is self-documenting
- [ ] Complex logic has comments explaining "why"
- [ ] Tests are included for new features
- [ ] Breaking changes are documented
- [ ] API contracts are backwards compatible
- [ ] Configuration is externalized

## Common Anti-Patterns to Flag

### 1. God Objects / Functions

```typescript
// Bad: function does too many things
function processOrder(order: Order) {
  validateOrder(order)
  calculateTax(order)
  applyDiscount(order)
  chargePayment(order)
  sendEmail(order)
  updateInventory(order)
  generateInvoice(order)
}

// Better: separate concerns
async function processOrder(order: Order) {
  const validatedOrder = await orderValidator.validate(order)
  const pricedOrder = await pricingService.calculate(validatedOrder)
  const payment = await paymentService.charge(pricedOrder)
  await notificationService.sendConfirmation(payment)
  await inventoryService.update(pricedOrder)
}
```

### 2. Premature Optimization

Flag overly complex code that optimizes without evidence of a performance problem. Always measure first.

### 3. Missing Error Boundaries

```typescript
// Bad: errors silently swallowed
try {
  await riskyOperation()
} catch (e) {
  // empty catch
}

// Better: handle or propagate
try {
  await riskyOperation()
} catch (error) {
  logger.error('Operation failed', { error, context })
  throw new AppError('OPERATION_FAILED', { cause: error })
}
```

### 4. Magic Numbers and Strings

```typescript
// Bad
if (user.role === 3) { ... }
setTimeout(fn, 86400000)

// Better
const ADMIN_ROLE = 3
const ONE_DAY_MS = 24 * 60 * 60 * 1000
if (user.role === ADMIN_ROLE) { ... }
setTimeout(fn, ONE_DAY_MS)
```

## Review Comment Guidelines

When writing review comments:

1. **Be specific** - Point to the exact line and suggest a fix
2. **Explain why** - Don't just say "change this", explain the reasoning
3. **Be kind** - Use "we" instead of "you", ask questions instead of commands
4. **Prioritize** - Label comments as `blocker`, `suggestion`, or `nit`
5. **Praise good code** - Acknowledge well-written solutions
