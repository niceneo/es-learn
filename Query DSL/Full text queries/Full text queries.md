## Full text queries (全文本查询)
全文本查询能使用搜索通过分析文本字段，从邮件中检索出body部分。查询字符串处理使用了相同分词方式，在索引字段时。

这组查询:
###### [intervals query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-intervals-query.html)    
全文本查询允许控制精细粒度的指令，接近匹配的字段

###### [match query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-query.html    
标准的全文本查询，包括fuzzy 模糊查询，phrase 短语查询, proximity 邻近查询

###### [match_bool_prefix query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-bool-prefix-query.html)    
增加布尔查询，匹配每一个字段的查询，除开最后一个字段，使用匹配前缀查询。

###### [match_phrase query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-query-phrase.html)    
像匹配查询，但是用匹配精准短语，或邻近词匹配

###### [match_phrase_prefix query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-query-phrase-prefix.html)    
像短语匹配查询，但是使用一个通配符，在搜索最后一个词

###### [multi_match query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.html)    
多字段版本匹配查询

###### [common terms query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-common-terms-query.html)   
一些专业查询匹配一些不常用的词

###### [query_string query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)    
支持简洁的lucense查询字符串语法，允许你指定(AND|OR|NOT)条件和多字段检索，在单个查询字符串内，仅供专家使用。

###### [simple_query_string query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-simple-query-string-query.html)    
更简单，更健壮的字符串查询版本语法，适用于直接暴露给用户使用