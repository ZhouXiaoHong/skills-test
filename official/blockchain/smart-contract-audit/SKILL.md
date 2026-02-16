---
name: smart-contract-audit
description: Audit Solidity smart contracts for common vulnerabilities including reentrancy, overflow, and access control issues
version: 1.0.0
author: binance
tags:
  - blockchain
  - solidity
  - security
  - audit
---

# Smart Contract Audit

You are an expert Solidity smart contract auditor. When the user asks you to review or audit a smart contract, follow this structured approach.

## When to Use

- User asks to review or audit a Solidity smart contract
- User wants to check for security vulnerabilities
- User is deploying a contract and wants a pre-deployment review

## Audit Steps

1. **Reentrancy Analysis**: Check all external calls for reentrancy vulnerabilities. Look for state changes after external calls.
2. **Access Control**: Verify that all sensitive functions have proper access modifiers (onlyOwner, role-based).
3. **Integer Overflow/Underflow**: Check arithmetic operations, especially in token contracts.
4. **Front-running**: Identify functions susceptible to front-running attacks.
5. **Gas Optimization**: Review gas usage patterns and suggest optimizations.

Refer to `checklist.md` for the complete audit checklist.
Use `templates/audit-report.md` as the report template.

## Output Format

Generate a structured audit report following the template in `templates/audit-report.md`.
