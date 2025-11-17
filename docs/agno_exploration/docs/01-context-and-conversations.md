# Contexto e Conversas - AVA & Agno Exploration

**Data de compilação**: 2025-01-13

---

## 1. Primeira Proposta ao Ricardo (Abordagem Lean)

**Contexto**: Após conversa com Nishal sobre demonstrar "inteligência na interface" (feedback de David Ting)

```
Estava conversando hoje mais cedo com o Nishal, dado o que o David Ting disse ontem sobre ver inteligência na interface - claro, ele não falou apenas do AVA, nosso assistente conversacional, mas é um dos pontos que logo vai pegar :slightly_smiling_face:

E acho que pra gente isso é uma oportunidade de demonstrar bom trabalho. AVA vai depender do que os outros times entregam, mas é algo que podemos acelerar para ficar demo-able :smiling_imp: fast :rocket:.

Minha proposta: Vou fazer um pente-fino no que temos documentado sobre AVA, separando:
Essencial (sem isso não funciona, bloqueia v1)
Desejável (melhora experiência, mas pode vir depois)
A ideia é começar lean - ter algo funcionando logo que mostre a inteligência conversacional, e ir evoluindo em cima. Interface conversacional é perfeita pra isso, conseguimos iterar incrementalmente.

Próximos passos:

Meu lado: Vou revisar a documentação mais atualizada do AVA e montar roadmap priorizado

Seu lado: Implementação com minha supervisão + bastante AI assistant no código inicial (Nishal bateu forte nisso - usar code assistants ao máximo)
A gente alinha sobre o que faz sentido implementar primeiro

O que acha dessa abordagem? Tem algum ponto específico do AVA que você já tá mais familiarizado ou que vê como crítico?
```

---

## 2. Questionamento sobre LangGraph (Alinhamento com Nishal)

**Contexto**: Call com Nishal sobre justificativa técnica do LangGraph

```
One more consideration on AVA: Initial doc review suggests LangGraph is justified for the orchestration needs, but I want to set expectations - if it doesn't prove its value specifically for AVA during implementation, it gets cut too.

This isn't about delivery pressure - it's about technical merit. The question isn't even about multi-agent orchestration itself - it's whether that orchestration is actually simplified by LangGraph or not. Simply put: do we have a workflow that genuinely behaves like a graph/DAG, or are we forcing that pattern where it doesn't fit?
```

**Resposta de Nishal**: Concordou completamente. CTO quer entregas parciais funcionais, não soluções perfeitas. Evoluir iterativamente.

---

## 3. Abordagem de Entrega Incremental (Mensagem ao Nishal)

```
Perfect, understood - Ricardo with my oversight, leveraging AI assistants for initial code generation.

On AVA documentation: What's the most up-to-date document on AVA?

Yesterday while prepping Ricardo for the potential presentation to David (knew we wouldn't have time, but it was productive preparation for next time), I got a better ground-level understanding of AVA.

Given David Ting's directive about "intelligence in the interface," it's clear AVA is one of the critical touchpoints - the conversational assistant in the UI.

My approach for early delivery here:
Distinguish essential (must-have for v1) from desirable (can iterate later)
Start lean, get something demo-able fast
Evolutionary approach: iterate on top of working foundation
The conversational interface is perfect for this - unlike other agents with more critical dependencies, we can iterate incrementally here.
```

---

## 4. Alinhamento com Ricardo (Report ao Nishal)

**Contexto**: Após conversa com Ricardo sobre stack técnico e papéis

```
Had a good conversation with Ricardo today. Wanted to give you a heads up on a few points that came up, and one area where alignment would be helpful.

The good stuff first:
Ricardo is thinking critically about the stack - I questioned him about whether he really thought we had a case for LangGraph. At first he didn't want to deviate, but then he questioned whether LangGraph is actually necessary for AVA or just overhead. In his view, for this case it's just overhead. After discussion, he concluded that for what we need, managing orchestration via code might be simpler and faster.

I pointed him to Agno - it handles agent creation, local model API integration, and observability tools well, which could accelerate his work (not positioning it as orchestration replacement, since we might not need complex orchestration at all). In other words, we don't need to go pure/vanilla Python either - Agno might be a good middle ground that still brings speed. He'll be reviewing it today.

Also shared some lightweight LLM libraries and the "agent that rags" article for context - aiming for a less coupled architecture.
https://weaviate.io/blog/what-is-agentic-rag

The concern:
Ricardo expressed discomfort with being "supervised." I clarified that my role is oversight (not supervision in the Portuguese sense) - architecture guidance, facilitating his work, not micromanaging his day-to-day or checking if he's working. I explained:
I'm not doing detailed(in the sense of dictating whether it is this way or that way) code review (have tooling for that with safety/architecture suggestions)
My focus is on streamlining his process, being a facilitator
Architecture decisions we'll discuss/align on together (it's my responsibility too that this succeeds)
I want to leverage his work, not police it

However, he wanted to align directly with you on a few things:
Reporting structure clarity (I believe you two already discussed this)
Who to follow when there are different directions (he mentioned you clarified this)
His autonomy vs. my involvement level

My take:
I told him to talk directly with you to align expectations - last thing I want is "telephone game" where he's following my guidance but unsure if it conflicts with yours. Better to clarify upfront.

I think this is just initial calibration. My baseline assumption is that he has solid experience and wants to ensure he has the autonomy to deliver. Once roles are clear (you = manager, me = architecture/research oversight to accelerate his work), we'll be good.
```

**Resposta de Nishal:**
```
Great, Thank you for the help Davi

I think we are all on the same page now
I mentioned that you are there for oversight and help
Pretty much what you said above Davi
```

---

## 5. Esclarecimento sobre Agno (Mensagem Contextual)

```
Hello, claro, lembrando que apesar do agno ser para orquestração leve, não é bem isso que estou pensando do caso dele por aqui, e sim como camada para iniciar os agentes, e pensar na orquestração mais sob nosso cuidado ali via código
```

**Interpretação**: Agno considerado para:
- **Inicialização de agentes** (não orquestração pesada)
- **Integração com modelos locais**
- **Observabilidade**
- Orquestração via código (controle manual, não framework-driven)

---

## 6. Documentação Original do AVA (Viés Acadêmico)

**Nota**: Documentação preparada por pessoa com viés mais acadêmico, propondo sistema completo desde início.

```
**(Using LangGraph + OpenPipe ART, aligned with Digital-Twin Ontology v1.1.0)**

## 1. Objective

Build a **modular, ontology-driven multi-agent ecosystem** where:

- The main agent (AVA) interacts with human users.
- Specialized sub-agents (maintenance, compliance, SOP generator, etc.) perform domain reasoning.
- ART is used **not just for final fine-tuning**, but as a **core part of agent development** — prompt versioning, checkpointing, RL loops, cost optimization.
- LangGraph orchestrates agent workflows and memory contexts.
- The system ensures semantic consistency (via the ontology), automated SOP creation, and continuous improvement through evaluation and feedback.
```

**Agentes propostos originalmente:**

| Agent | Role | Ontology Mapping |
|-------|------|------------------|
| **AVA (Main Orchestrator)** | Interfaces with human users, classifies intents, routes to sub-agents | DigitalTwin → AVA |
| **Planner Agent** | Decomposes complex queries into sub-tasks, coordinates multi-agent execution plans, combines results | DigitalTwin → AVA → Planner |
| **Reasoner Agent** | Performs semantic/ontology logic validation | AIFeedback, GovernanceKPI |
| **SOP Generator Agent** | Identifies missing ontology links and generates SOP questions | Maintenance → GovernanceKPI |
| **Maintenance Agent** | Links AI predictions to maintenance plans/actions | PredictionModel → Maintenance |
| **Compliance Agent** | Validates privacy/security/audit domain | GovernanceKPI → reportsPrivacyCompliance |
| **Data Agent** | Handles ingestion of AAS, streaming telemetry, normalization | DataStream |
| **Aggregator Agent** | Combines outputs from multiple agents, resolves conflicts, synthesizes unified responses | AIFeedback → DigitalTwin |
| **Context Manager Agent** | Maintains conversation history, tracks user intent across sessions, manages shared memory state | DigitalTwin → Memory |
| **Evaluator Agent** | Judges reasoning quality, depth, cost efficiency | AIFeedback |

**Fluxo de dados proposto:**
```
Factory Data → Ontology Parser → Reasoner Middleware
 ↓
 Data Agent (ingestion & normalization)
 ↓
 Context Manager Agent (maintains state & memory)
 ↓
 AVA (Main Orchestrator - intent classification)
 ↓
 Planner Agent (decomposes tasks & coordinates)
 ↓
 ┌────────┴────────┬──────────────┬─────────────┬──────────────┐
 ↓                 ↓              ↓             ↓              ↓
Reasoner Agent  SOP Generator  Maintenance  Compliance  [Other Sub-Agents]
 ↓                 ↓              ↓             ↓              ↓
 └────────┬────────┴──────────────┴─────────────┴──────────────┘
 ↓
 Aggregator Agent (combines & synthesizes outputs)
 ↓
 OpenPipe ART Training & Prompt Versioning
 ↓
 Evaluator Agent (LLM-as-Judge scoring)
 ↓
 Feedback Loop → Retraining → Updated Model/Prompt Versions
 ↓
 Deploy to LangGraph Nodes (versioned models & prompts)
```

---

## 7. Posição do Management e CTO

### David Ting (Global CTO)
- Quer ver "inteligência na interface"
- Entregas incrementais, funcionais (não soluções perfeitas)
- Performance é crítica (impaciente com frameworks lentos)
- Exemplo: Django criticado, FastAPI preferido

### Nishal (Manager)
- Abordagem lean, começar simples
- Uso massivo de AI assistants
- Cortar tecnologias que não justificam valor técnico
- Se LangGraph não provar valor → cortar

### Davi (Architecture/Research Oversight)
- Papel: Facilitar, orientar arquiteturalmente
- NÃO micromanagement, NÃO code review detalhado
- Decisões arquiteturais em conjunto com Ricardo
- Objetivo: Acelerar trabalho de Ricardo

### Ricardo (Engineer)
- Inicialmente resistente a "supervisão"
- Após alinhamento com Nishal: esclarecido sobre papéis
- Concordou que LangGraph provavelmente é overhead
- Revisando Agno como possível middle-ground

---

## 8. Decisão Técnica Atual

**Stack questionado:**
- ❌ LangGraph: Provavelmente overhead para necessidades reais do AVA

**Stack considerado:**
- ⚠️ Agno: Middle-ground entre LangGraph (pesado) e Python vanilla (manual)
  - Para: Inicialização de agentes
  - Para: Integração com modelos locais (vLLM, SGLang)
  - Para: Observabilidade
  - Orquestração: Via código (não framework)

**Necessidade:**
- Pesquisa fundamentada (Probe-standard) para avaliar se Agno faz sentido para contexto específico do AVA

---

**Observação final**: Ricardo não ficou muito feliz com supervisão, mas como mencionado "ele vai ter que acatar também o que realmente é meu papel, se lá vier".
