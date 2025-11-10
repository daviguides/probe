# Extract Topic from Input Workflow

**Purpose**: Parse user input (URL, text, or direct topic) to extract research topic, POV (Point of View), and source BIAS.

---

## Overview

This workflow handles all input types for `/probe:research`:
- **Direct topic**: `lmcache` → Extract as-is
- **URL only**: `https://...` → Fetch content, extract topic + POV + BIAS
- **Text only**: `"Would caching help multi-agent memory?"` → Extract topic + POV
- **Text + URL**: `"vLLM could help: [url]"` → Extract from both, synthesize
- **Direct topic + POV**: `lmcache --pov "I heard it's 15x faster"` → Use topic, capture POV

---

## Stage 0: Detect Input Type

### Step 0.1: Analyze Input String

**Detection patterns**:

1. **Contains `--pov` flag**:
   - Pattern: `<topic> --pov "<text>"`
   - Type: Direct topic with explicit POV
   - Action: Extract topic before flag, POV after flag

2. **Starts with URL** (http:// or https://):
   - Pattern: `https://...` (no additional text)
   - Type: URL only
   - Action: WebFetch URL

3. **Contains URL + text**:
   - Pattern: Text before/after URL
   - Type: Text + URL
   - Action: Parse text separately, then WebFetch URL

4. **Natural language question/statement** (>5 words, has spaces):
   - Pattern: Full sentences, questions
   - Type: Text only
   - Action: Parse for topic keywords

5. **Short string** (1-4 words, no URL):
   - Pattern: `lmcache`, `vector databases`
   - Type: Direct topic
   - Action: Use as-is

---

## Stage 1: Extract Topic

### For Direct Topic (Type 1 or 5)

**Action**: Use input string as topic (trim whitespace)

**Example**:
- Input: `lmcache`
- Topic: `lmcache`

---

### For URL Only (Type 2)

**Step 1.1: Fetch URL Content**

Use WebFetch to retrieve content:
```
WebFetch(url=<url>, prompt="Extract main topic, key claims, and article type")
```

**Step 1.2: Extract Topic from Content**

Identify:
1. **Main technology/concept** discussed (proper nouns, frameworks, techniques)
2. **Secondary topics** (if multiple technologies mentioned)
3. **Article focus** (introduction, comparison, tutorial, opinion)

**Example**:
- URL: LinkedIn post about LMCache
- Content: "LMCache is revolutionary for LLM serving with 15x speedup..."
- Topic: `lmcache`

**Step 1.3: Handle Multiple Topics**

If multiple technologies detected:
- Analyze relationship (nested vs independent)
- See Stage 2 for relationship analysis

---

### For Text Only (Type 4)

**Step 1.1: Parse for Technology Keywords**

Identify:
1. **Proper nouns** (LMCache, vLLM, Langchain)
2. **Technical concepts** (caching, memory management, vector databases)
3. **Techniques** (multi-agent systems, RAG, prompt engineering)

**Step 1.2: Extract User's Core Question/Concern**

Identify:
- What is the user asking? (evaluation, implementation, comparison)
- What problem are they trying to solve?

**Example**:
- Input: "For multi agent system, would cache help with memory management as info passes from agent to agent?"
- Topics detected: `multi-agent systems`, `caching`, `memory management`
- User concern: "Would caching help with context loss in multi-agent systems?"

**Step 1.3: Handle Multiple Topics**

See Stage 2 for relationship analysis.

---

### For Text + URL (Type 3)

**Step 1.1: Parse Text Component**

Apply "Text Only" extraction to text portion.

**Step 1.2: Fetch URL Component**

Apply "URL Only" extraction to URL portion.

**Step 1.3: Synthesize Topics**

**Prioritization**:
1. User's framing (text) takes precedence for scope
2. URL content provides supporting detail/context

**Example**:
- Input: "vLLM could be beneficial as we host open source models: [url to vLLM docs]"
- Text topic: `vLLM`, concern: "for self-hosted open source models"
- URL topic: `vLLM` (confirms)
- Final topic: `vLLM` (unified)
- Context: Self-hosted open source model deployment

---

## Stage 2: Analyze Topic Relationships (Multi-Topic Cases)

### Step 2.1: Classify Relationship

**Nested Topics** (research as unified topic):
- **Patterns**: "X for Y", "Y with X", "how to X in Y", "would X help with Y?"
- **Examples**:
  - "caching for multi-agent systems"
  - "memory management with caching"
  - "would caching help multi-agent memory?"
- **Action**: Create compound topic slug

**Independent Topics** (ask user: unified or separate):
- **Patterns**: "X and Y", multiple unrelated technologies
- **Examples**:
  - "langchain and vector databases" (unclear relationship)
  - "multi-agent systems and caching" (could be related or separate)
- **Action**: Ask user to clarify

**Comparative Topics** (research with Spectrum 11):
- **Patterns**: "X vs Y", "compare X and Y", "X or Y"
- **Examples**:
  - "LMCache vs CacheBlend"
  - "vLLM or SGLang"
- **Action**: Set comparative research mode

### Step 2.2: Create Topic Slug

**For Nested Topics**:
- Combine all related terms with hyphens
- Order: General → Specific
- Example: `multi-agent-memory-management-with-caching`

**For Independent Topics** (if user chooses unified):
- Combine terms with "and"
- Example: `langchain-and-vector-databases`

**For Comparative Topics**:
- Combine with "vs"
- Example: `lmcache-vs-cacheblend`

**Slug length warning**:
- If slug >80 characters, suggest user simplify
- Example: Too long → Ask "Can we focus on core relationship?"

---

## Stage 3: Extract POV (Point of View)

### Step 3.1: Identify POV Source

**From direct topic with --pov flag**:
- POV = text after `--pov`
- Example: `lmcache --pov "I heard it's 15x faster"` → POV: "I heard it's 15x faster"

**From URL content**:
- POV = main claim/assertion in article/post
- Example: LinkedIn post claims "LMCache is revolutionary with 15x speedup"
- POV: "LMCache provides 15x speedup for LLM serving"

**From text input**:
- POV = user's question or statement
- Example: "Would caching help with multi-agent memory loss?"
- POV: "Would caching help with context loss in multi-agent systems?"

**From text + URL**:
- POV = user's framing (text takes precedence)
- Include URL claim as supporting context

### Step 3.2: Extract Specific Claims

Break down POV into testable claims:
- **Performance claims**: "15x faster", "10x reduction in latency"
- **Capability claims**: "Works with all LLMs", "API-compatible"
- **Scope claims**: "Revolutionary", "Best solution for X"
- **Questions**: "Would X help with Y?", "Is X better than Y?"

**Example**:
- POV: "LMCache is revolutionary with 15x speedup for all LLMs"
- Claims extracted:
  1. "LMCache provides 15x speedup" (performance)
  2. "Works with all LLMs" (scope)
  3. "Revolutionary" (qualitative assessment)

---

## Stage 4: Detect Source BIAS

### Step 4.1: Identify Source Type

**For URL inputs**, classify source:

1. **LinkedIn post**:
   - URL contains `linkedin.com/posts/`
   - Bias: Engagement-optimized (positive bias, omits limitations)

2. **Vendor blog**:
   - URL from company domain (e.g., company.com/blog/)
   - Bias: Marketing material (cherry-picked claims, benefits emphasized)

3. **Academic paper**:
   - URL from arxiv.org, ACM, IEEE, research institutions
   - Bias: Rigorous but may lack practical guidance

4. **GitHub repository/issues**:
   - URL contains github.com
   - Bias: Technical detail, may have negative bias (focus on problems)

5. **Official documentation**:
   - URL from project's official docs
   - Bias: Authoritative, may omit known limitations

6. **Tech blog/Medium**:
   - URL from medium.com, towardsai.net, personal blogs
   - Bias: Variable (can be balanced or promotional)

### Step 4.2: Document Bias Characteristics

For detected source type, note:
- **Typical emphasis**: What this source type highlights
- **Typical omissions**: What this source type often skips
- **Reliability level**: How much to trust claims

**Example**:
- Source: LinkedIn post
- Bias characteristics:
  - Emphasis: Speed, innovation, "revolutionary" claims
  - Omissions: Deployment complexity, limitations, failure modes
  - Reliability: Low for quantitative claims (verify independently)

### Step 4.3: Extract Bias Indicators

Identify bias signals in content:
- **Superlatives**: "Best", "revolutionary", "game-changing"
- **Unqualified claims**: "15x faster" (no conditions mentioned)
- **Missing negatives**: No "when NOT to use" section
- **Cherry-picked data**: Only best-case benchmarks

---

## Stage 5: Confirm with User

### Step 5.1: Present Extraction Results

**Format**:
```
Topic detected: "<topic-slug>"

[If multiple topics and relationship unclear]
Topic relationship: <nested | independent | comparative>
Unified research: "<compound-topic>" OR Separate research: "<topic1>", "<topic2>"

[If POV exists]
POV identified:
"<original POV text>"
Claims to validate:
- <claim 1>
- <claim 2>

[If BIAS detected]
BIAS detected: <source type> (<bias characteristics>)
Typical emphasis: <what source emphasizes>
Typical omissions: <what source often skips>

Proceed with research?
```

**Example (LinkedIn post)**:
```
Topic detected: "lmcache"

POV identified:
"LMCache is the fastest serving engine for LLMs with 15x speedup"
Claims to validate:
- LMCache provides 15x speedup
- LMCache is the fastest serving engine for LLMs

BIAS detected: LinkedIn post (engagement-optimized, positive bias)
Typical emphasis: Speed, innovation, impressive metrics
Typical omissions: Deployment complexity, limitations, API compatibility issues

Proceed with research?
```

**Example (Text only, nested topics)**:
```
Topic detected: "multi-agent-memory-management-with-caching"

Topic relationship: Nested (caching FOR memory management IN multi-agent systems)
Unified research: "Caching strategies for multi-agent memory management"

POV identified:
"Would caching help with context loss as information passes from agent to agent?"
Question to answer:
- Can caching mitigate context loss in multi-agent systems?
- What caching strategies are suitable for agent-to-agent information passing?

BIAS detected: None (user question, no external source)

Proceed with research?
```

**Example (Independent topics - requires clarification)**:
```
Topics detected: "langchain", "vector-databases"

Topic relationship: Independent (both mentioned, unclear connection)

Please choose research approach:
1. Unified research: "Langchain and vector databases" (explore integration)
2. Separate research: "langchain" first, then "vector-databases" (two research sessions)
3. Comparative research: "langchain vs vector-databases" (if comparison intended)

Which approach?
```

### Step 5.2: Handle User Response

**If user confirms**: Proceed to research workflow

**If user rejects topic**: Ask for correct topic
- "What topic should we research instead?"
- Use corrected topic, keep POV/BIAS if still relevant

**If user chooses research approach** (independent topics):
- Apply choice (unified, separate, comparative)
- Update topic slug accordingly

---

## Stage 6: Prepare Extraction Output

### Step 6.1: Package Extraction Results

Create extraction object:
```
{
  "topic": "<final-topic-slug>",
  "research_mode": "standard | comparative",
  "pov": {
    "exists": true | false,
    "original_text": "<POV text>",
    "claims": ["<claim1>", "<claim2>", ...],
    "source": "user | url | flag"
  },
  "bias": {
    "exists": true | false,
    "source_type": "<source type>",
    "characteristics": {
      "emphasis": "<typical emphasis>",
      "omissions": "<typical omissions>",
      "reliability": "high | medium | low"
    },
    "indicators": ["<indicator1>", "<indicator2>", ...]
  },
  "original_input": "<raw user input>",
  "confirmation": "confirmed by user"
}
```

### Step 6.2: Pass to Research Workflow

This extraction output is passed to:
- `conduct-research-workflow.md` (Stage 1: Context Detection)
- Used in Stage 4 to generate POV-ANALYSIS.md (if POV exists)
- Used in Stage 4 to generate BIAS-ANALYSIS.md (if BIAS exists)

**Important**: Extraction does NOT affect research depth or workflow
- Research proceeds with standard 10 spectra
- Depth based on familiarity + goal (standard calibration)
- POV and BIAS are analyzed POST-research

---

## Examples

### Example 1: LinkedIn Post (URL only)

**Input**: `https://linkedin.com/posts/akshay-pachaar_lmcache-analysis`

**Extraction**:
- Topic: `lmcache`
- POV: "LMCache provides 15x speedup for LLM serving"
- Claims: ["15x speedup", "fastest serving engine"]
- BIAS: LinkedIn post (engagement-optimized)
- Confirmation: Present to user → Proceed

---

### Example 2: Article (URL only)

**Input**: `https://pub.towardsai.net/we-spent-47000-running-ai-agents`

**Extraction**:
- Topic: `ai-agents-production-costs` (or `multi-agent-system-cost-management`)
- POV: "We spent $47k running AI agents in production - issues with A2A and MCP"
- Claims: ["High production costs for AI agents", "A2A has cost issues", "MCP has cost issues"]
- BIAS: Tech blog (medium reliability, experience report)
- Confirmation: Present to user → Proceed

---

### Example 3: Text + URL

**Input**: `vLLM could be beneficial as we host open source models: http://docs.vllm.ai/en/latest/`

**Extraction**:
- Topic: `vllm`
- POV: "vLLM could be beneficial for self-hosted open source model deployment"
- Claims: ["vLLM is suitable for self-hosted models"]
- Context: User is evaluating vLLM for their use case
- BIAS: Official docs (authoritative, may omit limitations)
- Confirmation: Present to user → Proceed

---

### Example 4: Text Only (Complex Question)

**Input**: `For multi agent system, have we thought about per conversation memory management? As info passes from agent to agent, there will be context loss. Would cache help?`

**Extraction**:
- Topics detected: `multi-agent systems`, `memory management`, `caching`
- Relationship: Nested (caching FOR memory management IN multi-agent systems)
- Topic: `multi-agent-memory-management-with-caching`
- POV: "Would caching help mitigate context loss as information passes between agents in multi-agent systems?"
- Claims: ["Caching can mitigate context loss in multi-agent systems"]
- BIAS: None (user question)
- Confirmation: Present to user → Proceed

---

### Example 5: Direct Topic with POV Flag

**Input**: `lmcache --pov "I heard it's 15x faster than standard LLM serving"`

**Extraction**:
- Topic: `lmcache`
- POV: "I heard it's 15x faster than standard LLM serving"
- Claims: ["15x faster than standard LLM serving"]
- BIAS: None (user-provided POV)
- Confirmation: Present to user → Proceed

---

## Success Criteria

Extraction is successful when:
- [ ] Input type correctly detected
- [ ] Topic extracted (compound if nested topics)
- [ ] POV captured (if exists)
- [ ] BIAS detected (if applicable)
- [ ] User confirmed extraction before proceeding

---

**Extract Topic from Input Workflow - Parse all input types, capture POV and BIAS, confirm with user.**
