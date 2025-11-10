# probe:research

**Conduct deep multi-spectrum technical research following Probe methodology.**

---

## Usage

```
/probe:research <topic|url|text>
```

**Input types**:
- **Direct topic**: Single word/phrase (e.g., `lmcache`, `vector-databases`)
- **URL**: Article/post to analyze (extracts topic, POV, and source bias)
- **Text**: Question/statement (extracts topic and captures POV)
- **Text + URL**: User context + supporting link
- **Topic + POV**: Direct topic with `--pov` flag for explicit point of view

**Examples**:

**Direct topic**:
```
/probe:research lmcache
/probe:research vector-databases
/probe:research multi-agent-systems
```

**URL (LinkedIn post, article, documentation)**:
```
/probe:research https://linkedin.com/posts/...lmcache-analysis
/probe:research https://pub.towardsai.net/we-spent-47000-running-ai-agents
/probe:research https://docs.vllm.ai/en/latest/
```

**Text only (question or statement)**:
```
/probe:research "Would caching help with multi-agent memory management?"
/probe:research "For multi agent system, have we thought about context loss as info passes from agent to agent?"
```

**Text + URL**:
```
/probe:research "vLLM could be beneficial as we host open source models: https://docs.vllm.ai/"
/probe:research "We need guardrails for long-running agents: https://pub.towardsai.net/article"
```

**Direct topic with POV**:
```
/probe:research lmcache --pov "I heard it's 15x faster"
/probe:research vector-databases --pov "Stakeholder recommended for RAG"
```

---

## What This Does

Launches autonomous research agent that:
1. **Extracts topic from input** (URL, text, or direct topic) and confirms with user
2. **Captures POV** (Point of View) if provided - original claim, question, or assertion
3. **Detects source BIAS** if applicable (LinkedIn hype, vendor marketing, etc.)
4. Creates local research directory + private GitHub repo
5. Investigates topic across 10 research spectra (or 11 for comparative research)
6. Applies critical analysis (beyond marketing hype)
7. Generates comprehensive research artifacts
8. **Generates POV-ANALYSIS.md** (if POV exists) - dialogues with original claim/question
9. **Generates BIAS-ANALYSIS.md** (if bias detected) - counter-balances source bias
10. Commits and publishes to repository
11. Returns key findings and recommendation

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

**Output artifacts**:
- Local: `~/work/sources/researchs/research-<topic>/`
- GitHub: Private repo `research-<topic>`
- Files (always):
  - `README.md` - Overview + key findings
  - `RESEARCH.md` - Complete 10 (or 11) spectra
  - `FAQ.md` - Critical questions
- Files (conditional):
  - `POV-ANALYSIS.md` - If POV provided (dialogues with original claim/question)
  - `BIAS-ANALYSIS.md` - If bias detected (counter-balances source bias)
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
