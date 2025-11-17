# AVA Phase 2 Multi-Agent Architecture: Agno v2 Hybrid Orchestration

**Research Date**: January 2025 (Updated November 2024)
**Context**: AVA Multi-Agent System (AccelVeo)
**Framework**: Agno v2 (v2.0.0, Sep 2024)
**Architecture**: 10-Agent System with Hybrid Orchestration (Teams + Workflows)
**Status**: ✅ Updated with Agno v2 Teams + Workflows

---

## Executive Summary

This document presents the **Phase 2 architecture for AVA (AccelVeo Virtual Advisor)** using **Agno v2 hybrid orchestration** (Teams + Workflows) to coordinate 10 specialized agents across manufacturing operations.

**Key Architecture Decisions:**
- **10-Agent System**: 1 orchestrator (AVA) + 9 specialist agents
- **Hybrid Orchestration**: Teams (dynamic queries) + Workflows (production-critical operations)
- **Agno v2 Team Patterns**: Router, Selective Delegation, and Collaborative patterns
- **Agno v2 Workflows (NEW)**: 4 production workflows (PdM, Compliance, RCA, SOP)
- **Data Flow**: Query → Classification → **Hybrid Routing** → Execution → Response
- **Coordination**: Hierarchical routing with parallel execution (`arun()`) and conflict resolution
- **Latency**: ~1-5s (varies by complexity and workflow type, within 3-5s P95 SLO)

**Economics (Updated with Workflows):**
- Agno v2 **hybrid architecture** saves **95-112h** Phase 2 work (vs manual orchestration)
- **Teams** (original): 35-65h savings (coordination, observability, memory)
- **Workflows (NEW)**: Additional **37-47h savings** (audit trails, state management, orchestration)
- Built-in Langfuse observability (0h setup vs 15-23h manual)
- PostgreSQL UserMemory integration ready (0h vs 10-15h custom)
- Workflow state caching (`session_state`): 300-500ms latency savings per cached operation

**Workflow Business Value:**
- **PdM Workflow**: Prevent unplanned downtime ($50k-200k per event); ML inference caching
- **Compliance Workflow**: ISO 19011 audit trails (avoid $10k-100k fines); legally defensible
- **RCA Workflow**: Systematic failure investigation (40-60% recurrence reduction); knowledge accumulation
- **SOP Workflow**: Safe procedure generation; validation gates prevent unsafe operations

**⚠️ Important Notes:**

1. **Agno v2 Dual Orchestration Paradigm:**
   - **Teams** (released with v2.0.0): Dynamic, LLM-driven coordination for exploratory queries
   - **Workflows** (released with v2.0.0): Deterministic, programmatic control for production-critical operations
   - Use **both** in AVA for optimal flexibility + reliability

2. **Deprecated API from Agno v1:**
   - Old `mode=` parameter removed (`route`, `coordinate`, `collaborate`)
   - Replaced by delegation control: `respond_directly`, `determine_input_for_members`, `delegate_task_to_all_members`
   - `arun()` for parallel execution vs `run()` for sequential

3. **Workflow Constructs:**
   - `Step`: Execute agent, team, or Python function
   - `Parallel`: Concurrent execution of multiple steps
   - `Router`: Conditional branching
   - `Condition`: Make steps conditional
   - `Loop`: Repeat steps until condition met

---

## 1. Architecture Overview

### 1.1 Full System Architecture

```mermaid
graph TB
    User[👤 User Query<br/>Line 3 downtime increased.<br/>Root cause?]

    User --> AVA[🎯 AVA Orchestrator<br/>Agent<br/><br/>• Intent classification<br/>• Agent routing<br/>• Conflict resolution<br/>• Response synthesis]

    AVA --> Planner[📋 Planner Agent<br/><br/>• Query decompose<br/>• Task breakdown<br/>• Dependency map]

    AVA --> Reasoner[🧠 Reasoner Agent<br/><br/>• Logical validation<br/>• Consistency check<br/>• Inference rules]

    Planner --> SpecTeam[⚡ Specialist Agent Team<br/>Agno Delegation: Selective<br/>Parallel execution arun + synthesis]
    Reasoner --> SpecTeam

    SpecTeam --> Maint[🔧 Maintenance<br/>Agent<br/><br/>• PdM<br/>• RCA<br/>• CMMS]
    SpecTeam --> Comp[📜 Compliance<br/>Agent<br/><br/>• Privacy<br/>• Audit<br/>• GDPR]
    SpecTeam --> Data[📊 Data Agent<br/><br/>• Metrics<br/>• Anomaly<br/>• Trends]
    SpecTeam --> SOP[📝 SOP<br/>Generator<br/><br/>• Procedures<br/>• Checklists<br/>• Templates]

    Maint --> Agg[🔄 Aggregator Agent<br/>Delegation: Collaborative<br/><br/>• Consolidate outputs<br/>• Resolve conflicts<br/>• Priority: safety > cost > time]
    Comp --> Agg
    Data --> Agg
    SOP --> Agg

    Agg --> Context[💾 Context Manager<br/>Agent<br/><br/>• Session tracking<br/>• User preferences<br/>• Historical context]

    Context --> Eval[✅ Evaluator Agent<br/><br/>• Quality check<br/>• Fact verification<br/>• Compliance validation<br/>• Feedback loop]

    Eval --> AVA

    AVA --> Response[📤 Final Response<br/><br/>Root cause: Press 07<br/>vibration drift.<br/>Maintenance: 2025-11-12<br/>Downtime: 4h, OEE: +7%]

    subgraph orchestration [Orchestration Layer]
        AVA
        Planner
        Reasoner
    end

    subgraph specialists [Specialist Layer - Parallel Execution]
        SpecTeam
        Maint
        Comp
        Data
        SOP
    end

    subgraph synthesis [Synthesis Layer - Concurrent Processing]
        Agg
        Context
        Eval
    end

    style AVA fill:#ff6b6b,stroke:#333,stroke-width:3px,color:#fff
    style SpecTeam fill:#4ecdc4,stroke:#333,stroke-width:2px,color:#000
    style Agg fill:#ffe66d,stroke:#333,stroke-width:2px,color:#000
    style Response fill:#95e1d3,stroke:#333,stroke-width:2px,color:#000
    style orchestration fill:#fff,stroke:#ff6b6b,stroke-width:2px,stroke-dasharray: 5 5
    style specialists fill:#fff,stroke:#4ecdc4,stroke-width:2px,stroke-dasharray: 5 5
    style synthesis fill:#fff,stroke:#ffe66d,stroke-width:2px,stroke-dasharray: 5 5
```

### 1.2 ASCII Architecture Diagram (Backup)

```
┌─────────────────────────────────────────────────────────────────────┐
│                         USER QUERY                                   │
│              "Line 3 downtime increased. Root cause?"                │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    AVA ORCHESTRATOR AGENT                            │
│  • Intent classification                                             │
│  • Agent routing (Team delegation pattern)                          │
│  • Conflict resolution                                               │
│  • Response synthesis                                                │
└────────────┬───────────────────────────┬────────────────────────────┘
             │                           │
             ▼                           ▼
┌─────────────────────┐     ┌─────────────────────────┐
│   PLANNER AGENT     │     │   REASONER AGENT        │
│                     │     │                         │
│ • Query decompose   │     │ • Logical validation    │
│ • Task breakdown    │     │ • Consistency check     │
│ • Dependency map    │     │ • Inference rules       │
└─────────┬───────────┘     └────────────┬────────────┘
          │                              │
          └──────────────┬───────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────────┐
│              SPECIALIST AGENT TEAM                                   │
│              Agno Delegation Pattern: Selective                      │
│              (Parallel execution via arun() + synthesis)            │
│                                                                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌─────────┐│
│  │ MAINTENANCE  │  │ COMPLIANCE   │  │  DATA AGENT  │  │   SOP   ││
│  │   AGENT      │  │   AGENT      │  │              │  │ GENERATOR││
│  │              │  │              │  │              │  │         ││
│  │ • PdM        │  │ • Privacy    │  │ • Metrics    │  │ • Procs ││
│  │ • RCA        │  │ • Audit      │  │ • Anomaly    │  │ • Checks││
│  │ • CMMS       │  │ • GDPR       │  │ • Trends     │  │ • Temps ││
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  └────┬────┘│
│         │                 │                 │                │     │
│         └─────────────────┴─────────────────┴────────────────┘     │
└───────────────────────────┼─────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    AGGREGATOR AGENT                                  │
│  Agno Delegation: Collaborative (delegate_task_to_all_members)     │
│  • Consolidate specialist outputs                                   │
│  • Resolve conflicts (priority: safety > cost > time)               │
│  • Generate unified response                                         │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                 CONTEXT MANAGER AGENT                                │
│  • Session tracking                                                  │
│  • User preferences                                                  │
│  • Historical context                                                │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    EVALUATOR AGENT                                   │
│  • Response quality check                                            │
│  • Fact verification                                                 │
│  • Compliance validation                                             │
│  • Feedback to AVA for iteration (if needed)                        │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                      FINAL RESPONSE                                  │
│   "Root cause: Press 07 vibration drift.                            │
│    Maintenance scheduled 2025-11-12 02:00.                          │
│    Expected downtime: 4h. OEE recovery: +7%"                        │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 2. Agno v2 Team Delegation Patterns

### 2.1 Three Coordination Patterns

Agno v2 replaces the deprecated `mode=` parameter with **delegation control parameters**. Here are the three patterns that map to common orchestration needs:

#### **Pattern 1: Router** (Single delegation without synthesis)

- **Use Case**: Route to ONE most appropriate specialist, return their response directly
- **Agno v2 Parameters**:
  - `respond_directly=True` (bypass leader synthesis)
  - `determine_input_for_members=False` (pass original query unchanged)
- **AVA Usage**: Simple queries requiring single domain expertise

```python
from agno.team import Team

# Router pattern: AVA routes to single best specialist
routing_team = Team(
    name="AVA_Router",
    members=[
        maintenance_agent,
        compliance_agent,
        data_agent,
        sop_generator_agent
    ],
    instructions=[
        "Analyze the query intent",
        "Select the most appropriate specialist based on their role",
        "Delegate to that specialist"
    ],
    respond_directly=True,  # Return specialist output directly
    determine_input_for_members=False  # Pass original query unchanged
)

# Example query: "What's the current OEE for Line 3?"
response = routing_team.run(query)
```

**Flow:**
```
User Query → Team Leader → [Route decision] → Single Specialist → Direct Response
```

**Latency:** ~1-2s (minimal overhead, no synthesis)

**When to use:**
- Simple single-domain queries
- User needs specialist output verbatim
- Minimal leader processing desired

---

#### **Pattern 2: Selective Delegation** (Multi delegation + synthesis)

- **Use Case**: Leader delegates to MULTIPLE specialists dynamically, synthesizes results
- **Agno v2 Parameters**:
  - **Default behavior** (no special params needed)
  - Leader uses LLM + `delegate_task_to_members` tool to choose specialists
  - Use `arun()` for parallel execution when leader delegates to multiple
- **AVA Usage**: Complex queries requiring multiple specialist inputs

```python
# Selective delegation: Planner delegates to relevant specialists
specialist_team = Team(
    name="SpecialistTeam",
    members=[
        maintenance_agent,
        compliance_agent,
        data_agent,
        sop_generator_agent
    ],
    instructions=[
        "Analyze the query and identify required expertise areas",
        "Delegate to relevant specialists (you may choose multiple)",
        "Synthesize their outputs into a coherent, unified response"
    ]
    # No special parameters - default leader delegation behavior
)

# Example: Complex multi-domain query
# Use arun() for parallel execution when leader delegates to multiple agents
response = await specialist_team.arun(
    "Line 3 downtime increased. Find root cause, compliance risk, and generate SOP."
)
```

**Flow:**
```
Planner Leader → [Analyzes query]
              → [Delegates to N specialists in parallel via arun()]
                  ├─ Maintenance Agent
                  ├─ Compliance Agent
                  ├─ Data Agent
                  └─ SOP Generator
              → [Synthesizes outputs] → Response
```

**Latency:** ~2-3s (parallel execution via `arun()` + synthesis)

**Key Points:**
- **Leader decides** which specialists to involve (dynamic selection)
- **Parallel execution**: When leader delegates to multiple, `arun()` runs them concurrently
- **Auto-synthesis**: Leader automatically synthesizes member outputs
- **Sequential fallback**: Use `run()` instead of `arun()` for sequential execution

---

#### **Pattern 3: Collaborative** (All execute + synthesis)

- **Use Case**: ALL members execute concurrently, leader synthesizes collective outputs
- **Agno v2 Parameters**:
  - `delegate_task_to_all_members=True` (force delegation to all)
  - Use `arun()` to ensure parallel execution
- **AVA Usage**: Aggregation, conflict resolution, quality checks

```python
# Collaborative pattern: All agents execute concurrently
synthesis_team = Team(
    name="SynthesisTeam",
    members=[
        aggregator_agent,
        context_manager_agent,
        evaluator_agent
    ],
    instructions=[
        "All members process the specialist outputs concurrently",
        "Aggregator consolidates results",
        "Context Manager enriches with session data",
        "Evaluator validates quality and compliance",
        "Synthesize collective insights into final response"
    ],
    delegate_task_to_all_members=True  # Force all members to execute
)

# Specialist outputs → concurrent synthesis
response = await synthesis_team.arun(specialist_outputs)
```

**Flow:**
```
Specialist Outputs → Team Leader
                   → [Concurrent delegation to ALL members via arun()]
                       ├─ Aggregator (consolidate)
                       ├─ Context Manager (enrich)
                       └─ Evaluator (validate)
                   → [Synthesizes collective outputs] → Final Response
```

**Latency:** ~300-500ms (concurrent processing via `arun()`)

**When to use:**
- All perspectives needed (aggregation, validation, enrichment)
- Concurrent processing for speed
- Collective intelligence for synthesis

---

### 2.2 Async vs Sync Execution

**Critical distinction in Agno v2:**

| Method | Behavior | When Leader Delegates to Multiple |
|--------|----------|----------------------------------|
| `arun()` | **Async** | Members execute **in parallel** (concurrent) |
| `run()` | **Sync** | Members execute **sequentially** (one at a time) |

**Example:**
```python
# Parallel execution (faster)
response = await specialist_team.arun(query)  # If leader picks 3 agents, they run concurrently

# Sequential execution (slower, but deterministic)
response = specialist_team.run(query)  # If leader picks 3 agents, they run one by one
```

**Performance Impact:**
- **Sequential**: 1.5s × 3 agents = **4.5s total**
- **Parallel**: max(1.5s, 1.3s, 1.4s) = **1.5s total** (~67% faster)

---

### 2.3 Delegation Control Parameters

Agno v2 provides fine-grained control over delegation behavior:

| Parameter | Type | Default | Effect |
|-----------|------|---------|--------|
| `respond_directly` | bool | False | If True, return member outputs directly (skip leader synthesis) |
| `determine_input_for_members` | bool | True | If False, pass original user input to members (leader doesn't reformulate) |
| `delegate_task_to_all_members` | bool | False | If True, force delegation to ALL members (collaborative pattern) |
| `show_members_responses` | bool | False | If True, show intermediate member responses in output |

**Common Combinations:**

| Pattern | `respond_directly` | `determine_input_for_members` | `delegate_task_to_all_members` |
|---------|-------------------|------------------------------|-------------------------------|
| **Router** | True | False | False |
| **Selective Delegation** | False (default) | True (default) | False (default) |
| **Collaborative** | False | True | **True** |

---

### 2.4 Workflows: Deterministic Orchestration

**NEW in Agno v2.0.0 (Sep 2024)**: In addition to Teams (dynamic coordination), Agno v2 introduced **Workflows** for deterministic, sequential orchestration.

#### What are Workflows?

Workflows provide **programmatic control** over agent execution, complementing the dynamic nature of Teams:

| Aspect | Teams | Workflows |
|--------|-------|-----------|
| **Decision Making** | LLM-driven (leader decides) | Programmatic (developer defines) |
| **Execution Path** | Dynamic (varies per query) | Deterministic (fixed steps) |
| **Predictability** | Low (LLM variability) | High (guaranteed order) |
| **Best For** | Flexible problem-solving | Repeatable processes |
| **AVA Use Cases** | Exploratory queries | PdM, Compliance, RCA, SOP |

#### Workflow Constructs

Agno v2 Workflows provide five core constructs:

| Construct | Purpose | Example |
|-----------|---------|---------|
| **Step** | Execute agent, team, or Python function | `Step(pdm_agent, name="MLInference")` |
| **Loop** | Repeat steps until condition met | `Loop(steps=[...], max_iterations=3)` |
| **Parallel** | Execute multiple steps concurrently | `Parallel(steps=[agent1, agent2, agent3])` |
| **Router** | Conditional branching | `Router(routes={"high": urgent_path, "low": normal_path})` |
| **Condition** | Make step conditional | `Condition(condition="risk=='high'", if_true=alert)` |

#### When to Use Workflows vs Teams in AVA

**Use Workflows when:**
- ✅ **Predictable execution required** (PdM ML pipeline must run in order)
- ✅ **Audit trails mandated** (ISO 19011 compliance needs provable step logs)
- ✅ **Structured methodology** (RCA follows 5 Whys → hypothesis → validation)
- ✅ **Validation gates** (SOP must pass safety check before publish)
- ✅ **State caching needed** (expensive ML inference cached via `session_state`)

**Use Teams when:**
- ✅ **Query complexity varies** (simple OEE question vs complex analysis)
- ✅ **Dynamic specialist selection** (leader decides which experts needed)
- ✅ **Exploratory analysis** (user-driven investigation)
- ✅ **Flexible coordination** (synthesis from multiple sources)

#### Hybrid Pattern: Workflows Can Contain Teams

Workflows can include Teams as steps, combining deterministic flow with dynamic coordination:

```python
from agno.workflow import Workflow, Step

# Workflow with embedded Team for dynamic section
hybrid_workflow = Workflow(
    name="PredictiveMaintenance",
    steps=[
        Step(collect_data_function, name="DataCollection"),     # Function (fast)
        Step(preprocess_function, name="Preprocessing"),        # Function
        Step(specialist_team, name="Analysis"),                 # Team (dynamic!)
        Step(compliance_validator, name="ComplianceCheck"),     # Agent
    ]
)
```

**Benefits:**
- ✅ Overall flow is deterministic (data → preprocess → analysis → compliance)
- ✅ Analysis step uses Team for flexible specialist selection
- ✅ Best of both worlds: reliability + flexibility

#### AVA Workflow Applications

AVA will use **4 critical workflows** for production operations:

| Workflow | Business Value | Why Workflow (Not Team) |
|----------|----------------|------------------------|
| **PdM Forecast** | Prevent unplanned downtime | ML pipeline must execute in order; expensive inference needs caching |
| **Compliance Audit** | ISO 19011, GDPR legal compliance | Audit trail requires provable step-by-step execution log |
| **Root Cause Analysis** | Systematic failure investigation | RCA methodology (5 Whys, Fishbone) requires structured progression |
| **SOP Generation** | Safe operating procedures | Must pass compliance + safety validation gates before publish |

**Code Example: Simple PdM Workflow**

```python
from agno.workflow import Workflow, Step, Condition

pdm_workflow = Workflow(
    name="PredictiveMaintenance",
    steps=[
        Step(collect_sensor_data_function, name="DataCollection"),
        Step(preprocess_data_function, name="Preprocessing"),
        Step(pdm_model_agent, name="MLInference"),              # Expensive
        Step(risk_assessment_agent, name="RiskAssessment"),
        Condition(
            condition="risk_level == 'high'",
            if_true=immediate_action_agent,
            if_false=scheduled_maintenance_agent
        ),
        Step(compliance_team, name="ComplianceValidation"),     # Team as step!
    ],
    use_session_state=True  # Cache expensive ML inference
)

# Usage
result = await pdm_workflow.run(query)
```

**Key Advantages:**
- ✅ **Deterministic execution**: Data collection → Preprocessing → Model always runs in order
- ✅ **State caching**: Expensive ML inference cached (saves 300-500ms on repeated queries)
- ✅ **Conditional logic**: High risk triggers immediate action, low risk schedules maintenance
- ✅ **Mixed execution**: Functions (fast preprocessing) + Agents (ML) + Teams (validation)

#### Latency Impact

Workflows add minimal overhead while enabling optimizations:

| Aspect | Impact | Notes |
|--------|--------|-------|
| **Workflow Orchestration** | +50-100ms | Step coordination overhead |
| **State Caching** | -300-500ms | Expensive operations cached via `session_state` |
| **Net Latency** | **Similar or better** | Caching offsets overhead for repeated patterns |

**For AVA**: Workflows maintain ~2-3s latency targets while adding production reliability.

---

## 3. Detailed Sequence Flow

### 3.1 Complex Query Flow with Latencies

```mermaid
sequenceDiagram
    participant U as User
    participant AVA as AVA Orchestrator
    participant P as Planner
    participant R as Reasoner
    participant ST as Specialist Team<br/>(selective delegation)
    participant M as Maintenance
    participant C as Compliance
    participant D as Data
    participant S as SOP Gen
    participant AG as Aggregator
    participant CM as Context Mgr
    participant E as Evaluator

    U->>AVA: "Line 3 downtime increased. Root cause?"

    Note over AVA: Intent Classification<br/>(200ms)
    AVA->>AVA: Classify: complex_query<br/>Domains: [maintenance, compliance, data]

    AVA->>P: Decompose query
    Note over P: Task Breakdown<br/>(150ms)
    P->>P: Tasks: [RCA, compliance_check, metrics, SOP]

    AVA->>R: Validate plan logic
    Note over R: Logic Check<br/>(100ms)
    R-->>AVA: ✓ Valid

    AVA->>ST: Execute specialist team
    Note over ST: Agno Team<br/>Selective Delegation<br/>(parallel via arun)

    par Parallel Execution via arun() - 1.5s total
        ST->>M: Root cause analysis
        Note over M: Neo4j Graph-RAG<br/>PdM forecast
        M-->>ST: "Press 07 vibration"

        ST->>C: Compliance check
        Note over C: GDPR validation<br/>Audit trail
        C-->>ST: "ISO audit required"

        ST->>D: Metrics analysis
        Note over D: OEE calculation<br/>Anomaly detection
        D-->>ST: "OEE dropped 7%"

        ST->>S: Generate SOP
        Note over S: Template generation
        S-->>ST: "4-step procedure"
    end

    ST->>AG: Consolidated outputs
    Note over AG: Agno Team<br/>Collaborative<br/>(delegate_task_to_all_members)

    par Concurrent Synthesis via arun() - 300ms total
        AG->>AG: Consolidate results<br/>Resolve conflicts
        AG->>CM: Enrich with context
        Note over CM: UserMemory<br/>Session history
        CM-->>AG: Context added

        AG->>E: Validate quality
        Note over E: Fact-check<br/>Compliance check
        E-->>AG: ✓ Quality OK
    end

    AG->>AVA: Synthesized response

    Note over AVA: Final Synthesis<br/>(200ms)
    AVA->>U: "Root cause: Press 07 vibration...<br/>Maintenance: 2025-11-12..."

    Note over AVA,U: Total Latency: ~2.4s<br/>✓ Within SLO (3-5s)
```

### 3.2 Latency Breakdown

| Phase | Time | Type | Optimization |
|-------|------|------|--------------|
| AVA Intent Classification | 200ms | Sequential | Cached patterns |
| Planner Decompose | 150ms | Sequential | Task templates |
| Reasoner Validation | 100ms | Sequential | Logic rules cache |
| **Specialist Execution** | **1.5s** | **Parallel (arun, 4 agents)** | Async I/O |
| Aggregation | 200ms | Sequential | Conflict resolution |
| **Synthesis Team** | **300ms** | **Concurrent (arun, 3 agents)** | Parallel validation |
| AVA Final Response | 200ms | Sequential | Template rendering |
| **Total** | **~2.4s** | Mixed | **✅ Within SLO (3-5s)** |

**Key Optimizations:**
- **Parallel specialist execution via `arun()`**: 6s sequential → 1.5s parallel (**75% reduction**)
- **Concurrent synthesis via `arun()`**: 900ms sequential → 300ms concurrent (**67% reduction**)
- **Cached fact-checking**: 50% hit rate (300ms → 150ms average)

---

### 3.3 Workflow-Based Execution Patterns

In addition to Team-based orchestration (shown in 3.1-3.2), AVA uses **Workflows** for deterministic, production-critical operations.

#### Pattern 1: Predictive Maintenance (PdM) Workflow

**Flow:**
```
Sensor Data Collection (function)
    ↓
Data Preprocessing (function)
    ↓
ML Model Inference (agent + Neo4j)
    ↓
Risk Assessment (agent)
    ↓
Conditional Routing (Workflow Router)
  ├─ High Risk → Immediate Action Workflow
  └─ Low Risk → Scheduled Maintenance Agent
    ↓
Compliance Validation (Team as step!)
    ↓
Report Generation (agent)
```

**Latency:** ~2-3s (with ML inference caching via `session_state`)

**Key Features:**
- ✅ **Deterministic ML pipeline**: Always runs data collection → preprocessing → model
- ✅ **Caching**: Expensive ML inference cached (saves 300-500ms on repeated queries)
- ✅ **Conditional logic**: Router directs high-risk to immediate action
- ✅ **Mixed execution**: Functions (fast) + Agents (ML) + Teams (validation)

---

#### Pattern 2: Compliance Audit Workflow

**Flow:**
```
Data Collection (agent + Neo4j)
    ↓
Parallel Compliance Checks (Workflow Parallel)
  ├─ GDPR Validator Agent
  ├─ ISO 19011 Checker Agent
  └─ Privacy Validator Agent
    ↓
Audit Trail Generation (function - structured logging)
    ↓
Report Compilation (agent)
```

**Latency:** ~1-2s (parallel validation)

**Key Features:**
- ✅ **Parallel execution**: All compliance checks run concurrently
- ✅ **Audit trail**: Step-by-step execution log (legal requirement)
- ✅ **Guaranteed execution**: Every check runs (no LLM variability)

---

#### Pattern 3: Root Cause Analysis (RCA) Workflow

**Flow:**
```
Symptom Analysis (agent + Neo4j context)
    ↓
Hypothesis Generation (agent + domain KB)
    ↓
Hypothesis Testing (Workflow Router)
  ├─ Mechanical → Mechanical Test Team
  ├─ Electrical → Electrical Test Team
  ├─ Software → Software Test Team
  └─ Process → Process Audit Team
    ↓
Root Cause Validation (agent + inference rules)
    ↓
Corrective Action Recommendation (agent)
    ↓
SOP Update Trigger (function - integration)
```

**Latency:** ~3-5s (depends on hypothesis complexity)

**Key Features:**
- ✅ **Structured methodology**: Enforces RCA best practices (5 Whys, Fishbone)
- ✅ **Router branching**: Dynamically routes to specialist teams based on hypothesis type
- ✅ **Step chaining**: Each step's output informs the next (symptom → hypothesis → test → validation)

---

#### Pattern 4: SOP Generation + Validation Workflow

**Flow:**
```
SOP Draft Generation (agent + templates)
    ↓
Technical Review (agent + domain expertise)
    ↓
Parallel Validation (Workflow Parallel)
  ├─ Compliance Validator Agent
  └─ Safety Validator Agent
    ↓
Approval Gate (Workflow Condition)
  ├─ All Checks Passed → Approval Agent → Publish
  └─ Checks Failed → Revision Loop (max 3 iterations)
        ↓
    Revision Agent
        ↓
    Technical Review (re-validate)
        ↓
    [Loop back to Parallel Validation]
```

**Latency:** ~2-4s (single pass), up to ~10s (with revisions)

**Key Features:**
- ✅ **Validation gates**: SOP cannot publish without passing all checks
- ✅ **Revision loop**: Failed SOPs auto-iterate (max 3 attempts)
- ✅ **Safety-critical**: Ensures no unsafe procedures published

---

#### Workflow vs Team Latency Comparison

| Execution Type | Team-Based | Workflow-Based | Notes |
|----------------|-----------|----------------|-------|
| **Simple Query** | ~1-2s | N/A | Teams (Router) optimal |
| **Complex Multi-Domain** | ~2-3s | N/A | Teams (Selective) optimal |
| **PdM Forecast** | ~3-4s (variable) | **~2-3s (cached)** | Workflow faster (caching) |
| **Compliance Audit** | ~2-3s (variable) | **~1-2s (parallel)** | Workflow faster (parallel) |
| **RCA Investigation** | ~4-6s (variable) | **~3-5s (structured)** | Workflow more consistent |
| **SOP Generation** | ~3-5s (variable) | **~2-4s (gates)** | Workflow safer (validation) |

**Key Insight**: Workflows not only provide **reliability and audit trails**, but often achieve **better latency** through caching and parallel execution.

---

## 4. Decision Flow: Hybrid Orchestration (Teams + Workflows)

### 4.1 Updated Decision Flow with Workflows

```mermaid
flowchart TD
    Start([User Query]) --> Classify{AVA: Classify<br/>Intent & Complexity}

    Classify -->|Simple Query<br/>Single Domain| Router[Agno Team<br/>Router Pattern]
    Classify -->|Complex Query<br/>Multi-Domain Exploration| Selective[Agno Team<br/>Selective Delegation]
    Classify -->|Structured Operation<br/>Production-Critical| WorkflowRouter{Workflow<br/>Type?}

    Router --> SingleAgent[Single Specialist<br/>executes]
    SingleAgent --> LightEval[Lightweight<br/>Evaluation]
    LightEval --> Response1([Response<br/>~1-2s])

    Selective --> Planner[Planner<br/>decomposes]
    Planner --> Reasoner[Reasoner<br/>validates]
    Reasoner --> Parallel[Parallel Execution<br/>via arun<br/>4 specialists]

    Parallel --> Collab[Agno Team<br/>Collaborative Pattern]
    Collab --> Concurrent[Concurrent Synthesis<br/>via arun<br/>Aggregator + Context + Evaluator]
    Concurrent --> Response2([Final Response<br/>~2-3s])

    WorkflowRouter -->|PdM Forecast| PdMWF[Agno Workflow<br/>Predictive Maintenance]
    WorkflowRouter -->|Compliance/Audit| CompWF[Agno Workflow<br/>Compliance Audit]
    WorkflowRouter -->|Root Cause Analysis| RCAWF[Agno Workflow<br/>RCA Investigation]
    WorkflowRouter -->|SOP Creation| SOPWF[Agno Workflow<br/>SOP Generation]

    PdMWF --> Response3([Response<br/>~2-3s])
    CompWF --> Response4([Response<br/>~1-2s])
    RCAWF --> Response5([Response<br/>~3-5s])
    SOPWF --> Response6([Response<br/>~2-4s])

    style Router fill:#95e1d3,stroke:#333,stroke-width:2px
    style Selective fill:#4ecdc4,stroke:#333,stroke-width:2px
    style Collab fill:#ffe66d,stroke:#333,stroke-width:2px
    style PdMWF fill:#ff9ff3,stroke:#333,stroke-width:2px
    style CompWF fill:#ff9ff3,stroke:#333,stroke-width:2px
    style RCAWF fill:#ff9ff3,stroke:#333,stroke-width:2px
    style SOPWF fill:#ff9ff3,stroke:#333,stroke-width:2px
    style Response1 fill:#a8e6cf,stroke:#333,stroke-width:2px
    style Response2 fill:#a8e6cf,stroke:#333,stroke-width:2px
    style Response3 fill:#a8e6cf,stroke:#333,stroke-width:2px
    style Response4 fill:#a8e6cf,stroke:#333,stroke-width:2px
    style Response5 fill:#a8e6cf,stroke:#333,stroke-width:2px
    style Response6 fill:#a8e6cf,stroke:#333,stroke-width:2px
```

### 4.2 Decision Criteria: Teams vs Workflows

| Query Type | Example | Orchestration Pattern | Latency | Why This Pattern? |
|------------|---------|----------------------|---------|-------------------|
| **Simple Fact** | "What's Line 3 OEE?" | **Team: Router** | ~1-2s | Single specialist, dynamic routing |
| **Complex Exploration** | "Analyze Line 3 performance trends" | **Team: Selective + Collaborative** | ~2-3s | Multi-domain, flexible coordination |
| **Multi-turn Conversation** | "What about Press 07?" (follow-up) | **Team: Router** (with context) | ~1-2s | Context-aware, adaptive |
| **PdM Forecast** | "Predict Line 3 failures next week" | **Workflow: PdM** | ~2-3s | ML pipeline must run in order; caching |
| **Compliance Check** | "Generate ISO 19011 audit report" | **Workflow: Compliance** | ~1-2s | Legal audit trail required |
| **Root Cause Analysis** | "Why did Press 07 fail?" | **Workflow: RCA** | ~3-5s | Structured methodology (5 Whys) |
| **SOP Creation** | "Create maintenance SOP for Press 07" | **Workflow: SOP** | ~2-4s | Validation gates (safety + compliance) |

### 4.3 Intent Classification Logic

AVA Orchestrator uses keyword detection + complexity analysis to route between Teams and Workflows:

```python
def classify_and_route(query: str) -> OrchestrationType:
    """AVA intent classifier with hybrid routing."""

    # Workflow-based routing (deterministic operations)
    if any(kw in query.lower() for kw in ["predict", "forecast", "pdm", "maintenance schedule"]):
        return WorkflowType.PDM

    elif any(kw in query.lower() for kw in ["audit", "compliance", "iso", "gdpr", "regulatory"]):
        return WorkflowType.COMPLIANCE

    elif any(kw in query.lower() for kw in ["root cause", "rca", "why did", "failure analysis"]):
        return WorkflowType.RCA

    elif any(kw in query.lower() for kw in ["sop", "procedure", "checklist", "operating guide"]):
        return WorkflowType.SOP

    # Team-based routing (dynamic queries)
    elif is_simple_query(query):  # Single metric, factual
        return TeamPattern.ROUTER

    else:  # Complex multi-domain
        return TeamPattern.SELECTIVE_COLLABORATIVE
```

**Key Decision Factors:**

| Factor | Teams | Workflows |
|--------|-------|-----------|
| **Keywords** | General questions, exploration | "predict", "audit", "root cause", "sop" |
| **Complexity** | Varies (simple → router, complex → selective) | Structured process |
| **Predictability** | Output varies by query | Output follows template |
| **Audit Requirement** | Traces via Langfuse | Step-by-step execution log |
| **Validation Gates** | Optional (Evaluator agent) | Mandatory (Condition steps) |

---

## 5. Components and Infrastructure

```mermaid
graph LR
    subgraph agents [Agno Agents - 10 Total]
        AVA[AVA<br/>Orchestrator]
        P[Planner]
        R[Reasoner]
        M[Maintenance]
        C[Compliance]
        D[Data]
        S[SOP Gen]
        AG[Aggregator]
        CM[Context Mgr]
        E[Evaluator]
    end

    subgraph teams [Agno Teams - Delegation Patterns]
        T1[Router Pattern<br/>AVA → Specialists]
        T2[Selective Delegation<br/>Planner → Specialists]
        T3[Collaborative Pattern<br/>AVA → Synthesis]
    end

    subgraph backend [Backend Infrastructure]
        vLLM[vLLM<br/>OpenAI-compatible API<br/>Llama 3 8B]
        Neo4j[Neo4j<br/>Manufacturing Ontology<br/>Graph-RAG]
        PG[PostgreSQL<br/>UserMemory<br/>Session State]
        LF[Langfuse<br/>Observability<br/>Traces]
    end

    subgraph tools [Custom Tools]
        PdM[PdM Forecaster]
        RCA[RCA Analyzer]
        CMMS[CMMS Connector]
        GDPR[GDPR Validator]
        Metrics[Metrics Calc]
    end

    AVA --> T1
    P --> T2
    AVA --> T3

    M --> vLLM
    M --> Neo4j
    M --> PdM
    M --> RCA
    M --> CMMS

    C --> vLLM
    C --> GDPR

    D --> vLLM
    D --> Metrics

    CM --> PG

    AVA --> LF
    AG --> LF
    E --> LF

    style AVA fill:#ff6b6b,color:#fff
    style T1 fill:#95e1d3
    style T2 fill:#4ecdc4
    style T3 fill:#ffe66d
    style vLLM fill:#dfe6e9
    style Neo4j fill:#74b9ff
    style PG fill:#a29bfe
    style LF fill:#fdcb6e
```

---

## 6. Implementation Example

### 6.1 Complete Phase 2 Implementation with Correct Agno v2 API

```python
from agno.agent import Agent
from agno.team import Team
from agno.models.openai.like import OpenAILike
from agno.knowledge import Neo4jKnowledgeBase
from agno.memory import UserMemory, PgMemoryDb
from agno.tools import tool

# ============================================================================
# Backend Configuration
# ============================================================================

# vLLM backend (self-hosted Llama 3 8B)
vllm_model = OpenAILike(
    id="meta-llama/Meta-Llama-3-8B-Instruct",
    api_key="EMPTY",
    base_url="http://localhost:8000/v1"
)

# Neo4j Graph-RAG for manufacturing ontology
neo4j_knowledge = Neo4jKnowledgeBase(
    graph_url="bolt://localhost:7687",
    username="neo4j",
    password="password"
)

# PostgreSQL for user memory
pg_memory = PgMemoryDb(
    db_url="postgresql://user:pass@localhost:5432/ava"
)

# ============================================================================
# Agent Definitions
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────
# Orchestration Layer
# ──────────────────────────────────────────────────────────────────────────

ava_orchestrator = Agent(
    name="AVA",
    model=vllm_model,
    instructions=[
        "You are AVA, the AccelVeo Virtual Advisor orchestrator.",
        "Classify user intent and complexity.",
        "Synthesize final responses with clarity and precision.",
        "Prioritize safety > compliance > cost > time."
    ],
    tools=[intent_classifier, conflict_resolver],
    add_history_to_context=True
)

planner_agent = Agent(
    name="Planner",
    model=vllm_model,
    role="Query decomposition and task planning specialist",
    instructions=[
        "Decompose complex queries into atomic sub-tasks.",
        "Identify dependencies between sub-tasks.",
        "Generate execution plan (sequential vs. parallel)."
    ],
    tools=[task_decomposer, dependency_mapper]
)

reasoner_agent = Agent(
    name="Reasoner",
    model=vllm_model,
    role="Logical validation and consistency checking specialist",
    instructions=[
        "Validate logical consistency of agent outputs.",
        "Check for contradictions or conflicts.",
        "Apply domain inference rules (manufacturing)."
    ],
    tools=[logic_validator, inference_engine]
)

# ──────────────────────────────────────────────────────────────────────────
# Specialist Layer (Domain Experts)
# ──────────────────────────────────────────────────────────────────────────

maintenance_agent = Agent(
    name="MaintenanceSpecialist",
    model=vllm_model,
    role="Predictive maintenance, RCA, and CMMS integration specialist",
    instructions=[
        "Expert in predictive maintenance (PdM) and root cause analysis.",
        "Query sensor data for anomaly detection.",
        "Recommend maintenance schedules (preventive/corrective).",
        "Cite all evidence from ontology (Neo4j)."
    ],
    tools=[pdm_forecaster, rca_analyzer, cmms_connector],
    knowledge=neo4j_knowledge,
    search_knowledge=True
)

compliance_agent = Agent(
    name="ComplianceSpecialist",
    model=vllm_model,
    role="GDPR, ISO 19011, and manufacturing compliance specialist",
    instructions=[
        "Expert in GDPR, ISO 19011, manufacturing compliance.",
        "Validate actions against regulatory requirements.",
        "Flag compliance risks (audit, privacy, safety).",
        "Generate audit trails."
    ],
    tools=[gdpr_validator, iso_checker, audit_logger]
)

data_agent = Agent(
    name="DataSpecialist",
    model=vllm_model,
    role="Manufacturing metrics, anomaly detection, and trend analysis specialist",
    instructions=[
        "Expert in manufacturing metrics (OEE, MTBF, MTTR).",
        "Detect anomalies in production data.",
        "Analyze trends and patterns.",
        "Provide statistical insights."
    ],
    tools=[metrics_calculator, anomaly_detector, trend_analyzer]
)

sop_generator_agent = Agent(
    name="SOPGenerator",
    model=vllm_model,
    role="Standard operating procedure and checklist generation specialist",
    instructions=[
        "Generate standard operating procedures (SOPs).",
        "Create maintenance checklists.",
        "Provide step-by-step guides for operators."
    ],
    tools=[template_generator, checklist_builder]
)

# ──────────────────────────────────────────────────────────────────────────
# Synthesis Layer
# ──────────────────────────────────────────────────────────────────────────

aggregator_agent = Agent(
    name="Aggregator",
    model=vllm_model,
    role="Multi-source output consolidation and conflict resolution specialist",
    instructions=[
        "Consolidate outputs from multiple specialists.",
        "Resolve conflicts using priority: safety > cost > time.",
        "Generate unified response.",
        "Preserve all citations and evidence."
    ],
    tools=[conflict_resolver, output_merger]
)

context_manager_agent = Agent(
    name="ContextManager",
    model=vllm_model,
    role="Session tracking and user preference management specialist",
    instructions=[
        "Track user session context.",
        "Maintain conversation history.",
        "Inject relevant historical context into responses."
    ],
    memory=UserMemory(
        db=pg_memory,
        user_id_param="user_id"
    ),
    add_history_to_context=True
)

evaluator_agent = Agent(
    name="Evaluator",
    model=vllm_model,
    role="Response quality validation and fact-checking specialist",
    instructions=[
        "Validate response quality (completeness, accuracy).",
        "Fact-check against ontology (Graph-RAG).",
        "Ensure compliance with manufacturing standards.",
        "Flag low-quality responses for iteration."
    ],
    tools=[fact_checker, quality_scorer],
    knowledge=neo4j_knowledge,
    search_knowledge=True
)

# ============================================================================
# Team Configurations (Agno v2 Correct API)
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────
# Team 1: Router Pattern for Simple Queries
# ──────────────────────────────────────────────────────────────────────────

routing_team = Team(
    name="SimpleRouter",
    members=[
        maintenance_agent,
        compliance_agent,
        data_agent,
        sop_generator_agent
    ],
    instructions=[
        "Analyze the query intent",
        "Select the single most appropriate specialist based on their role",
        "Delegate to that specialist"
    ],
    respond_directly=True,  # Return specialist output directly (no synthesis)
    determine_input_for_members=False  # Pass original query unchanged
)

# ──────────────────────────────────────────────────────────────────────────
# Team 2: Selective Delegation Pattern for Complex Queries
# ──────────────────────────────────────────────────────────────────────────

specialist_team = Team(
    name="SpecialistTeam",
    members=[
        maintenance_agent,
        compliance_agent,
        data_agent,
        sop_generator_agent
    ],
    instructions=[
        "Analyze the query and identify all required expertise areas",
        "Delegate to relevant specialists (choose multiple if needed)",
        "Synthesize their outputs into a coherent, unified response"
    ]
    # No special parameters - default selective delegation behavior
    # Use arun() to execute delegated agents in parallel
)

# ──────────────────────────────────────────────────────────────────────────
# Team 3: Collaborative Pattern for Synthesis
# ──────────────────────────────────────────────────────────────────────────

synthesis_team = Team(
    name="SynthesisTeam",
    members=[
        aggregator_agent,
        context_manager_agent,
        evaluator_agent
    ],
    instructions=[
        "All members process the specialist outputs concurrently",
        "Aggregator consolidates results and resolves conflicts",
        "Context Manager enriches with session data",
        "Evaluator validates quality and compliance",
        "Synthesize collective insights into final response"
    ],
    delegate_task_to_all_members=True  # Force all members to execute
    # Use arun() to ensure concurrent execution
)

# ============================================================================
# Orchestration Flow
# ============================================================================

async def handle_query(user_query: str, user_id: str):
    """
    Phase 2 orchestration flow for AVA queries.
    Automatically selects router vs selective delegation based on complexity.
    """

    # Step 1: AVA classifies intent and complexity
    intent = ava_orchestrator.run(
        f"Classify intent and complexity: {user_query}",
        session_id=f"ava-{user_id}"
    )

    # Step 2: Simple query → Router pattern (sync execution)
    if intent.content.get("complexity") == "simple":
        response = routing_team.run(user_query)
        return response.content

    # Step 3: Complex query → Planner decomposes
    plan = planner_agent.run(
        f"Decompose query: {user_query}\nIntent: {intent.content}"
    )

    # Step 4: Reasoner validates plan
    validated_plan = reasoner_agent.run(
        f"Validate plan logic: {plan.content}"
    )

    # Step 5: Specialist Team executes (Selective Delegation)
    # Use arun() for parallel execution when leader delegates to multiple
    specialist_outputs = await specialist_team.arun(
        f"Execute plan: {validated_plan.content}\nQuery: {user_query}"
    )

    # Step 6: Synthesis Team processes (Collaborative Pattern)
    # Use arun() to ensure concurrent execution of all 3 synthesis agents
    final_response = await synthesis_team.arun(
        f"Synthesize final response from:\n{specialist_outputs.content}\n"
        f"User: {user_id}\nQuery: {user_query}"
    )

    return final_response.content


# ============================================================================
# Example Usage
# ============================================================================

async def main():
    # Simple query (router pattern, sync)
    simple_query = "What's the current OEE for Line 3?"
    simple_response = routing_team.run(simple_query)
    print(f"Simple response: {simple_response.content}")

    # Complex query (selective + collaborative patterns, async parallel)
    complex_query = (
        "Line 3 downtime increased 40% last week. "
        "Find root cause, assess compliance risk, "
        "and generate preventive maintenance SOP."
    )
    complex_response = await handle_query(complex_query, user_id="operator123")
    print(f"Complex response: {complex_response}")


if __name__ == "__main__":
    import asyncio
    asyncio.run(main())
```

---

### 6.2 Workflow Implementations (Production-Critical Operations)

This section provides complete implementations of the 4 critical workflows for AVA's production operations.

#### Workflow 1: Predictive Maintenance (PdM)

```python
from agno.workflow import Workflow, Step, Parallel, Condition, Router
from agno.agent import Agent

# ──────────────────────────────────────────────────────────────────────────
# Python Functions for Fast Preprocessing (No LLM Needed)
# ──────────────────────────────────────────────────────────────────────────

def collect_sensor_data(input_data):
    """Collect sensor data from manufacturing equipment."""
    # Integration with IoT sensors, SCADA systems
    return {"sensor_data": fetch_from_sensors(input_data.equipment_id)}

def preprocess_data(step_input):
    """Clean and normalize sensor data for ML model."""
    raw_data = step_input.sensor_data
    # Normalization, outlier removal, feature engineering
    return {"preprocessed_data": normalize_and_engineer_features(raw_data)}

# ──────────────────────────────────────────────────────────────────────────
# PdM Workflow Definition
# ──────────────────────────────────────────────────────────────────────────

pdm_workflow = Workflow(
    name="PredictiveMaintenance",
    steps=[
        # Step 1: Data Collection (function - fast, no LLM)
        Step(
            executor=collect_sensor_data,
            name="DataCollection"
        ),

        # Step 2: Preprocessing (function - fast, deterministic)
        Step(
            executor=preprocess_data,
            name="Preprocessing"
        ),

        # Step 3: ML Model Inference (agent with Neo4j context)
        Step(
            executor=pdm_model_agent,  # Agent defined earlier
            name="MLInference"
            # This step is expensive (300-500ms), benefits from caching
        ),

        # Step 4: Risk Assessment (agent)
        Step(
            executor=risk_assessment_agent,
            name="RiskAssessment"
        ),

        # Step 5: Conditional Routing based on risk level
        Router(
            routes={
                "high_risk": Step(immediate_action_agent, name="ImmediateAction"),
                "medium_risk": Step(scheduled_maintenance_agent, name="ScheduledMaintenance"),
                "low_risk": Step(monitoring_continuation_agent, name="ContinueMonitoring"),
            },
            name="RiskBasedRouting"
        ),

        # Step 6: Compliance Validation (Team as workflow step!)
        Step(
            executor=compliance_team,  # Team defined in 6.1
            name="ComplianceValidation"
        ),

        # Step 7: Report Generation (agent)
        Step(
            executor=report_generator_agent,
            name="ReportGeneration"
        ),
    ],
    use_session_state=True,  # Cache expensive ML inference results
    description="End-to-end predictive maintenance pipeline with ML inference and compliance validation"
)

# Usage
async def run_pdm_forecast(equipment_id: str, user_id: str):
    result = await pdm_workflow.run(
        input_data={"equipment_id": equipment_id, "user_id": user_id}
    )
    return result.content
```

**Key Advantages:**
- ✅ **Deterministic execution**: Always runs data collection → preprocessing → ML → risk → routing → compliance → report
- ✅ **State caching**: ML inference cached via `use_session_state=True` (saves 300-500ms)
- ✅ **Mixed execution**: Functions (fast preprocessing) + Agents (ML, risk) + Teams (validation)
- ✅ **Conditional logic**: Router directs to different actions based on risk level

---

#### Workflow 2: Compliance Audit Trail

```python
from agno.workflow import Workflow, Step, Parallel

# ──────────────────────────────────────────────────────────────────────────
# Compliance Workflow Definition
# ──────────────────────────────────────────────────────────────────────────

compliance_audit_workflow = Workflow(
    name="ComplianceAudit",
    steps=[
        # Step 1: Data Collection (agent with Neo4j)
        Step(
            executor=data_collection_agent,
            name="DataCollection"
        ),

        # Step 2: Parallel Compliance Checks (all must pass)
        Parallel(
            steps=[
                Step(gdpr_validator_agent, name="GDPRValidation"),
                Step(iso_19011_checker_agent, name="ISOCompliance"),
                Step(privacy_validator_agent, name="PrivacyCheck"),
                Step(safety_regul_agent, name="SafetyRegulatory"),
            ],
            name="ParallelComplianceChecks"
            # All 4 agents run concurrently (~500ms total vs 2s sequential)
        ),

        # Step 3: Audit Trail Generation (function - structured logging)
        Step(
            executor=generate_audit_trail_function,
            name="AuditTrailGeneration"
            # Logs every step execution with timestamps, inputs, outputs
        ),

        # Step 4: Report Compilation (agent)
        Step(
            executor=audit_report_compiler_agent,
            name="ReportCompilation"
        ),

        # Step 5: Archival (function - long-term storage)
        Step(
            executor=archive_audit_report_function,
            name="AuditArchival"
            # Required for ISO 19011 (7-year retention)
        ),
    ],
    description="ISO 19011 and GDPR compliance audit with provable execution trail"
)

# Usage
async def run_compliance_audit(operation_id: str, audit_type: str):
    result = await compliance_audit_workflow.run(
        input_data={"operation_id": operation_id, "audit_type": audit_type}
    )
    return result.content
```

**Key Advantages:**
- ✅ **Parallel execution**: 4 compliance checks run concurrently (500ms vs 2s sequential)
- ✅ **Audit trail**: Step-by-step execution log (legal requirement)
- ✅ **Guaranteed execution**: Every check runs (no LLM skipping)
- ✅ **Archival**: Auto-archives for ISO 19011 compliance (7-year retention)

---

#### Workflow 3: Root Cause Analysis (RCA)

```python
from agno.workflow import Workflow, Step, Router, Loop

# ──────────────────────────────────────────────────────────────────────────
# RCA Workflow Definition
# ──────────────────────────────────────────────────────────────────────────

rca_workflow = Workflow(
    name="RootCauseAnalysis",
    steps=[
        # Step 1: Symptom Analysis (agent with Neo4j context)
        Step(
            executor=symptom_analyzer_agent,
            name="SymptomAnalysis"
            # Uses Neo4j to find similar historical failures
        ),

        # Step 2: Hypothesis Generation (agent with domain knowledge)
        Step(
            executor=hypothesis_generator_agent,
            name="HypothesisGeneration"
            # Generates 3-5 hypotheses using 5 Whys, Fishbone methodology
        ),

        # Step 3: Hypothesis Testing (Router to specialist teams)
        Router(
            routes={
                "mechanical": Step(mechanical_test_team, name="MechanicalTest"),
                "electrical": Step(electrical_test_team, name="ElectricalTest"),
                "software": Step(software_test_team, name="SoftwareTest"),
                "process": Step(process_audit_team, name="ProcessAudit"),
                "human_error": Step(human_factors_team, name="HumanFactorsAnalysis"),
            },
            name="HypothesisTesting"
            # Router selects appropriate specialist team based on hypothesis type
        ),

        # Step 4: Root Cause Validation (agent with inference rules)
        Step(
            executor=root_cause_validator_agent,
            name="RootCauseValidation"
            # Validates hypothesis test results using domain rules
        ),

        # Step 5: Corrective Action Recommendation (agent)
        Step(
            executor=corrective_action_agent,
            name="CorrectiveActions"
            # Recommends short-term fixes + long-term preventive measures
        ),

        # Step 6: SOP Update Trigger (function - integration)
        Step(
            executor=trigger_sop_update_function,
            name="SOPUpdateTrigger"
            # Triggers SOP workflow if process changes needed
        ),

        # Step 7: Knowledge Base Update (function)
        Step(
            executor=update_rca_knowledge_base_function,
            name="KnowledgeBaseUpdate"
            # Adds RCA findings to Neo4j for future symptom analysis
        ),
    ],
    description="Structured root cause analysis following 5 Whys and Fishbone methodology"
)

# Usage
async def run_rca(failure_event_id: str, user_id: str):
    result = await rca_workflow.run(
        input_data={"failure_event_id": failure_event_id, "user_id": user_id}
    )
    return result.content
```

**Key Advantages:**
- ✅ **Structured methodology**: Enforces RCA best practices (symptom → hypothesis → test → validate → action)
- ✅ **Router branching**: Dynamically routes to specialist teams based on hypothesis type
- ✅ **Knowledge accumulation**: Updates Neo4j KB for continuous learning
- ✅ **Step chaining**: Each step's output informs the next

---

#### Workflow 4: SOP Generation + Validation

```python
from agno.workflow import Workflow, Step, Parallel, Condition, Loop

# ──────────────────────────────────────────────────────────────────────────
# SOP Workflow Definition
# ──────────────────────────────────────────────────────────────────────────

sop_generation_workflow = Workflow(
    name="SOPGeneration",
    steps=[
        # Step 1: SOP Draft Generation (agent with templates)
        Step(
            executor=sop_generator_agent,
            name="DraftGeneration"
            # Uses SOP templates + domain knowledge
        ),

        # Step 2: Technical Review (agent with domain expertise)
        Step(
            executor=technical_reviewer_agent,
            name="TechnicalReview"
        ),

        # Step 3: Parallel Validation (compliance + safety checks)
        Parallel(
            steps=[
                Step(compliance_validator_agent, name="ComplianceValidation"),
                Step(safety_validator_agent, name="SafetyValidation"),
                Step(regulatory_checker_agent, name="RegulatoryCheck"),
            ],
            name="ParallelValidation"
        ),

        # Step 4: Approval Gate (conditional)
        Condition(
            condition="all_checks_passed == True",
            if_true=Step(approval_agent, name="Approval"),
            if_false=Loop(
                steps=[
                    Step(revision_agent, name="Revision"),
                    Step(technical_reviewer_agent, name="ReReview"),
                    # Loop back to Parallel Validation
                ],
                max_iterations=3,
                name="RevisionLoop"
                # Max 3 revision attempts, then escalate to human
            ),
            name="ApprovalGate"
        ),

        # Step 5: Publication (function - integration)
        Step(
            executor=publish_sop_function,
            name="Publication"
            # Publishes to SOP management system
        ),

        # Step 6: Notification (function)
        Step(
            executor=notify_stakeholders_function,
            name="StakeholderNotification"
            # Notifies operators, supervisors of new SOP
        ),
    ],
    description="SOP generation with multi-step validation gates and revision loop"
)

# Usage
async def run_sop_generation(task_description: str, equipment_id: str, user_id: str):
    result = await sop_generation_workflow.run(
        input_data={
            "task_description": task_description,
            "equipment_id": equipment_id,
            "user_id": user_id
        }
    )
    return result.content
```

**Key Advantages:**
- ✅ **Validation gates**: SOP cannot publish without passing all checks
- ✅ **Revision loop**: Failed SOPs auto-iterate (max 3 attempts) before human escalation
- ✅ **Safety-critical**: Ensures no unsafe procedures published
- ✅ **Audit trail**: Every validation step logged (compliance requirement)

---

#### Hybrid Orchestration: Integrating Workflows with Teams

```python
# ============================================================================
# AVA Orchestrator with Hybrid Routing (Teams + Workflows)
# ============================================================================

async def ava_hybrid_orchestrator(user_query: str, user_id: str):
    """
    AVA orchestrator with hybrid routing between Teams and Workflows.
    """

    # Step 1: Intent Classification
    intent = ava_orchestrator.run(
        f"Classify intent and complexity: {user_query}",
        session_id=f"ava-{user_id}"
    )

    # Step 2: Route to appropriate orchestration pattern

    # Workflow-based routing (production-critical)
    if intent.workflow_type == "pdm":
        return await pdm_workflow.run({"query": user_query, "user_id": user_id})

    elif intent.workflow_type == "compliance":
        return await compliance_audit_workflow.run({"query": user_query, "user_id": user_id})

    elif intent.workflow_type == "rca":
        return await rca_workflow.run({"query": user_query, "user_id": user_id})

    elif intent.workflow_type == "sop":
        return await sop_generation_workflow.run({"query": user_query, "user_id": user_id})

    # Team-based routing (dynamic queries)
    elif intent.complexity == "simple":
        # Router pattern (simple queries)
        return routing_team.run(user_query)

    else:
        # Selective + Collaborative patterns (complex queries)
        # Step 3: Planner decomposes
        plan = planner_agent.run(f"Decompose: {user_query}\nIntent: {intent.content}")

        # Step 4: Reasoner validates
        validated_plan = reasoner_agent.run(f"Validate: {plan.content}")

        # Step 5: Specialist Team executes (Selective Delegation)
        specialist_outputs = await specialist_team.arun(
            f"Execute: {validated_plan.content}\nQuery: {user_query}"
        )

        # Step 6: Synthesis Team processes (Collaborative Pattern)
        final_response = await synthesis_team.arun(
            f"Synthesize:\n{specialist_outputs.content}\nUser: {user_id}"
        )

        return final_response.content


# ============================================================================
# Complete Example Usage
# ============================================================================

async def main():
    # Example 1: Simple query → Team (Router)
    response1 = await ava_hybrid_orchestrator(
        "What's Line 3 OEE?",
        user_id="operator123"
    )
    print(f"Simple query: {response1}")  # ~1-2s

    # Example 2: Complex query → Team (Selective + Collaborative)
    response2 = await ava_hybrid_orchestrator(
        "Analyze Line 3 performance trends and correlate with maintenance events",
        user_id="operator123"
    )
    print(f"Complex query: {response2}")  # ~2-3s

    # Example 3: PdM forecast → Workflow
    response3 = await ava_hybrid_orchestrator(
        "Predict Line 3 failures for next week",
        user_id="maintenance_supervisor"
    )
    print(f"PdM forecast: {response3}")  # ~2-3s (with caching)

    # Example 4: Compliance audit → Workflow
    response4 = await ava_hybrid_orchestrator(
        "Generate ISO 19011 audit report for Press 07 operations",
        user_id="compliance_officer"
    )
    print(f"Compliance audit: {response4}")  # ~1-2s (parallel checks)

    # Example 5: RCA → Workflow
    response5 = await ava_hybrid_orchestrator(
        "Why did Press 07 fail on 2025-11-12?",
        user_id="plant_manager"
    )
    print(f"RCA: {response5}")  # ~3-5s (structured methodology)

    # Example 6: SOP generation → Workflow
    response6 = await ava_hybrid_orchestrator(
        "Create preventive maintenance SOP for Press 07 vibration checks",
        user_id="maintenance_supervisor"
    )
    print(f"SOP generation: {response6}")  # ~2-4s (with validation gates)


if __name__ == "__main__":
    import asyncio
    asyncio.run(main())
```

---

## 7. Key Features and Economics

### 7.1 Agno v2 Features Used in AVA (Hybrid Architecture)

| Feature | Usage | Benefit |
|---------|-------|---------|
| **Team Delegation Patterns** | Router, Selective, Collaborative | 0-10h Phase 2 setup (vs 20-30h custom) |
| **Workflows (NEW)** | PdM, Compliance, RCA, SOP pipelines | Production reliability + audit trails (0h vs 15-25h custom) |
| **Async Execution** | `arun()` for parallel specialist execution | 75% latency reduction (6s → 1.5s) |
| **Delegation Control** | `respond_directly`, `delegate_task_to_all_members` | Fine-grained orchestration control |
| **Workflow Constructs** | Step, Loop, Parallel, Router, Condition | Deterministic control (0h vs 10-15h custom state machines) |
| **State Management** | `session_state` for workflow caching | ML inference caching (300-500ms savings) |
| **UserMemory** | PostgreSQL integration | Session continuity, preferences |
| **Knowledge** | Neo4j Graph-RAG | Fact-checking, citations, semantic search |
| **Tools** | Custom manufacturing integrations | Reusable across agents |
| **Observability** | Langfuse built-in | 0h setup (vs 15-23h manual) |

### 7.2 Phase 2 Economics (Updated with Workflows)

**Time Savings with Agno v2 Hybrid Architecture:**

| Component | Manual Work | Agno v2 Built-in | Savings |
|-----------|-------------|------------------|---------|
| Team Coordination | 20-30h | 0-10h | **20h** |
| **Workflow Orchestration (NEW)** | **15-25h** | **0-5h** | **15h** |
| **Audit Trail Implementation (NEW)** | **10-15h** | **0h (built-in step logs)** | **12h** |
| **State Management (NEW)** | **8-12h** | **0h (session_state)** | **10h** |
| Observability Setup | 15-23h | 0h (Langfuse ready) | **19h** |
| Memory Management | 10-15h | 0h (PostgreSQL ready) | **12h** |
| Async/Parallel Execution | 8-12h | 2-5h (`arun()` ready) | **7h** |
| **Total** | **86-132h** | **2-20h** | **95-112h saved** |

**Updated Cost Analysis:**
- Development time saved: **95-112h** (2.5-3 weeks of full-time work)
- **NEW**: Workflows save additional **37-47h** over Teams-only approach
- Team size: Ricardo + AI assistants (small team)
- Timeline: 2-3 weeks Phase 1 (tight deadline)
- **Conclusion**: Agno v2 **hybrid architecture** (Teams + Workflows) critical for meeting timeline AND production requirements

**Business Value of Workflows:**

| Workflow | Business Impact | Economics |
|----------|----------------|-----------|
| **PdM Workflow** | Prevent unplanned downtime (avg $50k-200k per event) | State caching saves 300-500ms per query; ROI in first prevented failure |
| **Compliance Audit** | ISO 19011 legal compliance (audit failures = $10k-100k fines) | Built-in audit trails (0h vs 10-15h manual); legally defensible |
| **RCA Workflow** | Systematic failure investigation (reduces recurrence by 40-60%) | Knowledge accumulation in Neo4j; continuous improvement |
| **SOP Workflow** | Safe operating procedures (prevents safety incidents) | Validation gates ensure no unsafe SOPs published; liability reduction |

**Why Workflows Matter for AVA:**
1. ✅ **Compliance**: ISO 19011 audit trails built-in (vs 10-15h manual logging)
2. ✅ **Reliability**: Production-critical operations guaranteed (PdM, RCA, SOP)
3. ✅ **Performance**: State caching reduces latency (300-500ms per cached operation)
4. ✅ **Safety**: Validation gates prevent unsafe procedures (SOP workflow)
5. ✅ **Cost**: 37-47h additional savings over Teams-only approach

---

## 8. Summary

### 8.1 Architecture Highlights (Hybrid: Teams + Workflows)

| Component | Implementation | Agno v2 Feature |
|-----------|---------------|-----------------|
| **Orchestrator** | AVA Agent with hybrid routing | Agent + Team leader + Workflow router |
| **Planning** | Planner + Reasoner | Agents with tools |
| **Simple Routing** | 1 specialist | Team: Router pattern (`respond_directly=True`) |
| **Complex Coordination** | N specialists parallel | Team: Selective delegation + `arun()` |
| **Synthesis** | 3 agents concurrent | Team: Collaborative pattern (`delegate_task_to_all_members=True`) + `arun()` |
| **PdM Pipeline** | Deterministic ML workflow | **Workflow**: Step + Router + Condition + caching |
| **Compliance Audit** | Parallel validation + audit trail | **Workflow**: Parallel + Step logging |
| **RCA Investigation** | Structured methodology | **Workflow**: Step chaining + Router branching |
| **SOP Generation** | Multi-gate validation | **Workflow**: Condition + Loop + Parallel |
| **Memory** | Context Manager | UserMemory + PostgreSQL |
| **Knowledge** | Neo4j Graph-RAG | Knowledge + search_knowledge |
| **Validation** | Evaluator | Tools + fact-checking |
| **Observability** | Langfuse | Built-in tracing (Teams + Workflows) |

### 8.2 When to Use Each Pattern (Teams vs Workflows)

#### Team Patterns (Dynamic Queries)

| Pattern | Use Case | AVA Example | Parameters | Execution | Latency |
|---------|----------|-------------|------------|-----------|---------|
| **Router** | Simple queries (1 domain) | "What's Line 3 OEE?" → Data Agent | `respond_directly=True`, `determine_input_for_members=False` | `run()` | ~1-2s |
| **Selective Delegation** | Complex queries (multi-domain) | "Analyze Line 3 trends + correlations" → Multiple specialists | Default (leader decides) | `arun()` | ~2-3s |
| **Collaborative** | Synthesis & validation | Aggregator + Context + Evaluator → Concurrent processing | `delegate_task_to_all_members=True` | `arun()` | ~300-500ms |

#### Workflow Patterns (Production-Critical Operations)

| Workflow | Use Case | AVA Example | Key Constructs | Execution | Latency |
|----------|----------|-------------|----------------|-----------|---------|
| **PdM** | Predictive maintenance forecast | "Predict Line 3 failures" → ML pipeline | Step + Router + Condition + `session_state` | `workflow.run()` | ~2-3s (cached) |
| **Compliance** | Regulatory audit trail | "Generate ISO audit" → Parallel validation | Parallel + Step logging | `workflow.run()` | ~1-2s |
| **RCA** | Root cause analysis | "Why did Press 07 fail?" → Structured investigation | Step chaining + Router (hypothesis testing) | `workflow.run()` | ~3-5s |
| **SOP** | Safe procedure generation | "Create PM SOP" → Multi-gate validation | Condition + Loop + Parallel validation | `workflow.run()` | ~2-4s |

### 8.3 Key Advantages of Agno v2 Hybrid Architecture for AVA

**Teams (Dynamic Coordination):**
1. **Python-native**: No graph DSL, simple Python delegation patterns
2. **Flexible delegation**: Router, selective, collaborative patterns cover all needs
3. **Async-first**: `arun()` enables parallel execution (75% latency reduction)
4. **Dynamic routing**: LLM-driven specialist selection adapts to query complexity

**Workflows (Deterministic Orchestration - NEW):**
5. **Production reliability**: Guaranteed execution order for mission-critical operations
6. **Audit trails**: Step-by-step logging (ISO 19011 compliance)
7. **State caching**: `session_state` for expensive operations (300-500ms savings)
8. **Validation gates**: Condition + Loop ensure safety-critical checks

**Combined Advantages:**
9. **Hybrid flexibility**: Best of both worlds (dynamic + deterministic)
10. **Minimal overhead**: <500ms orchestration latency (within SLO)
11. **Self-hosted**: vLLM integration via OpenAI-compatible API
12. **Observability**: Built-in Langfuse tracing for audit trails
13. **Scalability**: Async-first, stateless architecture (horizontal scaling)
14. **Time savings**: **95-112h Phase 2 work saved** (critical for 2-3 week timeline)

### 8.4 Migration from Agno v1

**Deprecated API (v1):**
```python
Team(mode="route", ...)  # ❌ REMOVED
Team(mode="coordinate", ...)  # ❌ REMOVED
Team(mode="collaborate", ...)  # ❌ REMOVED
```

**Correct API (v2):**
```python
# Router pattern
Team(respond_directly=True, determine_input_for_members=False, ...)

# Selective delegation (default)
Team(...)  # Leader decides dynamically
await team.arun(query)  # Parallel execution

# Collaborative pattern
Team(delegate_task_to_all_members=True, ...)
await team.arun(query)  # Concurrent execution
```

---

## References

**Agno v2 Documentation**:
- Teams Overview: https://docs.agno.com/concepts/teams/overview
- Delegation Patterns: https://docs.agno.com/concepts/teams/delegation
- Building Teams: https://docs.agno.com/concepts/teams/building-teams

**Baseline Research**: `research-agno/AVA-EXECUTIVE-SUMMARY.md`
**Framework Comparison**: `README.md`
**Agno Repository**: https://github.com/agno-agi/agno (31.1k stars, 4.6k forks)

---

**Document Version**: 2.0 (✅ Updated with correct Agno v2 API)
**Date**: 2025-11-13
**Status**: Phase 2 Architecture Specification
**Changes**: Removed deprecated `mode=` parameter, added correct delegation patterns and `arun()` parallel execution
**Next Steps**: Week 1 Agno v2 setup & vLLM validation
