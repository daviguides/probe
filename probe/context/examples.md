# Research Examples

**Analysis of real research conducted using Probe methodology (or aligned with it).**

---

## Purpose

Demonstrate Probe principles in action through concrete examples.

Reference: `/Users/daviguides/work/sources/researchs/research-llm-cache`

---

## Example 1: LMCache Research (Specific Tool, Never Heard Of It)

### Context

**Topic**: LMCache (KV cache library for LLMs)
**Familiarity**: Never heard of it before
**Goal**: Evaluation (can we adopt?)
**Source trigger**: Stakeholder sent LinkedIn post (positive-biased)
**Time invested**: Comprehensive research (multiple sessions)

### Spectrum Coverage Analysis

#### Spectrum 1: Fundamentals ✅

**Evidence of depth**:
```markdown
README.md provides:
- Clear 1-sentence definition: "KV cache layer for LLMs running locally"
- Problem statement: "Repeated context computation wastes GPU cycles"
- Key concepts explained: KV tensors, attention mechanism, cache reuse
- Context: Extension for vLLM/SGLang inference engines
```

**What makes this deep**:
- Starts from ZERO knowledge assumption
- Explains WHY it exists (problem it solves)
- Defines prerequisite concepts (KV cache, attention)
- Situates in ecosystem (vLLM/SGLang)

**Pattern**: Fundamentals-heavy because researcher had zero prior knowledge.

#### Spectrum 2: Architecture ✅

**Evidence**:
```markdown
Components identified:
- KV Tensor Store (multi-tier: GPU → CPU → Disk → Redis)
- Cache Manager (hit/miss, eviction)
- Encoder (compression)
- Integration Layer (framework adapters)

Flow diagram (ASCII art):
Query → Hash → Lookup → Hit? Reuse : Compute → Store
```

**What makes this deep**:
- Breaks down into understandable components
- Explains data flow
- Multi-tier storage detailed
- Integration points clear

**Pattern**: Architecture as foundation for understanding HOW it works.

#### Spectrum 3: Technical Deep-Dive ✅

**Evidence**:
```markdown
Advanced techniques covered:
- Non-prefix cache reuse (position-independent)
- CacheBlend (knowledge fusion + selective recomputation)
- Multi-tier with GDS (GPU Direct Storage)
- Custom tensor encoders (CacheGen)

Edge case addressed:
"How does LMCache handle dynamic context changes?"
→ Dedicated section with partial invalidation strategies
```

**What makes this deep**:
- Goes beyond basic caching to advanced (CacheBlend, non-prefix)
- Explains non-obvious features
- Addresses edge cases explicitly
- Technical mechanisms detailed

**Pattern**: Technical depth appropriate for research-driven tool.

#### Spectrum 4: Academic Research ✅

**Evidence**:
```markdown
Papers reviewed:
1. CacheGen (SIGCOMM 2024): Compression and streaming
2. CacheBlend (EuroSys 2025 - Best Paper): Knowledge fusion
3. Epic: Position-Independent Context Caching

Novelty assessed:
"First to combine non-prefix reuse + knowledge fusion"
```

**What makes this deep**:
- Foundational papers cited
- Key contributions summarized
- Novelty evaluated
- Research context provided

**Pattern**: Academic depth matches research-driven nature of tool.

#### Spectrum 5: Integration ✅

**Evidence**:
```markdown
Prerequisites clearly stated:
"Prerequisites: Local LLM deployment (vLLM or SGLang)
 NOT compatible with: OpenAI, Anthropic, cloud LLM APIs"

Installation: pip install lmcache vllm

Framework compatibility matrix:
✅ vLLM, SGLang, KServe, NVIDIA Dynamo
❌ Transformers, LlamaIndex, APIs
```

**What makes this deep**:
- Hard prerequisites identified EARLY (critical for evaluation)
- Incompatibilities stated explicitly
- Installation steps
- Framework matrix clear

**Pattern**: Integration-heavy because evaluation goal requires feasibility assessment.

#### Spectrum 6: Performance ✅

**Evidence**:
```markdown
Benchmarks WITH CONDITIONS:
- Multi-round QA: 10s → 1s TTFT (10x, with 100% cache hit, H100 GPU)
- RAG: 100 q/s → 450 q/s (4.5x, documents reused)
- Long context: 15s → 1s TTFT (15x, prefix cached)

Worst case documented:
"0% cache hit → slight overhead (~5-10%)"

Typical case:
"50-80% hit rate → 3-5x improvement"

Trade-offs:
"Storage overhead (1GB per 1M tokens) vs latency reduction"
```

**What makes this deep**:
- Metrics with CONDITIONS stated (not just "100x faster")
- Best AND worst AND typical case
- Trade-offs explicit
- Realistic expectations set

**Pattern**: Performance depth crucial for evaluation goal.

#### Spectrum 7: Use Cases ✅

**Evidence**:
```markdown
✅ Ideal for:
1. Chatbots (multi-turn): System prompt + history reused
2. RAG (document analysis): Same docs, multiple queries
3. Few-shot learning: Examples reused
4. Batch processing: Same doc, many questions

WHY it works:
"Customer service chatbot → System prompt (500 tokens) cached,
reused across conversations → 10x latency reduction"
```

**What makes this deep**:
- Specific, concrete use cases (not generic)
- Explanation of WHY for each
- Real-world scenario examples
- Quantified benefits per use case

**Pattern**: Use case depth supports evaluation (does it fit OUR chatbot/RAG needs?).

#### Spectrum 8: Applicability ✅ (CRITICAL)

**Evidence**:
```markdown
✅ Works well for:
- Local LLM deployments (vLLM, SGLang)
- Workloads with context reuse (chatbots, RAG)
- High cache hit rate scenarios (>50%)

❌ Less suitable for:
- API-based LLMs (OpenAI, Claude) - NOT compatible
- Unique queries without reuse - no cache benefit
- Resource-constrained environments - storage overhead

⚠️ Trade-offs:
- Storage cost vs latency gain
- Cache management complexity vs performance
- Infrastructure requirement (can't use with APIs)
```

**What makes this deep (and CRITICAL)**:
- Explicit "NOT suitable for" section
- Incompatibilities highlighted
- Trade-offs front and center
- Limitations as prominent as benefits

**Pattern**: Applicability is MOST CRITICAL for evaluation goal.

**Critical assessment**:
```markdown
"Applicability to our use case:
- Our context: API-based LLMs (OpenAI)
- LMCache requires: Local deployment
- Verdict: NOT applicable. LMCache incompatible with APIs.
- Alternative: OpenAI Prompt Caching (50% discount)"
```

**This is the ESSENCE of non-naive research**: Honest assessment that technology DOESN'T fit.

#### Spectrum 9: Implementation ✅

**Evidence**:
```python
# Working code examples
from vllm import LLM, SamplingParams
from lmcache import LMCacheConfig

config = LMCacheConfig(storage_backend="cpu")
llm = LLM(model="meta-llama/Llama-2-7b-hf", lmcache_config=config)

# Production config with Redis
config_prod = LMCacheConfig(
    storage_backend="redis",
    redis_host="localhost",
    redis_port=6379,
    compression_enabled=True
)
```

Troubleshooting:
```markdown
Common issue: Cache misses despite repeated context
→ Check: hash collision, token position shifts, chunk size mismatch
```

**What makes this deep**:
- Functional code (not pseudocode)
- Basic AND production configs
- Common pitfalls documented
- Debugging guidance

**Pattern**: Implementation sufficient for complexity assessment (not building yet).

#### Spectrum 10: Critical FAQ ✅ (CRITICAL)

**Evidence**:
```markdown
Q: Does LMCache work with OpenAI/Claude APIs?
A: NO. LMCache requires local LLM deployment (vLLM, SGLang).
   Alternative: Use Prompt Caching APIs (OpenAI offers 50% discount)

Q: Will I always get 10x speedup?
A: NO. Speedup depends on cache hit rate:
   - 100% hit: up to 15x
   - 50% hit: ~3-5x
   - 0% hit: slight overhead

Q: Is 100% cache hit realistic?
A: For specific workloads (chatbots with fixed prompts, RAG with doc reuse).
   NOT realistic for diverse unique queries.
```

**What makes this EXCELLENT**:
- Honest "NO" answers (multiple)
- Corrects misconceptions (not always 10x)
- Sets realistic expectations (100% hit is rare)
- Provides alternatives (Prompt Caching APIs)

**This exemplifies anti-naive research**: Questions that challenge optimistic claims, answered honestly.

---

### Anti-Naive Techniques Applied

#### Technique 1: Stakeholder Source Critique

**Starting point**: LinkedIn post (engagement-optimized, positive-biased)

**Critical response**:
- Didn't accept LinkedIn claims at face value
- Went to primary sources (GitHub, papers, docs)
- Verified claims independently
- Found what LinkedIn post DIDN'T mention (API incompatibility)

#### Technique 2: Limitation Mining

**Process**:
- Checked GitHub issues for problems
- Searched "LMCache doesn't work", "LMCache problems"
- Found real user issues (cache misses, setup complexity)
- Documented explicitly in "Less suitable for" section

#### Technique 3: Applicability to OUR Context

**Critical assessment**:
```markdown
"Our environment: API-based (OpenAI)
 LMCache requirement: Local deployment
 INCOMPATIBLE → Do not adopt
 Alternative: Prompt Caching APIs"
```

**This is the CORE of Staff-level research**: Assessing fit for SPECIFIC context, not generic.

#### Technique 4: Trade-Off Identification

**Pattern**: Every benefit paired with cost:
```markdown
Benefit: 10x latency reduction
Cost: Storage (1GB/1M tokens), setup complexity, infra management

Benefit: Advanced features (CacheBlend, non-prefix)
Cost: More complex than simple prefix caching
```

#### Technique 5: Honest FAQ Construction

**Not marketing FAQ**:
```markdown
❌ Marketing: "Is LMCache fast? Yes!"
✅ Critical: "Does LMCache work with APIs? NO."
```

**Pattern**: Questions that surface inconvenient truths, answered honestly.

---

### Depth Calibration Analysis

**Context**:
- Familiarity: Never heard of it (HIGH fundamentals depth)
- Goal: Evaluation (HIGH applicability depth)
- Topic: Research-driven tool (HIGH academic depth)
- Time: Standard research (~8-16h)

**Observed depth allocation** (estimated from output):
```
Fundamentals:     ████████ 80% ✅
Architecture:     ██████░░ 60% ✅
Technical:        ██████░░ 60% ✅
Academic:         ██████░░ 60% ✅
Integration:      ████████ 80% ✅ (evaluation goal)
Performance:      ████████ 80% ✅ (evaluation goal)
Use Cases:        ██████░░ 60% ✅
Applicability:    ████████ 100% ✅ (CRITICAL for evaluation)
Implementation:   ████░░░░ 40% ✅ (not building yet)
Critical FAQ:     ████████ 80% ✅ (address concerns)
```

**Pattern matches**: "Specific Tool, Never Heard Of, Evaluation Goal" from depth-calibration.md.

---

### What Makes This Research NON-NAIVE

**1. Source Diversity**:
- GitHub repo (code inspection)
- Academic papers (CacheGen, CacheBlend, Epic)
- Official docs
- Community (GitHub issues)
- NOT just LinkedIn post or vendor blog

**2. Critical Skepticism**:
- Challenged "seamless integration" → found setup complexity
- Questioned "works with LLMs" → found API incompatibility
- Verified "100x speedup" → found conditions (cache hit rate)

**3. Limitations Prominent**:
- "Less suitable for" section as prominent as "Ideal for"
- API incompatibility highlighted
- Worst-case performance documented

**4. Trade-Offs Explicit**:
- Storage cost vs latency
- Complexity vs features
- Control vs convenience (vs API caching)

**5. Applicability Assessment**:
- Evaluated against SPECIFIC use case (API-based deployment)
- Concluded: NOT applicable
- Provided alternative (Prompt Caching APIs)

**6. Honest FAQ**:
- Multiple "NO" answers
- Corrected misconceptions
- Set realistic expectations

---

### Learning Points for Future Research

**Patterns to replicate**:

1. **Start with fundamentals when zero knowledge** - Don't assume prior knowledge exists

2. **Emphasize applicability for evaluation** - "Does it fit?" is more critical than "How does it work?" when deciding adoption

3. **Surface incompatibilities EARLY** - API incompatibility could have saved hours if found first

4. **Document limitations as prominently as benefits** - ❌ sections as visible as ✅ sections

5. **Honest FAQ with "NO" answers** - Challenge optimistic claims, provide realistic answers

6. **Assess for YOUR context, not generic** - "Works for chatbots" is useless if YOUR chatbot uses APIs

7. **Provide alternatives when it doesn't fit** - Don't just say "not applicable", suggest what IS applicable

---

### Validation Against Probe Specs

**Completeness** ✅:
- All 10 spectra covered
- All critical questions answered
- Source diversity (GitHub + papers + docs + issues)
- Structural completeness (intro, arch, perf, ❌ sections, FAQ)

**Depth** ✅:
- Mechanisms explained (KV cache, how it works)
- Limitations surfaced (API incompatibility)
- Trade-offs explicit (storage vs latency)
- Comparative (vs vLLM native, vs API caching)
- Academic foundation (3 papers reviewed)

**Quality** ✅:
- Critical skepticism (challenged claims)
- Realistic performance (best/typical/worst case)
- Applicability assessed (NOT applicable to our context)
- Honest FAQ (multiple "NO" answers)

**Result**: Research-llm-cache exemplifies Probe methodology.

---

## Example 2: (Placeholder for Future Examples)

When additional research is conducted following Probe methodology, analyze here.

**Suggested future examples**:
- General concept research (e.g., "LLM caching" broadly)
- Comparison research (e.g., "Vector databases for RAG")
- Deep-dive research (e.g., advanced LangChain patterns)

---

## Summary

**LMCache research demonstrates**:
- Multi-spectrum coverage (all 10)
- Depth calibration (heavy fundamentals + applicability)
- Anti-naive techniques (critical questions, honest "NO" answers)
- Applicability focus (evaluated for SPECIFIC context, rejected when didn't fit)
- Honest limitations (API incompatibility highlighted)
- Alternative suggestions (Prompt Caching APIs)

**Key lesson**: Deep research concludes with "NOT applicable" is SUCCESS, not failure.

**Naive research** would have stopped at "sounds good" and recommended adoption.

**Deep research** assessed critically, found incompatibility, provided alternative.

**This is the Probe standard.**
