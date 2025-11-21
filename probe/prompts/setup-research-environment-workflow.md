# Setup Research Environment Workflow

**Create local research directory and private GitHub repository for research artifacts.**

---

## Purpose

Before conducting research, setup organized environment:
1. Local directory: `~/work/sources/probes/probe-<topic>`
2. Private GitHub repo: `research-<topic>`
3. Git initialization and connection

---

## Input

**Topic**: `<research-topic>` (e.g., "lmcache", "llm-cache", "vector-databases")

---

## Step 1: Generate Repository Name

Call script to generate appropriate repo name:

```bash
./probe/scripts/generate-repo-name.sh "<topic>"
```

**Script logic**:
- Specific tool: lowercase, no spaces (e.g., "lmcache" → "research-lmcache")
- General concept: lowercase, hyphens (e.g., "llm cache" → "research-llm-cache")
- Comparison: category name (e.g., "vector databases" → "research-vector-databases")

**Output**: `research-<normalized-name>`

---

## Step 2: Create Local Research Directory

```bash
./probe/scripts/create-research-repo.sh "<repo-name>"
```

**Script actions**:
1. Create directory: `~/work/sources/researchs/<repo-name>/`
2. Initialize git repository
3. Create initial structure:
   ```
   research-<topic>/
   ├── README.md (placeholder)
   ├── .gitignore
   └── notes/ (for intermediate research notes)
   ```

---

## Step 3: Create Private GitHub Repository

**Use GitHub CLI**:

```bash
cd ~/work/sources/researchs/<repo-name>

gh repo create <repo-name> \
  --private \
  --description "Deep technical research: <topic>" \
  --source=. \
  --remote=origin \
  --push
```

**Validation**: Verify repo created and connected:
```bash
gh repo view
git remote -v
```

---

## Step 4: Initial Commit

```bash
cd ~/work/sources/researchs/<repo-name>

git add .
git commit -m "chore: initialize research repository for <topic>"
git push -u origin main
```

---

## Output

Return to caller:
```json
{
  "local_path": "~/work/sources/probes/probe-<topic>",
  "github_repo": "daviguides/research-<topic>",
  "status": "ready"
}
```

---

## Error Handling

**If directory exists**:
- Check if empty or has content
- If empty: Proceed
- If has content: Warn user, ask to backup or delete

**If GitHub repo exists**:
- Check if already connected to local
- If yes: Use existing
- If no: Warn user about name collision

**If gh CLI not available**:
- Error: "GitHub CLI (gh) required. Install: brew install gh"
- Halt setup

---

## Success Criteria

- [ ] Local directory created: `~/work/sources/probes/probe-<topic>/`
- [ ] Git initialized
- [ ] GitHub private repo created
- [ ] Local repo connected to GitHub (origin remote)
- [ ] Initial commit pushed

---

**Environment ready for research conduct.**
