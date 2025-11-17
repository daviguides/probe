# Make RAG 100x Better with Real-Time Knowledge Graphs - Transcrição

**Vídeo:** Introducing Graphiti - Temporal Knowledge Graphs
**Data de Transcrição:** 2025-11-13

---

## Introdução ao Problema do RAG (0:00 - 1:25)

### RAG em AI Agents

Retrieval Augmented Generation (RAG) é usado na maioria dos agentes de IA. É a forma de fornecer documentos e dados ao agente para construir uma base de conhecimento.

### Limitações do RAG Tradicional

**Maior problema: RAG é muito estático**

> "É sua responsabilidade manter constantemente a base de conhecimento do agente sincronizada com seu armazenamento de dados. E esse processo é ineficiente e não confiável."

**Cenários problemáticos:**
- Negócios/plataformas em constante evolução
- Dados em mudança constante:
  - Preferências de usuários
  - Métricas internas
  - Condições de mercado

**Conclusão:** RAG simplesmente não consegue acompanhar.

---

## Introdução ao Graphiti (0:45 - 1:25)

### O que é Graphiti?

**Graphiti:** Plataforma open-source para construir **temporal-aware knowledge graphs**

### Conceito Principal

> "É uma camada em cima do RAG projetada para ingerir continuamente dados em constante mudança, mantendo também um registro histórico de como seus dados mudaram."

### Benefícios

**Consciência temporal:**
- Agente ciente de como a base de conhecimento muda ao longo do tempo
- Registro histórico completo
- Extremamente poderoso para ambientes dinâmicos

### Conteúdo do Vídeo

1. Introdução ao Graphiti
2. Como usar (muito fácil)
3. Comparação com outros knowledge graphs (LightRAG)
4. Como usar Graphiti com outras estratégias RAG

---

## Graphiti Overview (1:25 - 3:17)

### Repositório GitHub

**Qualidade excepcional:**
> "Este é um dos READMEs mais bem escritos que vi em um bom tempo. Te deixa pronto para rodar tão rapidamente e você faz isso completamente de graça."

### Temporal-Aware Knowledge Graph - Exemplo

#### Cenário: Preferências de Usuário

**Estado Inicial:**
```
Fato: Kendra loves Adidas shoes
```

**Mudança:**
```
Mensagem: "Oh, my shoes broke. Now I think Puma shoes are the best."
```

**Abordagem Tradicional (RAG):**
- Substitui o fato antigo pelo novo
- Perde contexto histórico

**Abordagem Graphiti:**
- Adiciona AMBOS os fatos
- Adiciona contexto histórico:
  - "Ela não gosta mais desses sapatos"
  - "Ela costumava gostar, mas agora gosta de Puma"

### Por que isso é Poderoso?

#### Caso de Uso: Customer Support Agent

**Necessidade de contexto:**
- Preferências passadas
- Preferências atuais
- Evolução de preferências

**Resultado:**
- Experiência personalizada
- Atendimento acima e além
- Contexto rico para decisões

### Aplicabilidade

> "Você pode pegar isso e aplicar a tantos outros tipos diferentes de ambientes dinâmicos que você tem para seu negócio ou sua plataforma."

---

## Visualização do Knowledge Graph (2:38 - 3:17)

### Neo4j como Motor

**Plataforma:** Neo4j
- Engine por trás do Graphiti
- Armazena todo conhecimento temporal-aware

### Estrutura do Grafo

**Componentes:**
- **Nodes:** Pedaços de informação
- **Relationships:** Conexões entre informações
- **Temporal Metadata:** Como mudou ao longo do tempo

### Exemplo de Relacionamento

**GPT-4 ↔ GPT-3.5**

```
Relationship: "previous version"
- GPT-3.5 é versão anterior do GPT-4
- Metadata temporal captura essa evolução
```

### Knowledge Graphs vs Traditional RAG

**Por que Knowledge Graphs são mais poderosos:**

```
Traditional RAG:
- Busca por similaridade vetorial
- Sem contexto relacional
- Informação isolada

Knowledge Graphs:
- Informação conectada
- Relacionamentos explícitos
- Contexto rico
- Navegação entre conceitos
```

**Importante:** Não é um ou outro!

### Abordagem Recomendada: Hybrid

**Ferramentas do Agente:**
1. **Knowledge Graph Search Tool**
   - Para buscas relacionais
   - Exploração de conexões

2. **Vector Database Tool**
   - Para lookup tradicional
   - Busca por similaridade

**Resultado:** Combinação muito poderosa

### Outras Estratégias RAG Complementares

Já cobertas no canal:
- **Hybrid RAG**
- **Contextual RAG**

> "Você ainda quer ter isso e construir essas estratégias adicionais [...] Este é um componente muito importante para ter na maioria dos seus agentes de IA."

---

## Graphiti vs GraphRAG/LightRAG (4:01 - 5:37)

### Disclosure

**Parceria:** Vídeo em parceria com Graphiti

**Mas:**
- Já planejava cobrir de qualquer forma
- Muitos pedidos da audiência
- Pensamentos honestos sobre comparação

### GraphRAG e LightRAG

#### Propósito Principal

**Otimizado para:**
- Sumarização de documentos estáticos
- Documentação que não muda frequentemente
- Análise de conteúdo fixo

#### Quando usar GraphRAG/LightRAG

**Cenários ideais:**
```
✓ Documentação técnica estática
✓ Livros e artigos
✓ Conhecimento que raramente muda
✓ Análise retrospectiva
```

### Graphiti

#### Propósito Principal

**Otimizado para:**
- Dados dinâmicos
- Atualizações contínuas
- Contexto temporal

#### Quando usar Graphiti

**Casos de uso:**
```
✓ Plataformas em evolução
✓ Negócios dinâmicos
✓ Preferências de usuários
✓ Métricas em tempo real
✓ Condições de mercado
✓ Qualquer sistema vivo/ativo
```

> "Para a maioria dos seus casos de uso, trabalhando com sua plataforma ou seu negócio ou apenas sua vida, você está trabalhando com dados muito dinâmicos."

### Características do Graphiti

#### 1. Atualizações Incrementais Contínuas

```python
# Ingestão contínua
graphiti.add_episode(episode_1)  # T0
graphiti.add_episode(episode_2)  # T1
graphiti.add_episode(episode_3)  # T2
# Sistema sempre atualizado
```

#### 2. Contexto Histórico

```
Fact (T0): "Best LLM: GPT-4"
  valid_at: 2024-01-15

Fact (T1): "Best LLM: Claude 4"
  valid_at: 2024-03-20
  invalidated_previous: T0 fact

Agent tem acesso a AMBOS + timestamps
```

#### 3. Lightweight e Escalável

**Comparação com LightRAG:**

| Aspecto | LightRAG | Graphiti |
|---------|----------|----------|
| **Build Speed** | Lento | Rápido |
| **Query Speed** | Lento | Subsecond (<1s) |
| **Scalability** | Limitada | Alta |
| **Production Ready** | Questionável | ✓ Sim |

**Experiência pessoal:**
> "Uma das coisas que eu realmente não gostei sobre LightRAG foi quão lento era tanto construindo o knowledge graph quanto para a consulta em si."

**Graphiti:**
- Latência tipicamente subsecond
- Muito mais escalável
- Pronto para produção

---

## Graphiti Quickstart (5:38 - 9:21)

### Objetivos

1. **Quickstart básico**
   - Entender fundamentos
   - Ver Graphiti em ação

2. **Full AI Agent**
   - Knowledge graph como ferramenta
   - Busca via agente
   - Pydantic AI integration

### Pré-requisitos

```bash
# Software necessário
✓ Python
✓ Neo4j (knowledge graph engine)
✓ LLM Provider (OpenAI/Gemini/Anthropic)
```

### Suporte Multi-Provider

#### Documentação Oficial

**Providers suportados:**
- OpenAI (default nos exemplos)
- Azure OpenAI
- Google Gemini
- Anthropic Claude
- **Ollama (100% local!)**

#### Implementação 100% Local

```bash
# Setup local completo
Neo4j: Open-source, roda localmente
Ollama: LLMs locais
Graphiti: Processa tudo local

= Sistema completamente offline
```

**Referência:** Documentação oficial → Installation tab

### Neo4j Setup

#### Opção A: Neo4j Desktop (Recomendado oficialmente)

**Processo:**
1. Acessar link de download
2. Seguir instruções de instalação
3. Configurar database
4. Salvar informações:
   - URL do Neo4j
   - Username
   - Password

**Uso posterior:** Environment variables

#### Opção B: Local AI Package (Recomendado pelo instrutor)

**O que é:**
- Pacote curado de soluções open-source
- Tudo roda junto
- Neo4j incluído

**Setup:**
- Vídeo masterclass disponível no canal
- Um pouco antigo, mas ainda funciona
- Configurar env vars adicionais:
  - Neo4j username
  - Neo4j password

**Demonstração:**

```bash
# Docker Desktop
Container: neo4j
Status: Running
Part of: local-ai-stack

# Acesso via browser
http://localhost:7474
```

### Estrutura do Quickstart

**Repositório GitHub:**
- Link disponível na descrição
- Exemplos prontos para usar
- Template inicial
- Instruções no README

**Conteúdo:**
1. Quickstart básico
   - Adicionar dados ao knowledge graph
   - Queries simples

2. Full AI Agent
   - Graffiti como tool
   - Evolução de dados ao longo do tempo
   - Demonstração de respostas dinâmicas

---

## Quickstart Code Walkthrough (9:21 - 14:25)

### Setup Inicial

#### Conexão Neo4j

```python
# Environment variables
NEO4J_URI = os.getenv("NEO4J_URI")
NEO4J_USER = os.getenv("NEO4J_USER")
NEO4J_PASSWORD = os.getenv("NEO4J_PASSWORD")

# Main function
def main():
    # Inicializar Graphiti
    graphiti = Graphiti(
        neo4j_uri=NEO4J_URI,
        neo4j_user=NEO4J_USER,
        neo4j_password=NEO4J_PASSWORD
    )

    # Build indices e constraints
    graphiti.build_indices_and_constraints()
```

**Processo:**
1. Conectar ao Neo4j com credenciais
2. Inicializar Graphiti
3. Configurar índices e constraints iniciais

### Conceito: Episodes

**O que são Episodes?**
> "Episodes são todos os pedaços de informação que queremos armazenar no nosso knowledge graph. É apenas como Graphiti os chama."

#### Flexibilidade de Formato

**Característica importante:**
> "A melhor parte sobre esses episodes é que eles NÃO precisam seguir um formato específico."

### Tipos de Episodes

#### Tipo 1: Text Episode

```python
# Episode de texto simples
episode_claude = {
    "type": "text",
    "content": "Claude is Anthropic's flagship AI assistant,
                known for being helpful, harmless, and honest."
}

await graphiti.add_episode(
    name="claude_info",
    episode_content=episode_claude["content"],
    source="documentation",
    reference_time=datetime.now()
)
```

**Características:**
- Formato: String simples
- Tipo: `text`
- Uso: Informação narrativa

#### Tipo 2: JSON Episode

```python
# Episode estruturado
episode_gpt = {
    "type": "json",
    "content": {
        "model": "GPT-4",
        "previous_version": "GPT-3.5",
        "release_date": "2024-01-15",
        "capabilities": ["reasoning", "code", "analysis"]
    }
}

await graphiti.add_episode(
    name="gpt4_specs",
    episode_content=episode_gpt["content"],
    episode_type="json",
    source="specifications",
    reference_time=datetime.now()
)
```

**Características:**
- Formato: Object (key-value pairs)
- Tipo: `json`
- Uso: Dados estruturados

### Como Episodes Criam Relacionamentos

**Exemplo do vídeo:**

```json
{
  "model": "GPT-4",
  "previous_version": "GPT-3.5"
}
```

**Resultado no Knowledge Graph:**

```
[GPT-4] --[previous_version]--> [GPT-3.5]

Metadata:
- GPT-3.5 é versão anterior do GPT-4
- Criado dinamicamente pelo LLM
```

**Processo:**
1. LLM processa episode
2. Identifica entidades (GPT-4, GPT-3.5)
3. Identifica relacionamento (previous_version)
4. Cria nodes e edges automaticamente

> "Nós temos essa criação dinâmica do nosso knowledge graph baseado apenas em como o LLM está entendendo os dados que estamos fornecendo. É isso que o torna tão poderoso."

### Adicionando Episodes

```python
# Loop para adicionar múltiplos episodes
for episode in episodes:
    await graphiti.add_episode(
        name=episode["name"],
        episode_content=episode["content"],
        episode_type=episode.get("type", "text"),
        source=episode["source"],
        reference_time=datetime.now(),  # CRUCIAL!
        metadata=episode.get("metadata", {})
    )
```

#### Parâmetros Importantes

**1. name:** Identificador do episode
**2. episode_content:** O conteúdo em si
**3. episode_type:** text, json, etc
**4. source:** Origem da informação
**5. reference_time:** **SUPER IMPORTANTE!**

#### Por que reference_time é crucial?

```python
reference_time=datetime.now()
```

**Temporal Knowledge Graph requer:**
- Timestamp de quando informação foi inserida
- Timestamp de quando foi invalidada (futuro)
- Rastreamento completo de timeline

**Uso:**
```
Fact A inserted: 2024-01-15 10:00
Fact B invalidates A: 2024-03-20 14:30

Query: "What was true on 2024-02-01?"
Answer: Fact A (era válido naquela data)

Query: "What is true now?"
Answer: Fact B (mais recente)
```

### Buscando no Knowledge Graph

#### Busca Básica

```python
# Query simples
results = await graphiti.search(
    query="Which AI assistant is from Anthropic?",
    num_results=5  # Opcional: número de resultados
)

# Processar resultados
for result in results:
    print(f"UUID: {result.uuid}")
    print(f"Fact: {result.fact}")
    print(f"Valid at: {result.valid_at}")

    if result.invalid_at:
        print(f"Invalidated at: {result.invalid_at}")
```

**Parâmetros disponíveis:**
- `query`: Pergunta em linguagem natural
- `num_results`: Número de fatos retornados
- `num_nodes`: Número de nodes explorados
- Veja documentação para mais

**Estrutura do Resultado:**

```python
SearchResult:
  - uuid: str          # Identificador único
  - fact: str          # Informação em si
  - valid_at: datetime # Quando foi inserido
  - invalid_at: datetime | None  # Se foi invalidado
```

**Poder da informação temporal:**
> "E isso é tão poderoso para dar ao nosso agente de IA para que ele possa raciocinar sobre qual informação ainda é realmente relevante para responder nossa pergunta."

#### Center Node Search

**Conceito:** Busca refinada ao redor de um node específico

**Caso de uso:**
```
Cenário: Múltiplas entidades similares no grafo
- Claude 4: 200k token limit
- GPT-4: 128k token limit
- Gemini: 1M token limit

Query: "What is the token limit?"
Problema: Qual modelo?

Solução: Center node search
```

**Implementação:**

```python
# Passo 1: Busca inicial
initial_results = await graphiti.search(
    query="Claude 4"
)

# Passo 2: Usar top result como center
center_node = initial_results[0]

# Passo 3: Busca refinada
refined_results = await graphiti.search(
    query="What is the token limit?",
    center_node_uuid=center_node.uuid,
    num_results=5
)

# Agora só busca ao redor do Claude 4
for result in refined_results:
    print(f"Fact: {result.fact}")
```

**Benefícios:**
- Evita confusão entre entidades similares
- Busca mais precisa
- Re-ranking contextual
- Navegação no grafo

**Exemplo prático:**
```
Query inicial: "Claude 4" → Node UUID: abc123

Center node search:
- "token limit" with center=abc123
- Só busca nos adjacentes de Claude 4
- Não retorna token limit do GPT-4
```

#### Search Recipes (Avançado)

**Conceito:** Diferentes estratégias de busca otimizadas

```python
from graphiti import SearchRecipe

# Node-focused search
results = await graphiti.search(
    query="AI models",
    search_recipe=SearchRecipe.NODES,
    config=search_config
)

# Edge-focused search
results = await graphiti.search(
    query="relationships between companies",
    search_recipe=SearchRecipe.EDGES,
    config=search_config
)
```

**Tipos disponíveis:**
- **NODES:** Foca em entidades
- **EDGES:** Foca em relacionamentos
- Outros (ver documentação)

**Quando usar cada um:**
```
NODES:
- "Who is the CEO?"
- "What is Claude?"
- Foco em entidades específicas

EDGES:
- "How are Microsoft and OpenAI related?"
- "What connects these concepts?"
- Foco em relacionamentos
```

**Nota do instrutor:**
> "Não vou cobrir muito aqui apenas para manter as coisas breves [...] Apenas mais uma forma de levar isso adiante."

### Cleanup

```python
# Ao final do script
async def main():
    graphiti = Graphiti(...)

    try:
        # ... operações ...
    finally:
        # IMPORTANTE: Prevenir memory leaks
        await graphiti.close()
```

**Por quê?**
- Conexão com Neo4j precisa ser fechada
- Prevenir memory leaks
- Boa prática de resource management

---

## Graphiti Demo (14:25 - 16:47)

### Executando o Quickstart

```bash
# Terminal
python quickstart.py
```

### Visualização em Tempo Real - Neo4j

**Setup:**
1. Abrir Neo4j Browser
2. Limpar grafo (demo anterior)
3. Preparar para visualização
4. Modo Graph ativo

#### Estado Inicial

```cypher
MATCH (n) RETURN n
```

**Resultado:** Grafo vazio

### Processo de Construção

#### Fase 1: Claude Episodes

**Terminal:**
```
Processing episode: claude_info
→ Multiple OpenAI API requests
  - Embedding model calls
  - LLM calls (GPT)
  - Relationship extraction
```

**Neo4j refresh:**
```
Nodes criados: Claude-related
- Claude (entity)
- Anthropic (entity)
- Relationships criados
```

#### Fase 2: GPT Episodes

**Terminal:**
```
Processing episode: gpt4_specs
Processing episode: gpt35_info
→ More API requests
  - Processing relationships
  - Extracting entities
  - Building connections
```

**Neo4j refresh:**
```
2 clusters visíveis:
1. GPT Cluster:
   - GPT-4
   - GPT-3.5
   - Version relationships

2. Claude Cluster:
   - Claude
   - Anthropic
   - Assistant relationships
```

### Sobre as Requisições OpenAI

**Por que tantas?**

> "A razão de haver tantas requisições é porque temos que processar esses episodes e construir todas essas relações. Há tanto acontecendo por baixo dos panos."

**Breakdown:**
1. **Embedding calls:** Vetorizar conteúdo
2. **LLM calls:** Extrair entidades
3. **LLM calls:** Identificar relationships
4. **LLM calls:** Consolidar conhecimento

### Otimização de Custos

**Recomendação:**
> "Você pode definitivamente usar LLMs mais baratos para garantir que esse processo não seja muito caro. Realmente não é tão ruim."

**Estratégias:**
```python
# Use modelos mais baratos para ingestão
graphiti = Graphiti(
    ...,
    embedding_model="text-embedding-3-small",  # Mais barato
    llm_model="gpt-4-turbo-preview"  # Ou gpt-3.5-turbo
)
```

### Imprevisibilidade do LLM

**Observação importante:**
```
Demo 1: LLM conectou Claude e GPT clusters
Demo 2 (agora): Clusters separados
```

> "Às vezes o LLM vai conectar essas [entidades] como fez na demo que mostrei antes. Há um pouco de imprevisibilidade com knowledge graphs porque estamos confiando em um LLM para construir essas relações."

**Mas:**
> "No geral, isso funciona muito, muito bem."

**Lição:**
- Knowledge graphs não são determinísticos
- Estrutura pode variar entre execuções
- Conteúdo e relacionamentos principais permanecem
- Aceitável para maioria dos casos de uso

### Visualização Final

**Grafo completo construído:**
```
Clusters:
1. Claude + Anthropic
2. GPT-4 + GPT-3.5

Relationships:
- Company ownership
- Product lines
- Version history
- Capabilities
```

---

## Resultados das Buscas (16:47 - 17:00)

### Search 1: Basic Search

```python
query = "Which AI assistant is from Anthropic?"
results = await graphiti.search(query)
```

**Output:**
```
Rank 1:
UUID: abc-123-def
Fact: "Claude is the flagship AI assistant from Anthropic"
Valid at: 2024-11-13 10:23:45
Invalid at: None

Rank 2-5: [outros resultados relacionados]
```

**Análise:**
> "Esse fato top realmente responde diretamente nossa pergunta."

### Search 2: Center Node Search

```python
# Usar Claude 4 como centro
center_node = results[0]  # Claude 4 node

query = "What is the token limit?"
results = await graphiti.search(
    query=query,
    center_node_uuid=center_node.uuid
)
```

**Cenário explicado:**
> "Talvez queremos perguntar o limite de tokens para um LLM, queremos se estamos olhando para Claude especificamente, usar Claude como o center node. Dessa forma não puxamos acidentalmente o limite de tokens para GPT-4."

**Resultado:**
```
Rank 1: (ainda sobre Claude)
Fact: "Claude is the flagship AI assistant from Anthropic"
Valid at: [timestamp]

Rank 2-5: (fatos adjacentes a Claude)
```

**Nota:**
> "Você pode imaginar cenários onde não obtemos exatamente a informação certa, mas então podemos fazer uma nova busca com aquilo como centro. Então esperançosamente os nodes adjacentes que puxamos têm, sabe, o contexto perfeito que precisamos."

### Search 3: Alternative Strategy

**Não coberto em detalhes:**
- Diferentes search recipes
- Ver documentação

---

## Graphiti AI Agent com Pydantic AI (16:48 - 20:03)

### Transição

> "Agora quero mostrar como podemos construir um agente de IA completo para aproveitar essa base de conhecimento como ferramentas para o agente."

### Arquitetura do Sistema

**Dois scripts principais:**

#### 1. `llm_evolution.py`
**Propósito:** Adicionar informação ao knowledge graph

**Diferencial:**
- Adiciona em **batches/fases**
- Permite conversar com agente entre fases
- Demonstra evolução temporal

**Objetivo:**
> "Podemos ver como nossos dados evoluem ao longo do tempo, como isso também muda as respostas do nosso agente ao longo do tempo. Acho que essa é realmente a melhor forma de mostrar o poder do Graphiti."

#### 2. `agent.py`
**Propósito:** Agente conversacional

**Capacidades:**
- Busca no knowledge graph
- Responde perguntas
- Adapta respostas conforme dados evoluem

### llm_evolution.py - Code Breakdown

#### Setup

```python
# Conexão Neo4j (mesmo do quickstart)
NEO4J_URI = os.getenv("NEO4J_URI")
NEO4J_USER = os.getenv("NEO4J_USER")
NEO4J_PASSWORD = os.getenv("NEO4J_PASSWORD")

# Inicializar Graphiti
graphiti = Graphiti(
    neo4j_uri=NEO4J_URI,
    neo4j_user=NEO4J_USER,
    neo4j_password=NEO4J_PASSWORD
)
```

#### Função Helper

```python
async def add_episodes(graphiti, episodes):
    """Adiciona múltiplos episodes ao grafo"""
    for episode in episodes:
        await graphiti.add_episode(
            name=episode["name"],
            episode_content=episode["content"],
            source=episode["source"],
            reference_time=datetime.now()
        )
```

### Fases de Evolução

#### Phase 1: Best LLMs (Estado Inicial)

```python
phase_1_episodes = [
    {
        "name": "gpt_4_1",
        "content": "GPT-4.1 is OpenAI's latest model with
                    advanced reasoning capabilities",
        "source": "documentation"
    },
    {
        "name": "gemini_2_5_pro",
        "content": "Gemini 2.5 Pro is currently considered
                    the best LLM available, with superior
                    performance across benchmarks",
        "source": "benchmarks"
    },
    {
        "name": "claude_3_7_sonnet",
        "content": "Claude 3.7 Sonnet offers excellent
                    performance with strong safety features",
        "source": "documentation"
    }
]

await add_episodes(graphiti, phase_1_episodes)
print("Phase 1 complete. Talk to agent now!")
input("Press Enter to continue to Phase 2...")
```

**Estado do conhecimento:**
```
Best LLM: Gemini 2.5 Pro
Also available: GPT-4.1, Claude 3.7 Sonnet
```

#### Phase 2: New Release (Mudança)

```python
phase_2_episodes = [
    {
        "name": "claude_4_release",
        "content": "Anthropic just released Claude 4.
                    It is now the best LLM available,
                    surpassing Gemini 2.5 Pro in all benchmarks",
        "source": "news"
    },
    {
        "name": "gemini_superseded",
        "content": "Gemini 2.5 Pro was the best LLM,
                    but now Claude 4 has taken that position",
        "source": "analysis"
    }
]

await add_episodes(graphiti, phase_2_episodes)
print("Phase 2 complete. Talk to agent again!")
input("Press Enter to continue to Phase 3...")
```

**Estado do conhecimento:**
```
Best LLM (current): Claude 4
Best LLM (previous): Gemini 2.5 Pro [INVALIDATED]
Historical context preserved
```

#### Phase 3: Paradigm Shift (Mudança Dramática)

```python
phase_3_episodes = [
    {
        "name": "mlm_introduction",
        "content": "A revolutionary new type of AI model called
                    Massive Language Models (MLMs) has been
                    introduced. MLMs make traditional LLMs
                    completely irrelevant",
        "source": "research"
    },
    {
        "name": "nexus_one",
        "content": "Nexus One is the first MLM, representing
                    a completely new paradigm beyond LLMs",
        "source": "announcement"
    },
    {
        "name": "llm_obsolete",
        "content": "LLMs are now considered obsolete technology.
                    The industry is moving to MLMs",
        "source": "industry_analysis"
    }
]

await add_episodes(graphiti, phase_3_episodes)
print("Phase 3 complete. Final agent interaction!")
```

**Nota humorística:**
> "Só como uma piada, isso não é real. Estou dizendo que há um novo tipo revolucionário de modelo de IA chamado Massive Language Models ou MLMs [...] não confundir com multi-level marketing."

**Estado do conhecimento:**
```
Current paradigm: MLMs (Massive Language Models)
Best MLM: Nexus One
LLMs: Obsolete [including Claude 4]
Full historical timeline preserved
```

### Main Function Flow

```python
async def main():
    # Setup
    graphiti = await setup_graphiti()

    # Phase 1
    await add_episodes(graphiti, phase_1_episodes)
    input("Ready for Phase 2? Press Enter...")

    # Phase 2
    await add_episodes(graphiti, phase_2_episodes)
    input("Ready for Phase 3? Press Enter...")

    # Phase 3
    await add_episodes(graphiti, phase_3_episodes)

    # Cleanup
    await graphiti.close()

if __name__ == "__main__":
    asyncio.run(main())
```

### agent.py - Pydantic AI Agent

#### Disclaimer

> "Não vou mergulhar exatamente em como Pydantic AI funciona neste vídeo. Há muito outro conteúdo no meu canal sobre Pydantic AI."

#### Dependencies

```python
from pydantic_ai import Agent
from graphiti import Graphiti

# Agent dependencies (context)
class AgentDeps:
    graphiti_client: Graphiti
```

**Propósito:** Passar Graphiti client para as ferramentas do agente

#### Model Setup

```python
# Baseado em environment variables
model = os.getenv("LLM_MODEL", "openai:gpt-4")

# Criar agente
agent = Agent(
    model=model,
    deps_type=AgentDeps,
    system_prompt="You are a helpful AI assistant with
                   access to a knowledge graph..."
)
```

#### Tool: Knowledge Graph Search

```python
@agent.tool
async def search_knowledge_graph(
    ctx: RunContext[AgentDeps],
    query: str
) -> str:
    """
    Search the knowledge graph for relevant information.

    Args:
        query: The search query (agent determines this)

    Returns:
        Formatted results with facts and temporal info
    """
    # Access Graphiti client from context
    graphiti = ctx.deps.graphiti_client

    # Perform search
    results = await graphiti.search(query=query, num_results=5)

    # Format results for agent
    formatted_results = []
    for result in results:
        fact_info = {
            "fact": result.fact,
            "valid_at": result.valid_at.isoformat(),
            "invalid_at": (result.invalid_at.isoformat()
                          if result.invalid_at else "Still valid")
        }
        formatted_results.append(fact_info)

    return json.dumps(formatted_results, indent=2)
```

**Características importantes:**

1. **Agent determina query:**
   ```
   User: "What is the best LLM?"
   Agent (internal): query = "best LLM current"
   ```

2. **Temporal info incluída:**
   ```json
   {
     "fact": "Claude 4 is the best LLM",
     "valid_at": "2024-03-20T14:30:00",
     "invalid_at": "Still valid"
   }
   ```

3. **Agent raciocina sobre tempo:**
   - Vê múltiplos fatos
   - Compara timestamps
   - Identifica qual é atual
   - Usa histórico para contexto

#### Main - CLI Interface

```python
async def main():
    # Setup Graphiti
    graphiti = Graphiti(...)
    await graphiti.build_indices_and_constraints()

    # Create dependencies
    deps = AgentDeps(graphiti_client=graphiti)

    # CLI loop
    print("Chat with the agent (type 'exit' to quit)")
    while True:
        user_input = input("\nYou: ")

        if user_input.lower() == 'exit':
            break

        # Run agent
        result = await agent.run(
            user_input,
            deps=deps
        )

        print(f"\nAgent: {result.data}")

    # Cleanup
    await graphiti.close()
```

---

## Live Demo - True Power of Graphiti (20:03 - 24:47)

### Setup

**Dois terminais:**
1. **Terminal 1:** `agent.py` (conversação)
2. **Terminal 2:** `llm_evolution.py` (evolução de dados)

### Execução Inicial

#### Terminal 1: Start Agent

```bash
python agent.py
```

**Output:**
```
Chat with the agent (type 'exit' to quit)

You: _
```

#### Teste Básico

```
You: hello

Agent: Hello! How can I help you today? I have access
       to a knowledge graph that I can search for information.
```

#### Primeira Query (Dados Vazios)

```
You: What is the best LLM?

[Tool Call: search_knowledge_graph(query="best LLM")]

Agent: I don't have enough information in the knowledge
       graph yet to answer that question.
```

**Estado:** Knowledge graph vazio, sem dados

### Phase 1: Initial Data

#### Terminal 2: Run Evolution Script

```bash
python llm_evolution.py
```

**Output:**
```
Processing Phase 1...
Adding episode: gpt_4_1
Adding episode: gemini_2_5_pro
Adding episode: claude_3_7_sonnet

✓ Phase 1 complete
Talk to agent now!
Press Enter to continue to Phase 2...
```

**Duração:** ~20 segundos

#### Verificação Neo4j

```cypher
MATCH (n)-[r]->(m) RETURN n, r, m
```

**Resultado visualizado:**
```
Nodes criados:
- Gemini 2.5 Pro
- Claude 3.7 Sonnet
- GPT-4.1

Relationships:
- Performance comparisons
- "Best LLM" designation → Gemini 2.5 Pro
```

#### Terminal 1: Query Again

```
You: What is the best LLM? Search again

[Tool Call: search_knowledge_graph(query="best LLM current")]

Agent: The best large language model right now is
       Gemini 2.5 Pro.
```

**Velocidade observada:**
> "Você vai ver quão rápido isso é comparado a outras ferramentas como LightRAG. [...] Em apenas alguns segundos, obtivemos nossa resposta. Isso é tão bom."

**Timestamp:** Resposta em ~2 segundos

### Phase 2: New Leader

#### Terminal 2: Continue

```
[User presses Enter]

Processing Phase 2...
Adding episode: claude_4_release
Adding episode: gemini_superseded

✓ Phase 2 complete
Talk to agent again!
Press Enter to continue to Phase 3...
```

#### Neo4j Verification

```
Refresh graph visualization
```

**Mudanças:**
```
New node: Claude 4
Updated relationships:
- Claude 4 → "Best LLM" (new)
- Gemini 2.5 Pro → "Best LLM" (invalidated)

Timeline preserved:
- Gemini was best (T1)
- Claude 4 is best (T2)
```

#### Agent Query - Fresh Start

**Nota importante:**
> "Comecei do zero aqui. Então você não tem histórico de conversação bagunçando nada."

```bash
# Terminal 1 - reiniciado
python agent.py

You: What is the best LLM right now?

[Tool Call: search_knowledge_graph(query="best LLM current")]
```

**Agent Response:**

```
Agent: Claude 4 is now the best LLM. It was recently
       released by Anthropic and surpasses Gemini 2.5 Pro
       in all benchmarks.

       Note: Gemini 2.5 Pro was previously considered the
       best LLM, but has been superseded by Claude 4.
```

**Análise da resposta:**

> "E porque estamos mantendo um registro histórico dessa informação e em um ponto Gemini 2.5 Pro era o melhor, ele também declara isso. Você pode ver apenas por essa resposta quão robusta nossa base de conhecimento está por trás dos panos."

**Poder do temporal awareness:**
1. Múltiplos fatos retornados
2. Timestamps comparados
3. Contexto histórico preservado
4. Resposta rica e completa

### Phase 3: Paradigm Shift

#### Terminal 2: Final Phase

```
[User presses Enter]

Processing Phase 3...
Adding episode: mlm_introduction
Adding episode: nexus_one
Adding episode: llm_obsolete

✓ Phase 3 complete
All phases done!
```

**Duração:** ~20 segundos novamente

#### Neo4j - Final Graph

```
Massive graph agora:
- LLM nodes (GPT, Claude, Gemini)
- MLM nodes (Nexus One)
- Relationships complexos
- Timeline completa
```

**Observação específica:**

```
MLM node mentions:
- "Large Language Models" (as obsolete)
- Previous paradigm

Relationships:
- MLMs supersede LLMs
- Nexus One as first MLM
```

#### Final Agent Query

```
You: What is the best LLM? Search again

[Tool Call: search_knowledge_graph(
    query="best LLM current state"
)]
```

**Agent Response - The Perfect Answer:**

```
Agent: While Claude 4 is currently recognized as the best
       LLM, there has been a recent emergence of Massive
       Language Models (MLMs).

       MLMs represent a new paradigm that makes traditional
       LLMs obsolete. Nexus One is the first MLM available.

       So while Claude 4 is the best LLM, the industry is
       moving beyond LLMs to MLMs.
```

**Reação do instrutor:**

> "Isso é simplesmente a resposta perfeita. Eu só amo as ressalvas que somos capazes de obter agora porque temos essa informação histórica."

**Breakdown da resposta:**

```
Layer 1 (Direct): Claude 4 = best LLM
Layer 2 (Context): LLMs são obsoletos
Layer 3 (New paradigm): MLMs são o futuro
Layer 4 (Specific): Nexus One é primeiro MLM

= Resposta extremamente rica e contextual
```

### Demonstração - Insights

#### Velocidade

**Observação importante:**
> "A propósito, isso leva apenas cerca de 20 segundos. Então é muito rápido. Mesmo sendo construindo muitos relacionamentos complexos por baixo dos panos."

**Comparação com LightRAG:**
- LightRAG: Minutos para builds similares
- Graphiti: ~20 segundos consistente

#### Complexidade do Grafo

**Visualização final:**
> "Olhe só quão grande nosso knowledge graph completo é agora."

```
Múltiplos clusters
Dezenas de nodes
Centenas de relationships
Timeline completa preservada
```

#### Exemplo Aplicável

**Reflexão do instrutor:**

> "Eu meio que apenas inventei esse exemplo na hora de comparar diferentes LLMs dentro do Graphiti aqui, mas acho que isso realmente realmente mostra o poder de ter um knowledge graph temporal-aware."

**Aplicabilidade universal:**

> "E basicamente a maioria dos agentes de IA que você quer fazer com RAG poderia se beneficiar disso. Não importa o negócio em que você está trabalhando, você tem dados dinâmicos. Algo assim é simplesmente tão poderoso."

---

## Graphiti e Agentic RAG + Outras Estratégias (24:47 - 26:07)

### Combinando Estratégias RAG

#### Mensagem Principal

> "A última coisa que eu realmente quero enfatizar para você é sobre usar knowledge graphs junto com RAG mais tradicional com vector databases. Você não tem que escolher um sobre o outro."

### Por que Múltiplas Estratégias?

**Filosofia do instrutor:**

> "É por isso que cubro tantas estratégias diferentes com RAG em geral, é porque você pode combinar muitas delas juntas."

**Estratégias já cobertas:**
- Traditional RAG (vector databases)
- Knowledge Graphs (Graphiti, LightRAG)
- Hybrid RAG
- Contextual RAG
- Agentic RAG

### Agentic RAG - Conceito

**Definição:**

> "É toda a ideia de dar ao seu agente a habilidade de explorar seu conhecimento de formas diferentes."

**Implementação prática:**

```python
# Agent tools
@agent.tool
async def search_knowledge_graph(ctx, query: str):
    """Search relational information in knowledge graph"""
    return await ctx.deps.graphiti.search(query)

@agent.tool
async def search_vector_database(ctx, query: str):
    """Search for similar documents in vector DB"""
    embeddings = await embed(query)
    return await ctx.deps.vector_db.similarity_search(embeddings)
```

### Quando Usar Cada Ferramenta

#### Knowledge Graph - Use Cases

**Melhor para:**
```
✓ Relacionamentos entre entidades
✓ Conexões complexas
✓ Navegação contextual
✓ Exploração de redes
✓ Perguntas relacionais

Exemplos:
- "Como Amazon e Anthropic estão relacionados?"
- "Quem são os parceiros da Microsoft?"
- "O que conecta esses conceitos?"
```

#### Vector Database - Use Cases

**Melhor para:**
```
✓ Busca por similaridade
✓ Recuperação de documentos
✓ Informação isolada
✓ Busca semântica
✓ Chunks de texto

Exemplos:
- "O que é RAG?"
- "Documentação sobre API keys"
- "Exemplos de código para X"
```

### Estratégia do Agente

**Raciocínio adaptativo:**

```
Agent recebe: "Explain the partnership between OpenAI and Microsoft"

Agent pensa:
1. "Partnership" = palavra relacional
2. Duas entidades mencionadas
3. → Usar Knowledge Graph tool

Results: Insufficient information

Agent pensa:
4. KG não teve info suficiente
5. → Tentar Vector Database
6. Buscar por "OpenAI Microsoft partnership"

Results: Detailed document about partnership

Agent: Combina informações e responde
```

**Flexibilidade:**
> "Isso só vai dar a você respostas melhores no geral."

### Solução RAG Ideal

**Componentes:**

```python
Ideal RAG System:
│
├── Vector Database
│   ├── Document chunks
│   ├── Embeddings
│   └── Similarity search
│
├── Knowledge Graph (Graphiti)
│   ├── Entities
│   ├── Relationships
│   ├── Temporal awareness
│   └── Graph traversal
│
├── Agent (Orchestrator)
│   ├── Query understanding
│   ├── Tool selection
│   ├── Multi-step reasoning
│   └── Result synthesis
│
└── Additional Strategies
    ├── Hybrid search
    ├── Contextual retrieval
    ├── Re-ranking
    └── Query expansion
```

**Afirmação do instrutor:**

> "É por isso que cubro tantas estratégias diferentes no meu canal. Por que estou introduzindo você a knowledge graphs agora. Acho que algo assim realmente é o que compõe a solução RAG ideal para a maioria dos agentes que você quer criar."

### Graphiti como Escolha Principal

**Posicionamento:**

> "E Graphiti sendo um dos melhores para o knowledge graph."

**Diferencial - Temporal Awareness:**

> "E eu simplesmente amo como esse temporal-aware apenas adiciona tanto contexto rico aos meus agentes."

**Prova:**
> "Como você viu naquela demo, se isso não te convence da ideia de pelo menos experimentar Graphiti, não sei o que convenceria."

### Stack Recomendado

```
Knowledge Graph Layer: Graphiti
├── Temporal awareness
├── Dynamic data handling
├── Fast queries (sub-second)
└── Production-ready

Vector Database Layer: [Sua escolha]
├── Pinecone
├── Weaviate
├── Qdrant
└── PostgreSQL + pgvector

Orchestration: Agentic RAG
├── Tool selection
├── Multi-strategy search
└── Context synthesis

Additional: Enhancement strategies
├── Hybrid search
├── Contextual RAG
└── Re-ranking
```

---

## Conclusão (26:07 - 26:38)

### Resumo

> "Aí está. Uma introdução limpa e simples ao Graphiti."

### Sentimento Geral

**Apreciação da plataforma:**
> "Eu simplesmente amo esta plataforma e definitivamente estou pensando em fazer mais conteúdo sobre ela no futuro."

**Call to action:**
> "Então, deixe-me saber nos comentários se você estaria interessado nisso."

### Posicionamento Final

**Convicção:**

> "Eu realmente acho que para a maioria dos agentes de IA, a solução RAG ideal tem um knowledge graph como uma das capacidades de busca e Graphiti é definitivamente um dos principais candidatos para uma ferramenta de knowledge graph."

**Ranking implícito:**
```
Top Knowledge Graph Tools:
1. Graphiti (temporal-aware, dynamic data)
2. LightRAG (static documents)
3. GraphRAG (static documents)

Escolha baseada em caso de uso
```

### Encerramento

**Agradecimento:**
> "Se você apreciou este conteúdo e está ansioso por mais coisas sobre RAG e agentes, eu realmente apreciaria um like e um subscribe."

**Despedida:**
> "E com isso, te vejo no próximo."

---

## Recursos Mencionados

### Links Principais

**Graphiti:**
- GitHub Repository
- Documentação Oficial
- Installation Guide

**Neo4j:**
- Neo4j Desktop Download
- Neo4j Browser

**Local AI Package:**
- Vídeo Masterclass (canal)
- Setup Instructions

**Conteúdo Relacionado (Canal):**
- Pydantic AI tutorials
- Agentic RAG explicado
- Hybrid RAG strategies
- Contextual RAG
- LightRAG comparison
- GraphRAG overview

### Templates e Código

**GitHub Repository (Instrutor):**
- Quickstart example
- Full AI Agent example
- README com instruções
- Environment variables template

**Arquivos principais:**
- `quickstart.py`
- `llm_evolution.py`
- `agent.py`
- `.env.example`
- `README.md`

---

## Conceitos-Chave e Glossary

### Termos Principais

**Temporal-Aware Knowledge Graph**
- Knowledge graph que rastreia mudanças ao longo do tempo
- Mantém registro histórico
- Timestamps para valid_at e invalid_at

**Episodes (Graphiti)**
- Unidades de informação adicionadas ao grafo
- Podem ser text, json, ou outros formatos
- Processados por LLM para extrair entidades e relacionamentos

**Agentic RAG**
- RAG onde agente escolhe como explorar conhecimento
- Múltiplas ferramentas de busca
- Raciocínio sobre qual estratégia usar

**Center Node Search**
- Busca refinada ao redor de node específico
- Útil para desambiguação
- Re-ranking contextual

**Search Recipes**
- Diferentes estratégias de busca otimizadas
- Node-focused vs Edge-focused
- Configurável por caso de uso

### Comparações

| Aspecto | Traditional RAG | Knowledge Graph | Graphiti |
|---------|----------------|-----------------|----------|
| **Estrutura** | Vetores planos | Nodes + Edges | Nodes + Edges + Time |
| **Busca** | Similaridade | Relacional | Relacional + Temporal |
| **Updates** | Replace | Add/Update | Add + Invalidate |
| **Histórico** | ✗ Não | ✗ Não | ✓ Sim |
| **Latência** | Rápida | Variável | Sub-second |
| **Dados** | Estáticos | Estáticos | Dinâmicos |

---

## Casos de Uso Recomendados

### Graphiti Ideal Para:

```
✓ Customer support (preferências em evolução)
✓ E-commerce (catálogo dinâmico, estoque)
✓ Mercado financeiro (preços, tendências)
✓ Notícias e mídia (eventos em tempo real)
✓ CRM systems (relacionamentos de clientes)
✓ Plataformas sociais (conexões, interações)
✓ IoT e monitoramento (métricas em tempo real)
✓ Business intelligence (KPIs em evolução)
```

### LightRAG/GraphRAG Ideal Para:

```
✓ Documentação técnica
✓ Livros e publicações
✓ Bases de conhecimento estáticas
✓ Análise de corpus fixo
✓ Pesquisa acadêmica
```

---

## Melhores Práticas

### Ingestão de Dados

```python
# ✓ BOM: Timestamp preciso
await graphiti.add_episode(
    ...,
    reference_time=datetime.now()
)

# ✗ RUIM: Timestamp genérico
reference_time=datetime(2024, 1, 1)
```

### Otimização de Custos

```python
# Use modelos mais baratos para ingestão
graphiti = Graphiti(
    embedding_model="text-embedding-3-small",
    llm_model="gpt-3.5-turbo"  # Mais barato
)

# Modelo melhor só para queries do agente
agent = Agent(model="gpt-4")
```

### Cleanup

```python
# Sempre fechar conexões
async def main():
    graphiti = Graphiti(...)
    try:
        # ... operações ...
    finally:
        await graphiti.close()
```

### Agent Tools

```python
# Fornecer contexto temporal ao agente
formatted_result = {
    "fact": result.fact,
    "valid_at": result.valid_at,
    "invalid_at": result.invalid_at or "Current",
    "confidence": result.score
}
```

---

## Troubleshooting Comum

### Knowledge Graph não conectando entidades

**Causa:** LLM não identificou relacionamento
**Solução:**
- Seja mais explícito nos episodes
- Use formato JSON para relacionamentos claros
- Considere adicionar metadata extra

### Queries lentas

**Causa:** Grafo muito grande, muitos nodes
**Solução:**
- Use center node search
- Limite num_results
- Configure search recipes apropriados

### Informação obsoleta retornada

**Causa:** Fato não foi invalidado
**Solução:**
- Adicione episode explicitamente invalidando
- Verifique timestamps
- Agent deve raciocinar sobre invalid_at

### Custos altos de API

**Causa:** Muitas chamadas LLM durante ingestão
**Solução:**
- Use modelos mais baratos
- Batch episodes quando possível
- Cache quando apropriado

---

## Próximos Passos

### Para Iniciantes

1. Setup Neo4j (Desktop ou Local AI)
2. Clone repo de exemplos
3. Configure .env
4. Run quickstart.py
5. Experimente com agent.py

### Para Avançados

1. Integre com sistema existente
2. Combine com vector database
3. Implemente search recipes customizados
4. Otimize para seu domínio
5. Deploy em produção

### Exploração Adicional

- Documentação oficial Graphiti
- Vídeos sobre Pydantic AI
- Agentic RAG patterns
- Neo4j query optimization
- Production deployment strategies

---

## Tags

`#graphiti` `#knowledge-graphs` `#temporal-rag` `#neo4j` `#agentic-rag` `#pydantic-ai` `#vector-database` `#llm` `#rag` `#ai-agents` `#dynamic-data` `#temporal-awareness` `#graph-search`
