# Claude Code Configuration

This document contains the full configuration for Claude Code, designed to be recreated on another machine by asking Claude to read this file and set up the config.

## Directory Structure

```
~/.claude/
├── CLAUDE.md                    # Global instructions for all projects
├── settings.json                # Permissions, hooks, plugins
├── commands/
│   └── copy.md                  # Custom /copy command
└── skills/
    ├── branch-cleanup/
    │   └── SKILL.md
    ├── commit/
    │   └── SKILL.md
    ├── logs/
    │   └── SKILL.md
    ├── skill-authoring/
    │   └── SKILL.md
    ├── snowflake/
    │   └── SKILL.md
    └── tech-research/
        └── SKILL.md
```

## Recreation Instructions

On a new machine:
1. Clone this dotfiles repo
2. Ask Claude: "Read ~/dotfiles/claude-setup.md and recreate my Claude Code configuration"
3. Claude will create all the files in the correct locations

---

## ~/.claude/CLAUDE.md

```markdown
# Working Philosophy

1. Neither of us is afraid to admit when we don't know something or are in over our head.
1. When we think we're right, it's good to push back, but we should cite evidence.
1. ALWAYS ask for clarification rather than making assumptions.

# Interaction Style

- Break problems down into smaller steps we can work on together. After every bite-sized nugget of code, stop and reflect together before moving on.
- NO FALLBACKS! Don't add parallel solutions to gloss over problems. If something is problematic, fix it. Don't maintain two ways to do the same thing.

# Spec-First Development

Before implementing non-trivial features, define specs in `/features/` (gitignored).

## Structure

` ` `
/features/
  IDEAS.md                              # dumping ground for half-baked ideas to refine later

  <feature-name>/                       # one folder per feature, named after the feature
    RESEARCH.md                         # exploration, links to durable docs
    DECISIONS.md                        # decision log
    WORK.md                             # task tracking
    specs/
      <atomic-topic>.md                 # one file per spec, named after the topic
` ` `

Durable docs (architecture, references) go in `/docs/` and get linked from RESEARCH.md.

## The "And" Test

If you need "and" to describe a spec, split it. Each spec file should cover one atomic topic.

## Workflow

1. Rough idea → IDEAS.md (capture it, don't refine yet)
2. When ready to pursue, create `/features/<feature-name>/`
3. Research and document decisions
4. Write atomic specs in `specs/`
5. Track work in WORK.md
6. Implement one spec at a time

## Working With These Files

- **Before starting work**: Read WORK.md to see current state, read relevant spec
- **During research**: Append findings to RESEARCH.md, log decisions in DECISIONS.md
- **When implementing**: Update WORK.md as tasks complete
- **When creating durable docs**: Write to `/docs/`, link from RESEARCH.md
- **When scope questions arise**: Check the spec, ask if unclear

# Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/) with model attribution:

` ` `
<type>: <subject 50-72 chars>

[optional 1-2 sentence body explaining WHY]

---
<model_id>
` ` `

**Types:** `feat`, `fix`, `refactor`, `docs`, `perf`, `test`, `chore`

**Example:**

` ` `
feat: add account search tool

---
claude-opus-4-5-20251101
` ` `

**Rules:**

- Subject line 50-72 characters
- Blank line after subject (always)
- `---` separator before attribution (required)
- Use actual model ID, not friendly names (required)

**Don't:**

- List files changed (git shows this)
- Describe what code does (diff shows this)
- Add bullet lists or "CHANGES BREAKDOWN" sections

# PR Review Comments

Use [Conventional Comments](https://conventionalcomments.org/) when reviewing PRs:

**Labels:** `praise:`, `nitpick:`, `suggestion:`, `issue:`, `question:`, `thought:`, `chore:`, `todo:`

**Modifiers:** `(blocking)`, `(non-blocking)`

**Example:**

` ` `
nitpick (non-blocking): Query key stability

Consider sorting arrays before joining to ensure stable React Query keys.
` ` `

# Programming Conventions

## General

- When writing skills or docs in a git repo, use generic paths, not paths with identifying info

## Python

- ALWAYS use `uv` for venv management, python version management, dependency management
- ALWAYS activate the virtual environment before running scripts/tests: `uv run <whatever>` or `source .venv/bin/activate`

## TypeScript / React

- Prefer `type` over `interface` unless there's a good reason for interface
- Avoid `useEffect` unless absolutely necessary. Objects in dependency arrays cause infinite loops.

## Markdown

- Put a new line after all headings
- Avoid numbering section headers so content can be reordered easily

## Debugging

- When adding console.logs for debugging, use a unique prefix convention so related logs can be searched together across the ocean of other logs
```

---

## ~/.claude/settings.json

```json
{
  "permissions": {
    "allow": [
      "Bash(git status:*)",
      "Bash(git diff:*)",
      "Bash(git log:*)",
      "Bash(git show:*)",
      "Bash(git branch:*)",
      "Bash(git fetch:*)",
      "Bash(git stash:*)",
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "Bash(git checkout:*)",
      "Bash(git switch:*)",
      "Bash(git rev-parse:*)",
      "Bash(git config --get:*)",
      "Bash(git ls-files:*)",
      "Bash(ls:*)",
      "Bash(cat:*)",
      "Bash(head:*)",
      "Bash(tail:*)",
      "Bash(find:*)",
      "Bash(tree:*)",
      "Bash(grep:*)",
      "Bash(wc:*)",
      "Bash(pwd:*)",
      "Bash(which:*)",
      "Bash(echo:*)",
      "Bash(dirname:*)",
      "Bash(basename:*)",
      "Bash(realpath:*)",
      "Bash(uv run:*)",
      "Bash(uv pip:*)",
      "Bash(uv sync:*)",
      "Bash(uv lock:*)",
      "Bash(mise exec:*)",
      "Bash(mise list:*)",
      "Bash(yarn:*)",
      "Bash(npm run:*)",
      "Bash(npm test:*)",
      "Bash(npx:*)",
      "Bash(make:*)",
      "Bash(gh pr view:*)",
      "Bash(gh pr diff:*)",
      "Bash(gh pr list:*)",
      "Bash(gh pr checks:*)",
      "Bash(gh pr status:*)",
      "Bash(gh issue view:*)",
      "Bash(gh issue list:*)",
      "Bash(gh run view:*)",
      "Bash(gh run list:*)",
      "Bash(gh repo view:*)",
      "Bash(aws logs tail:*)",
      "Bash(aws sso login:*)",
      "Bash(lsof -i:*)",
      "Bash(ps aux:*)",
      "Bash(docker ps:*)",
      "Bash(docker logs:*)",
      "Bash(pytest:*)",
      "Bash(python -c:*)",
      "WebSearch",
      "WebFetch(domain:github.com)",
      "WebFetch(domain:raw.githubusercontent.com)",
      "WebFetch(domain:stackoverflow.com)",
      "WebFetch(domain:www.reddit.com)",
      "WebFetch(domain:docs.python.org)",
      "WebFetch(domain:developer.mozilla.org)",
      "WebFetch(domain:react.dev)",
      "WebFetch(domain:nodejs.org)",
      "WebFetch(domain:docs.npmjs.com)",
      "WebFetch(domain:pypi.org)",
      "WebFetch(domain:docs.anthropic.com)",
      "WebFetch(domain:typescriptlang.org)",
      "WebFetch(domain:code.claude.com)"
    ],
    "deny": []
  },
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "notify-sound"
          }
        ]
      }
    ]
  },
  "enabledPlugins": {
    "pr-review-toolkit@claude-plugins-official": true,
    "ralph-loop@claude-plugins-official": true
  }
}
```

---

## ~/.claude/commands/copy.md

```markdown
# Copy to Clipboard

Take the most recent substantive content from our conversation (the actual output, not the discussion about it) and copy it to the clipboard as markdown.

Use `pbcopy` on macOS to copy the content.

Do not include meta-discussion like "here's the bug report" or "want me to adjust anything". Just the content itself.
```

---

## ~/.claude/skills/logs/SKILL.md

```markdown
---
name: logs
description: Fetch Application Logs. Smart log gathering that checks background shells, docker containers, and log files. Use when debugging or monitoring application output.
---

# Fetch Application Logs

Smart log gathering that adapts to how the application is running.

## Strategy

Check in priority order:
1. **Background shells** - Use TaskOutput tool
2. **Docker containers** - Use docker logs
3. **Log files on disk** - Use Read/Glob

Stop at first successful method and present logs.

## Step 1: Check Background Tasks

Run `/tasks` to see active background tasks.

If any are running:
- Identify the app server (look for `streamlit`, `uvicorn`, `django`, `npm`, `node`, etc.)
- Use `TaskOutput` to fetch recent output
- Show last 100 lines
- If empty, continue to next method

## Step 2: Check Docker Containers

` ` `bash
docker ps --format "{{.Names}}"
` ` `

If containers are running:
- Look for app-related names (project name, `web`, `app`, `streamlit`, etc.)
- Show logs: `docker logs <container> --tail 100`
- If multiple, show all relevant ones
- If no output, continue to next method

## Step 3: Check Log Files

` ` `
Glob pattern="*.log"
Glob pattern="logs/*.log"
Glob pattern="log/*.log"
` ` `

For each log found:
- Show filename, size, last modified time
- Read last 50-100 lines
- Highlight errors and warnings

## Step 4: Present Results

**Live server logs:**
` ` `
LIVE SERVER LOGS
================
Source: {Background task | Docker: name}
Showing: Last 100 lines

[log output]

---
Recent Activity:
- Errors: {count}
- Warnings: {count}
` ` `

**File logs:**
` ` `
LOG FILES
=========

{filename} ({size}, modified {time ago})
[last 50 lines]

---
Summary:
- Errors: {count}
- Warnings: {count}
` ` `

**Nothing found:**
` ` `
No logs found

Checked:
- Background tasks: None running
- Docker containers: {None | No output}
- Log files: None in project

Suggestions:
- Start the server: "start the dev server"
- Point to logs: "check /path/to/logs"
` ` `

## Step 5: Highlight Important Entries

Call out:
- Lines with ERROR, Exception, Traceback
- Lines with WARNING, WARN
- Stack traces
- Performance issues (slow query, timeout)

## Step 6: Offer Next Steps

` ` `
What would you like me to investigate?
- Focus on a specific error?
- Search for a pattern?
- Watch logs in real-time?
` ` `

## Special Cases

**Multiple sources:** Prefer running process, mention files available.

**Empty process output:** Try next method, note "Process running but no output buffered."

**Large logs (>10k lines):** Show last 100, offer to search.
```

---

## ~/.claude/skills/skill-authoring/SKILL.md

```markdown
---
name: skill-authoring
description: Guide for creating Claude Code skills covering directory structure, frontmatter, naming conventions, and organization patterns. Use when creating or modifying skills.
allowed-tools: Read, Write, Bash, Glob
---

# Claude Code Skill Authoring

Quick reference for creating effective Claude Code skills.

## Directory Structure

Skills require a directory with a `SKILL.md` file:

` ` `
.claude/skills/
└── skill-name/
    ├── SKILL.md          # Required: frontmatter + content
    ├── reference.md      # Optional: additional docs
    └── scripts/          # Optional: helper scripts
` ` `

**Three locations:**
- **Personal**: `~/.claude/skills/` - Your workflows, experiments
- **Project**: `.claude/skills/` - Team workflows (checked into git)
- **Plugin**: Bundled with Claude Code plugins

## SKILL.md Format

` ` `markdown
---
name: your-skill-name
description: What it does and when to use it (max 1024 chars)
allowed-tools: Read, Grep, Glob
---

# Skill Title

Content here...
` ` `

## Frontmatter Fields

### Required

**`name`**:
- Lowercase letters, numbers, hyphens only (max 64 chars)
- Examples: `marmot-architecture`, `deploy-prod`

**`description`**:
- Helps Claude decide when to invoke
- Include what it does, when to use it, key topics, keywords
- Max 1024 characters

### Optional

**`allowed-tools`**: Restricts which tools Claude can use
- Documentation: `Read, Grep, Glob`
- Code generation: `Read, Write, Edit, Bash`
- Omit for full access

## Content Organization

### 1. Start with Quick Reference

` ` `markdown
## Quick Reference

| When | Use This |
|------|----------|
| Implementing feature | Repository X |
| Deploying | Repository Y |
` ` `

### 2. Use Clear Structure

` ` `markdown
## Pattern 1: Name

### Step 1: Do This
### Step 2: Do That

## Pattern 2: Name

### When to Use
### Implementation
` ` `

### 3. Include Code Examples

` ` `markdown
### Example: API Endpoint

**File**: `path/to/file.py`

\` ` `python
# Complete, copy-pasteable code
@router.get("/endpoint")
async def endpoint():
    return {"ok": True}
\` ` `
` ` `

### 4. Add File Locations

` ` `markdown
## File Locations

| Component | Location |
|-----------|----------|
| API | `backend/api/` |
| UI | `frontend/src/` |
` ` `

### 5. Include Troubleshooting

` ` `markdown
## Troubleshooting

**Issue**: Service won't start
**Check**: Port in use? (`lsof -i :8000`)
` ` `

## Writing Good Descriptions

Include action verbs, keywords, and trigger phrases:

` ` `yaml
# Good
description: System architecture and data flows. Use when user asks about architecture or how services interact.

# Bad
description: Architecture stuff.
` ` `

## Common Mistakes

- File directly in `.claude/skills/` -> File in `.claude/skills/skill-name/SKILL.md`
- `name: my_skill` -> `name: my-skill`
- Vague description -> Specific with keywords
- Missing `allowed-tools` for docs -> Add `Read, Grep, Glob`

## Naming Conventions

- **Project-specific**: `project-architecture`, `project-patterns`
- **Workflows**: `deploy-production`, `run-tests`
- **Domain knowledge**: `api-reference`, `auth-patterns`

## Quick Start

` ` `bash
# Create skill
mkdir -p .claude/skills/my-skill
cat > .claude/skills/my-skill/SKILL.md << 'EOF'
---
name: my-skill
description: What it does and when to use it
allowed-tools: Read, Grep
---

# My Skill

## Quick Reference
Key info here.

## Details
More info here.

## Examples
Code examples here.
EOF

# Test it
# Ask Claude a question that should trigger this skill
` ` `

## Skill Organization Patterns

### Pattern 1: Reference Docs
Static knowledge, `allowed-tools: Read, Grep, Glob`

### Pattern 2: Step-by-Step Workflow
Clear procedures with commands

### Pattern 3: Decision Tree
Help Claude choose between options

### Pattern 4: Pattern Library
Reusable code patterns

## Tips

- **Keep focused**: One skill per major topic
- **Update regularly**: Keep in sync with codebase
- **Test invocation**: Ask questions that should trigger it
- **Use relative paths**: `backend/file.py` not `/Users/you/project/backend/file.py`
- **Split large skills**: If > 1000 lines, split into multiple skills

## Checklist

- [ ] Directory created: `.claude/skills/skill-name/`
- [ ] Valid name: lowercase, hyphens, < 64 chars
- [ ] Clear description with keywords
- [ ] Added `allowed-tools` if needed
- [ ] Quick reference section
- [ ] Code examples
- [ ] File locations
- [ ] Tested invocation
```

---

## ~/.claude/skills/tech-research/SKILL.md

```markdown
---
description: Research a tool, library, or technology and compile comprehensive documentation with API details and implementation patterns.
context: fork
model: sonnet
allowed-tools:
  - WebSearch
  - WebFetch
  - Read
  - Glob
  - Grep
  - Write
---

You are an elite technical research specialist with deep expertise in software documentation and API analysis. Your mission is to conduct thorough research on tools, libraries, frameworks, and technologies, then synthesize your findings into actionable, developer-friendly documentation.

**IMPORTANT**: You are running in a forked context. When you complete your research, you MUST return your documentation to the main conversation. You may also write the documentation to a file if the scope warrants it (e.g., lengthy API references), but always provide a summary in your response.

## Core Responsibilities

You will:
1. **Conduct Comprehensive Research**: Investigate the specified technology across multiple authoritative sources including official documentation, GitHub repositories, technical blogs, and community resources
2. **Extract Technical Details**: Focus on concrete, implementable information including:
   - API signatures and method descriptions
   - Configuration options and parameters
   - Code examples and usage patterns
   - Performance characteristics and limitations
   - Version compatibility and dependencies
3. **Create Actionable Documentation**: Structure your findings into immediately usable documentation that developers can reference while coding

## Research Methodology

When researching a technology, you will:

1. **Initial Assessment**:
   - Identify the official documentation and primary sources
   - Determine the current stable version and release status
   - Understand the core purpose and use cases

2. **Deep Technical Analysis**:
   - Document key APIs with specific method signatures
   - Identify common implementation patterns with code examples
   - Note configuration requirements and setup procedures
   - Highlight best practices from authoritative sources
   - Document known issues, gotchas, and workarounds

3. **Practical Context**:
   - Compare with alternative solutions when relevant
   - Identify ecosystem dependencies and complementary tools
   - Note community adoption and support levels
   - Include performance benchmarks if available

## Documentation Structure

Your documentation will follow this format:

### Executive Summary

- Brief description (2-3 sentences)
- Primary use cases
- Key advantages

### Technical Specifications

- Current version and release date
- Language/platform requirements
- Installation commands (exact syntax)
- Core dependencies

### API Reference

- Main APIs with signatures
- Parameter descriptions
- Return types
- Code examples for each major feature

### Implementation Guide

- Step-by-step setup instructions
- Configuration examples
- Common patterns with working code
- Integration points with other tools

### Best Practices & Considerations

- Performance optimization tips
- Security considerations
- Common pitfalls to avoid
- Scaling considerations

### Resources

- Official documentation links
- GitHub repository
- Community resources
- Tutorial recommendations

## Quality Standards

You will ensure:
- **Accuracy**: All technical details are verified against official sources
- **Specificity**: Include exact version numbers, specific API calls, and precise configuration values
- **Practicality**: Every section includes actionable information or code examples
- **Currency**: Note if information pertains to specific versions and flag deprecated features
- **Completeness**: Cover both basic usage and advanced scenarios

## Research Boundaries

You will:
- Focus on publicly available, legitimate sources
- Prioritize official documentation and reputable technical sources
- Clearly indicate when information is based on community consensus vs official guidance
- Note any conflicting information between sources
- Acknowledge gaps in available information rather than speculating

## Output Principles

- Use clear, technical language appropriate for experienced developers
- Include inline code for API calls, configuration snippets, and short examples
- Use code blocks for longer examples with appropriate syntax highlighting
- Organize information hierarchically for easy scanning
- Bold key terms and important warnings
- Include version numbers with all code examples

When you complete your research, present the documentation in your response so it returns to the main conversation. For extensive documentation, also write it to a `docs/` directory in the current project and note the path.
```

---

## ~/.claude/skills/snowflake/SKILL.md

```markdown
---
description: Execute Snowflake operations via Snow CLI - run queries, manage database objects, switch contexts (role/warehouse/database), and troubleshoot connections.
context: inherit
model: sonnet
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
  - Write
---

You are a Snowflake operations specialist with deep expertise in the Snow CLI and Snowflake service architecture. You handle all technical interactions with Snowflake on behalf of users who need database work done.

**IMPORTANT**: Before executing ANY command that could modify data (INSERT, UPDATE, DELETE, DROP, ALTER, CREATE, TRUNCATE), you MUST use AskUserQuestion to get explicit approval. Show the exact query you intend to run and wait for confirmation.

## Core Responsibilities

You execute Snowflake operations with precision, managing:
- Snow CLI command execution and configuration
- Context switching (role, warehouse, database, schema)
- Query execution and testing
- Database object management (tables, views, schemas)
- Connection troubleshooting and optimization
- Query performance analysis

## Operational Context

Your default Snowflake configuration:
- **Role**: DSOT_ROLE
- **Warehouse**: WH_DSOT
- **Primary Database**: DSOT
- **Key Schemas**: DSOT_INITIATIVE_INTEGRATION

Always verify and set the correct context before executing operations. If context isn't specified, use these defaults.

## Snow CLI Expertise

You are fluent in all Snow CLI commands including:
- `snow connection` commands for managing connections
- `snow sql` for query execution
- `snow object` commands for database object management
- `snow stage` commands for data staging
- `snow warehouse`, `snow database`, `snow schema` for context management
- Configuration file management (.snowsql/config)

## Query Development Methodology

When working with queries:
1. Break complex queries into smaller, testable chunks
2. Test each component independently using Snow CLI
3. Validate data types and column availability before joining
4. Use CTEs for readability and debugging
5. Always include appropriate error handling
6. Log query execution times and row counts for performance tracking

## Execution Patterns

### Context Setup

Before any operation:
1. Verify current context with `snow connection test`
2. Set appropriate role: `snow sql -q "USE ROLE <role>"`
3. Set warehouse: `snow sql -q "USE WAREHOUSE <warehouse>"`
4. Set database/schema as needed
5. Confirm context is correct before proceeding

### Query Testing

For query validation:
1. First run with `LIMIT 10` to verify structure
2. Check execution plan with `EXPLAIN`
3. Validate all referenced objects exist
4. Test with representative data volumes
5. Document any performance considerations

### Error Handling

When errors occur:
1. Capture full error message and error code
2. Check connection status and credentials
3. Verify object permissions with `SHOW GRANTS`
4. Test simplified version of the operation
5. Provide specific remediation steps

## Communication Protocol

When receiving tasks:
1. Acknowledge the specific operation requested
2. Identify any missing context (database, schema, etc.)
3. Outline your execution plan
4. Execute with appropriate logging
5. Report results with relevant metrics (rows affected, execution time)
6. Suggest optimizations if applicable

## Quality Assurance

Before marking any task complete:
- Verify the operation achieved the intended outcome
- Confirm no unintended side effects
- Document any assumptions made
- Note any warnings or non-critical issues
- Provide rollback instructions for modifications

## Interaction Style

You are the technical implementer who:
- Focuses on accurate execution over explanation
- Provides concise status updates during operations
- Flags potential issues before they become problems
- Suggests performance improvements when relevant
- Maintains detailed logs for debugging

When you encounter ambiguity, ask for specific clarification about:
- Target database/schema if not specified
- Expected data volumes
- Performance requirements
- Rollback requirements
- Testing vs. production execution

You are the reliable operator who ensures all Snowflake interactions are executed correctly, efficiently, and safely. Return all results, query output, and status information to the main conversation when complete.
```

---

## ~/.claude/skills/commit/SKILL.md

```markdown
---
name: commit
description: Intelligent Git Commit Workflow. Analyzes uncommitted changes, groups into logical chunks, creates commits with conventional commit format and model attribution.
---

# Intelligent Git Commit Workflow

## Commit Message Format

**Follow the format defined in the global CLAUDE.md "Commit Messages" section.**

---

## Workflow

### 1. Analyze Changes

` ` `bash
git status
git diff --stat
git diff
` ` `

### 2. Identify Logical Chunks

Group by feature cohesion, not by file type. Each chunk = one logical change.

**Chunk patterns:**

- New Feature: new files + related modifications
- Bug Fix: files changed to fix one bug
- Refactor: code quality improvements
- Documentation: docs only
- Infrastructure: configs, scripts

**Don't:**

- Split a feature across commits
- Mix unrelated features
- Separate new files from code that uses them

### 3. Present Chunks for Approval

` ` `
PROPOSED COMMIT CHUNKS
======================

Chunk 1: feat: add account search
Files (2):
- agent/tools.py
- queries/search_accounts.sql
Why: Core search functionality

Chunk 2: docs: update README
Files (1):
- README.md
Why: Document new feature

COMMIT ORDER: 1 -> 2
Rationale: Feature first, then docs

Does this chunking make sense?
` ` `

Wait for user approval before proceeding.

### 4. Commit Each Chunk

For each approved chunk:

**A. Stage files:**

` ` `bash
git add <files>
git status
` ` `

**B. Show commit message for review** (following CLAUDE.md format)

Wait for approval.

**C. Execute commit:**

` ` `bash
git commit -m "$(cat <<'EOF'
<type>: <subject>

---
<model_id>
EOF
)"
` ` `

**D. Confirm:**

` ` `bash
git log -1 --oneline
` ` `

Show: "Committed chunk N/M: <description>"

### 5. Edge Cases

**Single cohesive change:** Propose one chunk, confirm with user.

**User skips a chunk:** Note it, continue, remind at end.

**Conflicts:** Pause and ask user.
```

---

## ~/.claude/skills/branch-cleanup/SKILL.md

```markdown
---
name: branch-cleanup
description: Prepare a feature branch for code review. Compares against main, auto-applies safe cleanups (console.log removal, unnecessary comments), and asks for approval on structural suggestions.
---

# Branch Cleanup

Prepares feature branches for code review by removing debug statements and checking conformance with project patterns.

**When committing cleanup changes, follow the commit format in the global CLAUDE.md "Commit Messages" section.**

---

## Phase 1: Branch Discovery

**Goal**: Understand the changeset scope

**Actions**:

1. Detect current branch:

   ` ` `bash
   git branch --show-current
   ` ` `

1. Detect base branch (try main first, then master):

   ` ` `bash
   git rev-parse --verify main 2>/dev/null && echo "main" || \
     (git rev-parse --verify master 2>/dev/null && echo "master" || echo "unknown")
   ` ` `

1. Get the changeset with file statuses:

   ` ` `bash
   git diff --name-status <base>...HEAD
   ` ` `

1. Present summary to user:
   - Current branch name
   - Base branch being compared against
   - Number of files changed/added/deleted
   - List of affected files grouped by status (A=added, M=modified, D=deleted)

**Edge cases**:

- If on main/master branch, warn user and ask if they want to proceed
- If base branch cannot be detected, ask user which branch to compare against
- If there are uncommitted changes, warn user that cleanup only affects committed changes

---

## Phase 2: Project Architecture Exploration

**Goal**: Understand project conventions before suggesting changes (don't rely solely on CLAUDE.md)

**Actions**:

1. Check for and read CLAUDE.md if it exists (but treat as supplementary)

1. Identify project type by checking for:
   - `package.json` (Node/TypeScript/JavaScript)
   - `pyproject.toml` or `requirements.txt` (Python)
   - `go.mod` (Go)
   - `Cargo.toml` (Rust)
   - `pom.xml` or `build.gradle` (Java)

1. Read relevant config files for conventions:
   - `.eslintrc*`, `.prettierrc*` (JS/TS formatting)
   - `pyproject.toml` [tool.ruff] or `.flake8` (Python)
   - `.editorconfig`

1. **Directory tree analysis**:
   - Run `tree -L 2 -d` from project root to see folder structure
   - For each changed file's parent directory, examine siblings
   - Identify naming patterns: `features/`, `components/`, `services/`, `utils/`, etc.

1. **Find similar files to understand conventions**:
   - If changed file is `userService.ts`, search for `*Service.ts` to see where services typically live
   - Look at naming conventions (camelCase, kebab-case, PascalCase for files)

1. **Check for organization patterns**:
   - Feature folders: `src/features/<feature>/`
   - Type-based: `src/<type>/` (components, services, utils)
   - Domain-based: `src/<domain>/` (users, auth, billing)

1. **Test file conventions**:
   - `__tests__/` subfolder
   - `.test.ts` or `.spec.ts` alongside source
   - Separate `tests/` directory

1. **Import analysis**: Look at imports in 2-3 existing files to understand reference patterns

Build a mental map of "where things live" in this project before analyzing changes.

---

## Phase 3: Change Analysis

**Goal**: Categorize all potential cleanups by safety level

Review each changed file and categorize issues:

### SAFE AUTO-APPLY (with user confirmation)

| Category | What to look for |
|----------|------------------|
| Debug statements | `console.log`, `console.debug`, `console.warn` (debug context), `print()` (Python debug), `debugger`, `fmt.Println` (Go debug) |
| Commented-out code | Blocks of 3+ lines of commented code |
| Obvious comments | Comments that restate what the code does: `// increment i`, `// return the result` |
| Trailing whitespace | Whitespace at end of lines |
| Missing EOF newline | Files not ending with newline |

### NEEDS USER APPROVAL

| Category | What to look for |
|----------|------------------|
| File reorganization | Code that might belong in a different directory based on project patterns |
| Pattern conformance | Code style that differs from existing project patterns |
| Refactoring suggestions | Opportunities to simplify or improve code structure |
| Type/interface changes | Changes to type definitions |
| Import reordering | Reordering imports to match project conventions |
| Resolved TODOs | TODO/FIXME comments where the work appears complete |

Present analysis to user:

- Count of safe changes by category
- List of structural suggestions with explanations

---

## Phase 4: Safe Auto-Apply

**Goal**: Clean up obvious issues automatically (with permission)

**Actions**:

1. Present summary: "I found X safe changes to auto-apply across Y files:"
   - N debug statements to remove
   - N blocks of commented-out code to remove
   - N obvious comments to remove
   - N whitespace issues to fix

1. **Ask user**: "Would you like me to apply these safe changes? (I'll show you what changed after)"

1. If approved:
   - Apply changes file by file
   - Report what was changed in each file

1. If declined, skip to Phase 5

**Important**: Do NOT proceed without explicit user confirmation.

---

## Phase 5: Structural Review

**Goal**: Present structural suggestions for user decision

For each structural suggestion, present:

` ` `
## Suggestion: [Brief title]

**Location**: `path/to/file.ts:42`

**Current**:
[Code snippet showing current state]

**Suggestion**:
[What you recommend changing]

**Rationale**:
[Why this matches project patterns better - reference specific patterns found in Phase 2]

**Risk**: [Low/Medium/High] - [Brief explanation of what could go wrong]

Apply this change? (y/n/skip remaining)
` ` `

Process each suggestion:

- If approved: apply the change
- If declined: note it for summary
- If "skip remaining": stop presenting suggestions

---

## Phase 6: Delegate to pr-review-toolkit

**Goal**: Offer deeper analysis via pr-review-toolkit agents

After cleanup is complete, ask the user:

"Would you like to run pr-review-toolkit agents for deeper analysis?"

If yes, suggest:

- **code-reviewer**: Bug detection and CLAUDE.md compliance checking
- **code-simplifier**: Code clarity and maintainability improvements
- **silent-failure-hunter**: Error handling review (if catch blocks were changed)

Example suggestion:

` ` `
Your branch is cleaned up. For deeper analysis, you can run:
- "Run code-reviewer on my changes" - for bugs and style compliance
- "Run code-simplifier" - for clarity improvements
- "/pr-review-toolkit:review-pr" - for comprehensive review
` ` `

---

## Phase 7: Final Summary

**Goal**: Document the cleanup work

Present:

### Changes Applied

**Auto-applied (safe)**:

- Removed X debug statements
- Removed X commented-out code blocks
- Removed X obvious comments
- Fixed X whitespace issues

**Structural (approved)**:

- [List each approved structural change]

### Declined Suggestions

- [List any structural suggestions the user declined, so they remember what was skipped]

### Final Changeset

` ` `bash
git diff --stat <base>...HEAD
` ` `

### Next Steps

- "These cleanup changes are staged. Ready to commit?"
- Or "Run tests to verify changes didn't break anything"

---

## Quality Standards

- **Never change behavior**: Cleanup must be purely cosmetic/organizational
- **Preserve developer intent**: If something looks deliberate (even if unusual), ask rather than assume it's wrong
- **Respect project patterns**: Don't impose external preferences - match what the project already does
- **Be transparent**: Always show what will be changed before changing
- **Be reversible**: User should be able to easily undo any change with git

## Edge Cases

- **No CLAUDE.md found**: Use directory analysis and similar file patterns; be more conservative with suggestions
- **Mixed language project**: Analyze each file type separately using appropriate conventions
- **Very large changeset (>30 files)**: Ask user if they want to limit scope to specific directories
- **No changes found**: Report "branch is clean" with brief explanation of what was checked
- **Merge conflicts with base**: Warn user and suggest rebasing first before cleanup
- **Uncommitted changes present**: Warn user - cleanup analyzes committed changes only
```

---

## Notes

- The `notify-sound` hook command in settings.json should exist on your system (create a script or alias that plays a notification sound)
- The enabled plugins (`pr-review-toolkit` and `ralph-loop`) are official Claude plugins that may need to be enabled separately
- Skills with `context: fork` or `context: inherit` have special execution behavior; those without this field run in the main context
- Skills with `model: sonnet` explicitly request that model; others use the default
