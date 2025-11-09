# probe:research

**Conduct deep multi-spectrum technical research following Probe methodology.**

---

## Usage

```
/probe:research <topic>
```

**Examples**:
```
/probe:research lmcache
/probe:research llm-cache
/probe:research vector-databases
/probe:research langchain
```

---

## What This Does

Launches autonomous research agent that:
1. Creates local research directory + private GitHub repo
2. Investigates topic across 10 research spectra
3. Applies critical analysis (beyond marketing hype)
4. Generates comprehensive research artifacts
5. Commits and publishes to repository
6. Returns key findings and recommendation

**Research spectra** (all 10 investigated):
1. Fundamentals - What it is, why it exists
2. Architecture - How it works internally
3. Technical Deep-Dive - Advanced techniques
4. Academic Research - Papers, theory
5. Integration - How to adopt
6. Performance - Benchmarks (realistic)
7. Use Cases - When to apply
8. Applicability - When to use / NOT use
9. Implementation - Code examples
10. Critical FAQ - Honest Q&A

**Output**:
- Local: `~/work/sources/researchs/research-<topic>/`
- GitHub: Private repo `research-<topic>`
- Summary: Key findings, recommendation, applicability

---

## Execution

Delegate to research-conductor agent:

@./agents/research-conductor.md

**Input**: Topic from user command
**Mode**: IMPLEMENTING (autonomous execution to completion)
**Anti-Babysitting**: Enabled (executes all 10 spectra without pausing)

---

## Expected Behavior

**Agent will**:
- ✅ Execute all 10 spectra autonomously
- ✅ Challenge claims and surface limitations
- ✅ Provide honest assessment (including "doesn't fit")
- ✅ Create local + GitHub repository
- ✅ Commit research artifacts
- ✅ Return concise summary

**Agent will NOT**:
- ❌ Pause mid-research to ask "should I continue?"
- ❌ Stop at 80% to "check progress"
- ❌ Echo marketing claims uncritically
- ❌ Omit limitations or "when NOT to use"

**Time**: Varies by topic (standard: 10-30 minutes autonomous execution)

---

## After Execution

**User receives**:
1. Key findings (strengths, limitations, trade-offs)
2. Recommendation (adopt / don't adopt / alternative)
3. Applicability assessment (fits your context?)
4. Link to full research repository

**User can then**:
- Read detailed multi-spectrum research
- Learn and grow knowledge
- Form pondered conclusions
- Return to stakeholders with informed assessment

---

**Probe** - Multi-spectrum research, systematized.
