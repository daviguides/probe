# Conduct Multi-Spectrum Research Workflow

**Orchestrate complete deep technical research following Probe methodology.**

---

## Prerequisites

Research context MUST be loaded before starting:

@./probe/prompts/load-research-context.md

---

## Input Parameters

**Input**: `<topic|url|text>` (various formats supported)
- Direct topic: `lmcache`
- URL: `https://linkedin.com/posts/...`
- Text: `"Would caching help with multi-agent memory?"`
- Text + URL: `"vLLM could help: [url]"`
- Topic + POV: `lmcache --pov "I heard it's 15x faster"`

**Context** (automatically detected or specified):
- Familiarity level: Never heard / Vaguely familiar / Somewhat familiar / Expert
- Research goal: Evaluation / Learning / Reporting / Comparison
- Topic type: Specific tool / General concept / Comparison
- Time constraint: Quick / Standard / Exhaustive

**Extraction Output** (from Stage 0):
- Topic (normalized slug)
- POV (if exists)
- BIAS (if detected)
- Research mode (standard | comparative)

---

## Research Workflow (Anti-Babysitting)

**CRITICAL RULE**: Execute ALL 10 spectra sequentially WITHOUT PAUSING for permission.

**DO NOT**:
- Stop after fundamentals to ask "should I continue?"
- Pause mid-research to "check progress"
- Ask "is this enough detail?" (calibrate based on methodology)
- Request approval between spectra

**DO**:
- Execute all 10 spectra to completion
- Calibrate depth based on context (loaded methodology)
- Apply critical thinking at each stage
- Surface limitations and honest assessments
- ONLY stop when all spectra complete OR hard blocker encountered

---

## Stage 0: Topic Extraction (For Non-Direct Topics)

**Skip this stage if**: Input is direct topic without --pov flag (e.g., `lmcache`)

**Execute this stage if**: Input is URL, text, text+URL, or topic+--pov

### Step 0.1: Execute Topic Extraction Workflow

@./probe/prompts/extract-topic-from-input-workflow.md

**Input**: Raw user input
**Output**: Extraction object with:
- `topic`: Normalized slug for research
- `pov`: POV object (if exists)
- `bias`: BIAS object (if detected)
- `research_mode`: standard | comparative

### Step 0.2: Confirm with User

**Present extraction results**:
- Detected topic
- POV identified (if any)
- BIAS detected (if any)
- Research mode (comparative if "X vs Y")

**Wait for user confirmation** before proceeding to Stage 1.

**If user rejects**: Ask for correct topic, update extraction, re-confirm.

### Step 0.3: Store Extraction Object

**CRITICAL**: Extraction object is stored for later use:
- Topic used for research scope (Stage 1)
- POV and BIAS **ignored during research** (Stages 1-3)
- POV and BIAS used **POST-research** (Stage 4) for analysis files

**Proceed to Stage 1** (context detection).

---

## Stage 1: Context Detection and Calibration

### Step 1.1: Detect Topic Characteristics

Analyze topic to determine:
```
Topic type:
├─ Specific tool? (e.g., "lmcache", "langchain") → Tool pattern
├─ General concept? (e.g., "llm-cache", "rag") → Concept pattern
└─ Comparison request? (e.g., "vector databases") → Comparison pattern

Maturity indicators (if tool):
├─ GitHub: First commit date, last commit, contributors
├─ Releases: Version number, changelog
└─ Maturity: Cutting-edge / Mature / Legacy

Research foundation:
├─ Papers exist? → Research-driven
└─ No papers? → Engineering-focused
```

### Step 1.2: Calibrate Depth Profile

Based on loaded depth-calibration.md, determine depth allocation for 10 spectra.

Example for "Never heard of, Evaluation goal, Specific tool, Standard time":
```
Fundamentals:     80% - Need complete intro
Architecture:     60% - Understand how works
Technical:        60% - Implementation understanding
Academic:         40% - If research-driven
Integration:      80% - CRITICAL for evaluation
Performance:      80% - CRITICAL for evaluation
Use Cases:        60% - Validate fit
Applicability:    100% - MOST CRITICAL
Implementation:   40% - Complexity assessment
Critical FAQ:     80% - Address concerns
```

### Step 1.3: Set Investigation Priority

Determine investigation order (default: Sequential 1→10).

For quick assessment: Prioritize Fundamentals, Applicability, Integration, Performance, FAQ.

---

## Stage 2: Multi-Spectrum Investigation

Execute 10 spectra sequentially. For EACH spectrum:

### Spectrum N Investigation Pattern

**1. Load critical questions** for spectrum N from critical-questions-spec.md

**2. Investigate using diverse sources**:
- Official documentation
- GitHub repository (code, issues, PRs)
- Academic papers (if applicable)
- Community sources (Stack Overflow, forums, Reddit)
- Independent benchmarks (if available)

**3. Apply critical thinking**:
- Challenge claims (who benefits?)
- Verify evidence (source credibility?)
- Surface assumptions (what's hidden?)
- Identify trade-offs (what's the cost?)
- Find limitations (when does it fail?)

**4. Answer ALL critical questions** for spectrum N

**5. Generate spectrum output** following research-spectra-spec.md requirements

**6. Mark spectrum N complete, proceed to N+1** (NO PAUSING)

---

### Spectrum 1: Fundamentals

**Objective**: Provide succinct introduction for zero prior knowledge.

**Critical questions**:
- What problem does this solve that existing solutions don't?
- Why was this created? What gap did it fill?
- What are 2-3 core concepts required to understand?
- How does this fit in broader ecosystem?
- Who is the target audience?

**Output**: Clear definition, problem statement, key concepts, context.

**Depth calibration**: HIGH if never heard of it, LOW if expert deep-dive.

**Continue to Spectrum 2** (no pause).

---

### Spectrum 2: Architecture

**Objective**: Explain how the system works internally.

**Critical questions**:
- What are major components and their roles?
- How do components interact? (data/control flow)
- What are key design decisions and rationales?
- What are integration points with external systems?
- What architectural patterns are employed?

**Output**: Component diagram, flow description, design decisions.

**Continue to Spectrum 3** (no pause).

---

### Spectrum 3: Technical Deep-Dive

**Objective**: Explore advanced technical details, algorithms, optimizations.

**Critical questions**:
- What algorithms or techniques enable core functionality?
- What optimizations are applied and why?
- How are edge cases and failures handled?
- What are implementation constraints or limitations?
- What makes this technically different from alternatives?

**Output**: Technical mechanisms, advanced features, edge cases.

**Depth calibration**: HIGH for research-driven or expert deep-dive.

**Continue to Spectrum 4** (no pause).

---

### Spectrum 4: Academic Research

**Objective**: Review underlying research, papers, theoretical foundations.

**Critical questions**:
- What papers or research does this build upon?
- What novel techniques or contributions introduced?
- What is theoretical foundation?
- What prior work improved upon, and how?
- What open research questions remain?

**Output**: Papers cited, theoretical concepts, novelty assessment.

**Acceptable**: "Not research-driven. Engineering-focused project." (if true)

**Continue to Spectrum 5** (no pause).

---

### Spectrum 5: Integration

**Objective**: Understand how to integrate/adopt.

**Critical questions**:
- What are hard prerequisites? (infrastructure, dependencies)
- What frameworks/libraries is this compatible with?
- What is installation/setup complexity?
- What does migration from existing solution require?
- What are configuration options and implications?

**Output**: Installation steps, prerequisites, compatibility matrix.

**Depth calibration**: HIGH for evaluation goal (can I adopt?).

**Continue to Spectrum 6** (no pause).

---

### Spectrum 6: Performance

**Objective**: Evaluate real-world performance with critical analysis.

**Critical questions**:
- What are performance metrics under REALISTIC conditions?
- Under what conditions were benchmarks measured?
- What is WORST-CASE performance?
- What are performance trade-offs?
- How does performance scale with load/data size?
- Independent benchmarks or only vendor claims?

**Output**: Quantitative metrics, conditions, best/typical/worst case.

**CRITICAL**: Challenge vendor benchmarks, seek independent verification.

**Continue to Spectrum 7** (no pause).

---

### Spectrum 7: Use Cases

**Objective**: Document practical applications and when to use.

**Critical questions**:
- What are 3-5 specific, concrete use cases?
- WHY does this work well for each use case?
- Are there production deployments? Where and by whom?
- What problem does each use case solve?
- Are use cases representative or narrow niche?

**Output**: 3-5 concrete use cases with WHY explanations.

**Continue to Spectrum 8** (no pause).

---

### Spectrum 8: Applicability (MOST CRITICAL)

**Objective**: Critical assessment of when to use and when NOT to use.

**Critical questions** (MOST IMPORTANT):
- Under what conditions does this work WELL?
- Under what conditions does this work POORLY or FAIL? **← KEY**
- What are explicit trade-offs?
- When should I NOT use this? **← KEY**
- Does this solve MY problem? (context-specific)
- What constraints does MY environment impose?

**Output**:
- ✅ "Works well for" section
- ❌ "Less suitable for" section **← MANDATORY**
- ⚠️ "Trade-offs" section **← MANDATORY**
- Decision framework

**VALIDATION**: ❌ section MUST be as prominent as ✅ section.

**Depth calibration**: 100% depth regardless of other factors (always critical).

**Continue to Spectrum 9** (no pause).

---

### Spectrum 9: Implementation

**Objective**: Provide practical code, configuration, setup guidance.

**Critical questions**:
- Can I get this running with working code examples?
- What are common pitfalls during implementation?
- What configuration is needed for production?
- How do I debug when things go wrong?
- What are best practices?

**Output**: Functional code, production config, troubleshooting.

**Continue to Spectrum 10** (no pause).

---

### Spectrum 10: Critical FAQ

**Objective**: Answer realistic questions with honest, anti-hype responses.

**Critical questions**:
- What are most common misconceptions?
- Does this work with <popular alternative>?
- What does vendor claim that is misleading?
- What alternatives exist and how does this compare?
- What are costs (money, time, complexity)?
- What realistic ROI can I expect?

**Output**: 5-10 critical questions with HONEST answers.

**VALIDATION**: At least 1 explicit "NO" answer required.

**Common "NO" questions**:
- "Does it work with <incompatible system>?" → NO
- "Will I always get <best-case metric>?" → NO
- "Is it <zero-cost claim>?" → NO

**Mark research COMPLETE** (all 10 spectra investigated).

---

## Stage 3: Synthesis and Validation

### Step 3.1: Validate Completeness

Check against validation-spec.md:
- [ ] All 10 spectra covered
- [ ] All critical questions answered
- [ ] Source diversity (3+ source types)
- [ ] Limitations surfaced (❌ sections present)
- [ ] Trade-offs explicit
- [ ] At least 1 "NO" answer in FAQ

### Step 3.2: Validate Depth

Check:
- [ ] Beyond "what" to "how" and "why"
- [ ] Limitations as prominent as benefits
- [ ] Trade-offs paired with benefits
- [ ] Comparative analysis (not isolated)
- [ ] Academic foundation (if research-driven)

### Step 3.3: Validate Quality

Check:
- [ ] Critical skepticism applied (claims challenged)
- [ ] Realistic performance expectations (best/typical/worst)
- [ ] Applicability to context assessed
- [ ] Honest FAQ (including "NO" answers)

### Step 3.4: Synthesis

Generate research summary:
```markdown
# <Topic> Research Summary

## TL;DR

[1-2 paragraphs: What it is, key finding, recommendation]

## Key Findings

✅ Strengths: [3-5 bullet points]
❌ Limitations: [3-5 bullet points]
⚠️ Trade-offs: [2-3 key trade-offs]

## Recommendation

[Evaluation goal: Adopt / Do not adopt / Further investigation / Alternative recommended]
[Learning goal: Summary of knowledge gained]
[Reporting goal: Executive summary for stakeholders]

## Applicability to Our Use Case

[Context-specific assessment]
[Does it fit? Yes/No/Partially]
[If No: Why not + Alternative suggested]
```

---

## Stage 4: Output Generation

### Step 4.1: Generate Core Research Files

Create structured research output (format flexible, but must include all 10 spectra).

**Always generate**:
```
README.md - Overview, TL;DR, key findings
RESEARCH.md - Complete multi-spectrum investigation (10 or 11 spectra)
FAQ.md - Critical questions and answers
```

**For comparative research** (research_mode = comparative):
- RESEARCH.md includes **Spectrum 11: Comparative Analysis**
- Side-by-side comparison of both topics
- Recommendations for choosing between them

### Step 4.2: Generate POV-ANALYSIS.md (If POV Exists)

**Trigger**: Check extraction object → `pov.exists = true`

**Execute**:
1. Reference extraction object for POV claims
2. Reference RESEARCH.md for findings
3. Generate POV-ANALYSIS.md following @./probe/spec/pov-bias-analysis-spec.md

**Structure**:
- Original POV reproduced
- Claims extracted vs research findings
- Assessment: ✅ confirmed | ❌ refuted | ⚠️ partially true
- Answer to original question (if POV is question)
- Summary: POV vs Reality
- Recommendation in light of POV

**CRITICAL**: Use research findings to assess POV claims
- Do NOT re-research
- Reference completed RESEARCH.md
- Focus on claim validation

### Step 4.3: Generate BIAS-ANALYSIS.md (If BIAS Detected)

**Trigger**: Check extraction object → `bias.exists = true` AND bias is significant

**Execute**:
1. Reference extraction object for bias characteristics
2. Reference RESEARCH.md for counter-balancing
3. Generate BIAS-ANALYSIS.md following @./probe/spec/pov-bias-analysis-spec.md

**Structure**:
- Source type identified
- Bias characteristics documented
- What bias emphasized vs omitted
- Counter-balancing: Complete picture from research
- Adjusted perspective
- What to trust vs verify vs ignore

**CRITICAL**: Use research findings to counter-balance bias
- Show what source omitted
- Provide missing context
- Balanced assessment

### Step 4.4: Final Artifact Structure

```
research-<topic>/
├── README.md              (always)
├── RESEARCH.md            (always - 10 or 11 spectra)
├── FAQ.md                 (always)
├── POV-ANALYSIS.md        (if POV exists)
└── BIAS-ANALYSIS.md       (if BIAS detected)
```

### Step 4.5: Commit to Research Repository

Commit all research files to `~/work/sources/researchs/research-<topic>/`.

Push to GitHub private repo `research-<topic>`.

### Step 4.6: Report to User

Return concise summary to user with:
- Key findings (strengths, limitations, trade-offs)
- Recommendation (adopt / don't adopt / alternative)
- **POV assessment** (if POV existed): How POV aligned with reality
- **Bias counter-balance** (if BIAS detected): What source missed
- Link to research repository
- List of generated files (including POV-ANALYSIS, BIAS-ANALYSIS if present)

---

## Anti-Babysitting Enforcement

**RULE**: Execute Stage 2 (all 10 spectra) WITHOUT pausing.

**Prohibited pauses**:
- ❌ "I've completed Fundamentals. Should I continue to Architecture?"
- ❌ "I've finished 5 spectra. Want to review before I continue?"
- ❌ "Research is 80% done. Should I complete the last 2 spectra?"

**NEVER ask these questions. ALWAYS continue until all 10 complete.**

**Only valid stop conditions**:
1. All 10 spectra complete (success)
2. Hard blocker: Tool doesn't exist, topic nonsensical, access impossible

**If uncertain about detail level**: Use calibrated depth profile, err toward deeper (can always summarize later).

**If research reveals it doesn't fit**: STILL complete all 10 spectra (thoroughness matters even for rejection).

---

## Context-Specific Adaptations

### Quick Assessment (2-4h)

Priority spectra only: 1 (Fundamentals), 5 (Integration), 6 (Performance), 8 (Applicability), 10 (FAQ).

Others: Minimal coverage.

### Standard Research (8-16h)

All 10 spectra, depth calibrated per methodology.

### Exhaustive Investigation (24-40h)

All 10 spectra at high depth, source code review, hands-on testing.

---

## Success Criteria

Research is **complete** when:
- [ ] All 10 spectra investigated
- [ ] All critical questions answered
- [ ] Validation checks passed (completeness, depth, quality)
- [ ] Limitations surfaced as prominently as benefits
- [ ] Honest assessment provided (including "doesn't fit" if true)
- [ ] Research artifacts generated and committed

Research is **high-quality** when:
- [ ] Goes beyond vendor marketing
- [ ] Provides informed recommendation
- [ ] Enables user to make pondered decision
- [ ] Withstands stakeholder scrutiny

---

## Output Delivery

Return to user:
1. **Summary**: Key findings, recommendation, applicability assessment
2. **Repository link**: Full research in `~/work/sources/researchs/research-<topic>/`
3. **Next steps** (if recommended for adoption): Integration plan outline

**User can then**:
- Read detailed research
- Learn and grow knowledge
- Form pondered conclusions
- Return to stakeholders with informed assessment

---

**Probe research complete.**
