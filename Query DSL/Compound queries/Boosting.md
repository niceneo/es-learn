## Boosting query
返回一个积极查询匹配的文档，同时减少消极查询匹配文档的相关性得分。    
你可以使用```boosting```查询，降低某确定文档的相关性，没有将他们从结果中排除。

#### Example request (查询例子)
```
GET /_search
{
    "query": {
        "boosting" : {
            "positive" : {
                "term" : {
                    "text" : "apple"
                }
            },
            "negative" : {
                 "term" : {
                     "text" : "pie tart fruit crumble tree"
                }
            },
            "negative_boost" : 0.5
        }
    }
}
```
#### Top-level parameters for ```boosting```
```positive(Required)```    运行查询，任何返回的文档都必须匹配这个查询。
```negative(Required)```    对匹配的文档，查询会降低相关性得分。    
如果返回的文档匹配```positive```和```negative```查询, ```boosting```查询计算最后文档相关性得分, [relevance score](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-filter-context.html),根据一下条件:
1、从```positive```查询，源计算相关性得分，
2、乘以```negative_boost```的值。
```negative_boost(Required)```    浮点数，在0和1.0之前，减少[relevance scores](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-filter-context.html),文档相关性得分，对于匹配```negative```的查询。

