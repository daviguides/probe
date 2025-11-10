# Source Bias Guide

**Type**: Applied Knowledge (CONTEXT layer)

**Purpose**: Practical guide for recognizing and counter-balancing source bias in research.

---

## Overview

Every source has bias - systematic tendencies to emphasize certain aspects and omit others. This guide helps identify bias patterns and counter-balance them during analysis.

**Important**: Bias is documented and analyzed POST-research. It does NOT affect research methodology or depth during investigation.

---

## 1. Source Type Taxonomy

### 1.1 LinkedIn Posts

**Characteristics**:
- Platform optimized for engagement (likes, shares, comments)
- Authors incentivized to create "viral" content
- Positive bias (negative posts get less engagement)
- Often promotional (personal brand, company marketing)

**Typical Emphasis**:
- 🔥 Impressive metrics ("15x faster", "100x improvement")
- 🚀 Innovation narratives ("revolutionary", "game-changing")
- ✨ Success stories (only best-case scenarios)
- 💡 "Hot take" opinions (contrarian for engagement)

**Typical Omissions**:
- ❌ Limitations and drawbacks
- ❌ Deployment complexity
- ❌ Prerequisites and requirements
- ❌ When NOT to use
- ❌ Failure modes and edge cases
- ❌ Realistic worst-case or average-case performance

**Reliability**:
- **Quantitative claims**: Low (verify independently)
- **Qualitative assessments**: Very low (often hyperbole)
- **Technical accuracy**: Medium (usually factually correct but selective)

**Red Flags**:
- Superlatives without qualification ("best", "fastest", "only")
- Unqualified performance claims ("15x faster" without conditions)
- No negative aspects mentioned
- "Everyone should use this" (no nuance)
- Emotional language ("blown away", "mind-blowing")

**Counter-Balancing Strategy**:
1. Verify ALL quantitative claims independently
2. Actively search for limitations (GitHub issues, Stack Overflow)
3. Look for "when NOT to use" discussions elsewhere
4. Find worst-case and average-case performance data
5. Check if prerequisites/complexity mentioned elsewhere

**Example**:

| LinkedIn Claim | What to Investigate |
|----------------|---------------------|
| "15x faster" | Faster than what? Under what conditions? What about worst-case? |
| "Revolutionary" | What's actually novel? How does it compare to existing solutions? |
| "Solves X problem" | What problems does it NOT solve? What new problems does it create? |

---

### 1.2 Vendor Blogs

**Characteristics**:
- Created by product/service companies
- Marketing objectives (drive adoption, sales, brand awareness)
- More balanced than LinkedIn (company credibility at stake)
- Factually accurate but selectively presented

**Typical Emphasis**:
- ✅ Product benefits and features
- 📊 Customer success stories
- 🏆 Competitive advantages
- 🎯 Use cases where product excels
- 📈 Best-case benchmarks

**Typical Omissions**:
- ❌ Product limitations and known issues
- ❌ Competitor strengths
- ❌ Total cost of ownership
- ❌ Migration challenges from existing solutions
- ❌ When competitors might be better fit
- ❌ Realistic learning curve

**Reliability**:
- **Technical features**: High (usually accurate)
- **Performance claims**: Medium (cherry-picked but not false)
- **Comparisons**: Low (biased toward own product)
- **Cost**: Low (highlights savings, hides total cost)

**Red Flags**:
- Only positive customer testimonials
- Benchmarks only against weak competitors
- "Up to X% improvement" (best-case only)
- Feature comparisons missing competitor strengths
- No discussion of trade-offs

**Counter-Balancing Strategy**:
1. Verify benchmarks with independent sources
2. Read competitor documentation for alternative perspective
3. Search for migration difficulty reports (Reddit, HN, Stack Overflow)
4. Calculate realistic total cost (not just advertised pricing)
5. Find users who switched away (why did they leave?)

**Example**:

| Vendor Blog Claim | What to Investigate |
|-------------------|---------------------|
| "50% cost reduction" | Compared to what? Does it include migration costs? Hidden costs? |
| "Easier than X" | Is X a strawman? What about equally easy alternatives? |
| "Works with all..." | Are there exceptions? Edge cases? Unsupported scenarios? |

---

### 1.3 Academic Papers

**Characteristics**:
- Peer-reviewed research (rigorous methodology)
- Incentivized to demonstrate novel contribution
- Theoretical focus (practical deployment secondary)
- Often evaluated in idealized conditions

**Typical Emphasis**:
- 📐 Methodology and theoretical foundation
- 🔬 Novel algorithms or techniques
- 📊 Controlled benchmark results
- 📚 Comparison to baseline/state-of-the-art
- 🧮 Mathematical proofs

**Typical Omissions**:
- ❌ Practical implementation challenges
- ❌ Ease of use and developer experience
- ❌ Production deployment considerations
- ❌ Real-world messy data performance
- ❌ Engineering effort required
- ❌ Maintenance and operational complexity

**Reliability**:
- **Methodology**: Very high (peer-reviewed)
- **Benchmark results**: High (but often idealized conditions)
- **Practical applicability**: Low (not primary focus)
- **Ease of use**: Very low (rarely discussed)

**Red Flags**:
- Benchmarks only on curated datasets
- No discussion of computational cost in production
- Missing comparison to simple baselines
- "Future work" includes most practical aspects
- No code/implementation provided

**Counter-Balancing Strategy**:
1. Test on messy real-world data (not curated benchmarks)
2. Estimate engineering effort to implement
3. Compare to simple baselines (not just state-of-the-art)
4. Look for practitioners' implementation reports
5. Check if approach is used in production anywhere

**Example**:

| Academic Paper Claim | What to Investigate |
|----------------------|---------------------|
| "Achieves X accuracy" | On what dataset? How does it perform on noisy real-world data? |
| "Novel technique" | How much better than simple baseline? Worth complexity? |
| "Outperforms Y" | What about computational cost? Ease of implementation? |

---

### 1.4 GitHub Repositories/Issues

**Characteristics**:
- Developer-to-developer communication
- Problem-solving focus
- Technical accuracy valued
- Possible negative bias (issues emphasize problems)

**Typical Emphasis**:
- 🐛 Bugs and issues
- 🔧 Implementation details
- ⚠️ Edge cases and limitations
- 💬 Technical discussions
- 🛠️ Workarounds and fixes

**Typical Omissions**:
- ❌ Success stories (working code isn't discussed)
- ❌ Benefits and advantages
- ❌ "Happy path" scenarios
- ❌ Strategic context (why tool exists)
- ❌ High-level overviews

**Reliability**:
- **Technical accuracy**: Very high
- **Limitation identification**: Very high
- **Overall assessment**: Low (skewed negative)
- **Feature completeness**: Medium (focused on problems)

**Red Flags**:
- Too many open issues with no responses
- Maintainers dismissive of user problems
- Bugs marked "won't fix" for critical functionality
- Long-standing issues with workarounds only

**Counter-Balancing Strategy**:
1. Balance issues with actual usage (are people using it successfully?)
2. Check issue close rate (are problems being fixed?)
3. Look for positive indicators (stars, forks, active development)
4. Find production usage examples (companies using it)
5. Assess if issues are edge cases or core functionality

**Example**:

| GitHub Issue | Balanced Assessment |
|--------------|---------------------|
| "Memory leak in X scenario" | How common is scenario? Is there workaround? Is fix planned? |
| 50 open issues | Out of how many total? What's close rate? Are they edge cases? |
| "Won't fix" label | Is it truly won't fix or accepted limitation? Alternatives? |

---

### 1.5 Official Documentation

**Characteristics**:
- Created by project maintainers
- Goal: Enable successful usage
- Authoritative (factually correct)
- Often promotional (showcase features)

**Typical Emphasis**:
- 📚 Features and capabilities
- 🚀 Getting started guides
- ✅ Supported use cases
- 📖 API reference
- 🎯 Best practices

**Typical Omissions**:
- ❌ Known limitations (unless severe)
- ❌ Workarounds for common issues
- ❌ Performance characteristics (unless excellent)
- ❌ When NOT to use
- ❌ Comparison to alternatives
- ❌ "Sharp edges" (gotchas)

**Reliability**:
- **Feature accuracy**: Very high
- **API correctness**: Very high
- **Limitations**: Medium (present but understated)
- **Performance**: Medium (best-case scenarios)

**Red Flags**:
- No "Limitations" or "Known Issues" section
- Only "hello world" examples (no complex scenarios)
- Missing performance characteristics
- No migration guides (lock-in?)
- Underdocumented configuration options

**Counter-Balancing Strategy**:
1. Read "Advanced" and "Troubleshooting" sections carefully
2. Check GitHub issues for what docs omit
3. Look for "Limitations" in changelogs/release notes
4. Search Stack Overflow for common problems
5. Find practitioner blog posts about "gotchas"

**Example**:

| Docs Section | What to Look For Elsewhere |
|--------------|----------------------------|
| "Quick Start" | What's hidden complexity after hello world? |
| "Features" | What features are missing? What's on roadmap (not ready)? |
| "Performance" | What about worst-case? Common-case? |

---

### 1.6 Tech Blogs / Medium Articles

**Characteristics**:
- Individual practitioner experience
- Variable quality (not peer-reviewed, not official)
- Honest but limited perspective
- Possible sponsor/affiliate bias

**Typical Emphasis**:
- 👤 Personal experience ("I tried X")
- 📝 Tutorials and guides
- 💭 Opinions and hot takes
- 🎓 Learning journey
- 🔍 Specific use case

**Typical Omissions**:
- ❌ Broader context (other use cases)
- ❌ Alternative approaches
- ❌ Long-term maintenance experience
- ❌ Scale considerations
- ❌ Counter-arguments

**Reliability**:
- **Personal experience**: High (usually truthful)
- **General applicability**: Medium (one person's experience)
- **Technical accuracy**: Variable (depends on author)
- **Completeness**: Low (narrow perspective)

**Red Flags**:
- Sponsored content (undisclosed)
- Affiliate links without disclosure
- Only positive experiences (no challenges mentioned)
- Overgeneralization from single use case
- "This is the only way" (no alternatives)

**Counter-Balancing Strategy**:
1. Read multiple practitioner accounts
2. Check author's background (expertise level)
3. Look for disclosed limitations in article
4. Verify technical claims independently
5. Consider if use case matches yours

**Example**:

| Blog Claim | Balanced Assessment |
|------------|---------------------|
| "X is perfect for Y" | Perfect for author's Y, or Y in general? Other contexts? |
| "I solved Z with X" | Are there simpler solutions? Trade-offs? |
| "Best practice" | According to whom? Context-dependent? |

---

## 2. Bias Detection Techniques

### 2.1 Language Analysis

**High-bias indicators**:
- Superlatives: "best", "fastest", "only", "revolutionary"
- Absolutes: "always", "never", "all", "none"
- Emotional: "amazing", "incredible", "blown away"
- Vague: "significantly", "much", "way" (without numbers)
- Certainty: "obviously", "clearly", "undoubtedly"

**Low-bias indicators**:
- Qualified: "in certain scenarios", "for this use case"
- Specific: "15% faster for X workload compared to Y baseline"
- Balanced: "trades X for Y", "better at A, worse at B"
- Uncertain: "may", "might", "in our tests"
- Conditional: "if", "when", "depends on"

### 2.2 Content Analysis

**Check for**:
- [ ] Limitations section present?
- [ ] "When NOT to use" discussed?
- [ ] Trade-offs explicitly stated?
- [ ] Worst-case or average-case discussed (not just best-case)?
- [ ] Prerequisites and complexity mentioned?
- [ ] Comparison includes competitor strengths?
- [ ] Costs (all types) disclosed?

**Red flags** if missing:
- No negative aspects mentioned at all
- Only best-case scenarios
- Competitors only shown in unfavorable light
- Prerequisites hidden or minimized

### 2.3 Data Analysis

**Benchmark bias indicators**:
- Only favorable comparisons shown
- Baseline is weak/outdated
- Metrics cherry-picked (latency shown, throughput hidden)
- Test conditions idealized (not realistic)
- Sample size not disclosed
- Variance/error bars missing

**Balanced benchmarks**:
- Multiple metrics shown (even unfavorable ones)
- Comparisons to strong, recent alternatives
- Realistic conditions stated
- Worst-case and average-case included
- Variance and confidence intervals provided

---

## 3. Counter-Balancing Strategies

### 3.1 For Engagement-Optimized Sources (LinkedIn)

**Research priorities**:
1. ⚠️ **Verify metrics**: Independently confirm all quantitative claims
2. 🔍 **Find limitations**: Actively search GitHub, Stack Overflow, Reddit
3. 📊 **Realistic performance**: Look for average-case and worst-case data
4. ❌ **When NOT to use**: Find contraindications elsewhere
5. 💰 **Total cost**: Calculate beyond advertised numbers

**Emphasize in BIAS-ANALYSIS.md**:
- What metrics claim vs reality (with conditions)
- Limitations source omitted
- Prerequisites not mentioned
- Realistic performance expectations

---

### 3.2 For Marketing Material (Vendor Blogs)

**Research priorities**:
1. 🏆 **Competitor strengths**: Read competitor docs for other perspective
2. 💸 **True costs**: Migration + operational + hidden costs
3. ⚠️ **Known issues**: Check issue trackers, forums
4. 🔄 **Migration difficulty**: Search for user reports
5. 🚪 **Exit strategy**: Can you switch away easily?

**Emphasize in BIAS-ANALYSIS.md**:
- Competitor advantages not mentioned
- True total cost of ownership
- Migration and learning curve reality
- Trade-offs of choosing this product

---

### 3.3 For Academic Papers

**Research priorities**:
1. 🛠️ **Implementation effort**: How hard is it to actually build?
2. 📊 **Real-world data**: Performance on messy, not curated data
3. 🎯 **Simple baselines**: Compare to simple solutions, not just SOTA
4. 🏭 **Production usage**: Anyone using this in real systems?
5. 💡 **Practical value**: Worth the complexity?

**Emphasize in BIAS-ANALYSIS.md**:
- Practical implementation challenges
- Performance on real vs curated data
- Comparison to simpler approaches
- Engineering effort required

---

## 4. Bias Indicators Checklist

Use this checklist when analyzing sources:

### Content Completeness
- [ ] Benefits discussed?
- [ ] Limitations discussed equally?
- [ ] "When to use" present?
- [ ] "When NOT to use" present?
- [ ] Prerequisites disclosed?
- [ ] Costs (all types) disclosed?
- [ ] Trade-offs explicit?

### Language Balance
- [ ] Qualified claims (not absolute)?
- [ ] Specific metrics (not vague)?
- [ ] Neutral tone (not emotional)?
- [ ] Conditional statements (not universal)?
- [ ] Acknowledges uncertainty where appropriate?

### Data Integrity
- [ ] Multiple metrics shown?
- [ ] Realistic test conditions?
- [ ] Worst-case or average-case included?
- [ ] Comparison to strong alternatives?
- [ ] Variance/confidence intervals?
- [ ] Sample size disclosed?

### Perspective Breadth
- [ ] Multiple use cases considered?
- [ ] Alternatives acknowledged?
- [ ] Different contexts discussed?
- [ ] Failure modes mentioned?
- [ ] Counter-arguments addressed?

**Bias Score**:
- 15+ checked: Low bias (trustworthy)
- 10-14 checked: Medium bias (verify claims)
- <10 checked: High bias (approach skeptically)

---

## 5. Practical Application

### 5.1 During Extraction (Stage 0)

**Identify source type**:
1. Check URL domain and path
2. Classify into taxonomy (LinkedIn, vendor, academic, etc.)
3. Note typical bias patterns for that type
4. Document in extraction object

**Do NOT**:
- ❌ Adjust research depth based on bias
- ❌ Skip research areas due to bias
- ❌ Let bias influence methodology

**Do**:
- ✅ Document bias characteristics
- ✅ Note what to verify independently
- ✅ Flag for post-research analysis

---

### 5.2 During Research (Stages 1-3)

**Ignore bias**:
- Conduct standard 10-spectrum research
- Use familiarity + goal for depth calibration
- Do NOT let source bias affect investigation

**Research independently**:
- Verify source claims from multiple independent sources
- Seek contradictory evidence actively
- Find what source omitted

---

### 5.3 Post-Research Analysis (Stage 4)

**Generate BIAS-ANALYSIS.md**:
1. Reference bias characteristics from extraction
2. List specific bias indicators from source
3. Show what research found that source omitted
4. Provide counter-balanced perspective
5. State what to trust vs verify vs ignore

**Format**: See pov-bias-analysis-spec.md for structure

---

## 6. Examples

### Example 1: LinkedIn Post About LMCache

**Bias detected**: Engagement-optimized (high positive bias)

**Source emphasized**:
- "15x faster" (no conditions)
- "Revolutionary" (hyperbole)
- Only chatbot benchmark (best-case)

**Source omitted**:
- API incompatibility (vLLM required)
- Storage overhead (1GB per 1M tokens)
- Performance for low reuse (2-3x, not 15x)
- When NOT to use (API users, single-shot queries)

**Counter-balance**:
- Verify 15x claim: True for >70% context reuse, false otherwise
- Find limitations: API incompatibility, storage cost
- Realistic applicability: Good for chatbots, bad for API users

---

### Example 2: Vendor Blog About Product X

**Bias detected**: Marketing material (selective presentation)

**Source emphasized**:
- 50% cost reduction (vs specific competitor)
- Easy migration (happy path only)
- Customer success story (best case)

**Source omitted**:
- Migration challenges (downtime, data loss risks)
- Hidden costs (support contracts, training)
- Competitor Y's advantages (ignored)
- Learning curve for advanced features

**Counter-balance**:
- Calculate true TCO (migration + operational + support)
- Read competitor Y docs for alternative view
- Search Reddit/HN for migration difficulty reports
- Estimate realistic learning curve

---

### Example 3: Academic Paper About Algorithm Z

**Bias detected**: Rigorous but theoretical (practical applicability low)

**Source emphasized**:
- Novel theoretical contribution
- 20% accuracy improvement (curated dataset)
- Complexity analysis (big-O notation)

**Source omitted**:
- Performance on messy real-world data
- Implementation effort (300 lines → 3000 lines)
- Comparison to simple baseline (only vs SOTA)
- Production deployment considerations (none)

**Counter-balance**:
- Test on real messy data (accuracy drops to 5% improvement)
- Estimate engineering effort (weeks of work)
- Compare to simple baseline (2% worse, 10x simpler)
- Assess practical value (not worth complexity for 5% gain)

---

**Source Bias Guide - Recognize and counter-balance bias in research sources.**
