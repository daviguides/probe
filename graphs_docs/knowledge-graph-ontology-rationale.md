---
document: "Knowledge Graph & Formal Ontology Rationale"
category: "Technical Architecture - Justifications"
created_date: "2025-11-07"
purpose: "Consolidate all arguments, justifications, and benefits for using Knowledge Graph (Neo4j) and formal ontologies (OWL/RDF) in AccelVeo v2 architecture"
related_docs: ["Manufacturing Ontology", "Multi Agent System v2", "Digital Twin Requirements", "ForgeCleanRoom"]
---

# Knowledge Graph & Formal Ontology Rationale

Este documento consolida **todos os aspectos e argumentos** usados para justificar o uso de Knowledge Graph (Neo4j) e ontologia formal (OWL/RDF) na arquitetura v2 do AccelVeo.

---

## 1. Por Que Knowledge Graph? (vs. Bases de Dados Relacionais ou NoSQL)

### 1.1 Relationships São First-Class Citizens

**Problema com RDBMS:**
- Em bancos relacionais, relacionamentos são "afterthoughts" (foreign keys, joins)
- Queries multi-hop requerem múltiplos JOINs complexos e lentos
- Performance degrada exponencialmente com profundidade de relacionamentos

**Solução com Graph DB:**
```cypher
// Query de 4 hops em Neo4j - rápido e expressivo
MATCH (asset:Asset {name: "Line 3"})
      -[:HAS_SENSOR]->(sensor:Sensor)
      -[:EMITS_STREAM]->(stream:Stream)
      -[:GENERATES_EVENT]->(event:Event {type: "Downtime"})
      -[:CAUSED_BY]->(cause:Alarm)
RETURN asset, sensor, event, cause
```

**Benefício:**
- **Performance**: Graph traversal é O(n) vs O(n²) ou pior em RDBMS
- **Expressividade**: Cypher queries espelham o modelo mental ("Asset HAS Sensor")
- **Flexibilidade**: Adicionar novos relacionamentos não requer schema migrations complexas

### 1.2 Multi-Hop Reasoning Nativo

**Caso de Uso Manufacturing:**
> "Por que a Linha 3 parou? Foi problema de qualidade ou sensor?"

**Reasoning Path (4 hops):**
```
Asset (Line 3) → Event (Downtime E789) → Alarm (A123 Vibration Anomaly) → MaintenancePlan (overdue)
              ↘ Quality Audit (ISO 19011 nonconformity on Machine X)
```

**Por que Graph DB:**
- Permite explorar **múltiplas causas simultaneamente** (quality + sensor)
- Suporta **reasoning paths variáveis** (nem sempre 4 hops, pode ser 2 ou 6)
- **Não requer pre-definir** todos os caminhos possíveis (RDBMS precisa de views/JOINs pre-configurados)

**Evidência no Roadmap:**
> "Support at least 2-hop query chains by end of Q4'25, and 3–4 hop queries by Q2'26" (Multi Agent System v2.md)

### 1.3 Integração Federated Multi-Domain

**Problema de Silos:**
AccelVeo integra **4+ domínios** separados:
- **ISA-95**: Equipment hierarchy (Asset, Zone, WorkUnit)
- **ISO 19011**: Compliance/Audit (AuditFinding, Nonconformity)
- **OPC UA**: Sensor data (NodeId, Variables, DataStreams)
- **GS1**: Supply chain (GTIN, GIAI, Lot tracking)

**Por que Graph DB:**
```turtle
# RDF permite linking cross-domain
<Asset:LINE-003> a isa95:Asset ;
    owl:sameAs <opcua:NodeId_ns=2;s=Line3_PLC> ;
    gs1:GIAI "0012345678901234567890" ;
    audit:auditedBy <Audit:A456> .
```

**Benefícios:**
- **Entity Resolution**: "Line 3" no ERP = "Line Three" no SCADA = NodeId ns=2 no PLC
- **Cross-Domain Queries**: Um único query pode atravessar ISA-95 → OPC UA → ISO 19011
- **Semantic Interoperability**: Standards alignment via ontologies

**Evidência:**
> "federated query planner that maps natural language queries to multi-hop graph queries across the federated manufacturing ontologies" (Multi Agent System v2.md)

### 1.4 Graph-RAG vs Text-RAG

**Text-RAG Limitations:**
- Embeddings perdem **estrutura** (relationships implícitas no texto)
- Chunks de texto podem quebrar **contexto multi-hop**
- Difícil garantir **citation accuracy** (qual chunk específico?)

**Graph-RAG Advantages:**
```python
# Text-RAG: "Line 3 downtime caused by motor overheating [chunk_456]"
# Problema: chunk_456 pode não ter relação explícita Asset→Event→Cause

# Graph-RAG: "Line 3 downtime (Event:E789) caused by Alarm:A123 (Motor Overheating)"
# Benefício: Citation URI aponta exatamente para kg://accel/isa95/Event:E789@v1
```

**Benefícios:**
- **100% Citation Traceability**: Cada fato aponta para node ID específico
- **Structured Reasoning**: LLM vê estrutura explícita, não texto ambíguo
- **No Hallucination on Structure**: Relationships existem ou não (binary), texto é fuzzy

**Evidência:**
> "Unlike pure text-based RAG, this provides structured, contextual insights by exploiting the relationships in the ontology" (Multi Agent System v2.md)

---

## 2. Por Que Ontologia Formal? (OWL/RDF vs. JSON Schemas Apenas)

### 2.1 Semantic Reasoning (Inferência Automática)

**Problema sem Ontologia:**
```json
// JSON Schema: apenas valida sintaxe
{
  "asset": "Line 3",
  "status": "offline",
  "stream": "active"  // ❌ INCONSISTÊNCIA! Asset offline mas stream ativa
}
```

**Solução com OWL Reasoner:**
```turtle
# OWL axiom
:Asset a owl:Class .
:hasStream a owl:ObjectProperty ;
    rdfs:domain :Asset ;
    rdfs:range :Stream .

# Constraint (SHACL)
:AssetShape a sh:NodeShape ;
    sh:targetClass :Asset ;
    sh:property [
        sh:path :status ;
        sh:in ("online" "offline")
    ] ;
    # Rule: Se Asset offline, não pode ter Stream ativa
    sh:sparql [
        sh:select """
            SELECT ?this WHERE {
                ?this :status "offline" ;
                      :hasStream ?stream .
                ?stream :status "active" .
            }
        """ ;
    ] .
```

**Benefícios:**
- **Auto-validação**: Reasoner detecta inconsistências automaticamente
- **Inferência**: Se `Asset hasStream Stream` e `Stream generatesEvent Event`, reasoner infere `Asset indirectly-generates Event`
- **Safety Critical**: Manufacturing não pode tolerar dados inconsistentes

**Evidência:**
> "Reasoner Middleware: Implement service (using HermiT or Pellet) that takes ontology graph + submodel data and performs validations like: asset offline but DataStream active; prediction not linked to MaintenancePlan; multi-site hierarchy inconsistent" (OpenPipe_ART.md via Thread 3)

### 2.2 Standards Alignment & Interoperability

**Por Que Standards Formais:**
AccelVeo alinha com **7 standards industriais**:
- **ISA-95/88**: Manufacturing operations
- **ISO 10303** (STEP): Product data exchange
- **OPC UA NodeSets**: Industrial automation
- **GS1**: Supply chain identifiers
- **ISO 19011**: Audit/compliance
- **Dublin Core**: Metadata
- **Schema.org**: Linked data

**Sem Ontologia Formal:**
- Cada standard é "implementado" como JSON custom (zero interop)
- Clientes não podem integrar com seus sistemas (sem semantic mapping)

**Com Ontologia OWL/RDF:**
```turtle
# Explicit alignment
avm:Asset rdfs:subClassOf isa95:Equipment ;
    owl:equivalentClass opcua:Object ;
    skos:exactMatch gs1:GIAI .
```

**Benefícios:**
- **Compliance Provável**: Auditor pode validar alignment com ISA-95 via SPARQL
- **Client Integration**: Clientes exportam RDF e integram com seus triple stores
- **Future-Proof**: Novos standards podem ser mapeados via OWL

**Evidência:**
> "Standards-aligned semantic model integrando ISA-95/88, ISO 10303, OPC UA NodeSets, GS1, ISO 19011, Dublin Core" (Manufacturing Ontology.md)

### 2.3 Schema Evolution & Versioning

**Problema com JSON Schema Apenas:**
```json
// v1.0
{"assetType": "Machine"}

// v2.0 (breaking change)
{"equipmentCategory": "Machine"}  // ❌ Clientes v1.0 quebram
```

**Solução com OWL Deprecation:**
```turtle
# v1.3: Deprecate assetType, add equipmentCategory
avm:assetType a owl:DatatypeProperty ;
    avm:deprecatedOn "2026-01-15" ;
    avm:supersededBy avm:equipmentCategory .

avm:equipmentCategory a owl:DatatypeProperty ;
    rdfs:subPropertyOf avm:assetType .  # Backward compatible
```

**Benefícios:**
- **Graceful Deprecation**: Clientes têm 2 minor versions para migrar
- **Automated Migration**: Scripts podem ler `supersededBy` e auto-converter
- **Semantic Versioning**: MAJOR.MINOR.PATCH com regras claras

**Evidência:**
> "Semantic versioning (MAJOR.MINOR.PATCH) com deprecation windows de 2 minor versions" (Manufacturing Ontology.md)

### 2.4 Entity Resolution & Canonical IDs

**Problema: Mesma Entidade, Múltiplos Nomes**
- ERP: "Line 3"
- SCADA: "Line Three"
- OPC UA: NodeId ns=2;s=L3_PLC
- Operator: "linha 3" (português, lowercase)

**Sem Ontologia:**
```python
# Hard-coded mappings (não escala)
if mention in ["Line 3", "Line Three", "L3"]:
    return "line_3"
```

**Com Ontologia + Embeddings:**
```python
# 3-stage cascade (Epic 1 Sprint 5)
def resolve_entity(mention: str) -> tuple[URI, float]:
    # Stage 1: Exact match (owl:sameAs)
    exact = graph.query("""
        SELECT ?canonical WHERE {
            ?canonical owl:sameAs ?alias .
            ?alias rdfs:label ?mention .
            FILTER(?mention = "Line 3")
        }
    """)
    if exact: return exact[0], confidence=1.0

    # Stage 2: Fuzzy match (rdfs:label Levenshtein)
    candidates = graph.query("SELECT ?e, ?label WHERE {?e a :Asset}")
    fuzzy_scores = [(c, levenshtein(mention, c.label)) for c in candidates]
    best = max(fuzzy_scores, key=lambda x: x[1])
    if best[1] > 0.85: return best[0], confidence=best[1]

    # Stage 3: Embeddings (semantic similarity)
    mention_emb = embed_model.encode(mention)
    sims = cosine_similarity([mention_emb], asset_embeddings)
    if sims[best_idx] > 0.85: return assets[best_idx], confidence=sims[best_idx]

    return None, 0.0  # Failed resolution
```

**Benefícios:**
- **F1 ≥ 0.92 Target**: Quality gate para entity resolution (Epic 1 Sprint 5)
- **Canonical URIs**: `kg://accel/isa95/Asset:LINE-003@v1` (único, versionado, dereferenceable)
- **Multi-Lingual**: Embeddings capturam "Line 3" = "linha 3" semanticamente

**Evidência:**
> "Entity Resolution: 3-stage cascade (exact → fuzzy → embeddings), F1 ≥ 0.92 REQUIRED" (CLAUDE.md, Epic 1 Sprint 5)

---

## 3. Neo4j (Property Graph) vs RDF Triple Store

### 3.1 Por Que Neo4j Foi Escolhido

**Decision Rationale (Manufacturing Ontology.md):**

| Critério | Neo4j (Property Graph) | RDF Triple Store (GraphDB, Stardog) |
|----------|------------------------|-------------------------------------|
| **Performance** | ✅ Cypher traversal faster (índices nativos) | ⚠️ SPARQL mais lento para deep traversals |
| **Team Familiarity** | ✅ Eng team já usa Neo4j | ❌ Learning curve alta (SPARQL, OWL reasoners) |
| **Tooling** | ✅ Neo4j Browser, Bloom, dashboards | ⚠️ Tooling menos mature |
| **Expressividade** | ✅ Cypher legível (`MATCH (a)-[:REL]->(b)`) | ⚠️ SPARQL verbose |
| **Reasoning** | ❌ Sem inferência OWL nativa | ✅ Reasoners (HermiT, Pellet) built-in |
| **Interoperability** | ⚠️ Precisa export manual para RDF | ✅ RDF nativo (W3C standards) |

**Escolha: Neo4j + RDF Export**
- **Primary store**: Neo4j (performance, team velocity)
- **Export capability**: RDF/Turtle para interoperability quando necessário
- **Pragmatic over pure**: "Pragmatic over pure" é design principle (#4)

**Trade-off Aceito:**
- ❌ Perde reasoning automático OWL (mas ganha via SHACL + custom validators)
- ✅ Ganha performance 10-100x em graph traversal
- ✅ Reduz time-to-market (team já conhece Neo4j)

**Evidência:**
> "Escolheu Neo4j (property graph) como primary store. RDF/Turtle mantido para export/interoperability. Razão: Neo4j performance para graph traversal + equipe já familiar + Cypher expressividade" (Manufacturing Ontology.md)

### 3.2 Hybrid Approach: Best of Both Worlds

**Representação Multi-Formato:**
```
┌─────────────────────────────────────────┐
│ Neo4j (Primary Store)                   │
│ - Production queries (Cypher)           │
│ - Real-time graph traversal             │
│ - AVA multi-agent query execution       │
└─────────────┬───────────────────────────┘
              │ Export
              ↓
┌─────────────────────────────────────────┐
│ RDF/Turtle (Interoperability)           │
│ - Client integration                    │
│ - Standards compliance validation       │
│ - Semantic reasoning (offline)          │
└─────────────────────────────────────────┘
```

**Benefícios:**
- **Performance**: Queries produção usam Neo4j (rápido)
- **Compliance**: Audits/validations exportam RDF e rodam SPARQL compliance checks
- **Integration**: Clientes podem importar RDF exports para seus sistemas

**Evidência:**
> "RDF/OWL + Turtle: Para reasoning semântico e interoperabilidade. JSON-LD: Context publicado. Neo4j Cypher DDL: Property graph constraints e indexes" (Manufacturing Ontology.md)

---

## 4. Benefícios Específicos para Multi-Agent System (AVA)

### 4.1 Query Planning via Graph Structure

**Problema sem Graph:**
```python
# Text-based RAG: LLM precisa "adivinhar" sequência
query = "Why did Line 3 stop?"
# LLM: "Hmm, maybe check logs? Or sensors? Or maintenance?"
# Não há estrutura para guiar reasoning
```

**Solução com Graph:**
```cypher
// Planner Agent sabe a estrutura da ontologia
MATCH path = (asset:Asset {name: "Line 3"})
             -[:GENERATES_EVENT]->(event:Event {type: "Downtime"})
             -[:CAUSED_BY]->(cause)
RETURN path
// Planner pode executar sub-queries guiadas pela ontologia
```

**Benefícios:**
- **Deterministic Plans**: Plan DSL valida que queries são válidas ANTES de executar
- **No Hallucination**: LLM não pode inventar relacionamentos que não existem no schema
- **Multi-Hop Automatic**: Grafo expõe relacionamentos, planner segue edges

**Evidência:**
> "Query planner uses graph structure para federated queries. Plan DSL design - should it mirror ontology relationships?" (Manufacturing Ontology.md, Research Questions)

### 4.2 Agent Specialization via Domain Subgraphs

**Federated Architecture:**
```
┌──────────────────────────────────────────────────────┐
│ AVA Orchestrator                                     │
│ (Routes queries to specialist agents)                │
└────┬──────────┬──────────┬───────────┬──────────────┘
     │          │          │           │
     ↓          ↓          ↓           ↓
┌─────────┐ ┌────────┐ ┌────────┐ ┌──────────┐
│Operations│ │Quality │ │Sensor  │ │Knowledge │
│Agent    │ │Agent   │ │Agent   │ │Agent     │
│         │ │        │ │        │ │          │
│(ISA-95) │ │(ISO    │ │(OPC UA)│ │(Cross-   │
│         │ │19011)  │ │        │ │domain)   │
└────┬────┘ └───┬────┘ └───┬────┘ └────┬─────┘
     │          │          │           │
     ↓          ↓          ↓           ↓
┌────────────────────────────────────────────┐
│ Neo4j Knowledge Graph                      │
│ (Unified ontology, domain-specific views)  │
└────────────────────────────────────────────┘
```

**Benefícios:**
- **Domain Views**: Operations Agent só vê ISA-95 subgraph (Asset, WorkUnit, Event)
- **Isolation**: Quality Agent failure não afeta Sensor Agent (blast radius control)
- **Performance**: Cada agent query otimizado para seu subgraph (índices específicos)

**Evidência:**
> "Each domain agent (Operations, Quality, Sensors, Knowledge) owns its data model, prompts, and evaluation. Agents query Neo4j knowledge graph using Graph-RAG pattern" (CLAUDE.md)

### 4.3 Citation Traceability (kg:// URIs)

**Problema com Text-RAG:**
```
User: "Why did Line 3 stop?"
AVA: "Due to motor overheating [citation needed]"
User: "Where is the evidence?"
AVA: "Uh... it was in the logs somewhere?" ❌ Não rastreável
```

**Solução com Graph URIs:**
```
User: "Why did Line 3 stop?"
AVA: "Line 3 downtime (Event:E789) was caused by motor overheating (Alarm:A123).
      Maintenance records show PM was overdue (MaintenancePlan:MP456)."

# Citations são URIs dereferenceable:
kg://accel/isa95/Event:E789@v1
kg://accel/opcua/Alarm:A123@v1
kg://accel/maintenance/Plan:MP456@v1
```

**Benefícios:**
- **100% Citation Rate**: Quality gate - todas respostas devem ter citations
- **Verifiable**: Clicking citation mostra node exato no graph (UI integration)
- **Audit Trail**: Compliance pode validar que AVA usou dados corretos

**Evidência:**
> "Citations are mandatory (kg:// URI scheme) to prevent hallucination. 100% of answers provided to users include inline citations referencing the source graph nodes" (CLAUDE.md, Multi Agent System v2.md)

---

## 5. Manufacturing-Specific Justifications

### 5.1 Safety-Critical Requirements

**Por Que Precisão Estrutural Importa:**

Manufacturing ≠ Tech Startup:
- **Safety**: Decisões erradas → equipment damage, production downtime, worker injury
- **Compliance**: ISO 27001, GDPR não são opcionais
- **Quality Gates**: 99.5%+ accuracy (5-sigma standard)

**Graph DB + Ontologia = Safety:**
```python
# Reasoner valida ANTES de executar ação
action = {"type": "restart_machine", "asset": "Line 3"}

# Validation via SHACL
violations = reasoner.validate(action, ontology)
if violations:
    # Ex: "Asset Line 3 has active GuardingViolation (Safety:SV123)"
    raise SafetyException("Cannot restart - safety violation active")
```

**Benefícios:**
- **Pre-execution Validation**: Ontology constraints bloqueiam ações unsafe
- **Audit Trail**: Graph registra WHO authorized WHAT action on WHICH asset at WHEN
- **Compliance Provability**: Auditor pode query graph para provar compliance

**Evidência:**
> "Manufacturing context = safety-critical, lower error margin (99.5%+ accuracy requirements). All 10 agents necessary from day 1 (compliance/safety non-negotiable)" (Thread 3 response draft, manufacturing context section)

### 5.2 Root Cause Analysis (Multi-Hop Dependency Tracking)

**Caso de Uso Real:**
> "Downtime na Linha 3 - foi falha mecânica ou problema de qualidade?"

**Graph-Enabled RCA:**
```cypher
// Multi-hop query crossing 4 domains
MATCH (asset:Asset {name: "Line 3"})
      -[:GENERATES_EVENT]->(downtime:Event {type: "Downtime"})

// Path 1: Sensor data
OPTIONAL MATCH (downtime)-[:DETECTED_BY]->(alarm:Alarm)
                         -[:FROM_SENSOR]->(sensor:Sensor)

// Path 2: Quality audit
OPTIONAL MATCH (asset)<-[:AUDITED_ASSET]-(audit:AuditFinding)
WHERE audit.date < downtime.startedAt

// Path 3: Maintenance history
OPTIONAL MATCH (asset)-[:HAS_PLAN]->(plan:MaintenancePlan)
WHERE plan.status = "overdue"

RETURN downtime, alarm, audit, plan
```

**Output:**
```
Downtime E789:
├─ Alarm A123 (Motor vibration anomaly) ← SENSOR domain
├─ Audit A456 (PM overdue 30 days) ← QUALITY domain
└─ MaintenancePlan MP456 (overdue) ← MAINTENANCE domain

Root Cause: Likely mechanical (overdue PM + vibration), not quality defect.
```

**Benefícios:**
- **Cross-Domain RCA**: Um query atravessa 4 ontologies diferentes
- **Evidence-Based**: Cada conclusão tem citation (Alarm:A123, Audit:A456)
- **Human-Readable Path**: Graph visualizável (Neo4j Bloom)

### 5.3 Regulatory Compliance & Auditability

**Compliance Standards:**
- **ISO 27001**: Information security (data provenance, access control)
- **GDPR**: Data privacy (right to explanation, data lineage)
- **ISO 19011**: Audit management (traceability of audit findings)

**Graph DB = Compliance Built-In:**
```cypher
// GDPR Right to Explanation
MATCH (user:Person {id: "U123"})-[:MADE_QUERY]->(query:Query)
      -[:EXECUTED_PLAN]->(plan:Plan)
      -[:RETRIEVED_DATA]->(data:Asset|Event|Stream)
RETURN user, query, plan, data
// Shows EXACTLY what data was accessed for each query
```

**Benefícios:**
- **Audit Trail**: Every query, every agent action recorded as graph nodes
- **Provenance**: Can trace WHY decision was made (which nodes were accessed)
- **GDPR Compliance**: Can show user EXACTLY what data was used in recommendation

**Evidência:**
> "Governance & Compliance Layer: ISO 27001, GDPR compliance (non-optional). Audit trail for all agent actions" (OpenPipe_ART.md via Thread 3)

---

## 6. Alternatives Considered & Why Rejected

### 6.1 Alternative 1: Pure Semantic Web Stack (RDF-First)

**Proposta:**
- Primary store: GraphDB ou Stardog (RDF triple store)
- All queries via SPARQL
- Full OWL reasoning

**Por Que Rejeitado:**
- ❌ **Learning Curve**: Eng team precisaria aprender SPARQL, OWL, reasoners
- ❌ **Performance**: SPARQL materially slower para production-scale graph traversal
- ❌ **Tooling**: Dashboards, visualization tools menos mature
- ❌ **Time-to-Market**: Delay de 3-6 meses para team ramp-up

**Trade-off:**
- ✅ Ganha velocity (team já conhece Neo4j)
- ❌ Perde reasoning automático (mas compensa com SHACL + custom validators)

**Evidência:**
> "Pure semantic web stack (RDF-first): Rejected porque: Eng team learning curve alta, performance concerns para production scale, tooling menos mature" (Manufacturing Ontology.md, Alternatives Considered)

### 6.2 Alternative 2: No Ontology, Just JSON Schemas

**Proposta:**
- Usar apenas JSON Schemas para validação
- Graph DB sem semântica formal (nodes/edges ad-hoc)
- No OWL, no RDF

**Por Que Rejeitado:**
- ❌ **Zero Reasoning**: Schemas validam sintaxe, não semântica
  - Exemplo: JSON Schema não pode validar "Asset offline → Stream must be inactive"
- ❌ **No Interoperability**: Clientes não podem integrar (sem RDF export)
- ❌ **No Standards Alignment**: Impossível provar compliance com ISA-95, ISO 19011

**Evidência:**
> "No ontology, just JSON schemas: Rejected porque: Sem semântica = sem reasoning. AVA multi-agent system precisa de graph structure para federated queries. Schemas sozinhos não dão relationships" (Manufacturing Ontology.md, Alternatives Considered)

### 6.3 Alternative 3: Wait for Industry Standard Ontology

**Proposta:**
- Adopt MIMOSA CCOM (Condition-based Maintenance Ontology)
- Or wait for IEC 62264 (ISA-95) ontology formalization

**Por Que Rejeitado:**
- ❌ **Scope Mismatch**: MIMOSA foca em CBM, não cobre vision AI, compliance, agentic workflows
- ❌ **Timeline**: Standards bodies levam anos; AccelVeo precisa Q4'25
- ❌ **Customization**: Standards genéricos, manufacturing clients precisam extensions

**Mitigation:**
- ✅ Align com ISA-95/88 principles (broadly accepted)
- ✅ Extensible design (core + domain extensions)
- ✅ RDF export permite future standards mapping

**Evidência:**
> "Wait for industry standard ontology (ex: adopt MIMOSA CCOM): Rejected porque: MIMOSA foca em Condition Monitoring, não cobre vision AI, compliance, agentic workflows. Timing incompatível (precisa Q4'25)" (Manufacturing Ontology.md, Alternatives Considered)

---

## 7. Success Metrics & Quality Gates

### 7.1 Entity Resolution Quality

**Metric:** F1 Score ≥ 0.92
**Test Set:** 100+ entity mentions (cross-domain)
**Method:** 3-stage cascade (exact → fuzzy → embeddings)

**Why Critical:**
- Manufacturing tem **zero tolerance** para entity confusion
- "Line 3" vs "Line 4" misidentification → wrong maintenance action → downtime

**Gate:** Epic 1 Sprint 5 - blocks cross-ontology queries until F1 ≥ 0.92

### 7.2 Citation Accuracy

**Metric:** 0% Broken Citation Rate
**Test:** Click all citations in 100 sample answers, verify they resolve

**Why Critical:**
- Broken citations destroy user trust
- Compliance audits require verifiable sources

**Gate:** Epic 4 - blocks production deployment

### 7.3 Multi-Hop Query Success

**Metric:** ≥85% Query Coverage Accuracy (Q1'26)
**Test Set:** 200+ ground-truth Q&A pairs
**Depth:** 2-hop (Q4'25), 3-4 hop (Q2'26)

**Why Critical:**
- Manufacturing RCA requires multi-hop reasoning
- Single-hop queries insufficient for complex diagnostics

**Gate:** Epic 1 - validates Graph-RAG planner effectiveness

### 7.4 Ontology Fit Rate

**Metric:** ≥90% Pilot Entity Fit (without custom code)
**Pilot:** 2 manufacturing plants
**Validation:** JSON Schema validation pass rate

**Why Critical:**
- If ontology doesn't fit real data, entire architecture fails
- Custom code for each plant = not scalable

**Gate:** M1 (Nov '25) - blocks v1.0 freeze (Dec '25)

---

## 8. Risks & Mitigations

### 8.1 Risk: Ontology Freeze Delays → Blocks Q1'26

**Impact:** HIGH - Everything depends on ontology
**Mitigation:**
- v0.9 draft em Nov '25 (2-plant pilot BEFORE freeze)
- Gate: ≥90% entity fit without custom code
- Stakeholder review (Eng + CS + Select Customers)

### 8.2 Risk: Standards Alignment Complexity

**Impact:** MEDIUM - 7 standards hard to align perfectly
**Mitigation:**
- "Pragmatic over pure" - subset relevante, não 100% compliance
- Focus: ISA-95 Level 0-3 (não Level 4 ERP completo)
- Validation: Eng + CS sign-off on usability

### 8.3 Risk: Schema Evolution Breaks Integrations

**Impact:** MEDIUM - Clients break on updates
**Mitigation:**
- Semantic versioning (MAJOR.MINOR.PATCH)
- 2-minor-version deprecation window
- Auto-validators em ForgeCleanRoom detectam schema drift

### 8.4 Risk: Neo4j Performance at Scale (1M+ nodes)

**Impact:** MEDIUM - Production scale unknown
**Mitigation:**
- Índices críticos: `Asset.id`, `Event.startedAt`, `Stream.protocol`
- Partitioning por Site/Zone se necessário
- Load testing during Epic 4 integration

---

## 9. Research Questions (Open)

### 9.1 Ontology Alignment Validation

**Question:** How to programmatically validate alignment com ISA-95/88?
**Approach:** SPARQL queries que checam coverage de classes/properties ISA-95
**Expected Output:** Compliance report (% coverage, gaps)

### 9.2 Entity Resolution Threshold Tuning

**Question:** What's optimal fuzzy match threshold? (Currently 85%)
**Approach:** ROC curve analysis on gold dataset
**Expected Output:** Threshold recommendation (precision/recall trade-off)

### 9.3 Schema Evolution Impact Analysis

**Question:** Given schema change, predict blast radius?
**Approach:** SHACL diff + dependency graph analysis
**Expected Output:** Compatibility report (breaking vs non-breaking changes)

### 9.4 RAGAS Integration with Ontology

**Question:** Can ontology auto-generate gold Q&A sets for evaluation?
**Approach:** Walk graph, generate questions from structure
**Example:** "What sensors does Asset X have?" → [list from `Asset-[:HAS_SENSOR]->Sensor`]
**Expected Output:** 1000+ synthetic Q&A pairs for Epic 3 training

### 9.5 Plan DSL ↔ Ontology Relationship Design

**Question:** Should Plan DSL mirror ontology relationships exactly?
**Trade-off:**
- **Tight coupling**: DSL changes when ontology changes (consistency)
- **Loose coupling**: DSL abstract, ontology can evolve (flexibility)
**Expected Decision:** Likely tight coupling for v1.0 (simplicity), loosen in v2.0

---

## 10. Conclusão: Por Que Esta Arquitetura?

### 10.1 Resumo dos Benefícios

| Benefício | Graph DB | Ontologia Formal | Combined Power |
|-----------|----------|------------------|----------------|
| **Performance** | ✅ O(n) traversal | | ✅ Fast + Semantic |
| **Reasoning** | | ✅ OWL/SHACL inference | ✅ Validation automática |
| **Multi-Hop** | ✅ Native graph queries | ✅ Structure guidance | ✅ Complex RCA |
| **Citation** | ✅ Node URIs | ✅ Canonical IDs | ✅ 100% traceability |
| **Interop** | | ✅ RDF export | ✅ Standards compliance |
| **Safety** | | ✅ Constraint validation | ✅ Pre-execution checks |
| **Scalability** | ✅ Partitioning | ✅ Modular extensions | ✅ Multi-tenant |

### 10.2 Por Que Não Alternativas Simples?

**Text-RAG (embeddings apenas):**
- ❌ Perde estrutura (relationships implícitas)
- ❌ Citation accuracy baixa
- ❌ Multi-hop reasoning difícil

**RDBMS (PostgreSQL + foreign keys):**
- ❌ Multi-hop queries = múltiplos JOINs lentos
- ❌ Schema evolution complexa (migrations)
- ❌ Relacionamentos não são first-class

**NoSQL (MongoDB, etc.):**
- ❌ Zero reasoning (apenas validação sintática)
- ❌ Queries cross-domain ad-hoc (sem estrutura)
- ❌ Zero interoperability (formatos proprietários)

### 10.3 Manufacturing Context é Decisivo

Se AccelVeo fosse **tech startup** (e-commerce, social media):
- **Poderia** usar text-RAG (tolerância a erro maior)
- **Poderia** usar RDBMS (relationships menos complexas)
- **Poderia** iterar sem ontologia formal (compliance opcional)

Mas AccelVeo é **manufacturing**:
- ✅ Safety-critical (99.5%+ accuracy REQUIRED)
- ✅ Compliance mandatory (ISO 27001, GDPR, ISO 19011)
- ✅ Multi-domain integration (ISA-95, OPC UA, GS1, etc.)
- ✅ Root cause analysis (4+ hop queries rotina)
- ✅ Audit trail (every decision traceable)

**Logo: Graph DB + Ontologia Formal não é over-engineering, é REQUISITO.**

---

## 11. Insights do Slack: Team Discussions

### 11.1 Reasoner Selection (accelveo-research)

**Discussão Errol → Furkan (Nov 5, 2025):**
> "I've created a doc for us to investigate Reasoners related to our ontology. **HermiT and Pellet** seems like the best fit but added two others to consider as well plus benchmarks."

**Context:**
- Team está avaliando reasoners OWL para ontology validation
- **HermiT**: Fast tableau reasoner (OWL 2 DL compliant)
- **Pellet**: Incremental reasoner (good for dynamic graphs)

**Implicação para KG:**
- Reasoners são **críticos** para validation automática
- Escolha entre HermiT (speed) vs Pellet (incremental updates)
- Benchmarks necessários antes de production deployment

**Evidência que ontologia formal está sendo priorizada** - não é apenas design teórico, time está implementando reasoners.

---

### 11.2 Causal AI + Knowledge Graphs (accelveo-research)

**Discussão Furkan (Oct 28, 2025):**
> "Causal structure-based root cause analysis: don't just find the anomaly — ask 'why did it happen?' by **tracing the causal graph** and inverting causal mechanisms."

**Integration DoWhy + Knowledge Graph:**
```python
# Causal DAG para RCA
# DAG nodes = ontology entities (Asset, Sensor, Event)
# DAG edges = causal relationships (not just correlations)

dag = """
Sensor_Vibration -> Machine_Health -> Downtime_Event
MaintenancePlan_Overdue -> Machine_Health
Quality_Audit_Finding -> MaintenancePlan_Overdue
"""

# DoWhy usa DAG para counterfactual reasoning
model = dowhy.CausalModel(data, graph=dag)
identified_estimand = model.identify_effect()
estimate = model.estimate_effect(identified_estimand)

# Output: "Downtime causado 60% por PM overdue, 40% por vibration"
```

**Por Que Graph é Critical Aqui:**
- **Causal DAG ≠ Correlation Matrix**: Graph structure encodes causality, not just associations
- **DoWhy precisa de graph structure**: Sem grafo, DoWhy não consegue fazer counterfactual reasoning
- **Ontology provides DAG structure**: ISA-95 relationships são causal (Asset HAS Sensor EMITS Event)

**Evidência:**
> "Today: DoWhy covers functional causal models for identifying root causes in **known graphs**. LLMs can assist in formulating, verifying, and critiquing causal assumptions — even for token causality like event attribution."

---

### 11.3 Orchestration as Data, Not Code (accelveo-research)

**Post LinkedIn compartilhado por Errol (Nov 1, 2025):**
> "The orchestration challenge: agents must reliably discover, select, and **sequence** complex multi-step operations. **Structured knowledge is critical** in bridging the orchestration gap. **Orchestration as Data, Not Code**."

**Relevância para Knowledge Graph:**
```
┌─────────────────────────────────────────────┐
│ Traditional Approach (Code)                 │
│ if query.contains("downtime"):              │
│     call operations_agent()                 │
│     if result.needs_rca:                    │
│         call quality_agent()                │
│         call sensor_agent()                 │
└─────────────────────────────────────────────┘
❌ Hard-coded sequencing
❌ Não escala (cada novo domain = novo código)
❌ Não é auditável (lógica escondida em código)

┌─────────────────────────────────────────────┐
│ Orchestration as Data (Graph)               │
│ MATCH (query)-[:REQUIRES]->(domain:Domain)  │
│       (domain)-[:HAS_AGENT]->(agent:Agent)  │
│       (agent)-[:DEPENDS_ON]->(dep:Agent)    │
│ RETURN agent, dep ORDER BY dependency_depth │
└─────────────────────────────────────────────┘
✅ Declarative sequencing (graph structure)
✅ Escala (novos domains = novos nodes/edges)
✅ Auditável (query graph = execution trace)
```

**Implicação:**
- **Graph structure IS orchestration logic**
- Multi-agent sequencing guiado por ontology relationships
- Agent dependencies modelados como graph edges

**Por Que Isso Requer Knowledge Graph:**
- Code-based orchestration não é transparente (black box)
- Graph-based orchestration = data-driven + auditável
- Mudanças em orchestration = graph updates (não code deploy)

---

### 11.4 Synthetic Data via Knowledge Graph (accelveo-development)

**Discussão Reha (Dec, 2024):**
> "Synthetic Data Generator uses a **central knowledge graph** of factory operations, and using specialized models, automatically generates new contextually accurate knowledge documents like SOPs and manuals."

**Architecture:**
```
┌─────────────────────────────────────────────┐
│ Knowledge Graph (Factory Ontology)          │
│ - Assets, Sensors, Procedures, WorkUnits    │
│ - Relationships: HAS, EXECUTES, MONITORS    │
└────────────┬────────────────────────────────┘
             │ Queries graph structure
             ↓
┌─────────────────────────────────────────────┐
│ Synthetic Data Generator                    │
│ - Reads graph → generates SOPs              │
│ - Example: Asset "Line 3" HAS Sensor "S123" │
│   → Generate SOP: "Calibration for S123"    │
└─────────────────────────────────────────────┘
```

**Por Que Graph é Necessário:**
- **Contextual Accuracy**: SOPs precisam refletir real factory structure
- **Consistency**: Generated docs devem alinhar com ontology (não inventar assets)
- **Training Data for Epic 3**: Synthetic Q&A pairs gerados a partir de graph structure

**Benefício:**
- **Automated Training Data**: 1000+ synthetic examples sem manual curation
- **Ground Truth Guarantee**: Dados gerados respeitam ontology constraints
- **Scalability**: Adicionar novo Asset → auto-generate SOPs

**Evidência que KG não é só query - também é data generation engine.**

---

### 11.5 RAG + Knowledge Graph Integration (accelveo-development)

**Discussão sobre RAG evolution (Oct-Nov 2024):**

**Fase 1 (implementada):**
```python
# Text-based RAG
user_query = "What caused Line 3 downtime?"
embedded_query = embed(user_query)
similar_chunks = vector_db.search(embedded_query, k=5)
answer = llm.generate(query + similar_chunks)
```

**Fase 2 (planejada - Graph-RAG):**
```python
# Knowledge Graph RAG
user_query = "What caused Line 3 downtime?"

# Step 1: Entity resolution
entity = resolve("Line 3") → kg://accel/isa95/Asset:LINE-003@v1

# Step 2: Graph query
cypher = """
MATCH (asset:Asset {id: 'LINE-003'})
      -[:GENERATES_EVENT]->(event:Event {type: 'Downtime'})
      -[:CAUSED_BY]->(cause)
RETURN event, cause, cause.description
"""
graph_results = neo4j.query(cypher)

# Step 3: LLM synthesis with citations
answer = llm.generate(
    query=user_query,
    context=graph_results,
    citations=[r.uri for r in graph_results]
)
```

**Por Que Upgrade para Graph-RAG:**
- **Precision**: Graph query retorna EXACT relationships, não chunks similares
- **Citations**: URIs específicos (Event:E789), não chunk IDs genéricos
- **Multi-Hop**: Text-RAG não consegue fazer 4-hop reasoning nativo

**Evidência:**
> "RAG system enhanced context-aware evaluations. Multi-provider LLM support. Complete test suite with unit and integration tests." (accelveo-development chat)

Team está migrando de text-RAG → Graph-RAG para melhorar precision + citations.

---

### 11.6 Label Studio para Ontology Refinement (accelveo-development)

**Discussão sobre Label Studio integration:**
> "Expert-validated data is automatically **fed back into our system** to retrain and improve the generator. **Structured Feedback**: Expert knowledge is captured as **structured, machine-readable data** (e.g., a corrected entity label)."

**Workflow:**
```
1. Synthetic data generator creates SOP via knowledge graph
2. Expert reviews SOP in Label Studio
3. Expert corrections: "Asset X123 should be 'Welding Robot', not 'Assembly Robot'"
4. Correction updates ONTOLOGY (not just training data)
5. Future synthetic data uses corrected ontology
```

**Por Que Ontology é Critical:**
```
❌ Without Ontology:
- Expert corrections go to training data only
- Next synthetic generation may repeat same error
- No single source of truth

✅ With Ontology:
- Expert corrections update ontology schema
- All downstream systems (RAG, synthetic gen, agents) use updated ontology
- Single source of truth (ontology) ensures consistency
```

**Implicação:**
- **Ontology = Living Schema**: Updated via expert feedback loop
- **Not Static**: Ontology evolves based on domain expert corrections
- **Quality Gate**: Label Studio enforces ontology compliance

---

## 12. Conclusão dos Slack Insights

### 12.1 Team Consensus

**Evidence que Knowledge Graph + Ontology é prioridade:**

1. **Errol criou doc para Reasoners** (HermiT, Pellet) - implementação ativa, não teoria
2. **Furkan integrou DoWhy + Causal Graphs** - RCA requer graph structure
3. **Reha building Synthetic Data via KG** - ontology-driven data generation
4. **Label Studio feedback loop** - ontology refinement via expert validation
5. **RAG evolution: text → Graph-RAG** - team reconhece limitações text-based

### 12.2 Argumentos Únicos do Slack (não cobertos em docs)

**Argumento 7: Causal AI Requires Graph Structure**
- DoWhy counterfactual reasoning precisa de DAG
- Ontology relationships = causal edges (não apenas associações)
- **Evidência**: "DoWhy covers functional causal models for identifying root causes in known graphs"

**Argumento 8: Orchestration as Data (Not Code)**
- Multi-agent sequencing guiado por graph structure
- Agent dependencies = graph edges (declarative, auditável)
- **Evidência**: "Structured knowledge is critical in bridging the orchestration gap"

**Argumento 9: Synthetic Data Generation via Graph**
- Training data gerado a partir de ontology structure
- Garante contextual accuracy + consistency
- **Evidência**: "Synthetic Data Generator uses central knowledge graph of factory operations"

**Argumento 10: Living Ontology (Expert Feedback Loop)**
- Label Studio corrections update ontology (não apenas training data)
- Ontology evolui via domain expert validation
- Single source of truth para todos os sistemas downstream

---

**Standards Citados:**
- ISA-95/88 (ANSI/ISA-95.00.01-2010)
- ISO 10303 (STEP - Standard for Exchange of Product model data)
- OPC UA (IEC 62541)
- GS1 General Specifications
- ISO 19011:2018 (Guidelines for auditing management systems)
- W3C OWL 2, RDF 1.1, SHACL

**Research Papers:**
- "What is Graph-RAG?" (Ontotext.com)
- "Elysia: Agentic RAG Framework" (Weaviate.io)
- SOSA/SSN Ontology (W3C)
- "Causal structure based root cause analysis of outliers" (ICML 2022)
- "Causal Reasoning and Large Language Models" (arXiv 2024)

**Tools & Frameworks:**
- HermiT Reasoner (OWL 2 DL)
- Pellet Reasoner (Incremental reasoning)
- DoWhy (Causal inference library, Microsoft Research)
- Label Studio (Data annotation platform)
