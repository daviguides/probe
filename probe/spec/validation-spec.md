# Research Validation Specification

**Objective criteria for validating research completeness, depth, and quality.**

---

## Purpose

**Validation** = Objective assessment that research meets Probe standards.

Prevents research from being published until it meets depth and quality requirements.

**REQUIREMENT**: Research MUST pass ALL validation checks before being considered complete.

---

## Validation Levels

### Level 1: Completeness Validation

**Checks**: Are all required components present?

### Level 2: Depth Validation

**Checks**: Does research go beyond surface level?

### Level 3: Quality Validation

**Checks**: Is research critical, realistic, and useful?

**REQUIREMENT**: Pass all 3 levels.

---

## Level 1: Completeness Validation

### Rule 1.1: All Spectra Covered

**Check**: All 10 research spectra MUST be investigated.

```bash
Required spectra:
- [ ] Fundamentals
- [ ] Architecture
- [ ] Technical Deep-Dive
- [ ] Academic Research
- [ ] Integration
- [ ] Performance
- [ ] Use Cases
- [ ] Applicability
- [ ] Implementation
- [ ] Critical FAQ
```

**Validation**: Each spectrum has dedicated section or content addressing it.

**Failure**: ANY spectrum missing or only stub content.

### Rule 1.2: All Critical Questions Answered

**Check**: ALL mandatory questions from critical-questions-spec.md MUST be answered.

**Validation**: For each spectrum, verify all mandatory questions have substantive answers.

**Failure**: ANY mandatory question unanswered or answered with placeholder ("TBD", "TODO", "N/A" without explanation).

### Rule 1.3: Source Diversity

**Check**: Research MUST draw from multiple source types.

**Required source types**:
- [ ] Official documentation
- [ ] Academic papers (if available) or engineering blogs
- [ ] Community sources (GitHub issues, Stack Overflow, forums)
- [ ] Independent benchmarks or analyses (if available)

**Minimum**: 3 of 4 source types represented.

**Failure**: Only vendor documentation used, or single source type.

### Rule 1.4: Structural Completeness

**Check**: Research includes all required structural elements.

**Required elements**:
- [ ] Introduction / What is it
- [ ] How it works / Architecture
- [ ] Technical details
- [ ] Performance data
- [ ] ✅ "When to use" section
- [ ] ❌ "When NOT to use" section
- [ ] ⚠️ Trade-offs section
- [ ] Critical FAQ

**Validation**: Each element is present with substantive content.

**Failure**: Missing "when NOT to use" or "trade-offs" sections (most common).

---

## Level 2: Depth Validation

### Rule 2.1: Beyond "What" to "How" and "Why"

**Check**: Research explains mechanisms, not just descriptions.

**Shallow** (FAIL):
```markdown
LMCache caches LLM responses to improve performance.
```

**Deep** (PASS):
```markdown
LMCache caches KV (key-value) tensors from transformer attention layers.
When context repeats, cached KV are reused, skipping expensive self-attention
computation. Enables 10x TTFT reduction for high cache-hit scenarios.

How: Hash prompt → lookup KV in multi-tier cache → hit? reuse : compute
Why: Self-attention is O(n²), dominant cost for long contexts
```

**Validation**: Technical mechanisms explained, not just high-level claims.

### Rule 2.2: Limitations Surfaced

**Check**: Research MUST explicitly identify limitations.

**Required**:
- [ ] At least 3 specific limitations stated
- [ ] "When NOT to use" section with concrete scenarios
- [ ] Performance worst-case documented

**Shallow** (FAIL):
```markdown
LMCache works well for chatbots and RAG.
```

**Deep** (PASS):
```markdown
✅ Works well for: Chatbots, RAG, few-shot learning
❌ NOT suitable for:
- API-based LLMs (OpenAI, Claude) - incompatible
- Unique queries without context reuse - no benefit
- Storage-constrained environments - requires GB cache
- Rapid context switching - low hit rate
```

**Validation**: Negative cases stated as prominently as positive cases.

### Rule 2.3: Trade-Offs Explicit

**Check**: Benefits come with costs. Both MUST be stated.

**Pattern**: "You get X, but you pay Y"

**Shallow** (FAIL):
```markdown
LMCache reduces latency by 10x.
```

**Deep** (PASS):
```markdown
LMCache reduces latency by 3-15x (depends on cache hit rate).

Trade-off:
- Gain: Latency reduction, GPU utilization freed
- Cost: Storage overhead (1GB per 1M tokens), cache management complexity
- Constraint: Requires local LLM deployment (vLLM/SGLang), not API-compatible
```

**Validation**: For every major benefit, corresponding cost or constraint is stated.

### Rule 2.4: Comparative Analysis

**Check**: Technology assessed relative to alternatives, not in isolation.

**Required**:
- [ ] At least 2 alternatives identified
- [ ] Comparative strengths/weaknesses stated
- [ ] Decision criteria provided

**Shallow** (FAIL):
```markdown
LMCache is fast.
```

**Deep** (PASS):
```markdown
Comparison:
- LMCache: Best for local LLMs, high control, setup complexity
- Prompt Caching (OpenAI/Anthropic): Best for API users, 50% discount, less control
- vLLM native prefix caching: Simpler, less flexible (prefix-only)

Decision:
- Local deployment + context reuse → LMCache
- API-based + simple caching → Prompt Caching APIs
- No context reuse → None needed
```

**Validation**: Comparative context provided, not absolute claims.

### Rule 2.5: Academic Foundation (If Applicable)

**Check**: Research-driven technologies MUST reference underlying papers.

**Required** (if academic research exists):
- [ ] Foundational papers identified
- [ ] Key contributions summarized
- [ ] Novelty assessed

**Acceptable**: "Not research-driven. Engineering-focused project." (if true)

**Failure**: Research-driven technology with no papers reviewed.

---

## Level 3: Quality Validation

### Rule 3.1: Critical Skepticism Applied

**Check**: Research challenges claims, doesn't echo marketing.

**Red flags** (FAIL):
- Superlatives without caveat ("fastest", "best", "revolutionary")
- Vendor claims repeated verbatim
- No "NO" answers in FAQ
- Benchmarks accepted uncritically
- Only positive aspects discussed

**Green flags** (PASS):
- Claims contextualized ("fastest for X under Y conditions")
- Critical questions asked ("Is this realistic?")
- Honest "NO" answers included
- Benchmarks analyzed for conditions and limitations
- Negative cases documented

**Validation**: At least 3 vendor claims challenged or contextualized.

### Rule 3.2: Realistic Performance Expectations

**Check**: Performance data includes typical and worst-case, not just best-case.

**Required**:
- [ ] Benchmark conditions stated
- [ ] Typical-case performance (not just best)
- [ ] Worst-case performance
- [ ] Performance trade-offs

**Shallow** (FAIL):
```markdown
LMCache provides 15x speedup.
```

**Deep** (PASS):
```markdown
LMCache speedup depends on cache hit rate:
- Best case (100% hit): 15x
- Typical case (70% hit): 8-10x
- Mixed (50% hit): 3-5x
- Worst case (0% hit): slight overhead (~5%)

Conditions: Multi-round QA, 2K context, H100 GPU.
Worst case: Unique queries without reuse.
```

**Validation**: Performance range provided, not single number.

### Rule 3.3: Applicability to Research Context

**Check**: Research assesses if technology solves SPECIFIC problem (not just generic).

**Required**:
- [ ] Applicability to user's context evaluated
- [ ] Prerequisites checked against environment constraints
- [ ] "Does this solve MY problem?" answered

**Generic** (FAIL):
```markdown
LMCache is useful for chatbots.
```

**Context-Specific** (PASS):
```markdown
Applicability to our use case:
- Our context: API-based LLMs (OpenAI), dynamic context per query
- LMCache requires: Local deployment, context reuse
- Verdict: NOT applicable. LMCache incompatible with APIs.
- Alternative: OpenAI Prompt Caching (50% discount on cached tokens)
```

**Validation**: Specific assessment for user's context, not generic claims.

### Rule 3.4: Honest FAQ

**Check**: FAQ addresses realistic questions with honest answers, including "NO".

**Required**:
- [ ] At least 5 critical questions
- [ ] At least 1 "NO" answer
- [ ] Common misconceptions corrected
- [ ] Alternatives mentioned

**Marketing FAQ** (FAIL):
```markdown
Q: Is LMCache easy to use?
A: Yes, very easy!

Q: Does it improve performance?
A: Yes, up to 15x!
```

**Honest FAQ** (PASS):
```markdown
Q: Does LMCache work with OpenAI/Claude?
A: NO. Requires local LLM deployment. Use Prompt Caching APIs instead.

Q: Will I always get 15x speedup?
A: NO. Depends on cache hit rate. 0% hit = no benefit, slight overhead.

Q: Is setup easy?
A: Moderate complexity. Requires: vLLM/SGLang setup, cache storage config,
hit rate tuning. Not plug-and-play like API caching.
```

**Validation**: FAQ goes beyond vendor documentation, includes limitations.

---

## Automated Validation Checks

### Check 1: Keyword Presence

**Anti-naive keywords** (MUST be present):
- "limitation" or "constraint"
- "trade-off" or "trade off"
- "not suitable" or "less adequate" or "doesn't work for"
- "worst case" or "worst-case"

**Failure**: Zero instances of anti-naive keywords = likely superficial.

### Check 2: Negative Indicators Presence

**Required symbols/indicators**:
- ✅ (positive cases)
- ❌ (negative cases - MUST be present)
- ⚠️ (warnings or trade-offs)

**Validation**: ❌ indicators present, not just ✅.

**Failure**: Only ✅, no ❌ = missing limitations.

### Check 3: "NO" Answers in FAQ

**Required**: At least 1 explicit "NO" answer in FAQ.

**Common "NO" questions**:
- "Does it work with <incompatible system>?"
- "Will I always get <best-case metric>?"
- "Is it <zero-cost claim>?"

**Validation**: FAQ contains "NO." or "NO," (explicit negative).

**Failure**: All FAQ answers positive = marketing echo, not critical.

### Check 4: Performance Range

**Required**: Performance metrics as ranges, not single numbers.

**Pattern**: "X-Y" (e.g., "3-15x", "50-80%")

**Validation**: At least 2 performance ranges present.

**Failure**: Only single-point metrics = cherry-picked data.

---

## Validation Workflow

### Step 1: Automated Checks

Run automated validation:
```bash
./probe/scripts/validate-research.sh <research-dir>
```

Checks:
- All spectra present
- Anti-naive keywords present
- ❌ indicators present
- "NO" answers in FAQ
- Performance ranges

**Gate**: MUST pass automated checks before manual review.

### Step 2: Manual Completeness Review

Reviewer checks:
- [ ] All 10 spectra covered
- [ ] All critical questions answered
- [ ] Source diversity (3+ source types)
- [ ] Structural elements present

**Gate**: MUST pass completeness before depth review.

### Step 3: Manual Depth Review

Reviewer assesses:
- [ ] Mechanisms explained (how/why, not just what)
- [ ] Limitations surfaced prominently
- [ ] Trade-offs explicit
- [ ] Comparative analysis present
- [ ] Academic foundation (if applicable)

**Gate**: MUST pass depth before quality review.

### Step 4: Manual Quality Review

Reviewer evaluates:
- [ ] Critical skepticism applied
- [ ] Realistic performance expectations
- [ ] Applicability to context assessed
- [ ] Honest FAQ with limitations

**Gate**: MUST pass quality to be published.

### Step 5: Final Approval

**Criteria**: Passed automated + all manual reviews.

**Action**: Research approved for publication to repo.

---

## Failure Modes and Remediation

### Failure: Missing Spectrum

**Symptom**: Spectrum X not covered.

**Remediation**: Investigate spectrum X, answer all critical questions.

### Failure: Superficial Answers

**Symptom**: Critical questions answered with 1-sentence generic responses.

**Remediation**: Expand answers with specifics, examples, data.

### Failure: Marketing Echo

**Symptom**: Research repeats vendor claims, no critical analysis.

**Remediation**: Challenge claims, verify with independent sources, surface limitations.

### Failure: Missing Limitations

**Symptom**: No "when NOT to use" section, no ❌ indicators.

**Remediation**: Explicitly identify failure modes, incompatibilities, constraints.

### Failure: Positive-Only Bias

**Symptom**: All FAQ answers "YES", no negative cases.

**Remediation**: Add honest "NO" answers, correct misconceptions.

---

## Quality Metrics

### Metric 1: Critical Question Coverage

**Calculation**: Answered questions / Total mandatory questions

**Target**: 100%

**Acceptable**: ≥95% (some may be legitimately N/A)

**Failure**: <90%

### Metric 2: Source Diversity Score

**Calculation**: Unique source types / 4

**Target**: 100% (all 4 types)

**Acceptable**: ≥75% (3 of 4 types)

**Failure**: <50% (only 1-2 types)

### Metric 3: Limitation Density

**Calculation**: Limitation statements / Total claims

**Target**: ≥30% (every 3 claims, 1 limitation)

**Acceptable**: ≥20%

**Failure**: <10% (mostly positive claims)

### Metric 4: FAQ Honesty Score

**Calculation**: "NO" answers / Total FAQ questions

**Target**: ≥20% (1 in 5 is "NO")

**Acceptable**: ≥15%

**Failure**: 0% (all answers positive)

---

## Summary

**Validation ensures**:
1. **Completeness**: All spectra and questions covered
2. **Depth**: Beyond surface to mechanisms and analysis
3. **Quality**: Critical, realistic, context-aware

**Three-level process**:
- Level 1: Completeness (all parts present)
- Level 2: Depth (goes beyond obvious)
- Level 3: Quality (critical and realistic)

**Gates**: Must pass each level sequentially.

**Metrics**: Objective measurements of coverage, diversity, criticality.

**Failure remediation**: Specific actions for each failure mode.

**Standard**: Research published only after passing all validation.
