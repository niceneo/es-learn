## Compound queries(混合查询)
混合查询封装了其他混合查询或者叶子查询，结合他们结果和计算得分改变他们的行为，或者通过过滤上下文从查询中进行转换。

[bool query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html)    
默认查询结合多个子查询或混合查询子句，像```must```,```should```,```must_not```或者```filter```子句. 匹配的子句越多越好，```must```和```should```子句计算得分总和。
然而，```must_not```和```filter```子句通常在过滤上下文中使用。

[boosting query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-boosting-query.html)    
返回一个文档，匹配积极的查询```positive```，同时通过匹配```negative```查询，减少文档得分，，总之一句话，```boosting```是修改文档相关性的程序。

[constant_score query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-constant-score-query.html)    
在过滤上下文中执行的查询，或者子查询，匹配所有文档都会得到同样常量的得分。(固定得分)

[dis_max query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-dis-max-query.html)    
一个查询是由多个查询组成，返回的所有文档匹配任何查询子句。```bool```结合所有匹配查询的得分，```dis_max```查询使用最好的得分，匹配查询子句。

[function_score query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html)    
修改主查询返回的得分，通过函数的方式，需要考虑像受欢迎程度，新旧，距离，或者自定义脚本实现。