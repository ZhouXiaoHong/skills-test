# Smart Contract Audit Checklist

## Critical

- [ ] Reentrancy vulnerabilities (CEI pattern)
- [ ] Integer overflow/underflow (SafeMath or Solidity 0.8+)
- [ ] Unchecked external calls
- [ ] Access control on sensitive functions
- [ ] Delegatecall usage safety

## High

- [ ] Front-running susceptibility
- [ ] Oracle manipulation risks
- [ ] Flash loan attack vectors
- [ ] Timestamp dependence
- [ ] Block number dependence

## Medium

- [ ] Gas limit issues in loops
- [ ] Proper event emission
- [ ] Input validation
- [ ] Return value checks
- [ ] Centralization risks

## Low

- [ ] Code style consistency
- [ ] Documentation completeness
- [ ] Test coverage
- [ ] Compiler version pinning
- [ ] License header

## Informational

- [ ] Gas optimization opportunities
- [ ] Unused variables/imports
- [ ] Magic numbers
- [ ] TODO/FIXME comments
