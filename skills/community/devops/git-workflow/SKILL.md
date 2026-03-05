---
name: git-workflow
description: A comprehensive Git workflow guide that helps developers follow best practices for branching, committing, merging, and resolving conflicts. Use when working with Git repositories, managing branches, or handling complex merge scenarios.
---

# Git Workflow Best Practices

This skill provides guidance on Git workflows, branching strategies, and collaboration best practices.

## When to Use This Skill

Use this skill when the user:

- Needs help with Git branching strategies (GitFlow, trunk-based, etc.)
- Wants to write better commit messages
- Is dealing with merge conflicts
- Needs to set up CI/CD-friendly Git workflows
- Asks about rebasing vs merging
- Wants to manage release branches

## Branching Strategies

### GitFlow

GitFlow is a well-known branching model that uses feature branches, develop, release, and hotfix branches:

```
main ─────────────────────────────────────
  │                          ▲
  └── develop ───────────────┤
       │          ▲           │
       └── feature/login ────┘
```

**When to use:** Large teams with scheduled releases.

### Trunk-Based Development

All developers work on a single branch (main/trunk) with short-lived feature branches:

```
main ─────────────────────────────────────
  │    ▲    │    ▲    │    ▲
  └────┘    └────┘    └────┘
  (short feature branches, < 1 day)
```

**When to use:** Teams practicing continuous deployment.

## Commit Message Convention

Follow the Conventional Commits specification:

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

| Type     | Description                          |
| -------- | ------------------------------------ |
| feat     | A new feature                        |
| fix      | A bug fix                            |
| docs     | Documentation only changes           |
| style    | Code style changes (formatting)      |
| refactor | Code change that neither fixes nor adds |
| perf     | Performance improvement              |
| test     | Adding or updating tests             |
| chore    | Maintenance tasks                    |

## Handling Merge Conflicts

### Step-by-Step Resolution

1. **Identify conflicting files**: `git status`
2. **Open conflicting files** and look for conflict markers:
   ```
   <<<<<<< HEAD
   your changes
   =======
   incoming changes
   >>>>>>> feature-branch
   ```
3. **Resolve** by choosing the correct code
4. **Stage resolved files**: `git add <file>`
5. **Complete the merge**: `git commit`

### Tips

- Pull frequently to minimize conflicts
- Keep feature branches short-lived
- Communicate with teammates about shared files
- Use `git rerere` to remember conflict resolutions

## Useful Git Commands

```bash
# Interactive rebase for cleaning up commits
git rebase -i HEAD~3

# Stash changes temporarily
git stash push -m "work in progress"
git stash pop

# Cherry-pick a specific commit
git cherry-pick <commit-sha>

# View branch graph
git log --oneline --graph --all

# Find which commit introduced a bug
git bisect start
git bisect bad
git bisect good <known-good-commit>
```
