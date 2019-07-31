## Boolean query(布尔查询)
一个查询匹配的文档，要匹配布尔关系结合的其他查询。布尔查询映射为Lucene的```BooleanQuery```,他由一个或者多个布尔子句组成，每个子句的类型如下:
***
```must```    文档必须匹配查询子句，且与计算得分相关。(查询必须在文档中出现)
***
```filter```  查询必须在文档中出现，然而不像must，则会忽略计算得分，filter子句在[filter context](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-filter-context.html) 执行，意味着忽略计算得分和会查询缓存。
***
```should```  查询子句应该在文档中出现。
***
```must_not```  查询子句不应该出现在文档中，子句在[filter context](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-filter-context.html)中执行,意味着忽略计算得分，和会查询缓存。，因为忽略得分，所有的得分为0的文档被返回。
***

```bool```查询，是多匹配条件更好的处理。得分从每一个匹配```must```和```should```子句，加在一起，提供最后一个```_score```得分，对于每一个文档而言。

```
POST _search
{
  "query": {
    "bool" : {
      "must" : {
        "term" : { "user" : "kimchy" }
      },
      "filter": {
        "term" : { "tag" : "tech" }
      },
      "must_not" : {
        "range" : {
          "age" : { "gte" : 10, "lte" : 20 }
        }
      },
      "should" : [
        { "term" : { "tag" : "wow" } },
        { "term" : { "tag" : "elasticsearch" } }
      ],
      "minimum_should_match" : 1,
      "boost" : 1.0
    }
  }
}
```
#### Scoring whit ```bool.filter``` (布尔查询里的filter子查询算分)
指定的查询在```filter```里面，不影响算分，得分都是返回0，影响得分指在指定的查询中，下述例子，三个查询例子，返回的文档是在```status```字段包含```active```关键字。    
    
这第一个查询，会为所有文档分配得分为0，指定的查询不计算得分。
```
GET _search
{
  "query": {
    "bool": {
      "filter": {
        "term": {
          "status": "active"
        }
      }
    }
  }
}
```
在```bool```查询里，使用```match_all```查询，会为所有文档分配得分为```1.0```
```
GET _search
{
  "query": {
    "bool": {
      "must": {
        "match_all": {}
      },
      "filter": {
        "term": {
          "status": "active"
        }
      }
    }
  }
}
```
```constant_score```查询的行为与上述第二个例子相同，常量得分查询，指定分配得分为1，对于所有文档而言，在filter匹配当中。
```
GET _search
{
  "query": {
    "constant_score": {
      "filter": {
        "term": {
          "status": "active"
        }
      }
    }
  }
}
```
#### Using named queries to see which clauses matched(查询子句命名)
如果你需要知道哪些bool查询子句匹配文档，并返回，你可以使用[named queries](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-named-queries-and-filters.html)，为每一个子句分配一个名字。