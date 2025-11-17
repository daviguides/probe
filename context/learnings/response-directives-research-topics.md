# Response Directives: Research Topics

**Context:** Diretrizes extraídas da resposta sobre OpenPipe ART, aplicáveis a outros tópicos de pesquisa técnica

**Complements:**
- `/Users/daviguides/work/sources/bespin/bespin-docs/specs/writing-style-guide.md` (formatting/tone)
- `/Users/daviguides/work/sources/researchs/research-multi-agent-execution-guardrails/response-directives.md` (structure)
- `/Users/daviguides/work/sources/researchs/research-multi-agent-execution-guardrails/response-directives2.md` (argumentation)

**Date:** 2025-01-13

---

## 1. High-Level First, Technical Details Last

**Pattern:**
```
Section 1: Strategic evaluation (should we use X?)
Section 2: Conceptual trade-offs (X vs alternatives)
Section 3: Recommended approach (phased, risk-aware)
Section 4: Alignment questions (decision-oriented)
Section 5: Technical implementation details (if proceeding)
```

**Why it works:**
- Stakeholders can exit at strategic layer (exec reads 1-4, engineer reads all)
- Avoids premature focus on "how" before "should we"
- Manufacturing context: robustness decisions before implementation details

**Example from ART response:**
1. High-level issues (agent suitability, production readiness, infrastructure)
2. ART vs alternatives (conceptual comparison)
3. Phased approach (SFT → RL POC → production)
4. Alignment questions (strategic decisions needed)
5. Implementation details (model compatibility, API usage, prerequisites)

**Anti-pattern:**
❌ Starting with API syntax before validating if framework fits use case

---

## 2. Context-Specific Risk Assessment

**Pattern:**
Recognize **innovation space** while maintaining **clear risk awareness**

**Structure:**
```markdown
[Technology] is currently **early alpha**:
- [Evidence of immaturity]

> [Domain-specific context] amplifies risk:
> - [Specific compliance/reliability concerns]

**Important context:**

[Organization] is building [innovative solution] — not maintaining legacy infrastructure.
This creates **legitimate space for adopting new tools to solve new problems**.

**However**, the distinction between **experimentation** and **production deployment** is critical in [domain]:
- **POC/Innovation phase**: [Tool] is acceptable (prove value, fast iteration)
- **Production deployment**: Risk must be weighed against [domain requirements]

[Phased approach allows validation before commitment]

**This is not "don't use [Tool]"** — it's **"use [Tool] where it fits (POC),
then decide production framework based on demonstrated value and compliance requirements."**

[Domain] innovation requires both **boldness to try new approaches**
and **discipline to validate before production**.
```

**Example from ART response:**
- Recognized AccelVeo's innovation context
- Maintained heavy emphasis on production risk (ISO 19011, zero-tolerance)
- Proposed POC with ART → production decision with TRL/OpenRLHF
- Balanced: "boldness to try" + "discipline to validate"

**Why it works:**
- Validates stakeholder's desire to innovate
- Prevents reckless adoption in critical systems
- Provides clear staged path (experiment → validate → decide)

---

## 3. Celebrate User Insights Before Adding Yours

**Pattern:**
When user shares valuable insight, **acknowledge and expand** before proposing solutions

**Structure:**
```markdown
**[User's insight] (excellent insight from your [source]):**

From your [discussion/thread/analysis], I see you already have [key element]:
- [What they identified]

**This is excellent!** It means:
- [Why it's valuable - implication 1]
- [Why it's valuable - implication 2]
- [Why it's valuable - implication 3]

[Then connect to your recommendations]
```

**Example from ART response:**
User (Furkan) identified: "We can use action steps logs + confirmed work orders as reward"

Response celebrated:
- "**This is excellent!** It means:"
- "Baseline exists: measure success rate"
- "Reward function is clear: confirmed = 1, rejected = 0"
- "Data availability: real user feedback"
- Connected to phased approach (use confirmed logs → SFT → RL)

**Why it works:**
- Shows you listened and understood their insight
- Validates their thinking before adding recommendations
- Builds collaborative tone (not "here's what you missed")
- Strengthens recommendations (builds on their foundation)

---

## 4. Alternatives Contextualized, Not Exhaustive

**Pattern:**
Mention **relevant alternatives** but stay focused on **primary evaluation**

**When to mention:**
- User explicitly asks about alternatives (Furkan: "if you know similar frameworks")
- Alternative directly addresses limitation of primary tool
- Stakeholder mentioned it (Errol mentioned Google SRL)

**How to mention:**
```markdown
**Note on [Alternative] (from [source]):**

[Brief explanation of how it differs from primary tool]

**For [Organization's context]:**
- [How alternative applies to their specific case]
- [Key trade-off vs primary tool]

**Worth exploring [when/how]** - [specific guidance on decision criteria]
```

**Example from ART response:**
- Primary focus: ART evaluation
- Mentioned SRL briefly (Errol shared it)
- Contextualized: "SRL uses step-wise similarity vs ART's final answer"
- Guidance: "Worth exploring both in POC phase"
- **Did not** dive deep into SRL (stayed on ART evaluation)

**Anti-pattern:**
❌ Turning response into comprehensive survey of all RL frameworks
✅ Focus on primary evaluation, mention alternatives when contextually relevant

---

## 5. Agent-by-Agent or Component-by-Component Analysis

**Pattern:**
When evaluating technology for **multi-component system**, analyze fit **per component**

**Structure:**
```markdown
The document proposes [applying technology] to [all components].

> Question: Do all these [components] need [technology], or would some benefit
> more from [alternative approach]?
>
> [Component]-by-[component] analysis:
> - **[Component 1]**: [Task type] → likely [approach] ([reasoning])
> - **[Component 2]**: [Task type] → could benefit from [technology] ([reasoning])
> - **[Component 3]**: [Task type] → [technology] candidate ([reasoning])

**Pattern I see**: [X components] are [technology] candidates. Others likely [alternative].

[Explanation of when technology works best]
```

**Example from ART response:**
Furkan's doc proposed RL for all 10 agents.

Response analyzed agent-by-agent:
- AVA (intent classification) → supervised (labeled examples)
- Reasoner (ontology validation) → logic-based (may not need training)
- SOP Generator → RL candidate (reward = human validation)
- Maintenance → RL candidate (reward = action correctness)

Pattern identified: "2-3 agents are RL candidates, others supervised/rule-based"

**Why it works:**
- Prevents overuse of single solution for all problems
- Shows nuanced understanding of system
- Reduces implementation cost (only train what benefits from RL)

---

## 6. Explicit Advantages vs Trade-offs (No Emojis)

**Pattern:**
```markdown
**Option [N]: [Technology name]**

Advantages:
- [Benefit 1] ([context why it matters])
- [Benefit 2] ([context])

Trade-offs:
- [Limitation 1] ([impact])
- [Limitation 2] ([impact])

**[Domain] fit**: [Assessment specific to organization's context]
```

**Key principles:**
- ✅ Use "Advantages:" and "Trade-offs:" headers (explicit, not emoji)
- ✅ Contextualize each point (not generic "fast" but "2-6x faster than PPO")
- ✅ Add domain-specific fit assessment
- ❌ Avoid emojis unless user explicitly requests
- ❌ Avoid generic "pros/cons" lists without context

**Example from ART response:**
```
**Option 1: ART**

Advantages:
- Multi-turn native (fits agentic workflows)
- Fast training (2-6x faster than PPO)
- Cost-effective (~50% cheaper than traditional RL)

Trade-offs:
- **Early alpha** (breaking changes, production risk)
- **GPU required** (infrastructure investment)
- **Smaller community** (debugging at 2am harder)

**Manufacturing fit**: Good for POC, risky for production given compliance
```

---

## 7. Infrastructure Clarifications (Correct Misunderstandings)

**Pattern:**
When user states technical requirement incorrectly, **clarify diplomatically**

**Structure:**
```markdown
**Infrastructure clarifications:**

Based on your [thread/doc/statement], [N] important corrections:

**[Misunderstood aspect]:**
- You mentioned "[user's statement]"
- **Clarification**: [Correct information]
- "[Less X]" means [what it actually means], not [what user thought]
- **Options**:
  - [Option 1]
  - [Option 2]
```

**Example from ART response:**
Furkan said: "doesn't need heavy GPU resources"

Clarification:
- "You mentioned 'doesn't need heavy GPU resources'"
- "**Clarification**: ART **requires GPU** (no CPU-only mode)"
- "'Less heavy' means ~50% cheaper than PPO, not GPU-free"
- "**Options**: Local GPU / W&B Training (serverless) / SkyPilot"

**Why this pattern:**
- Acknowledges what they said (not dismissive)
- Corrects without condescension
- Provides concrete alternatives
- Prevents implementation surprises

---

## 8. Phased Approach for Risk Mitigation

**Pattern:**
For **innovative but immature technology**, propose **staged validation**

**Structure:**
```markdown
**Phased strategy** ([aligns with organization's philosophy]):

> **Phase 1: [Baseline approach] ([timeframe])**
> - [Simpler approach to establish baseline]
> - Measure: [success criteria]
> - **Decision gate**: [Go/no-go criteria]
>
> **Phase 2: [Experimental validation] (if [criteria met])**
> - **POC with [innovative tool]** (not production)
> - Compare vs Phase 1 baseline: [metrics]
> - Validate: [key question]
> - **Decision gate**: [threshold for proceeding]
>
> **Phase 3: [Production framework selection] (if [value proven])**
> - Choose [options] based on Phase 2 learnings
> - [When to use innovative tool] vs [when to use mature tool]
>
> **Phase 4: [Long-term] (Year 2+)**
> - [Continuous improvement patterns]

**Why this approach for [Organization]:**
- [Reason 1 aligned with their philosophy]
- [Reason 2 - risk mitigation]
- [Reason 3 - flexibility]
```

**Example from ART response:**
1. Phase 1: SFT baseline (2-4 weeks) → measure success rate
2. Phase 2: RL POC with ART (if baseline >30%) → validate RL adds value
3. Phase 3: Production framework (ART vs TRL) → based on POC results
4. Phase 4: Continuous improvement (Year 2+)

**Why aligned with AccelVeo:**
- "Measure twice, cut once" (manufacturing philosophy)
- Risk mitigation (POC before production commitment)
- Compliance-friendly (SFT simpler to audit than RL)
- 5-year maintenance (delays RL until value demonstrable)

---

## 9. Domain-Specific Compliance Integration

**Pattern:**
For **regulated domains**, explicitly address **compliance implications**

**Key questions to address:**
```markdown
**Observability for [compliance standard]:**
- [Tool] integrates with [observability platform]
- **For [standard] compliance**, need to log:
  - [Requirement 1]
  - [Requirement 2]
  - [Requirement 3]
- **Question**: Does [tool]'s observability meet [organization]'s [compliance] requirements?
```

**Example from ART response:**
```
**Observability for audit trails:**
- ART integrates with Langfuse + W&B
- **For ISO 19011 compliance**, need to log:
  - Model version, prompt version, training data version
  - Reward function logic (how was decision scored?)
  - Rollout trajectories (full conversation, not just output)
- **Question**: Does ART's observability meet AccelVeo's audit requirements?
```

**Why it matters:**
- Compliance is often **blocking issue** in regulated industries
- Shows awareness of domain constraints
- Raises question early (not discovered during implementation)

---

## 10. Alignment Questions (Decision-Oriented, Not Generic)

**Pattern:**
End with **specific questions that need answers**, not "Your thoughts?"

**Structure:**
```markdown
**Questions to align on:**

1. **[Decision area]**: [Specific question with options/examples]?

2. **[Technical constraint]**: [Question about availability/capability]?

3. **[Risk tolerance]**: [Question about acceptable risk levels]?
   - **[Phase 1]**: [What's acceptable here]?
   - **[Phase 2]**: [What's acceptable here]?

4. **[Infrastructure]**: [Specific deployment question]?

5. **[Compliance]**: [How does X work with Y requirement]?
```

**Example from ART response:**
1. **Agent prioritization**: Which 2-3 agents deliver most value?
2. **Training data availability**: Have validated examples or need to create?
3. **Environment reproducibility**: Sandbox with mock data or production data?
4. **Risk tolerance**: POC (ART) vs Production (TRL)?
5. **GPU infrastructure**: On-premise vs cloud? Serverless vs dedicated?
6. **Compliance integration**: How do audit trails work with RL-trained models?

**Anti-pattern:**
❌ "What do you think?" (too vague)
❌ "Does this make sense?" (yes/no, not actionable)

✅ Specific questions that unblock decisions

---

## 11. Connect User's Vision to Implementation Reality

**Pattern:**
When user proposes ambitious vision, **validate vision** then **show pragmatic path**

**Structure:**
```markdown
**[User's vision/plan]** ([what they want to achieve]):

Your plan to "[user's goal]" aligns perfectly with **[approach]**:
- [How their vision maps to technical approach]
- [Connection to recommended phased strategy]
- **Then** [next logical step]

This "[user's concept] → [technical execution] → [outcome]" pipeline is
[assessment for their domain/context].
```

**Example from ART response:**
Furkan's vision: "Reasoning Bank to store and reuse strong reasoning examples"

Response connected:
- "Your plan aligns perfectly with **Phase 1 (SFT)**"
- "Use confirmed work order logs → create supervised dataset"
- "Train baseline with approved examples"
- "**Then** use RL to discover strategies beyond logged examples"
- "This 'confirmed steps → Reasoning Bank → SFT → RL' pipeline is ideal for manufacturing robustness"

**Why it works:**
- Validates their strategic thinking
- Shows how vision translates to execution
- Grounds ambition in pragmatic steps
- Maintains motivation while adding rigor

---

## Usage Notes

### When to Apply These Directives

**Applicable to:**
- Technology evaluation for production systems
- Innovative tools in regulated/critical domains
- Multi-component system architecture decisions
- Balancing experimentation vs production readiness

**NOT applicable to:**
- Simple "how-to" implementation questions
- Non-critical prototyping decisions
- Internal research without production path

### Combining with Existing Directives

**This document (Research Topics):**
- Strategic evaluation structure (high-level first)
- Risk assessment in innovation context
- Component-by-component analysis
- Phased validation approach

**Writing Style Guide:**
- Formatting (bold, blockquotes, lists)
- Tone (collaborative, humble markers)
- Visual hierarchy

**Response Directives v2:**
- Validate + expand concerns
- Propositional language
- Prioritization with impact justification
- Specific alignment questions

**Use all three together:**
- Research Topics: WHAT to evaluate and HOW to structure (this doc)
- Response Directives v2: HOW to argue and prioritize
- Writing Style Guide: HOW to format and phrase

---

## Examples Comparison

### Low-Quality Research Response

```markdown
ART is a cool new RL framework. It's faster than PPO and works great for agents.

You should use it because:
- Fast
- Good results
- Easy to use

Here's how to implement:
[Jumps straight to code without evaluation]
```

**Problems:**
- ❌ No strategic evaluation (should we use it?)
- ❌ Generic benefits (no context or quantification)
- ❌ Ignores production readiness
- ❌ No risk assessment for manufacturing
- ❌ Skips alternatives comparison
- ❌ Implementation before validation

### High-Quality Research Response (Using These Directives)

```markdown
Hi @Stakeholder,

**Overall the structure looks solid** — [acknowledgment of their work]

Before diving into implementation, here are some **high-level considerations**:

**Issues to consider:**

1. **[Component] suitability (which components benefit from [technology]?)**
   [Agent-by-agent or component analysis]

2. **Production readiness vs [domain] compliance requirements**
   [Evidence of maturity issues]

   > [Domain-specific context] amplifies risk:
   [Specific concerns for their industry]

   **Important context:**
   [Organization] is building [innovative solution] — legitimate space for new tools.

   **However**, distinction between POC and production is critical:
   [Phased recommendation]

3. **Infrastructure requirements**
   [Specific requirements with clarifications]

──────────────────────────────────────

**[Technology] vs alternatives in [Organization] context:**

[Structured comparison with Advantages/Trade-offs/Domain fit]

──────────────────────────────────────

**Approach I suggest:**

**Phased strategy** (aligns with [Organization's philosophy]):

> **Phase 1: [Baseline]**
> **Phase 2: [Experimental validation]**
> **Phase 3: [Production selection]**

**Why this approach:**
[Reasons aligned with their context]

──────────────────────────────────────

**[User's insight] (excellent insight!):**

[Celebrate their contribution, expand implications]

**[Alternative mentioned] (from [source]):**

[Brief contextualization without derailing]

**Infrastructure clarifications:**

[Correct misunderstandings diplomatically]

──────────────────────────────────────

**Questions to align on:**

1. [Specific decision-oriented question]
2. [Specific technical constraint question]
3. [Specific risk tolerance question]

──────────────────────────────────────

**Implementation details (if proceeding):**

[Technical specifics only after strategic validation]
```

**Why better:**
- ✅ Strategic evaluation before implementation
- ✅ Risk assessment specific to domain
- ✅ Component-by-component analysis
- ✅ Celebrates user insights
- ✅ Phased validation approach
- ✅ Specific alignment questions
- ✅ Technical details at end (not beginning)

---

**Last Updated:** 2025-01-13
**Source:** OpenPipe ART research response (AccelVeo context)
**Complements:** `writing-style-guide.md`, `response-directives.md`, `response-directives2.md`
