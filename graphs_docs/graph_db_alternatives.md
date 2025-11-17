## Graph Databases Open-Source

É preciso pequisar e considar cada uma(TODAS) das alternativas abaixo:

**1. Neo4j Community Edition**
- Limitações: sem clustering, sem hot backups, suporte limitado
- Boa para dev/prototyping, ruim para produção enterprise

**2. Memgraph**
- Compatível com Cypher (Neo4j query language)
- Performance muito boa (in-memory)
- Melhor alternativa ao Neo4j na minha opinião
- Community edition tem boa parte das features

**3. ArangoDB**
- Multi-model (graph + document + key-value)
- Query language própria (AQL)
- Performance boa, features enterprise na versão community

**4. JanusGraph**
- Distribuído, escalável
- Suporta diferentes backends (Cassandra, HBase, BerkeleyDB)
- Mais complexo de configurar

**5. Nebula Graph**
- Distribuído, open-source
- Performance muito boa em escala
- Arquitetura separada (storage/compute/query)

## Hybrid/Lighter Approaches

**6. PostgreSQL + pgvector + Apache AGE**
- AGE = Apache Graph Extension para Postgres
- Cypher queries no Postgres
- Aproveita infraestrutura existente