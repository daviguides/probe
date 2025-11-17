# Agentic RAG + Knowledge Graphs - Transcrição do Vídeo

**Vídeo:** RAG com Grafos de Conhecimento
**URL:** https://www.youtube.com/watch?v=p0FERNkpyHE
**Data:** 2025-11-13

---

## Introdução (0:00 - 1:08)

Nos últimos meses, tenho explorado profundamente todas as estratégias de RAG possíveis, buscando a melhor maneira de dar aos meus agentes de IA a capacidade de pesquisar meu conhecimento.

As duas estratégias que continuo revisitando são:
- **Agentic RAG**
- **Knowledge Graphs (Grafos de Conhecimento)**

A melhor parte é que é muito fácil combinar essas duas estratégias para criar sistemas de recuperação de conhecimento extremamente poderosos para agentes de IA.

### Conteúdo do Vídeo

1. Demonstração ao vivo
2. Por que usar Agentic RAG e Knowledge Graphs
3. Como o agente funciona
4. Como usei Claude Code para construir este template

---

## Demonstração do Agente (1:08 - 2:41)

### Interface de Linha de Comando

Construí uma interface CLI simples que se comunica com meu agente hospedado através de um endpoint de API.

### Capacidades do Agente

O agente tem acesso a:
- **Vector Database (Banco de Dados Vetorial)**
- **Knowledge Graph (Grafo de Conhecimento)**

Através de ferramentas do agente, ele pode escolher como explorar o conhecimento na base de conhecimento.

### Arquitetura de Dados

#### PostgreSQL + pgvector
- Usando a plataforma Neon para PostgreSQL
- Extensão pgvector para capacidades vetoriais
- É um banco SQL completo, não apenas um banco vetorial
- Contém embeddings para todos os chunks de documentos (RAG tradicional)

#### Documento de Exemplo
- Informações sobre iniciativas de IA de grandes empresas de tecnologia
- Empresas incluídas: OpenAI, Microsoft, Amazon, Anthropic
- Documentos divididos em chunks e embedded no banco de dados

---

## Knowledge Graph - Visualização (2:10 - 3:10)

### Estrutura Relacional

O Knowledge Graph representa informações de forma diferente - muito mais relacional - dando ao agente a capacidade de explorar o conhecimento de maneira alternativa.

### Exemplos de Relacionamentos

**Amazon ↔ Anthropic**
- Amazon investiu na Anthropic
- Toda infraestrutura da Anthropic roda em AWS

**Microsoft ↔ OpenAI**
- Parceria estratégica
- OpenAI usa exclusivamente Azure para hospedar modelos

### Por que usar ambos?

Quando pensamos em iniciativas de IA para grandes empresas:
- **Knowledge Graph:** Melhor para ver como empresas trabalham juntas
- **Vector Database:** Melhor para buscar informações individuais sobre empresas específicas

Este é o tipo de raciocínio que queremos permitir que o agente execute ao responder perguntas.

---

## Exemplos de Queries (3:17 - 4:17)

### Query 1: Busca Vetorial Simples

**Pergunta:** "What are the AI initiatives for Google?"

**Ferramenta utilizada:** Vector Search
- Query: "Google AI initiatives"
- Resposta obtida com sucesso

**Análise:** Não precisou do Knowledge Graph, apenas busca vetorial simples.

### Query 2: Busca Relacional

**Pergunta:** "How are OpenAI and Microsoft related?"

**Ferramenta utilizada:** Graph Search
- Query: "OpenAI Microsoft relationship"
- Resposta: Discute Azure como provedor exclusivo para modelos OpenAI

**Análise:** Pergunta que explicitamente requer consulta ao Knowledge Graph para ver relacionamentos.

### Query 3: Busca Combinada

**Pergunta:** "What are the initiatives for Microsoft? How does that relate to Anthropic? Use both search types."

**Ferramentas utilizadas:**
1. Vector Search - Buscar iniciativas de IA da Microsoft
2. Graph Search - Comparar estratégias Microsoft e Anthropic

**Análise:**
- Primeiro busca informações gerais
- Depois refina comparando relacionamentos
- Demonstra flexibilidade do sistema agentic

---

## Tech Stack (5:24 - 6:35)

### Bibliotecas e Ferramentas Principais

| Componente | Tecnologia | Propósito |
|------------|-----------|-----------|
| **AI Agent Framework** | Pydantic AI | Core do agente |
| **Knowledge Graph Library** | Graphiti | Gerenciamento do grafo |
| **Graph Engine** | Neo4j | Motor subjacente do grafo |
| **Vector Database** | PostgreSQL + pgvector | Armazenamento vetorial |
| **API Framework** | FastAPI | API do agente em Python |
| **AI Coding Assistant** | Claude Code | Ferramenta de desenvolvimento |

### Arquivos no Repositório

O repositório inclui arquivos mostrando como trabalhei com Claude Code para construir o template.

---

## Agentic RAG - Conceitos (6:36 - 9:17)

### Evolução do RAG

Artigo de referência da Weaviate sobre RAG tradicional vs Agentic RAG.

### Vanilla/Naive RAG

**Processo:**
1. Documentos → Chunks (pedaços de tamanho adequado para LLM)
2. Embedding Model → Representação vetorial
3. Armazenamento em Vector Database (Quadrant, Pinecone, Weaviate, etc.)
4. User Query → Embedding
5. Busca por similaridade no banco vetorial
6. Context retrieval → Adiciona ao prompt do LLM
7. Geração de resposta aumentada

**Limitações:**
- Extremamente inflexível
- Fluxo de dados rígido: Query → Embed → Retrieve → Generate
- Agente forçado a usar o contexto recuperado
- Sem capacidade de refinar buscas
- Sem opção de exploração mais profunda
- Não suporta múltiplas fontes de conhecimento

### Agentic RAG

**Diferencial Principal:**
> Dar ao agente a capacidade de raciocinar sobre como explorar a base de conhecimento, ao invés de sempre forçar o contexto como pré-processamento.

**Capacidades:**
- Definir queries dinamicamente
- Explorar diferentes vector databases
- Usar outras ferramentas (ex: web search) para suplementar
- Raciocinar sobre quando usar cada tipo de busca
- Muito mais flexibilidade

### Combinação: Agentic RAG + Knowledge Graphs

**Estratégia:**
- Mesmo dado armazenado de duas formas diferentes:
  - Vector Database (busca por similaridade)
  - Knowledge Graph (busca relacional)

**Raciocínio do Agente:**

```
Se pergunta sobre empresa única (ex: Google):
  → Usar Vector Database
  → Busca simples de informações

Se pergunta sobre relacionamento (ex: Microsoft + OpenAI):
  → Usar Knowledge Graph
  → Explorar entidades e relacionamentos

Se pergunta complexa:
  → Combinar ambas as buscas
  → Máxima flexibilidade
```

---

## Setup do Template (10:23 - 15:15)

### Pré-requisitos

1. **Python** instalado
2. **PostgreSQL Database** (recomendado: Neon)
3. **Neo4j Database**
4. **LLM Provider API Key**
   - OpenAI
   - Ollama (local)
   - Gemini
   - Outros compatíveis com OpenAI API

### Instalação Básica

```bash
# Criar ambiente virtual
python -m venv venv
source venv/bin/activate  # Linux/Mac
# ou
venv\Scripts\activate  # Windows

# Instalar dependências
pip install -r requirements.txt
```

### Configuração do PostgreSQL (Neon)

#### SQL Setup

Localização: `sql/setup.sql`

**Caveats Importantes:**

1. **Dimensões do Embedding:**
   - Default: 1536 (text-embed-3-small da OpenAI)
   - Se usar outro modelo, atualizar em 3 lugares no SQL
   - Exemplo: Se usar Ollama com outro modelo

2. **Destruição de Tabelas:**
   - O script destrói e recria tabelas
   - Recomendado: usar em projeto novo

**Passos:**

1. Acessar [neon.tech](https://neon.tech)
2. Criar novo projeto (free tier disponível)
3. Ir para SQL Editor
4. Colar e executar o SQL do arquivo
5. Ignorar warnings - tabelas serão recriadas

**Por que Neon?**

- Free tier generoso
- Um dos fundadores (Heikki) contribui com PostgreSQL há 20+ anos
- Fácil de usar e configurar

### Configuração do Neo4j

#### Opção A: Local AI Package

- Pacote curado de software gratuito e open-source
- Neo4j incluído como serviço
- Link para masterclass disponível
- Obter username e password do setup

#### Opção B: Neo4j Desktop

- Instalar Neo4j Desktop
- Link: [neo4j.com/download](https://neo4j.com/download)
- Fácil de configurar
- Obter connection details do dashboard

---

## Configuração de Environment Variables (15:15 - 18:12)

### Arquivo .env

Copiar `.env.example` para `.env` e configurar:

### Database URLs

```bash
# PostgreSQL (Neon)
DATABASE_URL=postgresql://user:password@host/database

# Como obter (Neon):
# Dashboard → Connect → Copy connection string
# Importante: Mostrar password ou substituir asteriscos

# Neo4j
NEO4J_URI=bolt://localhost:7687
NEO4J_USERNAME=seu_username
NEO4J_PASSWORD=sua_senha
```

### LLM Provider Configuration

```bash
# Provider (escolher um)
LLM_PROVIDER=openai  # ou: open_router, ollama, gemini

# Base URL (exemplos)
# OpenAI (default)
LLM_BASE_URL=https://api.openai.com/v1

# Ollama (local)
LLM_BASE_URL=http://localhost:11434/v1

# Open Router
LLM_BASE_URL=https://openrouter.ai/api/v1

# API Key
LLM_API_KEY=sua_api_key  # ou "ollama" para uso local

# Model
LLM_MODEL=gpt-4.1-mini  # ou outro modelo
```

### Embedding Provider Configuration

**Flexibilidade:** Permite usar provider diferente do LLM

**Por quê?** Alguns providers (ex: Open Router) não oferecem modelos de embedding

```bash
# Embedding Provider
EMBEDDING_PROVIDER=openai  # ou: gemini, ollama

# Base URL (similar ao LLM)
EMBEDDING_BASE_URL=https://api.openai.com/v1

# API Key
EMBEDDING_API_KEY=sua_api_key

# Model
EMBEDDING_MODEL=text-embedding-3-small
```

### Ingestion LLM (Opcional)

**Propósito:** Modelo para processar documentos e transformar em knowledge graph

```bash
# Modelo mais leve para ingestion
INGESTION_LM_MODEL=gpt-4.1-nano
```

**Recomendação:** Usar modelo lightweight para reduzir custos

### Outras Configurações

```bash
# Deixar como default - configurações internas
# Relacionadas a:
# - Knowledge graph
# - Ingestão de documentos
# - Processamento
```

**Importante:** Configurar apenas de `INGESTION_LM_CHOICE` para cima. O resto pode manter default.

---

## Setup da Base de Conhecimento (18:17 - 21:56)

### Estrutura de Documentos

```bash
# Criar pasta (já incluída no repo)
mkdir documents

# Adicionar documentos markdown
documents/
  ├── doc1.md
  ├── doc2.md
  └── doc3.md
```

### Documentos de Exemplo

**Tema:** Iniciativas de IA de grandes empresas tech

**Empresas cobertas:**
- Google
- Microsoft
- OpenAI
- Amazon
- Anthropic

**Por que este tema?**
- Funciona bem com vector databases (informações individuais)
- Funciona bem com knowledge graphs (relacionamentos entre empresas)
- Demonstra valor da abordagem combinada

### Pipeline de Ingestão

**Nota:** Este é um pipeline básico, não comprehensivo

**Para pipeline completo:**
- Veja o curso AI Agent Mastery (Dynamus AI)
- Cobre: Google Drive, arquivos locais, watch de mudanças
- Deploy em produção
- RAG mais robusto

### Executar Ingestão

```bash
# Comando básico
python -m ingestion.ingest

# Com flag de limpeza (recomendado primeira vez)
python -m ingestion.ingest --clean

# Flag --clean:
# - Limpa knowledge graph
# - Limpa tabelas do vector database
# - Inicia do zero
```

### Processo de Ingestão

#### Fase 1: Inicialização
```
→ Conectando ao database
→ Conectando ao knowledge graph
→ Inicializando com Graphiti
```

#### Fase 2: Vector Database (RÁPIDO)
```
✓ 7 chunks criados
✓ Inseridos no vector database
⏱️  Alguns segundos
```

**Verificação no Neon:**
- Acessar tabela `chunks` → 7 chunks presentes
- Acessar tabela `documents` → 1 documento

#### Fase 3: Knowledge Graph (LENTO)

**Por que é lento?**

> Criar knowledge graph é computacionalmente caro porque usa LLMs para definir todas as entidades e relacionamentos.

**Processo:**
- Cada "episode" (Graphiti) precisa ser processado
- Entidades precisam ser identificadas
- Relacionamentos precisam ser definidos
- Tudo via chamadas a LLMs

**Tempos:**
- Vector Database: ~5 segundos
- Knowledge Graph: ~2 minutos (para 1 documento)

**Otimização disponível:**

```bash
# Opção para pular knowledge graph
python -m ingestion.ingest --no-knowledge-graph

# Resultado: Processamento muito mais rápido
# Trade-off: Sem capacidades de grafo
```

**Verificação no Neo4j:**

```cypher
// Query para visualizar grafo
MATCH (n)-[r]->(m) RETURN n, r, m
```

Resultado: Grafo completo com empresas e relacionamentos

---

## Configuração do Comportamento do Agente (22:26 - 24:47)

### Localização

```
agent/prompts.py
```

### System Prompt Principal

**Propósito:** Instruções que definem quando e como o agente usa cada capacidade.

### Customização Necessária

> "Eu posso criar um template genérico o máximo possível, mas baseado nas suas informações específicas, VOCÊ precisa controlar quando o agente busca em diferentes lugares."

### Estrutura do Prompt

```python
# prompts.py

SYSTEM_PROMPT = """
Você tem acesso a:
- Vector Database
- Knowledge Graph
- [Outras capacidades]

Use essas ferramentas da seguinte forma:

1. KNOWLEDGE GRAPH:
   - Quando: Usuário pergunta sobre DUAS empresas na mesma questão
   - Por quê: Analisar relacionamentos
   - Exemplo: "Como Amazon e Anthropic estão relacionadas?"

2. VECTOR STORE:
   - Quando: Perguntas sobre empresa única
   - Por quê: Busca simples de informações
   - Exemplo: "Quais são as iniciativas de IA do Google?"

3. AMBAS AS ABORDAGENS:
   - Quando: Solicitado explicitamente
   - [Nota: Isso é para demo - em produção, deixe agente decidir]
"""
```

### Exemplo de Instruções

**Para Knowledge Graph:**
```
Use a ferramenta de knowledge graph APENAS quando o usuário
perguntar sobre duas empresas na mesma questão, porque queremos
analisar o relacionamento entre elas.
```

**Para Vector Database:**
```
Caso contrário, use a ferramenta de vector store para buscas
diretas de informação.
```

**Para Combinação:**
```
Combine ambas as abordagens apenas quando explicitamente
solicitado.
```

### Nota sobre Demonstração

O prompt atual inclui "quando solicitado" para fins de demonstração.

**Em produção:**
- Usuário final não sabe que há vector DB e knowledge graph
- Agente deve raciocinar automaticamente
- Prompt deve permitir decisão autônoma

### Customização Recomendada

**Baseado no seu domínio:**

```python
# Exemplo: E-commerce
"""
KNOWLEDGE GRAPH: Use para perguntas sobre relacionamentos
- Produtos relacionados
- Categorias e subcategorias
- Histórico de compras de clientes

VECTOR STORE: Use para busca direta
- Descrições de produtos
- Especificações técnicas
- FAQs
"""

# Exemplo: Documentação técnica
"""
KNOWLEDGE GRAPH: Use para explorar
- Dependências entre módulos
- Hierarquia de classes
- Fluxo de dados

VECTOR STORE: Use para buscar
- Exemplos de código
- Documentação de funções
- Tutoriais
"""
```

---

## Executando o Agente (24:47 - 28:10)

### Iniciando o API Server

```bash
# Terminal 1
python -m agent.api
```

**Processo de inicialização:**
```
→ Conectando ao database...
→ Conectando ao Graphiti...
✓ Graph connection successful
✓ Ready to start
```

**Endpoint disponível:**
- URL: `http://localhost:8000`
- Porta pode ser customizada via env vars

**Nota sobre logs:** Ignorar warnings - nada está errado

### Métodos de Comunicação

#### Opção 1: HTTP Requests Diretos

```bash
# Endpoint chat simples
curl -X POST http://localhost:8000/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "What are the AI initiatives for Google?"}'

# Endpoint com streaming
curl -X POST http://localhost:8000/chat/stream \
  -H "Content-Type: application/json" \
  -d '{"message": "How are OpenAI and Microsoft related?"}'
```

#### Opção 2: CLI (Recomendado)

```bash
# Terminal 2 (manter Terminal 1 rodando)
python cli.py

# Com custom port/URL (opcional)
python cli.py --url http://localhost:8000
```

**Inicialização do CLI:**
```
→ Connecting to API...
✓ API is healthy
✓ Ready to chat
```

### Testando o Agente

#### Teste 1: Saudação

```
User: hi

[API Log] → Request successful: /chat/stream

Agent: Hello! How can I help you today?
```

#### Teste 2: Vector Search

```
User: What are the AI initiatives for Google?

Tools Used:
✓ Vector Search

Response:
[Resposta detalhada sobre iniciativas de IA do Google]
```

**Observação no Terminal 1:**
```
[Request] POST /chat/stream - 200 OK
```

#### Teste 3: Graph Search

```
User: How are Amazon and Anthropic related?

Tools Used:
✓ Graph Search
✓ Vector Search (adicional)

Response:
Amazon and Anthropic have a strategic partnership.
Amazon invested in Anthropic, and Anthropic's entire
infrastructure runs on AWS.
```

**Análise:**
- Usado Graph Search (esperado)
- Também Vector Search (decisão do agente)
- Comportamento não determinístico de LLMs
- Resposta correta obtida ✓

#### Teste 4: Busca Combinada

```
User: What are the AI initiatives for Microsoft?
How does that relate to Anthropic? Use both search types.

Tools Used:
✓ Vector Search (Microsoft initiatives)
✓ Graph Search (Microsoft-Anthropic comparison)

Response:
[Primeiro busca info da Microsoft]
[Depois compara estratégias Microsoft vs Anthropic]
```

### Agentic RAG em Ação

**O que está acontecendo:**
- Agente RACIOCINA sobre como explorar conhecimento
- Não é sempre o mesmo caminho
- LLMs são não-determinísticos
- Desde que obtenha resposta correta, está OK

**Poder da abordagem:**
- Flexibilidade
- Adaptabilidade
- Raciocínio contextual

### Comandos CLI Adicionais

**Disponíveis no README:**
- Histórico de conversas
- Limpar contexto
- Configurações
- Troubleshooting

### Documentação

**Também no README:**
- Como tudo funciona internamente
- Estrutura do projeto
- API documentation
- Unit tests
- Seção de troubleshooting

---

## Como Usei Claude Code (28:16 - 38:24)

### Visão Geral

**Disclaimer:** Usar Claude Code poderia ser um vídeo inteiro
- Vídeo deep dive virá no futuro
- Este é overview de alto nível
- Foco em como começar o projeto

### Filosofia de Uso

> "Eu NÃO recomendo 'vibe coding'. Você deve ter conhecimento para validar o output do assistente de IA e adicionar os últimos 10% para fazer tudo funcionar."

**Mas:** Para começar projetos, Claude Code é extremamente poderoso

### MCP Servers Setup

#### 1. Crawl for RAG MCP Server

```bash
# Adicionar MCP server
[comando para adicionar crawl-for-rag MCP]
```

**Propósito:**
- Adiciona documentação externa via RAG
- Claude Code aprende a usar bibliotecas
- Exemplo: Pydantic AI documentation

**Cobertura anterior:** Vídeo dedicado disponível no canal

#### 2. Neon MCP Server

```bash
# Adicionar Neon MCP
[comando para adicionar neon MCP]
```

**Capacidades:**
- Criar projeto no Neon automaticamente
- Executar queries SQL
- Gerenciar tabelas
- Validar schemas
- **TUDO automático durante desenvolvimento**

**Por que é crucial:**

> "Claude Code é tão agentic que pode fazer basicamente tudo por você. Pode planejar, criar task list, completar uma por uma, configurar database automaticamente, escrever testes, iterar - processo agentic completo de 30min a 1h."

**Benefício:**
- Não precisa interromper para configurar database manualmente
- Fluxo contínuo de desenvolvimento
- Database management automático

### Primeira Versão do Agente

**Fato impressionante:**
- Claude Code rodou por **35 minutos** contínuos
- Construiu primeira versão completa
- Totalmente agentic

### Plan Mode (Shift + Tab + Tab)

#### Acessando Plan Mode

```
Shift + Tab (1x) → Auto-accept mode
Shift + Tab (2x) → Plan mode
```

**Propósito do Plan Mode:**
> "Força Claude Code a NÃO escrever nada no sistema de arquivos ainda. Primeiro criamos plano comprehensivo."

#### Processo Recomendado

**Passo 1: Brainstorm**
```
1. Começar despejando ideias sobre o que quer criar
2. Pedir para fazer perguntas de follow-up
3. Claude Code começa entender:
   - O que você quer construir
   - Tipo de arquitetura necessária
```

**Passo 2: Geração de Documentos**

Claude Code cria 3 arquivos-chave:
1. `.claude.md` (global rules)
2. `planning.md` (plano do projeto)
3. `tasks.md` (lista de tarefas)

### Arquivos-Chave de Planejamento

#### 1. `.claude.md` - Global Rules

**Similar a:**
- Cursor rules
- Windsurf rules

**Conteúdo:**
```markdown
# Global Rules para AI Coding Assistant

## Como usar planning.md e tasks.md
[instruções]

## Como usar MCP servers
[instruções]

## Como trabalhar com unit testing
[instruções]

## [Outras regras globais]
```

**Fonte:** Vídeo sobre AI coding assistants (link disponível)
- Cobre global rules em detalhes
- Recurso disponível naquele vídeo

#### 2. `planning.md` - Project Plan

**Conteúdo de alto nível:**

```markdown
# Project Planning

## Architecture Overview
[Descrição da arquitetura]

## Core Components
### Component 1: Agent System
- Location: /agent
- Responsibilities: [...]
- Dependencies: [...]

### Component 2: Knowledge Base
- Location: /ingestion
- Responsibilities: [...]
- Dependencies: [...]

## Technology Stack
- Pydantic AI: [propósito]
- Graphiti: [propósito]
- Neo4j: [propósito]
- PostgreSQL + pgvector: [propósito]
- FastAPI: [propósito]

## Key Libraries
[Lista detalhada]

## Design Principles
1. [Princípio 1]
2. [Princípio 2]
3. [...]

## Folder Structure
```
project/
├── agent/
│   ├── api.py
│   ├── prompts.py
│   └── tools.py
├── ingestion/
│   └── ingest.py
├── documents/
└── sql/
```

## [Mais detalhes...]
```

**Características:**
- Muito detalhado
- Referencia paths específicos
- Claude Code constrói JUNTO com você
- Baseado em suas respostas e descrições

#### 3. `tasks.md` - Task List

**Formato:**

```markdown
# Tasks

## Setup
- [ ] Configure database connection
- [ ] Setup Neo4j integration
- [ ] Install dependencies

## Core Development
- [ ] Build agent system
- [ ] Create RAG pipeline
- [ ] Implement knowledge graph integration
- [ ] Setup vector database

## Testing
- [ ] Write unit tests
- [ ] Integration tests
- [ ] E2E tests

## Documentation
- [ ] README
- [ ] API documentation
- [ ] Setup guide
```

**Como funciona:**
1. Claude Code percorre lista
2. Marca com X quando completa: `- [x] Task completed`
3. Ordem de operações definida pela lista

**Configuração:** Ver `.claude.md` para instruções de como marcar

### Processo de Desenvolvimento

#### Fase 1: Planning Session

```
User: [Descreve o que quer construir]

Claude: [Faz perguntas de clarificação]

User: [Responde perguntas]

Claude: [Gera planning.md e tasks.md]
```

#### Fase 2: Início da Construção

**Saindo do Plan Mode:**
```
Shift + Tab → Exit plan mode
```

**Prompt de início (SUPER SIMPLES):**

```
User: take a look at planning and task md files
and execute that plan
```

**Por que tão simples?**
- Todo trabalho já feito nos 3 arquivos
- `.claude.md` → Como trabalhar
- `planning.md` → O que construir
- `tasks.md` → Ordem de execução
- Claude Code já sabe tudo

#### Fase 3: Execução Agentic

**Processo automático:**

```
→ Reading planning.md and tasks.md
→ Using Neon MCP to create project
→ Using Crawl for RAG to get Pydantic AI docs
→ Writing code
→ Running SQL
→ Creating tests
→ Iterating on tests
→ [... 35 minutos depois ...]
→ ✓ Project complete
```

**Única responsabilidade do desenvolvedor:**
- Aprovar ações
- Revisar código gerado
- Validar outputs

### Aprovações de MCP

**Primeira vez usando MCP tool:**

```
Claude Code: I want to use Neon MCP to create project
             Do you approve?

User: [Approve]
      [ ] Ask every time
      [x] Auto-approve for this tool
```

**Ações automáticas depois:**
- Criar projetos Neon
- Executar SQL
- Buscar documentação (Crawl for RAG)
- Todas as ferramentas aprovadas

**Configuração prévia:** Pode configurar aprovações antes de começar

### Fornecendo Exemplos

#### Pasta Examples

```
examples/
├── graffiti_setup.py
├── pydantic_ai_agent.py
├── multi_llm_support.py
└── vector_search.py
```

**Conteúdo:**
- Scripts Python de projetos anteriores
- Exemplos de implementações específicas
- Referências de best practices

**Uso:**

```markdown
# planning.md

## Reference Examples

When implementing:
- Graphiti: See examples/graffiti_setup.py
- Pydantic AI: See examples/pydantic_ai_agent.py
- Multi-LLM: See examples/multi_llm_support.py

Follow patterns from these examples.
```

**Fontes dos exemplos:**
- Vídeos do YouTube
- Conteúdo exclusivo da comunidade Dynamus
- Projetos anteriores pessoais

**Importante:**
> "Exemplos não estarão no source control, mas planning.md, .claude.md e tasks.md ESTARÃO disponíveis no GitHub."

### Disponível no GitHub

**Arquivos compartilhados:**
- ✓ `.claude.md` (global rules)
- ✓ `planning.md` (plano do projeto)
- ✓ `tasks.md` (task list)
- ✗ `examples/` (não incluídos)

**Uso sugerido:**
- Usar como modelo
- Adaptar para seus projetos
- Aprender estrutura de planejamento

### Preview: Vídeo Completo sobre Claude Code

**Planejado:**
- Deep dive completo em Claude Code
- Técnicas avançadas
- Melhores práticas
- Fluxos de trabalho

**Este vídeo:** Apenas bonus/introdução

---

## Conclusão (38:24 - 38:47)

### Agradecimentos

**Parceiro:** Neon
- Obrigado por tornar este vídeo possível

### Próximos Passos

**Se você gostou:**
- 👍 Like no vídeo
- 🔔 Subscribe no canal
- Usar o template você mesmo

### Próximos Conteúdos

Fique ligado para mais vídeos sobre:
1. **Agentic RAG**
2. **Knowledge Graphs**
3. **Claude Code** (deep dive completo)

---

## Recursos e Links

### GitHub Repository
- Template completo do agente
- Documentação
- Exemplos de configuração
- Planning files

### Comunidade Dynamus AI
- **AI Agent Mastery Course**
  - RAG pipeline completo
  - Google Drive integration
  - Deploy em produção
  - Sistema robusto de agentes

### Vídeos Relacionados
- MCP Servers (Crawl for RAG)
- AI Coding Assistants (Global Rules)
- Knowledge Graphs
- Agentic RAG

### Plataformas Mencionadas
- **Neon:** [neon.tech](https://neon.tech)
- **Neo4j:** [neo4j.com](https://neo4j.com)
- **Weaviate:** Artigo sobre RAG

---

## Glossary

| Termo | Definição |
|-------|-----------|
| **Agentic RAG** | Sistema RAG onde o agente raciocina sobre como explorar a base de conhecimento |
| **Knowledge Graph** | Representação de dados em formato de grafo com entidades e relacionamentos |
| **Vector Database** | Banco de dados otimizado para armazenar e buscar embeddings vetoriais |
| **Embedding** | Representação vetorial de texto/dados |
| **Chunk** | Pedaço de documento dividido para processamento |
| **LLM** | Large Language Model (Modelo de Linguagem Grande) |
| **MCP Server** | Model Context Protocol Server - extensões para AI assistants |
| **pgvector** | Extensão PostgreSQL para trabalhar com vetores |
| **Graphiti** | Biblioteca para gerenciamento de knowledge graphs |

---

## Tags

`#agentic-rag` `#knowledge-graphs` `#pydantic-ai` `#neo4j` `#postgresql` `#pgvector` `#claude-code` `#ai-agents` `#rag` `#vector-database` `#llm` `#fastapi` `#graphiti` `#neon` `#ai-coding`
