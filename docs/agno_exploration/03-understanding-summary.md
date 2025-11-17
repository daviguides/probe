# Sumário do Entendimento - Necessidade de Pesquisa Agno

**Data**: 2025-01-13

---

## Contexto Organizacional

### Stakeholders e Papéis

**David Ting (Global CTO)**
- Expectativa: Ver "inteligência na interface"
- Abordagem: Entregas incrementais funcionais (não soluções perfeitas)
- Performance: Crítica - impaciente com frameworks lentos
- Exemplo: Criticou Django, preferência por FastAPI

**Nishal (Manager dos times)**
- Alinhamento: Abordagem lean, entregas rápidas
- Tecnologia: Uso massivo de AI assistants
- Decisões: Cortar tecnologias que não justifiquem valor técnico
- Postura: Se LangGraph não provar valor → cortar

**Davi (Architecture/Research Oversight)**
- Papel: Facilitar e orientar arquiteturalmente (NÃO micromanagement)
- Responsabilidade: Arquitetura de sucesso em conjunto com Ricardo
- Abordagem: Streamlining do processo, não policiamento
- Ferramentas: Code review automatizado (não manual detalhado)

**Ricardo (Engenheiro Implementador)**
- Situação: Inicialmente resistente a "supervisão"
- Alinhamento: Esclarecido com Nishal sobre papéis
- Posição técnica: Concordou que LangGraph provavelmente é overhead
- Atividade: Revisando Agno como possível alternativa

---

## Situação Atual do Projeto AVA

### Mudança de Abordagem

**Documentação Original** (viés acadêmico):
- Sistema completo desde início
- LangGraph + OpenPipe ART
- 10 agentes especializados (AVA, Planner, Reasoner, SOP Generator, Maintenance, Compliance, Data, Aggregator, Context Manager, Evaluator)
- Orquestração complexa com graphs/DAGs
- Integração ontológica total

**Nova Abordagem** (lean, incremental):
- **Começar simples**: MVP funcional e demonstrável
- **Evoluir iterativamente**: Adicionar complexidade conforme necessário
- **Validar antes de expandir**: Não assumir necessidade de tecnologias complexas
- **Performance crítica**: Overhead de framework mínimo

### Tecnologia Questionada

**LangGraph**:
- Status: **Questionado** como overhead desnecessário
- Razão: AVA pode não precisar de orquestração graph/DAG complexa
- Posição de Ricardo + Davi: Provavelmente é overhead para caso de uso real
- Posição de Nishal: Se não justificar valor técnico → cortar

**Agno**:
- Status: **Em consideração** como middle-ground
- Propósito: **NÃO** orquestração pesada, mas:
  - Inicialização de agentes
  - Integração com modelos locais (vLLM, SGLang)
  - Ferramentas de observabilidade
- Orquestração: Via código (controle manual), não framework-driven

---

## Requisitos Técnicos Definidos

### Escopo Faseado

**Fase 1 (MVP Multi-Agent Básico)**:
- AVA (orquestrador principal)
- 2-3 sub-agentes especializados (ex: Maintenance, Compliance)
- Coordenação simples (if/else, ramificações condicionais)
- Demonstrável rapidamente

**Fase 2 (Sistema Multi-Agent Completo)**:
- Todos agentes especializados (Planner, Aggregator, Reasoner, etc)
- Coordenação avançada (possivelmente paralelismo, dependências)
- Integração com ontologia
- OpenPipe ART e observabilidade completa

### Constraints Técnicas

**Infraestrutura**:
- ✅ Modelos **self-hosted** (vLLM, SGLang, etc)
- ❌ **NÃO** APIs de terceiros (OpenAI, Anthropic)

**Orquestração**:
- ✅ Ramificações condicionais **básicas** (if/else)
- ❌ **NÃO** graphs/DAGs complexos (a menos que justificado)

**Performance**:
- ✅ **Overhead mínimo** de framework (crítico para CTO)
- ✅ Latência baixa (cada ms conta)

**Implementação**:
- ✅ **Rápida** (Ricardo + heavy uso de AI assistants)
- ✅ **Evolutiva** (MVP → iterações, não big bang)

---

## Necessidade da Pesquisa

### Objetivo Central

Avaliar se **Agno** faz sentido especificamente para o contexto AVA, considerando:
- Requisitos técnicos (self-hosted, overhead mínimo, coordenação simples)
- Constraints de entrega (rápida, incremental)
- Fases do projeto (MVP básico → sistema completo)

### Questões Críticas a Responder

**1. Fit Funcional**
- Agno simplifica inicialização de agentes vs código manual?
- Integra bem com modelos self-hosted (vLLM, SGLang)?
- Suporta coordenação simples sem forçar patterns complexos?

**2. Fit de Performance**
- Qual o overhead de framework do Agno?
- Impacto na latência é aceitável (mínimo)?
- Performance comparison vs vanilla Python?

**3. Fit de Implementação**
- Learning curve para Ricardo (com AI assistants)?
- Acelera desenvolvimento ou adiciona complexidade?
- Compatível com entrega incremental (Fase 1 → Fase 2)?

**4. Fit Evolutivo**
- Funciona bem para MVP simples (Fase 1)?
- Escala naturalmente para sistema completo (Fase 2)?
- Ou vira gargalo/limitação quando evoluir?

**5. Trade-offs**
- Benefícios: O que Agno traz que código vanilla não traz?
- Custos: Overhead, complexidade, lock-in, limitações?
- Vale a pena? (ROI para contexto específico)

### Resultado Esperado

**Decisão fundamentada** (Probe-standard) com uma das conclusões:

**A) Agno faz sentido**
- Justificativa clara de valor agregado
- Trade-offs explícitos (benefícios vs custos)
- Plano de adoção para Fase 1 e evolução para Fase 2

**B) Agno NÃO adiciona valor suficiente**
- Razões explícitas (overhead, complexidade, etc)
- Alternativas sugeridas:
  - Vanilla Python (controle total, zero overhead)
  - Framework alternativo (se houver melhor fit)
- Plano de implementação com alternativa escolhida

**C) Depende / Híbrido**
- Usar Agno para X (ex: inicialização, observabilidade)
- Usar código vanilla para Y (ex: orquestração)
- Justificativa de quando usar cada um

---

## Critérios de Avaliação

### Must-Have (Eliminatórios)

- ✅ Compatível com modelos **self-hosted**
- ✅ Overhead de framework **mínimo** (performance aceitável)
- ✅ Não força orquestração complexa (permite coordenação simples)
- ✅ Implementação **rápida** (learning curve aceitável)

### Nice-to-Have (Diferenciais)

- ⭐ Ferramentas de observabilidade built-in
- ⭐ Integração fácil com múltiplos backends (vLLM, SGLang, etc)
- ⭐ Suporte a evolução natural (MVP → sistema completo)
- ⭐ Comunidade ativa e documentação boa

### Red Flags (Rejeição)

- 🚫 Overhead significativo de framework (>10% latência adicional)
- 🚫 Força patterns complexos (graph/DAG quando não necessário)
- 🚫 Lock-in forte (dificulta migração futura)
- 🚫 Learning curve íngreme (Ricardo + AI assistants não conseguem acelerar)
- 🚫 Incompatível com modelos self-hosted

---

## Contexto de Decisão

### Pressões de Negócio

- David Ting quer ver "inteligência na interface" **rápido**
- AVA é oportunidade de demonstrar capacidade
- Entregas incrementais > solução perfeita
- Performance crítica (CTO impaciente com lentidão)

### Pressões Técnicas

- Stack original (LangGraph) questionado como overhead
- Necessidade de framework justificado tecnicamente (não hype)
- Simplicidade preferível quando suficiente
- Código > framework quando não há valor claro

### Pressões de Equipe

- Ricardo precisa de autonomia mas com guidance arquitetural
- Uso massivo de AI assistants para acelerar
- Alinhamento entre Davi (arquitetura) e Ricardo (implementação)
- Nishal como manager final, não "telephone game"

---

## Próximos Passos

1. **Pesquisa Probe sobre Agno**
   - Avaliar fit para contexto específico AVA
   - Responder questões críticas acima
   - Fornecer recomendação fundamentada

2. **Decisão de Framework** (pós-pesquisa)
   - Agno, vanilla Python, ou alternativa
   - Justificativa técnica clara

3. **Definição Final de MVP** (Fase 1)
   - Separar essencial vs desejável
   - Roadmap priorizado

4. **Início de Implementação** (Ricardo + Davi)
   - Arquitetura base
   - Primeiro agente funcional
   - Iterações rápidas

---

## Observações Importantes

**Sobre papéis**:
- Davi = oversight arquitetural, facilitação (NÃO supervisão micro)
- Ricardo = implementação com autonomia
- Nishal = management, decisões finais
- Alinhamento claro entre todos evita conflitos

**Sobre tecnologia**:
- Nenhuma tecnologia é sagrada (incluindo Agno, LangGraph)
- Justificativa técnica > hype ou "estado da arte"
- Simplicidade preferível quando suficiente
- Cortar quando não agregar valor

**Sobre entrega**:
- Incremental > big bang
- Demo-able a cada fase
- Performance não-negociável
- AI assistants para acelerar (não substituir pensamento crítico)

---

**Foco Imediato**: Conduzir pesquisa Probe sobre Agno para decisão fundamentada.
