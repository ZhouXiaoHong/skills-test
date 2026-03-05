---
name: api-testing
description: Guide for writing comprehensive API tests including unit tests, integration tests, and end-to-end tests. Covers REST and GraphQL APIs with popular testing frameworks like Jest, Supertest, and Playwright.
---

# API Testing Best Practices

This skill helps you write robust API tests for REST and GraphQL endpoints.

## When to Use This Skill

Use this skill when the user:

- Needs to write API tests for a backend service
- Wants to set up integration testing for REST endpoints
- Asks about testing GraphQL queries and mutations
- Needs to mock external API dependencies
- Wants to implement contract testing
- Is setting up automated API testing in CI/CD

## Testing Pyramid

```
        /  E2E  \           Few, slow, expensive
       /─────────\
      / Integration \       Medium count
     /───────────────\
    /   Unit Tests    \     Many, fast, cheap
   /───────────────────\
```

## REST API Testing with Jest + Supertest

### Setup

```typescript
import request from 'supertest'
import { app } from '../app'

describe('GET /api/users', () => {
  it('should return a list of users', async () => {
    const response = await request(app)
      .get('/api/users')
      .set('Authorization', `Bearer ${token}`)
      .expect(200)

    expect(response.body).toHaveProperty('data')
    expect(Array.isArray(response.body.data)).toBe(true)
  })

  it('should return 401 without auth token', async () => {
    await request(app)
      .get('/api/users')
      .expect(401)
  })
})
```

### Testing Error Scenarios

```typescript
describe('POST /api/users', () => {
  it('should return 400 for invalid email', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({ email: 'invalid', name: 'Test' })
      .expect(400)

    expect(response.body.errors).toContainEqual(
      expect.objectContaining({ field: 'email' })
    )
  })

  it('should return 409 for duplicate email', async () => {
    await request(app)
      .post('/api/users')
      .send({ email: 'exists@test.com', name: 'Test' })
      .expect(409)
  })
})
```

## Mocking External Services

```typescript
import nock from 'nock'

beforeEach(() => {
  nock('https://external-api.com')
    .get('/data')
    .reply(200, { result: 'mocked' })
})

afterEach(() => {
  nock.cleanAll()
})
```

## GraphQL Testing

```typescript
describe('GraphQL Queries', () => {
  it('should fetch user by ID', async () => {
    const query = `
      query GetUser($id: ID!) {
        user(id: $id) {
          id
          name
          email
        }
      }
    `

    const response = await request(app)
      .post('/graphql')
      .send({ query, variables: { id: '1' } })
      .expect(200)

    expect(response.body.data.user).toMatchObject({
      id: '1',
      name: expect.any(String),
    })
  })
})
```

## Test Coverage Checklist

- [ ] Happy path (200/201 responses)
- [ ] Authentication & authorization (401/403)
- [ ] Validation errors (400)
- [ ] Not found (404)
- [ ] Conflict/duplicate (409)
- [ ] Rate limiting (429)
- [ ] Server errors (500)
- [ ] Pagination & filtering
- [ ] Edge cases (empty arrays, null values, large payloads)
