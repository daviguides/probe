# Topic Extraction Specification

**Type**: Normative (SPECS layer)

**Purpose**: Define authoritative rules for extracting research topics from various input types.

---

## 1. Input Types (Normative)

### 1.1 Direct Topic

**Definition**: Single word or short phrase representing technology/concept.

**Patterns**:
- 1-4 words
- No URL
- No question marks
- No complex sentence structure

**Examples**:
- `lmcache`
- `vector databases`
- `prompt engineering`

**Processing**: Use as-is (trim whitespace, lowercase slug)

---

### 1.2 URL Only

**Definition**: HTTP/HTTPS URL without additional text.

**Patterns**:
- Starts with `http://` or `https://`
- No surrounding text (or only whitespace)

**Examples**:
- `https://linkedin.com/posts/...`
- `https://pub.towardsai.net/article`
- `https://docs.vllm.ai/`

**Processing**: WebFetch content, extract topic from content

---

### 1.3 Text Only

**Definition**: Natural language question, statement, or description.

**Patterns**:
- >5 words
- Contains sentence structure (questions, statements)
- No URL
- May contain multiple technology keywords

**Examples**:
- `Would caching help with multi-agent memory management?`
- `For multi agent system, have we thought about context loss?`
- `I need to understand vector databases for RAG applications`

**Processing**: Parse for technology keywords, analyze relationships

---

### 1.4 Text + URL

**Definition**: Natural language text combined with URL.

**Patterns**:
- Contains both text and URL
- Text provides user's context/framing
- URL provides supporting resource

**Examples**:
- `vLLM could be beneficial: https://docs.vllm.ai/`
- `We need guardrails for long responses: [article url]`

**Processing**: Parse text for context, WebFetch URL, synthesize (text takes precedence for framing)

---

### 1.5 Direct Topic + POV Flag

**Definition**: Direct topic with explicit POV provided via flag.

**Patterns**:
- `<topic> --pov "<pov text>"`

**Examples**:
- `lmcache --pov "I heard it's 15x faster"`
- `vector-databases --pov "Recommended for RAG by stakeholder"`

**Processing**: Use topic as-is, capture POV separately

---

## 2. Topic Relationships (Normative)

### 2.1 Nested Topics

**Definition**: Multiple topics where one is applied in the context of another.

**Patterns**:
- "X for Y"
- "Y with X"
- "X in Y context"
- "Would X help with Y?"
- "How to achieve Y using X?"

**Examples**:
- "caching for multi-agent systems"
- "memory management with caching"
- "vector databases in RAG context"
- "Would caching help with context loss?"

**Processing**:
- Treat as **unified topic**
- Create compound slug combining all related terms
- Research scope: Intersection of topics

**Slug generation**:
- Order: General → Specific
- Format: `general-concept-specific-application`
- Example: `multi-agent-memory-management-with-caching`

---

### 2.2 Independent Topics

**Definition**: Multiple unrelated or ambiguously related topics.

**Patterns**:
- "X and Y" (no clear relationship)
- Multiple technologies mentioned without connection

**Examples**:
- "langchain and vector databases" (could be related or separate)
- "multi-agent systems and caching" (relationship unclear)

**Processing**:
- **Ask user** to clarify relationship
- Options:
  1. Unified research (explore relationship/integration)
  2. Separate research (sequential, one per topic)
  3. Comparative research (if comparison intended)

**User confirmation required**: YES (always)

---

### 2.3 Comparative Topics

**Definition**: Explicit comparison between two or more technologies.

**Patterns**:
- "X vs Y"
- "X or Y"
- "compare X and Y"
- "X versus Y"

**Examples**:
- "LMCache vs CacheBlend"
- "vLLM or SGLang"
- "compare Redis and Memcached for caching"

**Processing**:
- Treat as **comparative research**
- Research both topics + Spectrum 11 (Comparative Analysis)
- Single research repo

**Slug generation**:
- Format: `topic1-vs-topic2`
- Example: `lmcache-vs-cacheblend`

---

## 3. Topic Slug Rules (Normative)

### 3.1 Slug Format

**Rules**:
1. Lowercase only
2. Words separated by hyphens
3. No special characters (except hyphens)
4. No spaces
5. Descriptive and readable

**Examples**:
- `lmcache`
- `vector-databases`
- `multi-agent-memory-management-with-caching`

### 3.2 Compound Slug Construction

**For nested topics**:
- Combine all related terms
- Order: General concept → Specific application
- Example: `caching` + `multi-agent systems` + `memory management` → `multi-agent-memory-management-with-caching`

**For comparative topics**:
- Format: `topic1-vs-topic2`
- Alphabetical order if no clear precedence
- Example: `lmcache-vs-cacheblend`

### 3.3 Slug Length Limits

**Soft limit**: 80 characters
- If exceeded, suggest user simplify
- Example: "Can we focus on the core relationship?"

**No hard limit**: Accept longer slugs if user confirms

---

## 4. POV (Point of View) Extraction (Normative)

### 4.1 POV Definition

**POV**: Original claim, question, or assertion that prompted the research.

**Sources**:
1. User's explicit question (text input)
2. Post/article claim (URL content)
3. User-provided statement (--pov flag)
4. Combined user context + URL claim (text + URL)

### 4.2 POV Components

**Must include**:
1. **Original text**: Exact reproduction of POV
2. **Claims extracted**: Specific testable assertions
3. **Source**: Where POV came from (user, LinkedIn, article, etc.)

**Example**:
```
POV: "LMCache provides 15x speedup for LLM serving"
Claims:
- Performance: "15x speedup"
- Scope: "For LLM serving"
Source: LinkedIn post
```

### 4.3 POV vs Research Workflow

**CRITICAL**: POV does NOT affect research workflow
- Research follows standard 10 spectra
- Depth based on familiarity + goal (standard calibration)
- POV is analyzed POST-research in POV-ANALYSIS.md

---

## 5. BIAS Detection (Normative)

### 5.1 BIAS Definition

**BIAS**: Systematic tendency of a source to emphasize certain aspects and omit others.

**Applies to**: URL sources only (not user text)

### 5.2 Source Types and Bias Patterns

**LinkedIn post**:
- Bias: Engagement-optimized (positive bias)
- Emphasis: Speed, innovation, impressive metrics
- Omissions: Limitations, deployment complexity, failure modes

**Vendor blog**:
- Bias: Marketing material
- Emphasis: Product benefits, customer success
- Omissions: Drawbacks, competitors, cost

**Academic paper**:
- Bias: Rigorous but theoretical
- Emphasis: Methodology, theoretical foundation
- Omissions: Practical implementation, ease of use

**GitHub repository/issues**:
- Bias: Technical, problem-focused
- Emphasis: Implementation details, bugs, limitations
- Omissions: Success stories, benefits (negative bias)

**Official documentation**:
- Bias: Authoritative but promotional
- Emphasis: Features, getting started
- Omissions: Known limitations, workarounds

**Tech blog/Medium**:
- Bias: Variable (depends on author)
- Emphasis: Experience reports, tutorials
- Omissions: Variable

### 5.3 BIAS vs Research Workflow

**CRITICAL**: BIAS does NOT affect research workflow
- Research follows standard depth calibration
- BIAS is documented and analyzed POST-research in BIAS-ANALYSIS.md

---

## 6. Confirmation Protocol (Normative)

### 6.1 Confirmation Required

**Direct topic** (Type 1.1): NO confirmation
- Example: `lmcache` → Proceed immediately

**All other types** (1.2, 1.3, 1.4, 1.5): YES confirmation required
- Present extracted topic, POV, BIAS to user
- User must approve before proceeding

### 6.2 Confirmation Format

**Minimum information**:
1. Detected topic (slug)
2. POV (if exists)
3. BIAS (if detected)
4. Research scope (unified, separate, comparative)

**User options**:
1. Confirm and proceed
2. Reject and provide correct topic
3. Choose research approach (if independent topics)

### 6.3 Independent Topics - User Choice Required

**When**: Multiple independent topics detected

**Present options**:
1. **Unified research**: Single research exploring integration/relationship
2. **Separate research**: Multiple sequential research sessions
3. **Comparative research**: Side-by-side comparison

**User must choose**: Cannot proceed without user decision

---

## 7. Extraction Output Format (Normative)

### 7.1 Standard Extraction Object

```json
{
  "topic": "topic-slug",
  "research_mode": "standard" | "comparative",
  "pov": {
    "exists": true | false,
    "original_text": "...",
    "claims": ["claim1", "claim2"],
    "source": "user" | "url" | "flag"
  },
  "bias": {
    "exists": true | false,
    "source_type": "linkedin" | "vendor-blog" | "academic" | "github" | "docs" | "tech-blog",
    "characteristics": {
      "emphasis": "...",
      "omissions": "...",
      "reliability": "high" | "medium" | "low"
    },
    "indicators": ["indicator1", "indicator2"]
  },
  "original_input": "raw user input",
  "confirmation": "confirmed" | "pending"
}
```

### 7.2 Usage in Downstream Workflows

**conduct-research-workflow.md**:
- Receives extraction object
- Uses `topic` for research scope
- Ignores `pov` and `bias` during research (standard 10 spectra)
- Uses `pov` and `bias` POST-research for analysis files

**setup-research-environment-workflow.md**:
- Uses `topic` for directory/repo naming

---

## 8. Edge Cases (Normative)

### 8.1 Ambiguous Input

**Example**: `lmcache.ai` (URL or topic name?)

**Rule**: If contains `.` + valid TLD → Treat as URL (attempt WebFetch)
- If WebFetch fails → Ask user if it's a topic name

### 8.2 Paywalled/Inaccessible URL

**Rule**: If WebFetch fails (paywall, 404, etc.):
1. Return error to user
2. Ask user to either:
   - Provide topic manually
   - Paste content for analysis

### 8.3 Too Many Topics (>3)

**Example**: "multi-agent systems, caching, memory management, vector databases, langchain"

**Rule**: Ask user to narrow scope
- "Detected 5 topics. Can you focus on 2-3 core topics?"

### 8.4 No Clear Topic

**Example**: Generic text without technology keywords

**Rule**: Ask user for clarification
- "Could not detect specific technology/concept. What should we research?"

---

## 9. Validation Rules (Normative)

### 9.1 Valid Topic

**Requirements**:
- [ ] Not empty string
- [ ] Contains at least one alphanumeric character
- [ ] Slug is valid (lowercase, hyphens only)
- [ ] Represents identifiable technology/concept

### 9.2 Valid POV

**Requirements** (if POV exists):
- [ ] Original text captured
- [ ] At least one claim extracted
- [ ] Source identified

### 9.3 Valid BIAS

**Requirements** (if BIAS exists):
- [ ] Source type classified
- [ ] Characteristics documented (emphasis, omissions)
- [ ] Reliability level assigned

### 9.4 Valid Extraction

**Requirements**:
- [ ] Valid topic
- [ ] POV valid (if exists)
- [ ] BIAS valid (if exists)
- [ ] User confirmation obtained (if required)

---

## 10. Examples (Normative Reference)

### Example 1: Direct Topic
**Input**: `lmcache`
- Type: 1.1 (Direct topic)
- Topic: `lmcache`
- POV: None
- BIAS: None
- Confirmation: Not required

### Example 2: URL Only (LinkedIn)
**Input**: `https://linkedin.com/posts/...lmcache...`
- Type: 1.2 (URL only)
- Topic: `lmcache` (extracted from content)
- POV: "LMCache provides 15x speedup" (extracted from post)
- BIAS: LinkedIn post (engagement-optimized)
- Confirmation: Required

### Example 3: Text Only (Nested Topics)
**Input**: `Would caching help with multi-agent memory management?`
- Type: 1.3 (Text only)
- Topic: `multi-agent-memory-management-with-caching` (nested)
- POV: "Would caching help mitigate context loss in multi-agent systems?"
- BIAS: None
- Confirmation: Required

### Example 4: Text + URL
**Input**: `vLLM could be beneficial: https://docs.vllm.ai/`
- Type: 1.4 (Text + URL)
- Topic: `vllm`
- POV: "vLLM could be beneficial for self-hosted models" (user framing)
- BIAS: Official docs (authoritative, may omit limitations)
- Confirmation: Required

### Example 5: Comparative
**Input**: `lmcache vs cacheblend`
- Type: Comparative (2.3)
- Topic: `lmcache-vs-cacheblend`
- Research mode: Comparative (Spectrum 11 added)
- POV: None (unless user adds context)
- BIAS: None
- Confirmation: Required

### Example 6: Independent Topics
**Input**: `langchain and vector databases`
- Type: Independent topics (2.2)
- Topics detected: `langchain`, `vector-databases`
- User choice: Unified | Separate | Comparative
- Confirmation: Required (with choice selection)

---

**Topic Extraction Specification - Normative rules for parsing all input types and extracting research scope.**
