# Requisição: Pesquisa de Frameworks Alternativos

**Data**: 2025-01-13
**Contexto**: Após pesquisa Agno, mapear alternativas light-weight

---

## O Que Foi Solicitado

**Objetivo**: Landscape mapping de frameworks **light-weight** para multi-agent systems

**Categoria**: Agent Frameworks (Similar ao Agno em filosofia)

**NÃO incluir**:
- ❌ Python vanilla (já decidido para orquestração via código)
- ❌ Building blocks isolados (Instructor, LiteLLM - não são frameworks de agents)
- ❌ Frameworks pesados (LangGraph - já descartado)

---

## Frameworks a Investigar

### Agent Frameworks Light-Weight

1. **PydanticAI** (https://github.com/pydantic/pydantic-ai)
   - Pydantic team oficial
   - Type-safe agent framework
   - Python-native
   - **Concorrente direto mais relevante do Agno**

2. **Mirascope** (https://github.com/Mirascope/mirascope)
   - Python-native LLM framework
   - Type-safe, Pydantic-based
   - Agent abstraction leve

3. **Marvin** (https://github.com/PrefectHQ/marvin)
   - Prefect team (workflow company)
   - AI engineering framework
   - Python-native, async

4. **Outros se aplicáveis** (descobrir durante pesquisa)
   - Frameworks similares em filosofia
   - Light-weight, agent-focused
   - Python-native

---

## Critérios de Avaliação

### Críticos (Must-Have)

1. **vLLM/SGLang support** (self-hosted models - eliminatório)
2. **Performance overhead** (mínimo - CTO requirement)
3. **Agent abstraction** (simplifica criação de agents - core value)
4. **Não força orquestração complexa** (permite Python code para coordenação)

### Importantes (Nice-to-Have)

- Simplicidade para Fase 1 (2-3 agents, routing simples)
- Escalabilidade para Fase 2 (10 agents, coordenação avançada)
- Maturidade (stars, commits, community)
- Documentação quality

---

## Formato de Output Esperado

### Comparison Matrix

| Framework | vLLM Support | Overhead | Força Orquestração? | Agent Abstraction | Fase 1 Fit | Fase 2 Fit | Maturity |
|-----------|--------------|----------|---------------------|-------------------|------------|------------|----------|
| **Agno** (baseline) | ✅ OpenAI-compatible | Minimal | ❌ Python code OK | ✅ Strong | ⚠️ Marginal | ✅ Good | Medium |
| **PydanticAI** | ? | ? | ? | ? | ? | ? | ? |
| **Mirascope** | ? | ? | ? | ? | ? | ? | ? |
| **Marvin** | ? | ? | ? | ? | ? | ? | ? |

### Categorização

**Tier 1: Direct Competitors** (filosofia similar ao Agno)
- Lista de frameworks
- Por que são similares

**Tier 2: Different Philosophy** (úteis mas abordagem diferente)
- Lista de frameworks
- Por que diferem

**Tier 3: Wrong Fit** (não atendem requisitos)
- Lista de frameworks
- Por que não se aplicam

### Recomendação

- **Frameworks que merecem deep-dive** (comparação head-to-head com Agno)
- **Frameworks descartados** (razões explícitas)
- **Decisão sugerida**: Qual investigar mais profundamente?

---

## Escopo de Profundidade

**Survey-style** (não Probe 10-spectrum completo):
- Breadth over depth (cobrir múltiplos frameworks)
- 3-4 horas total (~45min por framework)
- Foco: Fundamentals, Integration, Applicability

**POR FRAMEWORK:**
- ✅ Fundamentals (50%): O que é, filosofia
- ✅ Integration (80%): vLLM support (critical)
- ✅ Applicability (80%): Fit para AVA
- ⚠️ Performance (60%): Overhead (se disponível)
- ⚠️ Implementation (50%): Learning curve, docs
- ❌ Academic (skip): Não relevante
- ❌ Technical deep-dive (skip): Detalhes internos não necessários agora

---

## Deliverable

**Repository**: `/Users/daviguides/work/sources/researchs/research-lightweight-agent-frameworks/`

**Arquivos**:
1. `README.md` - Executive summary + comparison matrix
2. `FRAMEWORKS-OVERVIEW.md` - Brief summary de cada framework
3. `COMPARISON-ANALYSIS.md` - Side-by-side comparison
4. `RECOMMENDATION.md` - Qual framework merece deep-dive vs Agno

---

## Próximo Passo

**Após survey completo**:
- Se PydanticAI (ou outro) parecer superior ao Agno
- Conduzir pesquisa Probe completa (10-spectrum, estilo Agno)
- Decisão final: Agno vs PydanticAI vs Outro

---

**Objetivo Final**: Saber se Agno é a melhor escolha ou se existe alternativa light-weight superior para AVA.

---

**Requisição salva para execução futura.**
