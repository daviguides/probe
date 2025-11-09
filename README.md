# Probe

**A multi-spectrum research context architecture for deep technical investigation.**

---

## What is Probe?

**Probe** is a Claude Code plugin that conducts systematic, multi-dimensional technical research following the Gradient architectural pattern.

Like a space probe uses multiple instruments to analyze targets from multiple spectra, this system uses multiple research dimensions to investigate technical topics comprehensively.

Give it a term or query, and Probe investigates from 10 distinct perspectives:
- **Fundamentals** - What it is, why it exists
- **Architecture** - How it works internally
- **Technical Deep-Dive** - Advanced techniques, algorithms
- **Academic Research** - Papers, theoretical foundation
- **Integration** - How to adopt, prerequisites
- **Performance** - Benchmarks (realistic, not marketing)
- **Use Cases** - When to apply
- **Applicability** - When to use AND when NOT to use
- **Implementation** - Code examples, production patterns
- **Critical FAQ** - Honest Q&A, including "NO" answers

Probe reproduces structured research methodology through layered context (SPEC → CONTEXT → PROMPTS), ensuring consistent, thorough investigations that go beyond naive marketing acceptance.

---

## Why "Probe"?

### Semantic Rationale

**Probe** = The investigative agent, the system that explores and discovers.

The name draws inspiration from **space probes** (Voyager, Mars rovers, etc.):

```
PROBE (Voyager, Cassini, etc.)
├─ Spectrometer   → UV spectrum
├─ Camera         → Visible spectrum
├─ IR Sensor      → Infrared spectrum
└─ Radar          → Radio spectrum
```

Just as space probes use **multiple instruments** to analyze targets from **multiple spectra**, this system uses **multiple research dimensions** to understand technical topics comprehensively.

**Probe** is the **WHAT** (the investigative system).
**Spectrum** is the **HOW** (multi-dimensional analysis method).

---

## Philosophy

> "Like a space probe scanning distant worlds with multiple instruments, Probe examines technical topics through multiple analytical lenses."

Research isn't one-dimensional. Every query deserves investigation from libraries, techniques, comparisons, real-world applications, AND critical assessment of limitations.

**Key principles**:
- **Beyond naive acceptance** - Challenge claims, verify independently
- **Limitations as prominent as benefits** - Honest assessment
- **Multi-spectrum coverage** - All 10 dimensions investigated
- **Context-specific applicability** - Does it fit YOUR use case?
- **Critical FAQ** - Honest "NO" answers when appropriate

---

## Quick Start

### Installation

Install as Claude Code plugin (assumes Gradient structure for plugins).

### Usage

```bash
/probe:research <topic>
```

**Examples**:
```bash
/probe:research lmcache
/probe:research llm-cache
/probe:research vector-databases
```

**What happens**:
1. Creates `~/work/sources/researchs/research-<topic>/`
2. Creates private GitHub repo `research-<topic>`
3. Investigates all 10 research spectra
4. Generates comprehensive research artifacts
5. Commits and pushes to GitHub
6. Returns summary with key findings and recommendation

**Time**: 10-30 minutes autonomous execution (no pausing mid-research)

---

## Architecture

Probe follows the **Gradient pattern**:

```
probe/
├── spec/                           # SPECS - Normative (WHAT to research)
│   ├── research-methodology-spec.md      # Deep vs naive research
│   ├── research-spectra-spec.md          # 10 investigation dimensions
│   ├── critical-questions-spec.md        # Mandatory questions per spectrum
│   └── validation-spec.md                # Completeness/depth/quality criteria
│
├── context/                        # CONTEXT - Applied (HOW to research)
│   ├── research-patterns.md              # Investigation patterns by topic type
│   ├── anti-naive-guide.md               # Avoiding superficial research
│   ├── depth-calibration.md              # Adaptive depth based on context
│   ├── critical-thinking-guide.md        # 10-stage analysis framework
│   └── examples.md                       # LMCache research analyzed
│
├── prompts/                        # PROMPTS - Orchestration
│   ├── load-research-context.md          # Load specs + context (SSOT)
│   ├── conduct-research-workflow.md      # Main research workflow
│   └── setup-research-environment-workflow.md  # Repo creation workflow
│
└── scripts/                        # SCRIPTS - Automation
    ├── generate-repo-name.sh             # Normalize topic to repo name
    └── create-research-repo.sh           # Create local + GitHub repo

agents/                             # AGENTS - Autonomous execution
└── research-conductor.md                 # Multi-spectrum research agent

commands/                           # COMMANDS - Entry point
└── research.md                           # /probe:research command
```

Smooth transitions from normative research standards through applied investigation patterns to dynamic execution.

---

## Features

### Multi-Spectrum Investigation (10 Dimensions)

Every research covers:
1. **Fundamentals** - Succinct intro (zero knowledge assumed)
2. **Architecture** - How it works (components, flow)
3. **Technical Deep-Dive** - Advanced techniques
4. **Academic Research** - Papers, theoretical foundation
5. **Integration** - Prerequisites, adoption path
6. **Performance** - Benchmarks (realistic conditions)
7. **Use Cases** - Specific applications
8. **Applicability** - When to use / NOT use
9. **Implementation** - Working code examples
10. **Critical FAQ** - Honest Q&A (including "NO" answers)

### Anti-Naive Research

**Challenges claims**:
- Verifies vendor benchmarks independently
- Surfaces what marketing doesn't advertise
- Questions "up to 100x faster" with conditions
- Finds "when NOT to use" scenarios

**Trade-off identification**:
- Every benefit paired with cost
- Explicit "you get X but pay Y"
- Storage overhead vs performance gain
- Complexity vs features

**Honest limitations**:
- ❌ "Less suitable for" as prominent as ✅ "Ideal for"
- API incompatibilities highlighted
- Worst-case performance documented

### Critical FAQ with "NO" Answers

**Not marketing FAQ**:
```markdown
❌ Marketing: "Is it fast? Yes!"
✅ Critical: "Does it work with OpenAI API? NO. Alternative: Prompt Caching."
```

**Pattern**: Questions that surface inconvenient truths, answered honestly.

### Autonomous Execution (Anti-Babysitting)

**Executes to completion**:
- All 10 spectra investigated without pausing
- No "should I continue?" mid-research
- Completes or encounters hard blocker (no premature stops)

**User returns to**:
- Complete research (100%, not 80%)
- Committed to GitHub
- Summary with recommendation

---

## Use Cases

### Use Case 1: Stakeholder sent LinkedIn link

**Scenario**: Tech lead sends LinkedIn post about "revolutionary" new tool.

**Challenge**: LinkedIn is engagement-optimized (positive-biased).

**Probe response**:
```bash
/probe:research <tool-from-linkedin>
```

**Output**:
- Goes beyond LinkedIn hype
- Verifies claims independently (GitHub, papers, community)
- Surfaces limitations not mentioned in post
- Provides honest "works for X, NOT for Y" assessment
- Recommends adopt/reject based on YOUR context

### Use Case 2: Never heard of it, need to decide

**Scenario**: New technology mentioned in meeting. Zero prior knowledge. Need evaluation.

**Probe response**:
```bash
/probe:research <new-technology>
```

**Output**:
- Succinct intro (assumes zero knowledge)
- Comprehensive evaluation (all 10 spectra)
- Critical applicability assessment (fits YOUR use case?)
- Honest recommendation (including "doesn't fit" if true)
- Alternative suggestions (if rejected)

### Use Case 3: Learning for knowledge building

**Scenario**: Want to deeply understand topic for future reference.

**Probe response**:
```bash
/probe:research <topic>
```

**Output**:
- Comprehensive multi-spectrum coverage
- Balanced depth (fundamentals → advanced)
- Working examples and implementations
- Academic foundation (if research-driven)
- Reusable knowledge artifact

---

## Philosophy: Anti-Naive Research

### Naive Research (What Probe Avoids)

**Characteristics**:
- Echoes vendor claims uncritically
- Omits limitations and trade-offs
- Accepts "up to 100x faster" without conditions
- Only discusses positive aspects
- No "when NOT to use" section
- FAQ with all "YES" answers

**Result**: Marketing echo chamber, not useful for decision-making.

### Deep Research (What Probe Delivers)

**Characteristics**:
- Challenges claims with critical questions
- Surfaces trade-offs and limitations explicitly
- Assesses applicability to SPECIFIC context
- Provides honest "NO" answers
- Goes beyond "what" to "how" and "why"
- Includes "when NOT to use" prominently

**Result**: Informed, pondered assessment enabling real decisions.

---

## Status

**Current**: v1.0 - Initial implementation

**Complete**:
- ✅ 10 research spectra defined
- ✅ Anti-naive methodology specified
- ✅ Depth calibration patterns
- ✅ Critical thinking framework
- ✅ Research conductor agent
- ✅ `/probe:research` command
- ✅ Automated repo setup (local + GitHub)

---

## Examples

### Example: LMCache Research

See `probe/context/examples.md` for detailed analysis of LMCache research conducted using Probe methodology.

**Key findings example**:
```markdown
✅ Strengths:
- 10x latency reduction for chatbots with context reuse
- Advanced techniques (CacheBlend, non-prefix caching)
- Research-backed (papers: CacheGen, CacheBlend)

❌ Limitations:
- NOT compatible with API-based LLMs (OpenAI, Claude)
- Requires local deployment (vLLM, SGLang)
- Storage overhead (1GB per 1M tokens)

⚠️ Trade-offs:
- Performance vs Infrastructure complexity
- Control vs Convenience (compared to API caching)

Recommendation: Do NOT adopt (API incompatibility)
Alternative: OpenAI Prompt Caching (50% discount, API-compatible)
```

**This exemplifies**:
- Honest limitations (API incompatibility highlighted)
- Trade-offs explicit (performance vs complexity)
- Context-specific recommendation (doesn't fit → alternative suggested)
- "NO" in applicability (deep research concluded "don't adopt")

---

## Contributing

Research examples and pattern refinements welcome.

**Submit**:
- Additional research examples
- Depth calibration patterns
- Critical question refinements
- Anti-naive techniques

---

## License

MIT

---

**Probe** - Multi-spectrum technical research, systematized.

**Philosophy**: Deep research that concludes with "NOT applicable" is success, not failure.

Naive research recommends adoption uncritically. Deep research assesses critically, finds incompatibility, provides alternative.

**This is the Probe standard.**
