---
name: jira
description: Fetches and formats Jira tasks, issues, subtasks, descriptions, and comments in clean Markdown. Use whenever asked to look up a Jira issue, check acceptance criteria, inspect ticket details, or summarize card progress.
---

# Jira Task Viewer Skill

Fetches and displays Jira task details (summary, formatted description, subtasks, assignees, and latest comments) in clean Markdown with zero external dependencies.

## Usage

Run the `jira <KEY>` command in the terminal:

```bash
jira PROJ-123
```

Or pass the direct card URL:

```bash
jira https://your-domain.atlassian.net/browse/PROJ-123
```

### Available Options

- `jira PROJ-123`: Displays complete view with description, subtasks, and recent comments.
- `jira PROJ-123 --no-comments`: Hides the comments section.
- `jira PROJ-123 --json`: Returns raw API data in JSON format.
- `jira --config`: Interactively reconfigures URL, email, and API Token.
