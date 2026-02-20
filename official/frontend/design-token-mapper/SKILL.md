---
name: design-token-mapper
description: Map design system tokens to Tailwind v4 theme variables using UIKit CSS vars
version: 1.0.0
author: binance
tags:
  - frontend
  - design-system
  - tailwind
  - tokens
---

# Design Token Mapper

Use this skill to connect UIKit CSS variables to Tailwind v4 theme tokens.

## Quick mapping table

| Design token | UIKit var | Tailwind token |
| --- | --- | --- |
| Primary | `--color-PrimaryYellow` | `--color-primary` |
| Link | `--color-TextLink` | `--color-link` |
| Surface | `--color-CardBg` | `--color-surface` |
| Border | `--color-Line` | `--color-border` |

## Example

```css
@theme inline {
  --color-background: var(--color-BasicBg);
  --color-foreground: var(--color-PrimaryText);
  --color-primary: var(--color-PrimaryYellow);
  --color-link: var(--color-TextLink);
}
```

Open a JSON sample at [examples/tokens.json](./examples/tokens.json).
