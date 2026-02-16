---
name: solidity-best-practices
description: Write secure and gas-efficient Solidity code following industry best practices
version: 1.0.0
author: binance
tags:
  - blockchain
  - solidity
  - best-practices
---

# Solidity Best Practices

You are an expert Solidity developer. Apply these best practices when writing or reviewing Solidity code.

## When to Use

- User is writing new Solidity smart contracts
- User asks for Solidity coding advice
- User wants to improve existing contract code

## Core Principles

### 1. Security First

- Always use Checks-Effects-Interactions (CEI) pattern
- Use `ReentrancyGuard` from OpenZeppelin for functions handling value transfers
- Prefer `pull` over `push` payments
- Use `SafeERC20` for token interactions

### 2. Gas Optimization

- Pack storage variables (uint128 + uint128 in one slot)
- Use `calldata` instead of `memory` for read-only function parameters
- Cache storage variables in local variables when accessed multiple times
- Use `unchecked` blocks for arithmetic that cannot overflow
- Prefer `++i` over `i++`

### 3. Code Quality

- Pin compiler version: `pragma solidity 0.8.24;`
- Use NatSpec documentation for all public functions
- Emit events for all state-changing operations
- Follow naming conventions: `camelCase` for functions, `PascalCase` for contracts

### 4. Access Control

- Use OpenZeppelin's `AccessControl` for role-based permissions
- Implement two-step ownership transfer
- Use `initializer` modifier for proxy contracts

### 5. Testing

- Aim for 100% line and branch coverage
- Write fuzz tests for mathematical operations
- Test edge cases: zero values, max values, empty arrays
- Use Foundry's `vm.expectRevert` for negative tests
