# Research Patterns

**Applied patterns for conducting multi-spectrum research across different topic types.**

---

## Pattern Categories

### By Topic Type

1. **Specific Tool/Library** (e.g., LMCache, LangChain)
2. **General Technique/Concept** (e.g., LLM caching, RAG)
3. **Comparison/Survey** (e.g., Vector databases comparison)

### By Familiarity Level

1. **Never Heard Of It** - Zero prior knowledge
2. **Heard Of, Not Familiar** - Know it exists, don't know details
3. **Somewhat Familiar** - Used briefly or read about
4. **Deep-Dive** - Refresh or advanced investigation

---

## Pattern 1: Specific Tool (Never Heard Of)

**Example**: LMCache (user never heard of it before).

**Research approach**:

### Stage 1: Foundation (Spectra 1-2)

**Focus**: Understand WHAT it is and WHY it exists.

**Fundamentals**:
- Start with 1-2 sentence definition
- Explain problem it solves (motivation)
- Identify 2-3 core concepts needed to understand

**Architecture**:
- High-level components
- How it works (flow diagram helpful)
- Key design decisions

**Depth**: MORE depth in fundamentals (user has zero context).

### Stage 2: Deep Analysis (Spectra 3-4)

**Technical Deep-Dive**:
- Implementation details
- Advanced features
- Optimizations

**Academic Research** (if applicable):
- Papers that introduced techniques
- Theoretical foundation
- Novel contributions

**Depth**: Technical details to understand HOW it really works.

### Stage 3: Practical (Spectra 5-7)

**Integration**:
- Prerequisites (critical for "can I even use this?")
- Installation steps
- Framework compatibility

**Performance**:
- Benchmarks with realistic conditions
- Best/typical/worst case
- Trade-offs

**Use Cases**:
- 3-5 specific scenarios
- WHY it works for each

**Depth**: Practical assessment of adoption feasibility.

### Stage 4: Critical (Spectra 8-10)

**Applicability**:
- When to use / NOT use
- Explicit trade-offs
- Does it solve MY problem?

**Implementation**:
- Working code examples
- Production config
- Troubleshooting

**Critical FAQ**:
- Misconceptions corrected
- Honest "NO" answers
- Alternatives mentioned

**Depth**: MAXIMUM depth in limitations and applicability.

**Repo naming**: `research-<tool-name-lowercase>`

Example: `/probe:research lmcache` → `research-lmcache`

---

## Pattern 2: General Technique/Concept

**Example**: LLM caching (concept broader than specific tool).

**Research approach**:

### Stage 1: Concept Foundation

**Fundamentals**:
- Define the concept clearly
- Problem space it addresses
- Why it matters

**Architecture**:
- Common architectural patterns
- Typical components
- Variations in approach

**Depth**: Conceptual clarity, not tool-specific.

### Stage 2: Technical Landscape

**Technical Deep-Dive**:
- Different implementation strategies
- Algorithmic approaches
- Trade-offs between approaches

**Academic Research**:
- Foundational papers for the concept
- Research directions
- State of the art

**Depth**: Breadth across approaches, not depth in single tool.

### Stage 3: Ecosystem Survey

**Integration**:
- Common frameworks/tools that implement
- Ecosystem maturity
- Adoption patterns

**Performance**:
- Performance characteristics by approach
- Comparative benchmarks (Tool A vs B vs C)
- Scalability patterns

**Use Cases**:
- Diverse scenarios across different tools
- Domain-specific patterns
- Real-world deployments

**Depth**: Comparative perspective.

### Stage 4: Decision Framework

**Applicability**:
- When to use concept vs alternatives
- Which implementation for which scenario
- Decision criteria

**Implementation**:
- Example implementations across tools
- Best practices (general, not tool-specific)
- Common pitfalls

**Critical FAQ**:
- "Which tool should I use?" → Decision tree
- "Is this mature enough?" → Ecosystem assessment
- Comparative Q&A

**Depth**: MAXIMUM in decision-making guidance.

**Repo naming**: `research-<concept-with-hyphens>`

Example: `/probe:research llm-cache` → `research-llm-cache`

---

## Pattern 3: Comparison/Survey Research

**Example**: "Vector databases for RAG" (comparing multiple solutions).

**Research approach**:

### Stage 1: Landscape Mapping

**Fundamentals**:
- Define category (what are vector databases)
- Common use cases
- Key evaluation criteria

**Architecture**:
- Common architectural patterns in category
- Shared components
- Differentiating factors

**Depth**: Category-level understanding.

### Stage 2: Individual Analysis

**Technical Deep-Dive**:
- For top 3-5 options:
  - Key technical differentiators
  - Unique features
  - Implementation approaches

**Academic Research**:
- Research foundations for category
- Novel approaches by specific solutions

**Depth**: Enough per-tool detail to enable comparison.

### Stage 3: Comparative Evaluation

**Integration**:
- Comparison matrix: prerequisites, complexity, compatibility
- Migration paths between tools
- Ecosystem integrations

**Performance**:
- Side-by-side benchmarks
- Performance trade-off analysis
- Scalability comparison

**Use Cases**:
- Which tool for which scenario
- Strengths/weaknesses by use case

**Depth**: Direct comparisons, not isolated assessments.

### Stage 4: Decision Framework

**Applicability**:
- Decision tree or flowchart
- Tool selection criteria
- Scenario → Tool mapping

**Implementation**:
- Quick-start for top options
- Migration considerations
- Hybrid approaches

**Critical FAQ**:
- "Which is the best?" → "Depends on X, Y, Z"
- "Can I switch later?" → Migration analysis
- "Do I even need one?" → Alternatives

**Depth**: MAXIMUM in helping reader choose.

**Repo naming**: `research-<category-comparison>`

Example: `/probe:research vector-databases` → `research-vector-databases`

---

## Pattern 4: Deep-Dive (Familiar Topic)

**Example**: User knows LangChain basics, wants advanced understanding.

**Research approach**:

### Adjusted Focus

**Fundamentals**: MINIMAL - Quick recap only

**Architecture**: MODERATE - Focus on recent changes

**Technical Deep-Dive**: MAXIMUM - Advanced features, optimizations

**Academic Research**: MAXIMUM - Latest papers, cutting edge

**Integration**: MODERATE - New frameworks, updated patterns

**Performance**: MAXIMUM - Latest benchmarks, optimization techniques

**Use Cases**: MODERATE - Advanced patterns, edge cases

**Applicability**: MAXIMUM - When to use advanced features

**Implementation**: MAXIMUM - Production patterns, advanced config

**Critical FAQ**: Focus on advanced topics, known issues

**Adaptation**: Shift depth from fundamentals to advanced topics.

**Repo naming**: Same as Pattern 1.

---

## Adaptation Guidelines

### Familiarity Spectrum Adjustment

```
Never Heard Of:
├─ Fundamentals: ████████ (80% depth)
├─ Architecture: ██████░░ (60% depth)
└─ Deep-Dive:    ████░░░░ (40% depth)

Somewhat Familiar:
├─ Fundamentals: ████░░░░ (40% depth)
├─ Architecture: ██████░░ (60% depth)
└─ Deep-Dive:    ████████ (80% depth)

Deep-Dive:
├─ Fundamentals: ██░░░░░░ (20% depth - recap)
├─ Architecture: ████░░░░ (40% depth - updates)
└─ Deep-Dive:    ████████ (100% depth - advanced)
```

### Topic Type Spectrum Emphasis

```
Specific Tool:
├─ Implementation:  ████████ (high)
├─ Integration:     ████████ (high)
└─ Comparison:      ████░░░░ (low - vs alternatives only)

General Concept:
├─ Fundamentals:    ████████ (high - define concept)
├─ Comparison:      ████████ (high - approaches)
└─ Implementation:  ████░░░░ (low - examples, not focus)

Comparison/Survey:
├─ Comparison:      ████████ (high - core purpose)
├─ Applicability:   ████████ (high - decision framework)
└─ Deep-Dive:       ████░░░░ (low - breadth over depth per tool)
```

---

## Execution Patterns

### Sequential Investigation (Default)

**Order**: Spectrum 1 → 2 → 3 → ... → 10

**Rationale**: Build understanding progressively.

**Use when**: Standard research, no time constraints.

### Prioritized Investigation

**Order**: Critical spectra first, others as time allows.

**Priority order**:
1. Fundamentals (always first)
2. Applicability (critical for decision)
3. Performance (quantitative assessment)
4. Architecture (understand how)
5. Others (as needed)

**Use when**: Time-limited, need quick decision.

### Iterative Refinement

**Approach**:
1. Pass 1: All spectra at surface level (breadth)
2. Pass 2: Deepen critical areas based on findings
3. Pass 3: Fill gaps, add examples

**Use when**: Uncertainty about depth needed.

---

## Research Workflow Patterns

### Pattern A: Tool Evaluation (User considering adoption)

**Goal**: Decide if tool fits use case.

**Critical spectra**:
1. Fundamentals (what is it)
2. Applicability (does it solve MY problem)
3. Integration (can I adopt it)
4. Performance (does it meet requirements)
5. Critical FAQ (address concerns)

**Less critical**: Academic Research (unless research-driven decision).

**Output format**: Decision-focused (recommendation + rationale).

### Pattern B: Learning / Knowledge Building

**Goal**: Understand topic deeply for future reference.

**Critical spectra**:
1. Fundamentals (learn what it is)
2. Architecture (understand how)
3. Technical Deep-Dive (master details)
4. Use Cases (learn applications)
5. Implementation (hands-on practice)

**Less critical**: Applicability (not deciding now).

**Output format**: Educational (comprehensive coverage).

### Pattern C: Stakeholder Report

**Goal**: Provide realistic assessment to stakeholders.

**Critical spectra**:
1. Fundamentals (context for stakeholders)
2. Performance (data-driven assessment)
3. Applicability (honest when to/not to use)
4. Critical FAQ (address common misconceptions)
5. Comparison (alternatives considered)

**Less critical**: Technical Deep-Dive (stakeholders less technical).

**Output format**: Executive summary + detailed technical appendix.

---

## Anti-Patterns in Research Execution

### Anti-Pattern 1: Depth Mismatch

**Problem**: Spending 80% time on Technical Deep-Dive for evaluation research.

**Symptom**: User can't decide if tool fits because applicability not assessed.

**Fix**: Adjust depth based on research goal (use Patterns A/B/C).

### Anti-Pattern 2: Skipping Fundamentals

**Problem**: Jumping to advanced topics without establishing basics.

**Symptom**: Research assumes reader knowledge that doesn't exist.

**Fix**: ALWAYS cover Fundamentals, even if brief.

### Anti-Pattern 3: No Critical Assessment

**Problem**: Covering all spectra but missing critical evaluation.

**Symptom**: Research is comprehensive but doesn't help decision-making.

**Fix**: Emphasize Applicability and Critical FAQ.

### Anti-Pattern 4: Tool-Only Focus for Concept Research

**Problem**: Researching "LLM caching" by only looking at LMCache.

**Symptom**: Missing broader context, alternative approaches.

**Fix**: Use Pattern 2 (General Technique) not Pattern 1 (Specific Tool).

---

## Repository Naming Conventions

### Specific Tool

```
Tool name: LMCache
Repo: research-lmcache

Tool name: LangChain
Repo: research-langchain

Tool name: FAISS
Repo: research-faiss
```

**Rule**: Lowercase tool name, no spaces.

### General Concept

```
Concept: LLM caching
Repo: research-llm-cache

Concept: Retrieval-Augmented Generation
Repo: research-rag

Concept: Vector search
Repo: research-vector-search
```

**Rule**: Lowercase, hyphens for spaces, descriptive.

### Comparison

```
Topic: Vector databases
Repo: research-vector-databases

Topic: LLM frameworks comparison
Repo: research-llm-frameworks

Topic: Embedding models
Repo: research-embedding-models
```

**Rule**: Category name (plural if appropriate).

---

## Summary

**Research patterns** adapt investigation approach based on:
1. **Topic type**: Tool vs Concept vs Comparison
2. **Familiarity**: Never heard vs Deep-dive
3. **Goal**: Evaluation vs Learning vs Reporting

**Key adaptations**:
- Spectrum depth varies by pattern
- Investigation order can be adjusted
- Output format matches goal

**Execution flexibility**: Sequential, prioritized, or iterative based on constraints.

**Always maintain**: Critical assessment, honest limitations, applicability focus.
