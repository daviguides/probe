# Research Methodology Specification

**Normative definition of deep technical research vs naive investigation.**

---

## Core Philosophy

### Research Depth Principle

**Deep research** = Critical analysis that challenges claims, exposes trade-offs, and assesses real-world applicability.

**Naive research** = Surface-level acceptance of marketing materials without critical evaluation.

**RULE**: Every research output MUST go beyond "what the vendor says" to "what the reality is".

---

## Research Quality Criteria

### Criterion 1: Source Diversity

**REQUIREMENT**: Investigate from multiple authoritative sources.

**Prohibited**:
- Single vendor documentation as sole source
- LinkedIn posts treated as factual
- Marketing materials accepted uncritically
- Unverified claims propagated

**Required**:
- Academic papers (if available)
- Production case studies
- Community discussions (GitHub issues, Stack Overflow)
- Comparative analysis with alternatives
- Benchmark data from independent sources

### Criterion 2: Critical Skepticism

**REQUIREMENT**: Question every claim, especially positive ones.

**Critical questions**:
- "Who benefits from this claim?"
- "What are the unstated limitations?"
- "When would this NOT work?"
- "What trade-offs are being hidden?"
- "Is the benchmark cherry-picked?"

**Red flags - naive acceptance**:
- "X is the fastest/best/most popular"
- "Revolutionary breakthrough"
- "Solves all problems"
- No limitations mentioned
- Only positive aspects discussed

### Criterion 3: Trade-Off Analysis

**REQUIREMENT**: Every technology has trade-offs. Surface them explicitly.

**Pattern**:
```
✅ Works well for: <specific conditions>
❌ Less suitable for: <specific conditions>
⚠️ Trade-offs: <what you give up to get benefits>
```

**Example (from LMCache research)**:
```
✅ Perfect for: Chatbots (system prompt + history reused)
❌ Less adequate for: Unique queries without reuse
⚠️ Trade-off: Storage overhead vs latency reduction
```

### Criterion 4: Applicability Assessment

**REQUIREMENT**: Evaluate if technology solves YOUR problem, not just A problem.

**Critical questions**:
- "Does this fit our use case?"
- "What constraints does our environment impose?"
- "Are the prerequisites met?"
- "What would adoption cost?"

**Anti-pattern**: Researching technology without context of intended application.

### Criterion 5: Realistic Performance Data

**REQUIREMENT**: Distinguish marketing benchmarks from realistic expectations.

**Skeptical analysis**:
- "Under what conditions was this measured?"
- "Are conditions representative of production?"
- "What is worst-case performance?"
- "What are the error bars / confidence intervals?"

**Required metrics**:
- Best case AND worst case
- Typical case (not just optimal)
- Conditions under which measured
- Independent verification if possible

---

## Research Objectives

### Primary Objective

**Enable informed, pondered decision-making** by the researcher (Staff AI Architect).

Output is NOT for immediate execution. Output is for:
1. Learning and knowledge growth
2. Critical evaluation
3. Pondered conclusions
4. Informed recommendations to stakeholders

### Secondary Objectives

**Go beyond the obvious**:
- Stakeholders expect more than naive research
- Surface insights not readily apparent
- Challenge positive-biased sources (LinkedIn, vendor blogs)
- Provide realistic assessment

**Build structured knowledge**:
- Create reusable research artifacts
- Document learning journey (intro → deep)
- Enable future reference

---

## Anti-Patterns: Naive Research

### Anti-Pattern 1: Vendor Echo Chamber

**Problem**: Repeating vendor claims without verification.

```markdown
❌ NAIVE:
"LMCache is the fastest KV cache for LLMs, providing 15x speedup."

✅ CRITICAL:
"LMCache claims 15x speedup for specific workloads (multi-round QA, long context).
Benchmarks show 3-15x range depending on cache hit rate. Less suitable for
unique queries without reuse."
```

### Anti-Pattern 2: Missing Limitations

**Problem**: Only discussing when technology works, not when it doesn't.

```markdown
❌ NAIVE:
"CacheBlend achieves 100% cache hit rate in RAG."

✅ CRITICAL:
"CacheBlend achieves up to 100% cache hit rate in RAG when:
- Documents are reused across queries
- Context changes are partial, not complete
- ~15% selective recomputation is acceptable
Does NOT help when every query has unique context."
```

### Anti-Pattern 3: Uncritical Comparison

**Problem**: Comparing without context, accepting vendor comparisons.

```markdown
❌ NAIVE:
"X is better than Y."

✅ CRITICAL:
"X outperforms Y for <specific use case> because <technical reason>.
Y is superior for <different use case> due to <trade-off>.
Choice depends on: <decision criteria>."
```

### Anti-Pattern 4: Ignoring Prerequisites

**Problem**: Researching technology without checking compatibility.

```markdown
❌ NAIVE:
"LMCache reduces latency by 10x."

✅ CRITICAL:
"LMCache reduces latency IF:
- You run LLMs locally (vLLM, SGLang)
- NOT compatible with API-based LLMs (OpenAI, Anthropic)
- Requires managing infrastructure
Our use case: API-based → LMCache NOT applicable. Alternative: Prompt Caching APIs."
```

### Anti-Pattern 5: Shallow Technical Understanding

**Problem**: Describing WHAT without understanding HOW or WHY.

```markdown
❌ NAIVE:
"LMCache caches LLM responses."

✅ CRITICAL:
"LMCache caches KV (key-value) tensors from attention mechanism, not text responses.
Enables prefix reuse at architectural level. Works by:
1. Computing KV for context
2. Storing in multi-tier cache (GPU → CPU → Disk → Redis)
3. Reusing cached KV for matching prefixes
4. Advanced: Non-prefix reuse via position-independent caching (Epic)"
```

---

## Research Progression Levels

### Level 0: Pre-Research (Starting Point)

**State**: Never heard of the topic.

**Needs**:
- Succinct introduction
- Basic concepts explained
- Context for why it exists
- Problem it solves

**Output**: "What is X?" answered clearly.

### Level 1: Foundational Understanding

**State**: Know what it is, not how it works.

**Needs**:
- Architecture overview
- Key components
- How it works (high-level)
- Comparison to alternatives

**Output**: Can explain X to others.

### Level 2: Technical Deep-Dive

**State**: Understand how it works, ready for details.

**Needs**:
- Implementation details
- Advanced techniques
- Performance characteristics
- Edge cases and limitations

**Output**: Can evaluate if X fits specific use case.

### Level 3: Critical Evaluation

**State**: Deep technical understanding, assessing applicability.

**Needs**:
- Real-world usage patterns
- Production considerations
- Trade-off analysis
- Decision framework

**Output**: Can make informed recommendation.

**REQUIREMENT**: All research MUST reach Level 3.

---

## Validation Rules

### Completeness Check

Research is **incomplete** if ANY of the following is missing:
- [ ] Succinct introduction (Level 0)
- [ ] Architecture/how it works (Level 1)
- [ ] Technical deep-dive (Level 2)
- [ ] Trade-offs and limitations
- [ ] Applicability assessment
- [ ] Comparison with alternatives
- [ ] Performance data (realistic, not marketing)
- [ ] Prerequisites and constraints
- [ ] When to use / when NOT to use

### Quality Check

Research is **low-quality** if:
- Relies primarily on vendor materials
- Lacks critical analysis
- Omits limitations or trade-offs
- Accepts benchmarks uncritically
- No independent verification
- Missing "when NOT to use" section

### Depth Check

Research is **shallow** if:
- Stops at "what" without "how" or "why"
- No technical details beyond overview
- No source code or implementation analysis
- No academic papers reviewed (if available)
- No community insights (GitHub, forums)

---

## Summary

**Deep research**:
1. Challenges claims with critical questions
2. Surfaces trade-offs explicitly
3. Assesses real-world applicability
4. Distinguishes marketing from reality
5. Progresses from intro to critical evaluation
6. Provides pondered, informed analysis

**Naive research**:
1. Echoes vendor claims
2. Omits limitations
3. Accepts positive spin uncritically
4. Focuses on "what" without "how/why"
5. Stops at surface level
6. Provides regurgitated marketing content

**Standard**: All Probe research MUST meet deep research criteria.
