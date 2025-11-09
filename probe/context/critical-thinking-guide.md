# Critical Thinking Framework for Technical Research

**Structured approach to questioning, analyzing, and evaluating technical claims.**

---

## Core Framework

**Critical thinking** = Disciplined evaluation of information to form reasoned judgment.

**Applied to tech research**: Challenge claims, verify evidence, assess logic, surface assumptions.

**Goal**: Move from naive acceptance to informed skepticism to reasoned conclusion.

---

## Stage 1: Initial Claim Analysis

### Step 1: Identify the Claim

**Extract explicit claims** from source:

```markdown
Example source:
"LMCache is a revolutionary AI-powered caching solution that provides up to
100x speedup for LLMs with seamless integration."

Claims identified:
1. Revolutionary (superlative)
2. AI-powered (buzzword - what does this mean?)
3. Up to 100x speedup (performance metric)
4. Seamless integration (ease-of-use claim)
```

### Step 2: Categorize Claim Type

**Performance claim**: Quantitative (X is faster, cheaper, better)
**Capability claim**: Qualitative (X does Y)
**Compatibility claim**: Works with Z
**Ease claim**: Simple, seamless, zero-config

**Different categories require different verification approaches.**

### Step 3: Apply First-Order Questions

**For EVERY claim**:
- **Specificity**: Is this precise or vague?
  - "100x speedup" vs "significantly faster" (one is verifiable, one isn't)

- **Conditions**: Under what circumstances?
  - "100x" → for what workload? hardware? cache hit rate?

- **Source**: Who says? Vendor or independent?
  - Self-reported vs peer-reviewed vs community-verified

- **Evidence**: What supports this?
  - Benchmark data, paper, production case study, or just assertion?

---

## Stage 2: Evidence Evaluation

### Criterion 1: Source Credibility

**Assess source trustworthiness**:

```markdown
High credibility:
- Peer-reviewed paper with reproducible results
- Independent benchmark (MLPerf, etc)
- Production case study with data

Medium credibility:
- Vendor technical blog with details and code
- GitHub repo with working examples
- Community reports (multiple confirming)

Low credibility:
- Marketing material
- Press release
- LinkedIn post
- "Top 10" listicle

Zero credibility:
- Unsourced claim
- Obvious affiliate content
- Too-good-to-be-true without evidence
```

### Criterion 2: Evidence Quality

**Evaluate supporting evidence**:

**Strong evidence**:
- Quantitative data with conditions stated
- Reproducible experiments
- Multiple independent confirmations
- Source code available for inspection

**Weak evidence**:
- Vague claims without data
- Single anecdote
- Vendor-only testing
- No methodology described

**Red flags**:
- "Studies show" without citing studies
- "Everyone knows" without data
- "Obviously" (assertion, not evidence)
- Cherry-picked examples

### Criterion 3: Logical Consistency

**Check for internal contradictions**:

```markdown
Claim: "Zero configuration required"
Also claims: "Highly customizable with 50+ config options"

Contradiction: Can't be both zero-config and highly configurable.

Resolution: Likely means "works with defaults, tuning available"
```

**Check against known principles**:

```markdown
Claim: "100x faster with zero overhead"

Contradiction: Performance gains ALWAYS have trade-offs (CAP theorem, etc)

Question: What's the cost? Memory? Complexity? Setup time?
```

---

## Stage 3: Assumption Surfacing

### Identify Hidden Assumptions

**Every claim rests on assumptions. Make them explicit.**

**Example**:

```markdown
Claim: "LMCache reduces latency by 10x"

Hidden assumptions:
1. You run LLMs locally (NOT APIs)
2. Context is reused across requests (cache hits)
3. You have storage for cache (GB scale)
4. You can modify infrastructure (add caching layer)
5. Performance matters more than simplicity

If ANY assumption false → Claim doesn't apply to you.
```

### Assumption Validation

**For each assumption, ask**:
- "Does this hold in MY context?"
- "How often is this true vs exception?"
- "What happens if assumption breaks?"

**Example**:

```markdown
Assumption: "Context is reused (cache hits)"

Validation:
- Our use case: Unique context per user query
- Cache hit rate: ~10% (low)
- Conclusion: Assumption FAILS, benefit minimal
```

---

## Stage 4: Trade-Off Analysis

### Identify Costs (Nothing is Free)

**Framework**: For every benefit, find the cost.

**Common trade-off patterns**:

```markdown
Fast → Expensive (performance costs resources)
Simple → Limited (ease costs flexibility)
Flexible → Complex (power costs usability)
Cutting-edge → Unstable (innovation costs maturity)
General-purpose → Suboptimal (breadth costs optimization)
```

### Cost Quantification

**Make costs concrete**:

```markdown
Benefit: 10x latency reduction

Costs:
- Storage: 1GB per 1M tokens (~$20/month cloud storage)
- Setup: 3-5 eng days (~$6-10K)
- Complexity: Cache management, hit rate tuning
- Lock-in: Infrastructure requirement (can't easily switch to API)
- Operational: Monitoring, debugging, maintenance

Trade-off decision: Is 10x latency worth $10K setup + ongoing costs?
```

---

## Stage 5: Comparative Analysis

### Never Evaluate in Isolation

**Comparison framework**:

```markdown
Technology X vs:

1. Do Nothing (baseline)
   - What's current performance/cost?
   - Is problem actually painful enough?

2. Alternative A (different approach)
   - Same problem, different solution
   - Trade-offs comparison

3. Alternative B (simpler solution)
   - 80/20 rule - simpler solution for most of benefit?

Decision: Choose based on cost-benefit at YOUR constraints.
```

### Comparative Questions

- "How does this compare to NOT doing it?"
- "What simpler alternative exists?"
- "What more complex alternative offers?"
- "Which alternative for which scenario?"

---

## Stage 6: Scope and Limitations

### Positive Claims vs Negative Space

**What is claimed (positive)**:
```markdown
"Works well for chatbots and RAG"
```

**What is NOT claimed (negative - often hidden)**:
```markdown
"Does NOT work for:
- API-based LLMs (incompatible)
- Unique queries without reuse (no benefit)
- Storage-constrained envs (requires GB cache)"
```

**Critical thinking**: If only positive mentioned, actively search for negative.

### Boundary Identification

**Find the boundaries** where it stops working:

```markdown
Technology: LMCache

Works well when:
- Cache hit rate >50%
- Local LLM deployment
- Storage available (GB scale)

Starts to fail when:
- Cache hit rate <30%
- API-based deployment
- Storage limited

Completely fails when:
- 0% cache reuse
- Must use APIs (OpenAI, Claude)
- Real-time context changes
```

---

## Stage 7: Stakeholder and Bias Analysis

### Who Benefits from This Claim?

**Motivation analysis**:

```markdown
Source: Vendor blog claiming "revolutionary breakthrough"

Who benefits:
- Vendor: Funding, adoption, market share
- VC investors: Valuation increase
- Early adopters: Resume keyword, cutting-edge reputation

Who might lose:
- Competitors
- Users if overpromised and underdelivered

Likely bias: Positive (benefits from adoption)
```

### Bias Compensation

**Adjust for known biases**:

```markdown
Vendor claims 100x → Assume best-case, expect 10-30x realistic
LinkedIn post hype → Discount significantly, verify independently
Community complaints → May be edge cases, but surface real issues
Academic paper → Peer-reviewed but may overstate novelty
```

---

## Stage 8: Temporal Context

### Maturity Assessment

**Timeline reality check**:

```markdown
First release: 3 months ago

Implications:
- Expect bugs and breaking changes
- Documentation likely incomplete
- Few production deployments
- Community small, less support
- API probably unstable

Verdict: Experimental. Acceptable for R&D, risky for production.
```

### Hype Cycle Awareness

```markdown
New tech announcement
├─ Month 0-3: Peak hype (everyone talking, few using)
│   → Be MOST skeptical
├─ Month 3-6: Reality setting in (early adopters hit issues)
│   → Start to see real limitations
├─ Month 6-12: Maturation or abandonment
│   → Clearer signal of real value
└─ Month 12+: Established or irrelevant
    → If still active, likely real value
```

**Critical thinking**: Don't adopt at peak hype. Wait for reality check.

---

## Stage 9: Practical Validation

### Hands-On Verification

**Don't just read, test**:

```bash
# Verify claims hands-on
1. Clone repo
2. Run examples (do they work?)
3. Modify for your use case (how hard?)
4. Break it intentionally (error handling?)
5. Check resource usage (matches claims?)
```

### Adversarial Testing

**Try to make it fail**:

```markdown
Claim: "Seamless integration"

Adversarial test:
- Integrate with unusual framework
- Use edge-case config
- Stress test beyond stated limits
- Check error messages (helpful or cryptic?)

Result: "Seamless" actually means "easy for documented use case,
pain for anything else"
```

---

## Stage 10: Synthesis and Judgment

### Forming Reasoned Conclusion

**Pattern: Claim → Evidence → Analysis → Conclusion**

```markdown
Claim: "LMCache provides 100x speedup"

Evidence:
- Vendor benchmark: 100x for multi-round QA, H100 GPU
- Community reports: 10-30x typical, 50-80% cache hit rate
- GitHub issues: Overhead when low hit rate

Analysis:
- 100x is best-case (100% cache hit, long context)
- Realistic: 10-30x for chatbots with reuse
- Our use case: API-based, unique contexts → NOT applicable
- Trade-off: Performance vs infrastructure complexity

Conclusion:
LMCache CAN achieve 100x in optimal conditions, but:
- Realistic expectation: 10-30x for reuse-heavy workloads
- NOT applicable to our API-based deployment
- Alternative: Prompt Caching APIs (simpler, API-compatible)
- Recommendation: Do not adopt LMCache for current architecture
```

### Confidence Assessment

**Rate confidence in conclusion**:

```markdown
High confidence (80-100%):
- Multiple independent sources
- Hands-on validation
- Clear evidence
- No major contradictions

Medium confidence (50-80%):
- Limited independent sources
- Logical analysis but not tested
- Some contradictions explained

Low confidence (20-50%):
- Mostly vendor claims
- No hands-on verification
- Contradictions unresolved
- Assumptions not validated

Very low confidence (<20%):
- Single source
- Unverifiable claims
- Major contradictions
- No evidence

→ Report confidence level with conclusion
```

---

## Critical Thinking Checklist

**Before accepting any claim**:

- [ ] Identified specific claim (not vague)
- [ ] Assessed source credibility
- [ ] Evaluated evidence quality
- [ ] Checked logical consistency
- [ ] Surfaced hidden assumptions
- [ ] Validated assumptions against my context
- [ ] Identified trade-offs and costs
- [ ] Compared to alternatives
- [ ] Found limitations and boundaries
- [ ] Analyzed stakeholder biases
- [ ] Assessed temporal context (maturity)
- [ ] Attempted practical validation
- [ ] Synthesized reasoned conclusion
- [ ] Stated confidence level

**If ANY unchecked → Not critical enough, keep analyzing.**

---

## Anti-Patterns in Critical Thinking

### Anti-Pattern 1: Confirmation Bias

**Problem**: Seeking only information that confirms existing belief.

**Fix**: Actively seek disconfirming evidence.

```markdown
Belief: "This technology will solve our problem"

Antidote:
- Search: "<technology> problems", "<technology> doesn't work"
- Read negative reviews, not just positive
- Try to break it, not just verify it works
```

### Anti-Pattern 2: Authority Fallacy

**Problem**: "Expert says X, therefore X is true."

**Fix**: Evaluate evidence, not just source prestige.

```markdown
Famous engineer: "X is revolutionary"

Critical response:
- What evidence supports this?
- Is the expert financially involved?
- Do other experts agree?
- Does evidence hold under scrutiny?
```

### Anti-Pattern 3: Appeal to Popularity

**Problem**: "Everyone uses X, so X must be good."

**Fix**: Adoption doesn't equal quality. Assess for YOUR context.

```markdown
"500K downloads" → Doesn't mean it fits your use case
"Used by Google" → Different scale, different constraints

Question: Does it solve MY problem given MY constraints?
```

### Anti-Pattern 4: False Dichotomy

**Problem**: "Either adopt X or stick with slow/bad/old solution."

**Fix**: Explore alternative solutions (often more than 2 options).

```markdown
Not just: X vs status quo
Consider: X vs Y vs Z vs hybrid vs do-nothing
```

### Anti-Pattern 5: Sunk Cost Fallacy

**Problem**: "Already invested time researching, must adopt."

**Fix**: Evaluate on merit, ignore sunk cost.

```markdown
Spent 20 hours researching X
Discovered: X doesn't fit

WRONG: "I've invested so much, must use it"
RIGHT: "Doesn't fit, research was learning, move on"
```

---

## Summary

**Critical thinking stages**:
1. Analyze claims (identify, categorize, question)
2. Evaluate evidence (source, quality, logic)
3. Surface assumptions (make explicit, validate)
4. Analyze trade-offs (find costs, quantify)
5. Compare alternatives (never isolated)
6. Find limitations (boundaries, negative space)
7. Analyze biases (stakeholder motivations)
8. Assess maturity (timeline, hype cycle)
9. Validate practically (hands-on testing)
10. Synthesize judgment (claim → evidence → conclusion)

**Output**: Reasoned, evidence-based conclusion with confidence level.

**Goal**: Move from naive acceptance to informed, critical assessment.
