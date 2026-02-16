#!/usr/bin/env python3
"""Simple APR helper for test skill assets."""


def estimate_apr(reward_per_day: float, principal: float) -> float:
    if principal <= 0:
        raise ValueError("principal must be positive")
    return (reward_per_day * 365.0 / principal) * 100.0


if __name__ == "__main__":
    print(round(estimate_apr(3.5, 1200.0), 2))
