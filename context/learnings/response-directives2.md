# Response Directives v2 - Universal Patterns

**Context:** Evolved from Nishal multi-agent guardrails response (high-quality feedback)
**Complements:** `/Users/daviguides/work/sources/bespin/bespin-docs/specs/writing-style-guide.md` (formatting/tone)
**Focus:** Structure, argumentation, decision-making patterns

---

## 1. Stratified Technical Response Structure

**Pattern:**
```
Layer 1: Issues (validate + expand concerns)
Layer 2: Solutions (framework-agnostic concepts)
Layer 3: Implementations (practical approaches)
Layer 4: Prioritization (P0/P1/P2 with impact justification)
Layer 5: Alignment Questions (specific, not generic)
```

**Why it works:**
- Logical flow: understand problem → conceptualize solution → implement → prioritize → decide
- Each layer builds on previous (not random order)
- Stakeholder can exit at any layer (exec reads Layer 1+4, engineer reads all)

**Example:**
```markdown
Issues we need to address:
[Layer 1]

Here are some solutions I see for each:
[Layer 2]

Implementation approaches:
[Layer 3]

I suggest addressing this in priority layers:
P0 (critical - prevents 80% of scenarios): [...]
[Layer 4]

Questions to align on:
[Layer 5]
```

---

## 2. Validate + Expand Concerns (Before Proposing Solutions)

**Pattern:**
```
What they mentioned:
[acknowledge explicitly]

Implicit in their concern:
[what they're thinking but didn't say]

Additional risks they didn't mention:
[expand scope, show deeper thinking]
```

**Why it works:**
- Shows you understood their concern (validation)
- Shows you thought beyond their concern (expertise)
- Prevents "but what about X?" later (comprehensive)

**Example:**
```markdown
Response & conversation timeouts (what you mentioned):
- Agent-level: Individual agent hangs
- Conversation-level: A2A loops

Beyond timeouts (implicit in the incident):
- Cost explosion: Uncontrolled spending
- Detection delay: How long to notice?

Additional risks (not in article):
- Deadlock: Circular dependencies
- Error propagation: Cascading failures
```

**Anti-pattern:**
```markdown
❌ Here's the solution: [jumps straight to answer]
```

---

## 3. Propositional Language (Not Imperative)

**Pattern:**
- "Here are some solutions **I see** for each"
- "**I suggest** addressing this in priority layers"
- "**One option is**: Start with X, evolve to Y"

**Why it works:**
- Collaborative (invites discussion)
- Not authoritarian (respects stakeholder judgment)
- Leaves room for correction (flexible)

**Examples:**
```markdown
✅ "I suggest addressing this in priority layers"
❌ "We must implement in this order"

✅ "Here are some solutions I see"
❌ "Here's what we should do"

✅ "Does this approach make sense?"
❌ "This is the correct approach"
```

---

## 4. Prioritization with Impact Justification

**Pattern:**
```
P0 (critical - [quantifiable impact]):
- Item 1
- Item 2

P1 (important - [why it matters]):
- Item 3

P2 (desirable - [what it adds]):
- Item 4
```

**Why it works:**
- Stakeholder understands WHY priority, not just WHAT priority
- Enables informed trade-offs (skip P2 if timeline tight)
- Quantifiable impact > subjective importance

**Example:**
```markdown
✅ P0 (critical - prevents 80% of the article scenarios):
    - Multi-tier timeouts
    - Cost controls

❌ P0 (critical):
    - Multi-tier timeouts [why is it critical? unclear]
```

**Anti-pattern:**
```markdown
❌ High priority:
    - Timeouts
    - Cost controls
    [No justification, no quantification]
```

---

## 5. Specific Alignment Questions (Not Generic Closing)

**Pattern:**
End with **concrete questions** that need answers, not generic "thoughts?"

**Why it works:**
- Invites specific response (not vague "looks good")
- Unblocks decision-making (identifies open questions)
- Shows you've thought through implications

**Example:**
```markdown
✅ Questions to align on:
    - Acceptable budget per workflow? (defines thresholds)
    - Timeout values: 30s/5min/30min reasonable?
    - Observability: correlation with OEE is P0 or P2?

❌ Thoughts? [too vague]
❌ Does this make sense? [yes/no, not actionable]
```

**From writing-style-guide.md:**
- Generic closings ("Your thoughts?") are fine for OPEN-ENDED discussions
- Specific questions are better for DECISION-ORIENTED discussions

---

## 6. Visual Separators for Long Messages

**Pattern:**
Use `──────────────────────────────────────` between major sections

**Why it works:**
- Scannability in Slack (beyond blockquotes)
- Clear visual break (section transition)
- Works in monospace (Slack code blocks)

**Example:**
```markdown
Issues we need to address:
[...]

──────────────────────────────────────

Here are some solutions I see:
[...]

──────────────────────────────────────

Implementation approaches:
[...]
```

**When to use:**
- Long messages (>20 lines)
- Multiple distinct sections
- Slack/Discord (monospace-friendly)

**When NOT to use:**
- Short messages (<10 lines)
- Documentation (use headers instead)
- Email (may not render well)

---

## 7. Framework-Agnostic First, Then Practical

**Pattern:**
```
Section 1: Conceptual solutions (no frameworks)
Transition: "These patterns are framework-agnostic"

Section 2: Implementation approaches (mention tools)
Transition: "Specific tooling depends on stack"
```

**Why it works:**
- Conceptual understanding before implementation details
- Prevents premature framework lock-in
- Enables discussion of WHAT before HOW

**Example:**
```markdown
✅ Multi-tier timeout architecture:
    - Agent timeout (30s)
    - Conversation timeout (5min)
    [conceptual]

    Implementation approaches:
    - Wrapper functions with timeout decorators
    - Thread/process pools with TTL
    [practical]

❌ Use LangGraph's timeout decorators:
    [jumps to framework-specific without concept]
```

---

## 8. Context-Specific Without Over-Explanation

**Pattern:**
Mention relevant context (industry, compliance, constraints) but **don't explain basics**

**Why it works:**
- Contextualizes recommendations
- Respects reader's intelligence (they know their domain)
- Stays concise

**Example:**
```markdown
✅ "Manufacturing context adds requirement: ISO 19011 + GDPR
     require audit trails - guardrails must log events"
    [mentions standard, doesn't explain what ISO 19011 is]

❌ "ISO 19011 is an international standard for auditing
     management systems, which requires..."
    [over-explains, loses conciseness]
```

**When to explain:**
- Novel concept reader unlikely to know
- Acronym not standard in their domain
- Justification needed for recommendation

**When NOT to explain:**
- Industry-standard terms (ISO, GDPR in manufacturing)
- Concepts already in their question
- Common technical patterns (timeouts, circuit breakers)

---

## 9. Avoid Revealing Knowledge Sources

**Pattern:**
Present knowledge as **expertise**, not "I researched this"

**Anti-patterns:**
```markdown
❌ "I did research and found..."
❌ "According to a study I read..."
❌ "The ROI is $1.77M (from my analysis)"
❌ "LangGraph scores 5.1/10 (my evaluation)"
```

**Better:**
```markdown
✅ "Multi-tier timeouts prevent 80% of these scenarios"
    [states fact, not source]

✅ "Observability must correlate with production metrics"
    [presents insight, not research process]
```

**Exception:**
When citing external authority adds credibility:
```markdown
✅ "vLLM shows 2-4x throughput vs TGI in production benchmarks"
    [benchmark = external validation]
```

**Why it works:**
- Expertise > research (you're the expert, not Google)
- Concise (no "I found that..." preamble)
- Confident (not hedging with "according to...")

---

## 10. Flexibility Based on Feedback

**Pattern:**
When stakeholder corrects or clarifies, **acknowledge and adapt immediately**

**Example from thread:**
```
Nishal: "we might need advanced observability for end-user explainability"
✅ Davi: "Makes sense, if end-user explainability is core,
          advanced observability moves to P0"

❌ Davi: "But I prioritized it as P2 based on..."
    [defensive, rigid]
```

**Why it works:**
- Shows listening (not just broadcasting)
- Collaborative (not adversarial)
- Pragmatic (priorities depend on context)

**When to adapt:**
- New information changes assumptions
- Stakeholder has context you don't
- Trade-offs shift based on priorities

**When to push back:**
- Technical constraint (not just preference)
- Stakeholder request creates risk
- Important trade-off they may not see

**How to push back:**
```markdown
✅ "One consideration: X may impact Y. Still makes sense
     if [clarify assumption]?"
    [question, not refusal]

❌ "That won't work because..."
    [confrontational]
```

---

## Anti-Patterns (Learned from Nishal Thread)

### ❌ Rigid Prioritization Without Justification
```markdown
Bad:
P0: Timeouts, Cost controls
P1: Loop detection
P2: Observability

Better:
P0 (critical - prevents 80% of incidents):
    - Timeouts
    - Cost controls
```

### ❌ Solutions Without Validating Concerns First
```markdown
Bad:
[immediately jumps to solutions]

Better:
Issues we need to address:
[validate + expand concerns]

Here are some solutions I see:
[then solutions]
```

### ❌ Generic Conversational Closing
```markdown
Bad:
Your thoughts?

Better:
Questions to align on:
- Acceptable budget per workflow?
- Timeout values reasonable?
```

### ❌ Over-Explaining Context
```markdown
Bad:
ISO 19011 is an international standard for...
[paragraph of explanation]

Better:
Manufacturing context: ISO 19011 + GDPR require audit trails
[concise, assumes familiarity]
```

---

## Usage Notes

### When to Use These Patterns

**Applicable to:**
- Technical proposals (architecture, tooling, process)
- Strategic discussions (prioritization, roadmap)
- Complex trade-offs (performance vs maintainability)
- Decision-oriented conversations (need to align on choice)

**NOT applicable to:**
- Simple questions (use concise answer)
- Exploratory discussions (less structure needed)
- Updates/status reports (use bullet points)

### How to Combine with Writing Style Guide

**Writing Style Guide** (formatting/tone):
- Bold, blockquotes, italic (visual hierarchy)
- Concessions, humility markers (collaborative tone)
- Conversational closings (invite dialogue)

**Response Directives v2** (structure/argumentation):
- Stratified response (issues → solutions → implementation → prioritization)
- Validate + expand concerns (show deeper thinking)
- Specific alignment questions (decision-oriented)

**Use both:**
- Writing Style Guide: HOW to format and phrase
- Response Directives v2: WHAT to include and sequence

---

## Examples Comparison

### Low-Quality Response
```markdown
We should use multi-tier timeouts because they prevent loops.

Implementation:
- Agent timeout: 30s
- Conversation timeout: 5min

Thoughts?
```

**Problems:**
- ❌ No validation of concerns
- ❌ Jumps to solution without context
- ❌ No prioritization
- ❌ Generic closing

### High-Quality Response (Using These Directives)
```markdown
Completely agree - and there are additional risks beyond timeouts.

Issues we need to address:
  Response & conversation timeouts (what you mentioned):
  - [...]

  Beyond timeouts (implicit):
  - [...]

  Additional risks (not mentioned):
  - [...]

Here are some solutions I see for each:
  Multi-tier timeout architecture:
  - [...]

Implementation approaches:
  Timeouts:
  - [...]

I suggest addressing this in priority layers:
  P0 (critical - prevents 80% of scenarios):
  - [...]

Questions to align on:
  - Timeout values: 30s/5min reasonable?
  - [...]
```

**Why better:**
- ✅ Validates + expands concerns
- ✅ Stratified structure (issues → solutions → implementation → prioritization)
- ✅ Propositional language ("I suggest")
- ✅ Specific alignment questions

---

**Last Updated:** 2025-11-11
**Source:** Nishal multi-agent guardrails thread (high-quality feedback)
**Complements:** `writing-style-guide.md` (formatting/tone patterns)
