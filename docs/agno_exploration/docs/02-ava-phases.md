# Fases do Projeto AVA

**Entendimento baseado em**: Conversas com Nishal, Ricardo, e diretrizes do CTO David Ting

---

## Fase 1: MVP Multi-Agent Básico

### Objetivo
Demonstrar "inteligência na interface" rapidamente com sistema funcional e evolutivo.

### Escopo Essencial

**Agentes core:**
- **AVA (Orquestrador Principal)**
  - Interface com usuário humano
  - Classificação de intents
  - Roteamento para sub-agentes
  - Síntese de respostas

- **2-3 Sub-Agentes Especializados** (priorizar por valor demonstrável):
  1. **Maintenance Agent**: Consultas sobre manutenção, planos, ações
  2. **Compliance Agent**: Validação de privacidade/segurança/audit
  3. *Possivelmente*: Data Agent (se necessário para queries básicas)

**Coordenação:**
- **Simples, via código** (if/else, ramificações condicionais)
- AVA classifica intent → roteia para agente específico → recebe resposta → formata para usuário
- SEM graph/DAG complexo
- SEM orquestração paralela sofisticada (sequencial é suficiente)

**Memória/Estado:**
- Conversacional básico (histórico da sessão)
- Possivelmente context manager simples (em memória ou Redis)

**Infraestrutura:**
- Modelos **self-hosted** (vLLM, SGLang, ou similar)
- Backend: FastAPI (não Django - performance)
- Framework de agentes: **TBD** (Agno vs vanilla Python vs alternativa)

### Critérios de Sucesso Fase 1
- ✅ Demonstrável para David Ting
- ✅ Responde queries conversacionais básicas
- ✅ Roteia corretamente para 2-3 domínios especializados
- ✅ Performance aceitável (framework overhead mínimo)
- ✅ Base sólida para evolução

### Não-Escopo Fase 1 (Desejável, mas pode esperar)
- ❌ Planner Agent sofisticado (decomposição complexa de tarefas)
- ❌ Aggregator Agent com resolução de conflitos
- ❌ SOP Generator automático
- ❌ Evaluator Agent e feedback loops
- ❌ OpenPipe ART integration
- ❌ Sistema de observabilidade completo (apenas logging básico)

---

## Fase 2: Sistema Multi-Agent Completo

### Objetivo
Evoluir MVP para sistema robusto com capacidades avançadas de raciocínio e coordenação.

### Expansão de Agentes

**Novos agentes especializados:**
- **Planner Agent**: Decomposição de queries complexas em sub-tarefas
- **Aggregator Agent**: Combina outputs de múltiplos agentes, resolve conflitos
- **Context Manager Agent**: Gerenciamento sofisticado de histórico e estado cross-session
- **SOP Generator Agent**: Identifica gaps na ontologia e gera perguntas
- **Reasoner Agent**: Validação semântica/lógica via ontologia
- **Data Agent** (se não presente em Fase 1): Ingestão e normalização de telemetria
- **Evaluator Agent**: Julga qualidade de raciocínio, depth, cost efficiency

**Agentes existentes (da Fase 1):**
- AVA, Maintenance Agent, Compliance Agent

### Coordenação Avançada

**Orquestração mais sofisticada:**
- Workflows com **paralelismo** (múltiplos agentes executando simultaneamente)
- **Dependências** entre tarefas (output de Agent A → input de Agent B)
- Possível uso de **patterns** (fan-out/fan-in, conditional branching avançado)

**Ainda evitar**:
- Graph/DAG se não necessário (avaliar se LangGraph faz sentido aqui)
- Complexidade desnecessária (manter código sobre framework quando possível)

### Integrações

**OpenPipe ART:**
- Prompt versioning
- Checkpointing de modelos
- RL loops para fine-tuning
- Cost optimization

**Observabilidade:**
- Langfuse ou similar para tracing
- Métricas de performance por agente
- Cost tracking

**Ontologia:**
- Integração com Digital-Twin Ontology v1.1.0
- Reasoner validando consistência semântica
- SOP Generator identificando gaps

### Memória e Estado

**Context Manager avançado:**
- Cross-session memory (persistência)
- User intent tracking ao longo do tempo
- Shared state entre agentes

**Vector DB (possivelmente):**
- RAG para documentação técnica
- Histórico de conversas indexado
- Knowledge base ontológica

### Critérios de Sucesso Fase 2
- ✅ Sistema completo funcional
- ✅ Raciocínio complexo (multi-step, multi-agent)
- ✅ Integração com ontologia e SOP generation
- ✅ Observabilidade e cost tracking
- ✅ Feedback loops para melhoria contínua

---

## Fase 3 (Possível): Produção Hardened + AI Continuous Improvement

### Objetivo
Sistema production-ready com auto-melhoria, governança, e escala.

### Capacidades Produção

**Reliability:**
- Error handling robusto (fallbacks, retries)
- Graceful degradation (se agente falha, sistema continua)
- Circuit breakers para modelos/serviços externos
- Health checks e auto-recovery

**Security & Governance:**
- Audit logging completo
- Privacy compliance (GDPR, ISO 27001)
- Role-based access control (RBAC)
- Data anonymization onde necessário

**Scalability:**
- Horizontal scaling de agentes (múltiplas instâncias)
- Load balancing
- Rate limiting
- Caching estratégico (se aplicável)

### AI Continuous Improvement

**Feedback Loop Automatizado:**
- Evaluator Agent julgando todas interações
- Outputs anotados (correctness, depth, cost)
- Dataset de treinamento crescendo continuamente

**Fine-Tuning Pipeline:**
- OpenPipe ART orchestrando retraining
- A/B testing de versões de modelo/prompt
- Rollback automático se performance degrada

**Human-in-the-Loop:**
- Anotação de edge cases por especialistas
- Validação de SOP gerados
- Review de decisões críticas

### Observabilidade Avançada

**Dashboards:**
- Performance por agente (latência, success rate)
- Cost breakdown (por agente, por query type)
- User satisfaction metrics

**Alerting:**
- Anomaly detection (degradação de performance)
- Cost spikes
- Error rate thresholds

### Critérios de Sucesso Fase 3
- ✅ Production-ready (99.9% uptime target)
- ✅ Auto-melhoria contínua via feedback loops
- ✅ Governança e compliance totais
- ✅ Escalável para múltiplos clientes/sites

---

## Estratégia de Evolução

### Princípios

1. **Incremental, não Big Bang**
   - Cada fase entrega valor funcional
   - Próxima fase evolui sobre anterior (não rewrite)

2. **Validação antes de expansão**
   - Fase 1 validada com stakeholders antes de Fase 2
   - Não adicionar complexidade prematuramente

3. **Cortar quando não justificar**
   - Se tecnologia (Agno, LangGraph, etc) não provar valor → cortar
   - Simplicidade > "estado da arte"

4. **Performance sempre crítica**
   - Framework overhead mínimo
   - Latência monitorada desde Fase 1

5. **Demo-able a cada passo**
   - Cada fase deve ser demonstrável para David Ting
   - "Inteligência na interface" visível desde MVP

### Timeline Aproximado (Estimativa Inicial)

- **Fase 1 (MVP)**: 2-4 semanas
  - Sprint 1: Arquitetura base + AVA core
  - Sprint 2: 2-3 sub-agentes + coordenação simples

- **Fase 2 (Completo)**: 6-10 semanas após Fase 1
  - Expansão gradual de agentes
  - Integração com ontologia e ART
  - Observabilidade

- **Fase 3 (Produção)**: 8-12 semanas após Fase 2
  - Hardening
  - Governança
  - Auto-melhoria

**Nota**: Timelines dependem de validação de cada fase e prioridades de negócio.

---

## Decisões Arquiteturais por Fase

### Fase 1
- **Framework de agentes**: Agno (se pesquisa justificar) ou vanilla Python
- **Orquestração**: Código (if/else, funções)
- **Memória**: Em memória ou Redis simples
- **Observabilidade**: Logging básico

### Fase 2
- **Orquestração**: Código avançado ou framework (se justificado)
- **Memória**: Context Manager + Vector DB
- **Observabilidade**: Langfuse/similar
- **Training**: OpenPipe ART integration

### Fase 3
- **Infra**: Kubernetes ou similar para escala
- **Observabilidade**: Full stack (Prometheus, Grafana, alerting)
- **Governança**: Audit trails, compliance automation

---

**Foco Imediato**: Definir arquitetura Fase 1 (pesquisa Agno, decisão de framework, MVP scope final).
