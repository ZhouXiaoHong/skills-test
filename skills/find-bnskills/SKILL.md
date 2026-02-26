---
name: find-bnskills
description: Helps users discover and install agent skills when they ask questions like "how do I do X", "find a skill for X", "is there a skill that can...", or express interest in extending capabilities. This skill should be used when the user is looking for functionality that might exist as an installable skill.
---

# Find BNSkills

This skill helps you discover and install skills from the Binance agent skills repository.

## When to Use This Skill

Use this skill when the user:

- Asks "how do I do X" where X might be a common task with an existing skill
- Says "find a skill for X" or "is there a skill for X"
- Asks "can you do X" where X is a specialized capability
- Expresses interest in extending agent capabilities
- Wants to search for tools, templates, or workflows
- Mentions they wish they had help with a specific domain (blockchain, trading, security, etc.)

## What is bnskills?

`bnskills` is the Binance Agent Skills CLI. Skills are modular packages that extend agent capabilities with specialized knowledge, workflows, and tools.

**Key commands:**

- `bnskills add` - Browse and install skills interactively
- `bnskills add --list` - List all available skills
- `bnskills add --skill <name> -y` - Install a specific skill by name
- `bnskills check` - Check for skill updates
- `bnskills update` - Update all installed skills

## How to Help Users Find Skills

### Step 1: Understand What They Need

When a user asks for help with something, identify:

1. The domain (e.g., blockchain, trading, security, frontend, web3)
2. The specific task (e.g., writing smart contracts, reviewing PRs, analyzing trades)
3. Whether this is a common enough task that a skill likely exists

### Step 2: List Available Skills

Run the list command to see what's available:

```bash
bnskills add --list
```

### Step 3: Present Options to the User

When you find relevant skills, present them to the user with:

1. The skill name and what it does
2. The install command they can run

Example response:

```
I found a skill that might help! The "blockchain" skill provides
blockchain development best practices and smart contract guidelines.

To install it:
bnskills add --skill blockchain -g -y
```

### Step 4: Offer to Install

If the user wants to proceed, you can install the skill for them:

```bash
bnskills add --skill <skill-name> -g -y
```

The `-g` flag installs globally (user-level) and `-y` skips confirmation prompts.

## Common Skill Categories

When searching, consider these common categories:

| Category        | Example Skills                           |
| --------------- | ---------------------------------------- |
| Blockchain      | smart contracts, solidity, chain ops     |
| Trading         | trading strategies, market analysis      |
| Security        | audit, vulnerability scanning            |
| Web3            | dApps, DeFi, NFT                         |
| Frontend        | React, UI components, design systems     |

## Tips for Effective Searches

1. **Use `--list` first**: Run `bnskills add --list` to see all available skills
2. **Check categories**: Skills are organized under official/ and community/ directories
3. **Use specific names**: If you know the skill name, use `--skill <name>` directly

## When No Skills Are Found

If no relevant skills exist:

1. Acknowledge that no existing skill was found
2. Offer to help with the task directly using your general capabilities
3. Suggest the user could request a new skill to be added to the repository

Example:

```
I searched for skills related to "xyz" but didn't find any matches.
I can still help you with this task directly! Would you like me to proceed?
```
