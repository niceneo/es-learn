## Constant score query (常量得分的查询)
封装boolean查询里的过滤查询[filter query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html),返回每一个匹配文档相关性得分都等于```boost```参数的值。
```
GET /_search
{
    "query": {
        "constant_score" : {
            "filter" : {
                "term" : { "user" : "kimchy"}
            },
            "boost" : 1.2
        }
    }
}
```

#### Top-level parameters for ```constant_score```
*** 
```filter```     你希望运行过滤查询[Filter query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html),任何返回的文档必须匹配这个查询,必须提供, 过滤查询不计算相关性得分，加速性能，ES在过滤查询自动查找缓存
***
```boost```      使用浮点数，常量相关性得分，对于在过滤擦查询匹配的每一个文档。默认为1.0  ，可选参数