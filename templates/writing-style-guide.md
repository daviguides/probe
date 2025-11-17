# Writing Style Guide - Davi Guides

## Purpose
This document captures formatting and writing patterns for technical communication (Slack, documentation, proposals). The goal is rich formatting that enhances scannability while maintaining professional tone.

---

## 1. Bold (**) - Strategic Emphasis

### When to Use
- **Concessions before agreement**: "**While I found X interesting**, I agree..."
- **Key agreements**: "**I completely agree**"
- **Topic transitions**: "**About OCR:**", "**The question I would raise:**"
- **Critical points**: Highlight main takeaways

### Examples
```markdown
**While I found the abstraction that Parlant proposes interesting**,
in terms of abstraction itself (not functionality), **I completely agree**.

**The question I would raise is:** does this pattern have any benefit?

**About OCR:** Benchmarks are useful but they're still benchmarks.
```

### Why It Works
- Guides reader's attention to key decision points
- Creates visual hierarchy in dense text
- Makes arguments easy to follow (concession → agreement → question)

---

## 2. Blockquotes (>) - Structure of Thought

### When to Use
- **Personal perspective**: `> In my point of view:`
- **Case application**: `> And In this case, LangGraph covers:`
- **Context setting**: `> I'll be using these first two weeks to...`
- **Grouping related ideas**: Lists or explanations

### Examples
```markdown
> In my point of view: from an architectural standpoint, introducing
> a new framework only makes sense when native features don't meet our needs.

> And In this case, LangGraph covers what we need:
- Parallel execution (fan-out)
- Dynamic routing
- State management

> I'll be using these first two weeks to get up to speed. I'm already
> reading those two documents you shared, and I also want to start a
> deep dive into what's already been implemented.
```

### Why It Works
- Creates visual "layers" (main text vs supporting details)
- Enables quick scanning (blockquotes = detailed explanation)
- Softens opinionated statements ("my point of view" vs asserting)
- Groups related bullets under a context statement

---

## 3. Italic (_) - Reflections & Questions

### When to Use
- **Reflective questions**: Genuine inquiries, not rhetorical
- **Methodological shares**: "I like to do X" (softer than asserting)
- **Humble statements**: Acknowledging uncertainty or learning

### Examples
```markdown
_does Parlant's "dynamic guidelines" pattern have any conceptual
benefit that we can't achieve with LangGraph? Or is it just a
different way of solving the same problem?_

_I also for this kind of situation I like to run POCs with partial
mocks of the logic, domain, and context, to compare side by side
both in terms of implementation and functionality._

_I believe my suggestions will become more accurate over time.
In other words, fine-tuning with the project and with you all._
```

### Why It Works
- Softer tone than bold (reflection vs assertion)
- Invites collaboration (genuine questions)
- Shows thoughtfulness without arrogance
- Acknowledges learning process

---

## 4. Lists - Structured Information

### When to Use
- Feature comparisons
- Options or alternatives
- Steps in a process
- Related capabilities

### Best Practices
- **Always introduce with context** (blockquote or sentence)
- Keep items parallel (all nouns, all verbs, etc.)
- Use consistent punctuation (no periods if all items are short)

### Examples
```markdown
> And In this case, LangGraph covers what we need:
- Parallel execution (fan-out)
- Dynamic routing
- State management

NOT:
LangGraph covers:
- It has parallel execution
- Dynamic routing
- You can manage state
(Mixed structure - avoid)
```

---

## 5. Conversational Closings

### When to Use
- End of technical arguments
- After proposals
- When seeking input

### Examples
```markdown
Your thoughts?

What do you think?

Does this make sense?

Happy to discuss further.
```

### Why It Works
- Invites response (not a monologue)
- Shows openness to feedback
- Professional but collaborative
- Prevents "lecture" tone

---

## 6. Topic Transitions

### Pattern: Bold Header + Colon

```markdown
**About OCR:**
Benchmarks are useful but they're still benchmarks...

**On the architecture side:**
I think the separation of concerns is key...

**One question I have:**
How are you thinking about state management?
```

### Why It Works
- Clear visual break between topics
- Easy to navigate long messages
- Helps reader switch context

---

## 7. Humility Markers

### When to Use
- Making suggestions
- Asking questions

### Why It Works
- Shows self-awareness (Staff level, not arrogance)
- Invites correction without defensiveness
- Builds trust with team
- Professional without being weak

---

## 8. Formatting Hierarchy

### Visual Layers (Outer to Inner)

```
**Bold Statement** ← Key point (outer layer)
  ↓
  Regular text ← Main argument
  ↓
  > Blockquote ← Supporting detail (middle layer)
  >   - List items
  ↓
  _Italic reflection_ ← Thoughtful question (inner layer)
```

### Example of Full Hierarchy
```markdown
**While I found the abstraction interesting**, I completely agree.

> In my point of view: from an architectural standpoint, introducing
> a new framework only makes sense when native features don't meet needs.
>
> And In this case, LangGraph covers:
- Parallel execution
- Dynamic routing

_The question I would raise is: does this pattern have any conceptual
benefit we can't achieve with LangGraph?_

But there may be nuances I'm not seeing since I'm new to the project.
```

---

## 9. Anti-Patterns (Avoid)

### ❌ Wall of Text
```markdown
I think we should use LangGraph because it has parallel execution and
dynamic routing and we don't need to introduce a new framework which
would increase complexity and Parlant might have some benefits but...
```

**Fix:** Break into bold + blockquotes + lists

### ❌ Over-Assertion
```markdown
We MUST use LangGraph. Parlant is the wrong choice. This is the only way.
```

**Fix:** Add concessions, questions, humility markers

### ❌ Unclear Structure
```markdown
About OCR I think benchmarks are useful and also we should have fallback
and on the LangGraph side I agree with using Command goto...
```

**Fix:** Use **topic headers** to separate ideas

### ❌ Mixing Hierarchy
```markdown
> I think we should use LangGraph
**because it has these features:**
- Feature 1
```

**Fix:** Blockquote should contain the list, or bold should introduce blockquote

---

## 10. Context-Specific Guidelines

### Slack Messages (Technical Discussions)
- ✅ Use rich formatting (bold, blockquotes, italic)
- ✅ Keep opening line punchy (**concession + agreement**)
- ✅ End with open question ("Your thoughts?")
- ⚠️ Don't exceed ~10-15 lines (break into multiple messages if needed)

### Documentation / Proposals
- ✅ Use headers (##) for major sections
- ✅ Blockquotes for examples or callouts
- ✅ Bold for key concepts
- ⚠️ Less italic (more formal than Slack)

### Code Reviews / Technical Feedback
- ✅ Lead with positive (**What I like:**)
- ✅ Use blockquotes for code suggestions
- ✅ End with questions, not commands
- ⚠️ Avoid "you should" → prefer "consider" or "what if"

---

## 11. Template: Technical Discussion Response

```markdown
Hi @Person,

**[Concession if applicable]**, [Main agreement/position].

> [Your perspective]:
> [Detailed explanation or application to case]
>
> [If listing features/reasons]:
- Item 1
- Item 2
- Item 3

**[Key question to raise]:** _[Genuine question showing you've thought deeply]_

_[Optional: Share your methodology or approach]_

[Humility marker acknowledging you're new/learning]

**[Second topic if applicable]:**
[Concise take on second topic]

[Conversational closing]
```

### Example Application
```markdown
Hi @Nishal,

**While I found Parlant's abstraction interesting**, I completely agree.

> In my point of view: introducing a new framework only makes sense
> when native features don't meet our needs.
>
> And in this case, LangGraph covers:
- Parallel execution
- Dynamic routing

**The question I would raise:** _does the "dynamic guidelines" pattern
have any conceptual benefit we can't achieve with LangGraph?_

_I like to run POCs to compare side by side both implementation and functionality._

But there may be nuances I'm not seeing since I'm new to the project.

**About OCR:**
Benchmarks are useful but they're still benchmarks. We can choose a
winning solution now, but keep a fallback and use evals.

Your thoughts?
```

---

## 12. Key Principles Summary

1. **Scannability First**: Bold + blockquotes enable quick reading
2. **Hierarchy Matters**: Outer (bold) → Middle (blockquotes) → Inner (italic)
3. **Humility Embedded**: Acknowledge gaps, invite correction
4. **Invite Dialogue**: End with questions, not statements
5. **Visual Breathing Room**: Use formatting to prevent wall-of-text
6. **Professional but Warm**: Not academic, not casual—collaborative

---

## Usage Notes

- This style works best for **technical discussions where you want input**
- For **executive summaries**, reduce formatting (more direct)
- For **incident reports**, use less italic (more factual)
- For **team onboarding**, this style is perfect (collaborative, clear)

---

**Last Updated:** 2025-11-05
**Author:** Davi Guides
**Context:** AccelVeo project technical communication
