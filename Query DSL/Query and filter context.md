## Query and filter context(查询与过滤上下文)
查询子句的行为取决于是使用的查询上下文，或者过滤上下文。

#### Query context
一个查询子句使用查询上下文查找的问题是“这个文档与查询子句是匹配程度，或者说是文档与查询子句的相关度”，决定了文档是否匹配。这个查询子句会对匹配的文档进行计算得分，```_score```,相对于其他文档。
在[search](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-query.html) API当中的```query```参数，适用于所有查询上下文的查询子句。

#### Filter context
在过滤上下文中，一个查询子句回答了“这个文档是否匹配？"这个问题。答案简单，要么yes或者no,没有计算得分，过滤上下文更多是用在过滤数据结构。e.g.
- @timestamp时间，是否在2015-2016年时间段。
- ```status```字段设置是否为"published"?

使用过滤，会自动频繁使用缓存，提高检索性能。

一个查询子句里```filter```的参数，是可以影响过滤上下文，又例如在[bool](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html)查询里面的```filter```或者```must_not```参数。[constant_score](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-constant-score-query.html)里的filter参数。或者[filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-filter-aggregation.html)聚合

下述例子查询子句使用查询和过滤上下文，在```search```API中。
- ```title```字段包含```search```
- ```content```字段包含```elasticsearch```
- ```statue```字段不包含```pulished```
- ```publish_date```字段包含从2015年1月1日之后的。
```
GET /_search
{
  "query": {  #1
    "bool": {   #2
      "must": [
        { "match": { "title":   "Search"        }},   #3
        { "match": { "content": "Elasticsearch" }}    #4
      ],
      "filter": [   #5
        { "term":  { "status": "published" }},   #6
        { "range": { "publish_date": { "gte": "2015-01-01" }}}   #7
      ]
    }
  }
}
```
\#1 ```query```参数是查询上下文的标识
\#234 查询上下文内使用了```bool```和两个```match```子句，意味着他们使用了算分和匹配每一个文档
\#5 过滤上下文是```filter```参数标识，
\# 67 过滤上下文使用```term```和```range```子句。他们将过滤不匹配的文档，但是他们不会影响匹配文档的计分。

###### Tip
在查询上下文中使用查询子句，将影响计算得分，在匹配文档是，应该将不需要影响计算得分的查询子句放入过滤上下文。


