# Depth Calibration Guide

**Practical guidance for calibrating research depth based on topic, familiarity, and objectives.**

---

## Core Principle

**Not all spectra require equal depth**. Calibrate based on:
1. **Familiarity level** (never heard vs expert)
2. **Research goal** (evaluation vs learning vs reporting)
3. **Topic characteristics** (tool vs concept, mature vs cutting-edge)
4. **Time constraints** (quick assessment vs comprehensive)

**Goal**: Maximize value, minimize waste.

---

## Dimension 1: Familiarity-Based Calibration

### Level 0: Never Heard Of It

**Starting knowledge**: Zero.

**Depth allocation**:
```
Fundamentals:     ████████ 80% - Need complete intro
Architecture:     ██████░░ 60% - Understand how it works
Technical:        ████░░░░ 40% - Enough to grasp concepts
Academic:         ████░░░░ 40% - If research-driven
Integration:      ██████░░ 60% - Can I even use this?
Performance:      ██████░░ 60% - Is it worth it?
Use Cases:        ██████░░ 60% - When to apply?
Applicability:    ████████ 80% - Critical for decision
Implementation:   ████░░░░ 40% - Basic examples
Critical FAQ:     ████████ 80% - Address unknowns
```

**Rationale**: Heavy fundamentals and applicability. Need to understand WHAT and WHETHER.

**Output priority**:
1. Clear definition and context
2. When to use / not use
3. Prerequisites and constraints
4. Enough detail to decide if deeper dive needed

### Level 1: Heard Of, Not Familiar

**Starting knowledge**: Know it exists, vague idea of purpose.

**Depth allocation**:
```
Fundamentals:     ████░░░░ 40% - Quick recap, focus on gaps
Architecture:     ██████░░ 60% - How it actually works
Technical:        ██████░░ 60% - Implementation details
Academic:         ████░░░░ 40% - Background research
Integration:      ██████░░ 60% - How to adopt
Performance:      ████████ 80% - Quantitative assessment
Use Cases:        ████████ 80% - Real applications
Applicability:    ████████ 80% - When to use
Implementation:   ██████░░ 60% - Practical examples
Critical FAQ:     ██████░░ 60% - Common issues
```

**Rationale**: Less intro needed, more depth in practical assessment.

**Output priority**:
1. How it works (architecture)
2. Performance characteristics
3. When and how to use
4. Comparison with alternatives

### Level 2: Somewhat Familiar

**Starting knowledge**: Used briefly, read docs, basic understanding.

**Depth allocation**:
```
Fundamentals:     ██░░░░░░ 20% - Minimal recap
Architecture:     ████░░░░ 40% - Updates, new patterns
Technical:        ████████ 80% - Advanced techniques
Academic:         ██████░░ 60% - Latest research
Integration:      ████░░░░ 40% - Advanced patterns
Performance:      ████████ 80% - Optimization deep-dive
Use Cases:        ████░░░░ 40% - Edge cases, advanced
Applicability:    ██████░░ 60% - Nuanced assessment
Implementation:   ████████ 80% - Production patterns
Critical FAQ:     ██████░░ 60% - Advanced questions
```

**Rationale**: Skip basics, focus on advanced topics and optimization.

**Output priority**:
1. Advanced techniques
2. Performance optimization
3. Production best practices
4. Edge cases and gotchas

### Level 3: Expert-Level Deep-Dive

**Starting knowledge**: Daily user, deep familiarity.

**Depth allocation**:
```
Fundamentals:     ░░░░░░░░ 0% - Skip entirely
Architecture:     ██░░░░░░ 20% - Only cutting-edge changes
Technical:        ████████ 100% - Bleeding edge, internals
Academic:         ████████ 100% - Latest papers, unpublished
Integration:      ██░░░░░░ 20% - Novel integrations only
Performance:      ████████ 100% - Micro-optimizations
Use Cases:        ██░░░░░░ 20% - Exotic use cases
Applicability:    ████░░░░ 40% - Edge scenarios
Implementation:   ████████ 100% - Advanced patterns, source diving
Critical FAQ:     ████░░░░ 40% - Cutting-edge questions
```

**Rationale**: Extreme depth in technical, academic, performance. Skip intro entirely.

**Output priority**:
1. Latest research and developments
2. Internals and source code analysis
3. Micro-optimizations
4. Unpublished techniques

---

## Dimension 2: Goal-Based Calibration

### Goal A: Evaluation (Can I Adopt This?)

**Research objective**: Decide if technology fits use case.

**Depth allocation**:
```
Fundamentals:     ██████░░ 60% - Understand what it is
Architecture:     ████░░░░ 40% - High-level understanding
Technical:        ██░░░░░░ 20% - Enough to assess feasibility
Academic:         ██░░░░░░ 20% - Nice to have, not critical
Integration:      ████████ 80% - Can I adopt? Effort?
Performance:      ████████ 80% - Meets requirements?
Use Cases:        ██████░░ 60% - Fits my scenario?
Applicability:    ████████ 100% - CRITICAL - when to use/not use
Implementation:   ████░░░░ 40% - Complexity assessment
Critical FAQ:     ████████ 80% - Address concerns, blockers
```

**Critical spectra**: Applicability, Integration, Performance, Critical FAQ.

**Output format**: Decision-focused (recommendation + rationale).

**Time investment**: Quick to moderate (save time by skipping non-critical).

### Goal B: Learning (Knowledge Building)

**Research objective**: Master the topic for future reference.

**Depth allocation**:
```
Fundamentals:     ████████ 80% - Solid foundation
Architecture:     ████████ 80% - Deep understanding
Technical:        ████████ 80% - Comprehensive coverage
Academic:         ██████░░ 60% - Theoretical grounding
Integration:      ██████░░ 60% - How to use
Performance:      ██████░░ 60% - Characteristics
Use Cases:        ████████ 80% - Diverse applications
Applicability:    ██████░░ 60% - When appropriate
Implementation:   ████████ 80% - Hands-on practice
Critical FAQ:     ██████░░ 60% - Common questions
```

**Critical spectra**: All relatively deep (comprehensive learning).

**Output format**: Educational (tutorial-style, examples).

**Time investment**: Substantial (thorough coverage).

### Goal C: Stakeholder Reporting

**Research objective**: Provide realistic assessment for decision-makers.

**Depth allocation**:
```
Fundamentals:     ████████ 80% - Context for non-experts
Architecture:     ████░░░░ 40% - High-level only
Technical:        ██░░░░░░ 20% - Minimal (appendix)
Academic:         ██░░░░░░ 20% - If relevant to credibility
Integration:      ██████░░ 60% - Adoption effort
Performance:      ████████ 80% - Data-driven assessment
Use Cases:        ██████░░ 60% - Business relevance
Applicability:    ████████ 100% - CRITICAL - honest when to/not to
Implementation:   ████░░░░ 40% - Effort estimate
Critical FAQ:     ████████ 80% - Address stakeholder concerns
```

**Critical spectra**: Applicability, Performance, Critical FAQ.

**Output format**: Executive summary + appendix.

**Time investment**: Moderate (focus on decision support, less technical depth).

### Goal D: Competitive Analysis

**Research objective**: Compare multiple solutions in category.

**Depth allocation** (PER SOLUTION):
```
Fundamentals:     ████░░░░ 40% - Brief intro each
Architecture:     ████░░░░ 40% - Comparison of approaches
Technical:        ██████░░ 60% - Differentiators
Academic:         ██░░░░░░ 20% - If relevant
Integration:      ██████░░ 60% - Comparison matrix
Performance:      ████████ 80% - Side-by-side benchmarks
Use Cases:        ██████░░ 60% - Which for which scenario
Applicability:    ████████ 100% - Decision framework
Implementation:   ████░░░░ 40% - Quick-start comparison
Critical FAQ:     ██████░░ 60% - "Which one" questions
```

**Critical spectra**: Performance comparison, Applicability decision tree.

**Output format**: Comparison table, decision flowchart.

**Time investment**: High (multiple solutions researched).

---

## Dimension 3: Topic Characteristics

### Characteristic: Tool vs Concept

**Specific Tool** (e.g., LMCache):
- HIGH: Integration, Implementation, Performance (concrete)
- MODERATE: Use Cases, Applicability
- LOW: Conceptual breadth (focused on one tool)

**General Concept** (e.g., LLM caching):
- HIGH: Fundamentals, Architecture patterns, Comparative analysis
- MODERATE: Use Cases (diverse across tools)
- LOW: Tool-specific implementation (examples, not focus)

### Characteristic: Maturity Level

**Cutting-Edge** (new, <6 months):
- HIGH: Fundamentals (less prior knowledge available), Academic (recent papers)
- MODERATE: Architecture, Use Cases
- LOW: Integration (immature), Performance (benchmarks limited)
- CRITICAL: Maturity assessment, limitations (expect many)

**Mature** (18+ months, stable):
- LOW: Fundamentals (well-documented elsewhere)
- HIGH: Performance (comprehensive benchmarks), Use Cases (production examples)
- MODERATE: Architecture (focus on updates)
- CRITICAL: Comparison (alternatives matured too)

**Legacy** (stagnant, >2 years no updates):
- HIGH: Comparison with modern alternatives
- MODERATE: Use Cases (historical perspective)
- LOW: Deep technical (likely outdated)
- CRITICAL: Migration path to alternatives

### Characteristic: Research-Driven vs Engineering-Focused

**Research-Driven** (novel techniques from papers):
- HIGH: Academic Research, Technical Deep-Dive (novel algorithms)
- MODERATE: Fundamentals (build from theory)
- CRITICAL: Understand underlying research, novelty assessment

**Engineering-Focused** (pragmatic, no novel research):
- LOW: Academic Research ("Not research-driven" acceptable)
- HIGH: Integration, Implementation, Use Cases
- CRITICAL: Practical adoption and real-world benefits

---

## Dimension 4: Time Constraints

### Quick Assessment (2-4 hours)

**Prioritized spectra**:
1. Fundamentals (30 min) - What is it?
2. Applicability (45 min) - Does it fit?
3. Performance (30 min) - Good enough?
4. Integration (30 min) - Can I use it?
5. Critical FAQ (45 min) - Blockers?

**Skipped or minimal**:
- Technical Deep-Dive
- Academic Research
- Detailed Implementation

**Output**: Go/No-Go decision with caveats.

### Standard Research (8-16 hours)

**All spectra covered**, depth varies by factors above.

**Typical allocation**:
- Foundation (2-3h): Fundamentals + Architecture
- Deep Analysis (3-4h): Technical + Academic
- Practical (3-4h): Integration + Performance + Use Cases
- Critical (3-4h): Applicability + Implementation + FAQ

**Output**: Comprehensive multi-spectrum analysis.

### Exhaustive Investigation (24-40 hours)

**All spectra at HIGH depth**.

Includes:
- Source code review
- Running all examples
- Independent benchmarking
- Community deep-dive (forums, issues)
- Production deployment simulation

**Output**: Definitive reference document.

---

## Calibration Decision Tree

```
START: Research topic identified

├─ Familiarity?
│  ├─ Never heard → Pattern: Never Heard Of It
│  ├─ Vaguely familiar → Pattern: Heard Of, Not Familiar
│  ├─ Somewhat familiar → Pattern: Somewhat Familiar
│  └─ Expert → Pattern: Expert Deep-Dive
│
├─ Goal?
│  ├─ Evaluation → Emphasize: Applicability, Integration, Performance
│  ├─ Learning → Balanced depth across spectra
│  ├─ Reporting → Emphasize: Fundamentals, Applicability, FAQ
│  └─ Comparison → Multiple solutions, decision framework
│
├─ Topic Type?
│  ├─ Specific Tool → Emphasize: Integration, Implementation
│  ├─ Concept → Emphasize: Fundamentals, Comparison
│  └─ Comparison → Balanced across multiple
│
├─ Maturity?
│  ├─ Cutting-edge → Emphasize: Fundamentals, Academic, Limitations
│  ├─ Mature → Emphasize: Performance, Use Cases, Comparison
│  └─ Legacy → Emphasize: Alternatives, Migration
│
├─ Research vs Engineering?
│  ├─ Research-driven → Emphasize: Academic, Technical
│  └─ Engineering → Emphasize: Integration, Implementation
│
└─ Time Available?
   ├─ Quick (2-4h) → Priority spectra only
   ├─ Standard (8-16h) → All spectra, calibrated depth
   └─ Exhaustive (24-40h) → High depth everywhere

OUTPUT: Calibrated depth profile for 10 spectra
```

---

## Calibration Example: LMCache

**Context**:
- Familiarity: Never heard of it
- Goal: Evaluation (can we adopt?)
- Topic: Specific tool
- Maturity: Moderate (6-12 months)
- Type: Research + Engineering
- Time: Standard (8-16h)

**Calibrated depth**:
```
Fundamentals:     ████████ 80% - Zero knowledge, need intro
Architecture:     ██████░░ 60% - Understand how it works
Technical:        ██████░░ 60% - Non-prefix, CacheBlend (novel)
Academic:         ██████░░ 60% - Research-driven (papers important)
Integration:      ████████ 80% - CRITICAL - can we adopt?
Performance:      ████████ 80% - CRITICAL - meets requirements?
Use Cases:        ██████░░ 60% - Fits our chatbot/RAG needs?
Applicability:    ████████ 100% - CRITICAL - API vs local deployment
Implementation:   ████░░░░ 40% - Complexity assessment
Critical FAQ:     ████████ 80% - "Works with OpenAI?" → NO
```

**Rationale**:
- HIGH Applicability: Need to determine if API incompatibility is blocker
- HIGH Integration/Performance: Evaluation goal
- HIGH Fundamentals: Never heard of it
- MODERATE Technical/Academic: Research-driven, novel techniques
- MODERATE Use Cases: Validate fit
- LOW Implementation: Not building yet, just evaluating

**Output**: Decision doc with "NOT applicable (API incompatibility)" + alternative recommendations.

---

## Adaptive Signals

### Increase Depth When:

- Unexpected complexity discovered
- Novel techniques found
- Contradictory information from sources
- Critical to decision, need certainty
- Stakeholder questions reveal gaps

### Decrease Depth When:

- Topic simpler than expected
- Good existing resources found (reference instead)
- Not critical to decision
- Time constraint binding
- Diminishing returns (enough to decide)

---

## Summary

**Depth calibration** adapts research to context.

**Four dimensions**:
1. Familiarity (zero → expert)
2. Goal (evaluate vs learn vs report)
3. Topic (tool vs concept, mature vs new)
4. Time (quick vs standard vs exhaustive)

**Decision tree** combines factors → depth profile.

**Adaptive**: Adjust during research based on findings.

**Goal**: Right depth for each spectrum given context, not uniform depth across all.
