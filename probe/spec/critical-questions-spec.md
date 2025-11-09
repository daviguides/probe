# Critical Questions Specification

**Mandatory questions that MUST be answered for each research spectrum to ensure depth and avoid naive investigation.**

---

## Purpose

**Critical questions** = Guardrails against superficial research.

Each spectrum has mandatory questions that force critical thinking, challenge assumptions, and surface limitations.

**REQUIREMENT**: ALL critical questions for a spectrum MUST be answered before that spectrum is considered complete.

---

## Spectrum 1: Fundamentals

### Mandatory Questions

1. **What problem does this solve that existing solutions don't?**
   - Forces identification of unique value proposition
   - Prevents generic "it does X" descriptions

2. **Why was this created? What gap did it fill?**
   - Uncovers motivation and historical context
   - Reveals if it's solving a real problem or creating hype

3. **What are the 2-3 core concepts required to understand this?**
   - Ensures researcher identifies foundational knowledge
   - Prevents hand-waving over complex concepts

4. **How does this fit in the broader ecosystem?**
   - Situates technology in context
   - Reveals dependencies and relationships

5. **Who is the target user/audience?**
   - Clarifies intended use case
   - Helps assess relevance

---

## Spectrum 2: Architecture

### Mandatory Questions

1. **What are the major components and what role does each play?**
   - Forces decomposition into understandable parts
   - Prevents black-box descriptions

2. **How do components interact? What is the data/control flow?**
   - Reveals system dynamics
   - Uncovers complexity and coupling

3. **What are the key design decisions and their rationales?**
   - Surfaces architectural trade-offs
   - Explains WHY system is structured this way

4. **What are the integration points with external systems?**
   - Identifies dependencies
   - Reveals compatibility constraints

5. **What architectural patterns are employed?**
   - Connects to known patterns
   - Enables evaluation of design quality

---

## Spectrum 3: Technical Deep-Dive

### Mandatory Questions

1. **What algorithms or techniques enable core functionality?**
   - Goes beyond "what it does" to "how it does it"
   - Surfaces technical innovation

2. **What optimizations are applied and why?**
   - Reveals performance engineering
   - Uncovers trade-offs made

3. **How are edge cases and failures handled?**
   - Tests robustness understanding
   - Reveals maturity of implementation

4. **What are the implementation constraints or limitations?**
   - Surfaces technical debt
   - Identifies areas of brittleness

5. **What makes this technically different from alternatives?**
   - Forces comparative technical analysis
   - Reveals if novelty is real or marketing

---

## Spectrum 4: Academic Research

### Mandatory Questions

1. **What papers or research does this build upon?**
   - Establishes research lineage
   - Validates academic foundation

2. **What novel techniques or contributions does this introduce?**
   - Distinguishes innovation from iteration
   - Assesses originality

3. **What is the theoretical foundation?**
   - Goes beyond engineering to underlying theory
   - Enables evaluation of soundness

4. **What prior work did this improve upon, and how?**
   - Positions in research context
   - Quantifies advancement

5. **What open research questions remain?**
   - Identifies limitations of current state
   - Reveals areas of active investigation

**Note**: If no academic papers exist, answer: "Not research-driven. Engineering-focused project."

---

## Spectrum 5: Integration

### Mandatory Questions

1. **What are the hard prerequisites? (infrastructure, dependencies)**
   - Identifies barriers to adoption
   - Prevents "easy to integrate" false claims

2. **What frameworks/libraries is this compatible with?**
   - Defines integration scope
   - Reveals compatibility matrix

3. **What is the installation/setup complexity?**
   - Assesses adoption friction
   - Identifies configuration burden

4. **What does migration from existing solution require?**
   - Surfaces transition costs
   - Identifies lock-in risks

5. **What are the configuration options and their implications?**
   - Reveals tuning complexity
   - Uncovers operational requirements

---

## Spectrum 6: Performance

### Mandatory Questions

1. **What are the performance metrics under REALISTIC conditions?**
   - Prevents cherry-picked benchmark acceptance
   - Forces consideration of typical cases

2. **Under what conditions were benchmarks measured?**
   - Reveals test setup
   - Enables assessment of applicability

3. **What is WORST-CASE performance?**
   - Surfaces lower bounds
   - Prevents best-case-only thinking

4. **What are the performance trade-offs?**
   - "Fast for X at the cost of Y"
   - Reveals what is sacrificed

5. **How does performance scale with load/data size?**
   - Tests scalability understanding
   - Identifies bottlenecks

6. **Are there independent benchmarks or only vendor claims?**
   - Assesses credibility
   - Identifies need for verification

---

## Spectrum 7: Use Cases

### Mandatory Questions

1. **What are 3-5 specific, concrete use cases?**
   - Forces specificity over generic claims
   - Enables relevance assessment

2. **WHY does this work well for each use case?**
   - Requires explanation, not assertion
   - Reveals mechanism of value

3. **Are there production deployments? Where and by whom?**
   - Validates real-world usage
   - Assesses maturity

4. **What problem does each use case solve?**
   - Connects to actual pain points
   - Prevents solution-looking-for-problem

5. **Are use cases representative of diverse scenarios or narrow niche?**
   - Assesses generality
   - Identifies if overfitting to specific case

---

## Spectrum 8: Applicability

### Mandatory Questions (MOST CRITICAL)

1. **Under what conditions does this work WELL?**
   - Defines success envelope
   - Sets realistic expectations

2. **Under what conditions does this work POORLY or FAIL?**
   - **MOST IMPORTANT QUESTION**
   - Forces identification of limitations
   - Prevents naive "works for everything" thinking

3. **What are the explicit trade-offs?**
   - "You gain X but lose Y"
   - Reveals costs of benefits

4. **When should I NOT use this?**
   - Negative selection criteria
   - Prevents inappropriate adoption

5. **Does this solve MY problem? (specific to research context)**
   - Personalized applicability assessment
   - Forces context-specific evaluation

6. **What constraints does MY environment impose that affect this?**
   - Assesses compatibility with constraints
   - Identifies blockers

---

## Spectrum 9: Implementation

### Mandatory Questions

1. **Can I get this running with working code examples?**
   - Tests practicality
   - Validates "easy to use" claims

2. **What are common pitfalls during implementation?**
   - Surfaces gotchas
   - Prepares for real-world issues

3. **What configuration is needed for production?**
   - Distinguishes demo from production-ready
   - Reveals operational complexity

4. **How do I debug when things go wrong?**
   - Tests operational maturity
   - Assesses supportability

5. **What are the best practices?**
   - Captures tribal knowledge
   - Identifies optimal usage patterns

---

## Spectrum 10: Critical FAQ

### Mandatory Questions

1. **What are the most common misconceptions?**
   - Corrects marketing vs reality
   - Sets honest expectations

2. **Does this work with <popular alternative>?**
   - Tests compatibility assumptions
   - Forces honest "NO" when appropriate

3. **What does vendor claim that is misleading or needs context?**
   - Challenges marketing spin
   - Surfaces hidden caveats

4. **What alternatives exist and how does this compare?**
   - Provides decision context
   - Enables informed choice

5. **What are the costs (money, time, complexity)?**
   - Quantifies adoption investment
   - Prevents "free" illusion

6. **What realistic ROI can I expect?**
   - Sets grounded expectations
   - Prevents over-promising

---

## Meta-Questions (Cross-Spectrum)

**Apply these across ALL spectra**:

### Skepticism Questions

- "Who benefits from this claim?"
- "What are they not telling me?"
- "Is this realistic or cherry-picked?"
- "Would this work in MY context?"

### Source Quality Questions

- "Is this from vendor or independent source?"
- "Is there supporting evidence?"
- "Can this be verified?"
- "What conflicting information exists?"

### Applicability Questions

- "Does this solve MY problem?"
- "What do I give up to get this benefit?"
- "Are prerequisites met in MY environment?"
- "Is the juice worth the squeeze?"

---

## Validation Rules

### Per-Spectrum Validation

Spectrum is **incomplete** if:
- ANY mandatory question is unanswered
- Answers are superficial ("yes", "no" without explanation)
- Answers echo marketing without critical analysis

### Quality Validation

Answers are **low-quality** if:
- Repeat vendor claims verbatim
- Lack specificity (vague, generic)
- Avoid negative aspects
- Don't include "when NOT to use" or limitations

### Depth Validation

Answers are **shallow** if:
- Stop at surface level
- Don't explain WHY
- Accept claims uncritically
- Missing comparative analysis

---

## Answer Quality Standards

### Good Answer Characteristics

**Specific**: Uses concrete examples, quantitative data
**Critical**: Challenges claims, surfaces limitations
**Comparative**: References alternatives, provides context
**Honest**: Includes "NO" answers, admits unknowns
**Sourced**: Cites evidence, not just assertions

### Poor Answer Characteristics

**Vague**: Generic descriptions, hand-waving
**Accepting**: Echoes marketing uncritically
**Isolated**: No comparison to alternatives
**Positive-biased**: Omits limitations
**Unsourced**: Claims without evidence

---

## Examples: Good vs Poor Answers

### Example 1: "Does X work with OpenAI API?"

```markdown
❌ POOR (Marketing echo):
"Yes, X provides seamless integration with popular APIs."

✅ GOOD (Critical, honest):
"NO. X requires local LLM deployment (vLLM, SGLang). Not compatible with
API-based providers like OpenAI or Anthropic.

Alternative for API users: Use provider's Prompt Caching feature:
- OpenAI: 50% discount on cached tokens
- Anthropic: Similar caching mechanism

Trade-off: X offers more control but requires infrastructure.
API caching is easier but less flexible."
```

### Example 2: "What is the performance improvement?"

```markdown
❌ POOR (Uncritical):
"X provides 15x speedup."

✅ GOOD (Contextual, realistic):
"Performance depends on cache hit rate:
- 100% hit rate: up to 15x (ideal, rare)
- 80% hit rate: ~8-10x (realistic for chatbots)
- 50% hit rate: ~3-5x (mixed workloads)
- 0% hit rate: slight overhead (~5-10%)

Benchmark conditions: Multi-round QA, 2K token context, H100 GPU.

Worst case: Unique queries without reuse → no benefit, small overhead.

Trade-off: Storage cost (1GB per 1M cached tokens) vs latency gain."
```

### Example 3: "When should I use this?"

```markdown
❌ POOR (Vague, positive-only):
"Use X for improving performance and reducing costs."

✅ GOOD (Specific with negative cases):
"✅ Use when:
- Multi-round conversations (system prompt reused)
- Document analysis (same doc, multiple queries)
- Few-shot learning (examples reused)
- Local LLM deployment (vLLM/SGLang)
- Cache hit rate expected >50%

❌ Don't use when:
- Using API-based LLMs (incompatible)
- Unique queries without reuse (no benefit)
- Storage constraints (requires GB of cache)
- Rapid context changes (low hit rate)

Decision criteria: If context reuse >50%, evaluate. If <30%, skip."
```

---

## Summary

**Critical questions** = Depth guardrails for each spectrum.

**Mandatory**: ALL questions must be answered.

**Quality standards**: Specific, critical, comparative, honest.

**Goal**: Force thorough investigation, prevent superficial acceptance, surface limitations.

**Validation**: Unanswered or poorly-answered questions = incomplete research.
