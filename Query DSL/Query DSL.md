## Query DSL
ES提供所有Query查询语言，基于JSON定义的查询，Query DSL像特定语言查询一样，考虑两个方面的字句。

#### Leaf query clauses (叶子查询字句)
叶子查询字句，在特定的字段搜索特定值，像[match](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-query.html),[term](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-term-query.html),或者[range](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-range-query.html)查询，他们可以使用这类查询。

#### Compound query clauses (混合查询子句)
混合查询子句在逻辑上封装其他叶子子句或者其他混合查询子句使用多个查询，(例如：```bool```或者```dis_max```查询)，或者其他行为(例如```constant_score```查询)

查询子句的行为不同取决于他们使用的[query contenxt or filter context](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-filter-context.html)  查询上下文，过滤上下文。
