---
name: csp-hardening
description: Harden Content-Security-Policy for web apps without breaking essential scripts
version: 1.0.0
author: community-dev
tags:
  - security
  - csp
  - web
---

# CSP Hardening

Strengthen your Content-Security-Policy (CSP) without breaking essential UX.

## Baseline policy

```http
Content-Security-Policy: default-src 'self'; \
  script-src 'self' 'nonce-<RANDOM>'; \
  style-src 'self'; \
  img-src 'self' data: https:; \
  connect-src 'self' https:; \
  frame-ancestors 'none'
```

## Checklist

- [ ] Avoid `unsafe-inline` for scripts
- [ ] Use `nonce-...` or `sha256-...` for allowed inline scripts
- [ ] Prefer `strict-dynamic` only when you understand the trade-offs

External reference: [MDN CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
