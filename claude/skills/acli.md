---
name: acli
description: |
  Reference guide for the Atlassian CLI (acli). Use whenever Jira or Confluence
  operations are needed. Covers all subcommands, flags, and known quirks.
author: ksingh
version: 1.0.0
date: 2026-03-12
---

# acli — Atlassian CLI Usage Guide

## Auth
```bash
acli auth status                        # global status
acli jira auth status                   # jira-specific
acli confluence auth status             # confluence-specific
acli jira auth login                    # re-authenticate if broken
```

**Known cloudId bug:** `acli confluence page view` may return
"Activation id for cloudId null not found" even when authenticated.

Fallback chain:
1. Use the `eng-skills:confluence` skill.
2. If that also fails, call the Confluence REST API directly with cURL:
```bash
curl -s -u "$ATLASSIAN_EMAIL:$ATLASSIAN_API_TOKEN" \
  "https://netskope.atlassian.net/wiki/api/v2/pages/<PAGE_ID>?body-format=storage" \
  | jq .
```

---

## Jira — Work Items

### View
```bash
acli jira workitem view KEY-123                          # default fields
acli jira workitem view KEY-123 --fields '*all'          # all fields
acli jira workitem view KEY-123 --fields summary,comment
acli jira workitem view KEY-123 --json
```

### Search (JQL)
```bash
acli jira workitem search --jql "project = SPM AND assignee = currentUser()"
acli jira workitem search --jql "..." --fields "key,summary,status,assignee" --csv
acli jira workitem search --jql "..." --limit 50 --json
acli jira workitem search --jql "..." --paginate     # fetch all
acli jira workitem search --jql "..." --count        # count only
```

### Create
```bash
acli jira workitem create --summary "Title" --project SPM --type Story
acli jira workitem create --summary "Bug" --project SPM --type Bug \
  --assignee user@netskope.com --label "bug,cli" --description "Details"
acli jira workitem create --description-file desc.txt --project SPM --type Task
acli jira workitem create --generate-json            # scaffold JSON template
acli jira workitem create --from-json workitem.json
```

### Edit
```bash
acli jira workitem edit --key KEY-123 --summary "New title"
acli jira workitem edit --key "KEY-1,KEY-2" --assignee "@me"
acli jira workitem edit --key KEY-123 --labels "foo,bar" --remove-labels "old"
acli jira workitem edit --jql "project = SPM" --assignee user@netskope.com --yes
acli jira workitem edit --generate-json
```

### Transition (status change)
```bash
acli jira workitem transition --key KEY-123 --status "In Progress"
acli jira workitem transition --key "KEY-1,KEY-2" --status "Done" --yes
acli jira workitem transition --jql "project = SPM" --status "To Do" --yes
```

### Assign
```bash
acli jira workitem assign --key KEY-123 --assignee "@me"
acli jira workitem assign --key KEY-123 --assignee user@netskope.com
acli jira workitem assign --key KEY-123 --remove-assignee
```

### Comments
```bash
acli jira workitem comment list --key KEY-123
acli jira workitem comment create --key KEY-123 --body "My comment"
acli jira workitem comment create --key KEY-123 --body-file comment.txt
acli jira workitem comment update --key KEY-123 --id 10001 --body "Updated"
acli jira workitem comment delete --key KEY-123 --id 10001
```

### Links
```bash
acli jira workitem link list --key KEY-123
acli jira workitem link type                              # list available link types
acli jira workitem link create --out KEY-1 --in KEY-2 --type Blocks
acli jira workitem link create --generate-json
acli jira workitem link delete --key KEY-123 --id <link-id>
```

### Clone / Archive / Delete
```bash
acli jira workitem clone --key KEY-123 --to-project SPM
acli jira workitem archive --key "KEY-1,KEY-2" --yes
acli jira workitem delete --key KEY-123 --yes
acli jira workitem create-bulk --from-json issues.json
acli jira workitem create-bulk --from-csv issues.csv
acli jira workitem create-bulk --generate-json
```

---

## Jira — Sprints & Boards

```bash
acli jira board search --name "SPM" --type scrum
acli jira board get --id 123
acli jira board list-sprints --id 123 --state active
acli jira sprint view --id 456
acli jira sprint list-workitems --sprint 456 --board 123
acli jira sprint list-workitems --sprint 456 --board 123 --jql "assignee = currentUser()"
```

---

## Jira — Projects & Filters

```bash
acli jira project list --paginate
acli jira project view --key SPM
acli jira filter list --my
acli jira filter list --favourite
acli jira filter search --name "report" --owner user@netskope.com
acli jira filter get --id 10001
```

---

## Confluence — Pages

```bash
acli confluence page view --id 7053705560
acli confluence page view --id 7053705560 --body-format storage   # raw XHTML
acli confluence page view --id 7053705560 --body-format view       # rendered HTML
acli confluence page view --id 7053705560 --json
acli confluence page view --id 7053705560 --include-direct-children
```
**Note:** Page ID is the numeric segment in the Confluence URL:
`/wiki/spaces/SPACE/pages/<ID>/Title`

---

## Confluence — Spaces

```bash
acli confluence space list --type global
acli confluence space list --keys SPMENG,ENG --json
acli confluence space view --id 123456 --include-all
```

---

## Confluence — Blog Posts

```bash
acli confluence blog list --space-id 12345 --status current
acli confluence blog view --id 98765 --body-format storage
acli confluence blog create --space-id 12345 --title "Notes" --body "<p>...</p>"
acli confluence blog create --space-id 12345 --title "Draft" --status draft --from-file content.html
```

---

## Common Patterns

| Goal | Command |
|---|---|
| View a Jira ticket | `acli jira workitem view KEY-123 --fields '*all'` |
| Search by JQL | `acli jira workitem search --jql "..."` |
| Move ticket to status | `acli jira workitem transition --key KEY-123 --status "Done"` |
| Add comment | `acli jira workitem comment create --key KEY-123 --body "..."` |
| Read Confluence page | `acli confluence page view --id <page-id> --body-format view` |
| Extract page ID | From URL: `.../pages/<ID>/...` |
