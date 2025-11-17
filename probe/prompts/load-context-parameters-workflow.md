# Load Context Parameters Workflow

**Purpose**: Parse and load optional context parameters for context-driven research

**Called from**: research-conductor.md Phase 0.5

---

## Overview

This workflow parses `--role`, `--approach`, and `--docs` flags from user command, validates file paths, loads context files, and prepares context for use throughout research phases.

**Context affects**:
- **Role**: Research framing, decision criteria, recommendation style (architect vs developer vs PM)
- **Approach**: Scoring weights (robustness vs speed vs cost), trade-off priorities
- **Docs**: Analysis scope (planned architecture docs vs generic web research)

---

## Step 1: Parse Command Arguments

**Input**: User command string from `/probe:research` invocation

**Example commands**:
```
/probe:research langgraph-agno-hybrid --role ~/.probe/context/role.md
/probe:research vector-databases --approach ~/approach.md
/probe:research lmcache --role ~/role.md --approach ~/approach.md --docs ~/docs/
```

**Actions**:

1. **Extract topic** (first argument before any flags):
   ```
   topic = <first argument>
   ```

2. **Extract `--role` flag** (if present):
   ```
   role_file = <value after --role flag>
   ```
   - If no `--role` flag: `role_file = null`

3. **Extract `--approach` flag** (if present):
   ```
   approach_file = <value after --approach flag>
   ```
   - If no `--approach` flag: `approach_file = null`

4. **Extract `--docs` flag** (if present):
   ```
   docs_path = <value after --docs flag>
   ```
   - If no `--docs` flag: `docs_path = null`

**Example parsing**:
```
Input: /probe:research langgraph-agno-hybrid --role ~/.probe/role.md --approach ~/approach.md

Parsed:
- topic = "langgraph-agno-hybrid"
- role_file = "~/.probe/role.md"
- approach_file = "~/approach.md"
- docs_path = null
```

**Output**:
- `topic`: Research topic (normalized slug)
- `role_file`: Path to role file or null
- `approach_file`: Path to approach file or null
- `docs_path`: Path to docs or null

**If all three are null**: Skip this workflow, return to research-conductor.md with `context_loaded = false`

---

## Step 2: Validate and Expand File Paths

**For each provided file path** (`role_file`, `approach_file`, `docs_path`):

### 2.1: Expand Home Directory

**If path starts with `~`**:
- Expand to actual home directory path
- Example: `~/.probe/role.md` → `/Users/daviguides/.probe/role.md`

**Tools**: Use Bash for path expansion if needed:
```bash
echo ~/.probe/role.md
```

### 2.2: Check File Existence

**For role_file and approach_file**:
- Use Read tool to attempt reading the file
- If file doesn't exist: Record error for Step 3

**For docs_path**:
- If it's a file: Check if readable
- If it's a directory: Check if exists and list contents (confirm scope)
- Record error if neither file nor directory

### 2.3: Validate Readability

**Check if file can be read**:
- Attempt to read first few lines
- If permission error or unreadable: Record error for Step 3

**Output for each path**:
- `valid`: true/false
- `expanded_path`: Expanded absolute path
- `error`: Error message if invalid (or null)

---

## Step 3: Handle Validation Errors

**If any path is invalid**:

### 3.1: Report Errors to User

Show clear error messages:
```markdown
⚠️ **Context Parameter Validation Errors**

- **Role file**: Could not read `~/.probe/role.md`
  - Error: File does not exist
  - Expected location: `/Users/daviguides/.probe/role.md`

- **Approach file**: ✅ Valid (`/Users/daviguides/approach.md`)

- **Docs path**: ⚠️ Directory not found (`~/bespin-docs/summaries/`)
  - Error: No such directory
```

### 3.2: Offer Solutions

**For missing role/approach files**:
```markdown
**Options**:
1. Provide a different path
2. Skip this context parameter (proceed without role/approach)
3. Use template from `probe/templates/research-context/`
   - Role template: `probe/templates/research-context/role-template.md`
   - Approach template: `probe/templates/research-context/product-approach-template.md`
   - Example (AccelVeo): `probe/templates/research-context/examples/accelveo-role.md`

**What would you like to do?**
```

**For missing docs path**:
```markdown
**Options**:
1. Provide correct path to docs
2. Skip docs scope (proceed with web research only)

**What would you like to do?**
```

### 3.3: Wait for User Response

- If user provides new path: Return to Step 2 with new path
- If user skips: Set that parameter to null, continue
- If user cancels: Abort research workflow

**IMPORTANT**: Do NOT proceed with invalid paths. Either fix or skip.

---

## Step 4: Load Context Files

**Execute if**: All provided paths are valid (or user chose to skip invalid ones)

### 4.1: Load Role Context

**If role_file is valid**:

1. **Read role file content**:
   ```markdown
   ## Role & Perspective Context (Loaded)

   @<expanded_role_file_path>
   ```

2. **Extract key information for summary**:
   - Job title/function (e.g., "Staff AI Architect")
   - Decision authority (e.g., "Architectural decisions, not implementation")
   - Time horizon (e.g., "5-year robustness")
   - Primary concern (e.g., "Long-term maintainability")

3. **Store role context**:
   - `role_context.loaded = true`
   - `role_context.file = <expanded_path>`
   - `role_context.summary = <extracted summary>`

**If role_file is null**:
- `role_context.loaded = false`
- `role_context.summary = "Generic (no role specified)"`

### 4.2: Load Approach Context

**If approach_file is valid**:

1. **Read approach file content**:
   ```markdown
   ## Product Approach Context (Loaded)

   @<expanded_approach_file_path>
   ```

2. **Extract key information for summary**:
   - Industry/domain (e.g., "Manufacturing / Industrial IoT")
   - Development approach (e.g., "Robustness-first, not MVP iteration")
   - Scoring weights (e.g., "Robustness 30%, Maintainability 25%")
   - Criticality level (e.g., "Safety-critical, zero tolerance")

3. **Store approach context**:
   - `approach_context.loaded = true`
   - `approach_context.file = <expanded_path>`
   - `approach_context.weights = <extracted weights>`
   - `approach_context.summary = <extracted summary>`

**If approach_file is null**:
- `approach_context.loaded = false`
- `approach_context.weights = "Balanced (no approach specified)"`

### 4.3: Load Docs Scope

**If docs_path is valid**:

1. **Determine type** (file or directory):
   - If file: Store single file path
   - If directory: List contents and store directory path

2. **Store docs scope**:
   - `docs_scope.loaded = true`
   - `docs_scope.path = <expanded_path>`
   - `docs_scope.type = "file" | "directory"`
   - `docs_scope.summary = <brief description>`

**If docs_path is null**:
- `docs_scope.loaded = false`
- `docs_scope.summary = "Web research (no docs specified)"`

---

## Step 5: Confirm Context with User

**Show context summary before proceeding**:

```markdown
## Context Parameters Loaded ✅

**Role & Perspective**:
- [If loaded] <role_context.summary>
- [If not loaded] Generic research (no role specified)

**Product Approach**:
- [If loaded] <approach_context.summary>
- [If loaded] Scoring weights: <approach_context.weights>
- [If not loaded] Balanced weights (no approach specified)

**Analysis Scope**:
- [If loaded] <docs_scope.summary>
- [If loaded] Path: `<docs_scope.path>`
- [If not loaded] Web research (no docs specified)

---

**Research will be**:
- [If any context loaded] **Context-driven**: Tailored to your role, product constraints, and analysis scope
- [If no context] **Generic**: Broad applicability, educational focus

**How context affects research**:
- [If role loaded] Research framed for <role> perspective (vs generic)
- [If approach loaded] Scoring weighted for <approach> priorities (vs balanced)
- [If docs loaded] Analysis focused on specified docs (vs web research)

**Expected output**:
- Standard research artifacts (README, RESEARCH, FAQ)
- [If POV] POV-ANALYSIS.md
- [If BIAS] BIAS-ANALYSIS.md
- [If context loaded] CONTEXT-SPECIFIC-ANALYSIS.md (quantitative scoring, tailored recommendations)

Proceed with context-driven research? (y/n)
```

**Wait for user confirmation**:
- If yes: Proceed to return context object
- If no: Ask what to adjust (role, approach, docs, or cancel)

---

## Step 6: Return Context Object

**Output to research-conductor.md**:

```markdown
**Context Parameters Loaded**:

- `context_loaded`: true | false
- `role_context`:
  - `loaded`: true | false
  - `file`: <path> | null
  - `summary`: <summary string>
- `approach_context`:
  - `loaded`: true | false
  - `file`: <path> | null
  - `weights`: <weights object> | null
  - `summary`: <summary string>
- `docs_scope`:
  - `loaded`: true | false
  - `path`: <path> | null
  - `type`: "file" | "directory" | null
  - `summary`: <summary string>
```

**This context object will be referenced in**:
- Phase 1: Mention context loaded
- Phase 3: Apply context (framing, weights, docs analysis)
- Phase 4.7: Generate CONTEXT-SPECIFIC-ANALYSIS.md

---

## Error Handling Summary

**Common errors and solutions**:

| Error | Solution |
|-------|----------|
| File not found | Offer to provide new path, skip, or use template |
| Permission denied | Check file permissions, suggest moving to accessible location |
| Invalid format | Suggest using template from `probe/templates/research-context/` |
| Directory empty | Confirm if correct directory, offer to skip |
| Path expansion failed | Show expanded path, ask for absolute path |

**Critical principle**: Do NOT proceed with invalid context. Either fix or skip.

---

## Example Execution

**Input**:
```
/probe:research langgraph-agno-hybrid --role ~/.probe/accelveo-role.md --approach ~/.probe/accelveo-approach.md --docs ~/bespin-docs/summaries/
```

**Step 1: Parse**:
- topic: "langgraph-agno-hybrid"
- role_file: "~/.probe/accelveo-role.md"
- approach_file: "~/.probe/accelveo-approach.md"
- docs_path: "~/bespin-docs/summaries/"

**Step 2: Validate**:
- role_file: ✅ Valid → `/Users/daviguides/.probe/accelveo-role.md`
- approach_file: ✅ Valid → `/Users/daviguides/.probe/accelveo-approach.md`
- docs_path: ✅ Valid → `/Users/daviguides/bespin-docs/summaries/` (directory, 15 files)

**Step 3: Skip** (no errors)

**Step 4: Load**:
- role_context: Loaded (Staff AI Architect, 5-year horizon, architectural decisions)
- approach_context: Loaded (Manufacturing, Robustness 30%, Safety-critical)
- docs_scope: Loaded (Directory with 15 architecture summary files)

**Step 5: Confirm**:
```
Context Parameters Loaded ✅

**Role**: Staff AI Architect (designing future system, 5-year horizon)
**Approach**: Manufacturing (Robustness 30%, Maintainability 25%, Safety-critical)
**Docs**: ~/bespin-docs/summaries/ (15 architecture files)

Research will be context-driven: Tailored to Staff Architect perspective, manufacturing priorities, and planned architecture docs.

Proceed? y
```

**Step 6: Return**:
- `context_loaded = true`
- All three contexts loaded with full summaries
- Research-conductor proceeds to Phase 1 with context

---

**Load Context Parameters Workflow - Context-driven research enabler**
