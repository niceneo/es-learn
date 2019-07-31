## Disjunction max query
返回文档的文档匹配一个或者多个封装了查询或子查询。    
如果返回文档匹配多个查询子句，```dis_max```查询会从任何子查询子句返回匹配度相关性最高的文档。插件 tie breaking 增加任何条件匹配的子查询。

你可以使用```dis_max```在字段里搜索值，映射到不同的```boost```

#### Example Request
```
GET /_search
{
    "query": {
        "dis_max" : {
            "queries" : [
                { "term" : { "title" : "Quick pets" }},
                { "term" : { "body" : "Quick pets" }}
            ],
            "tie_breaker" : 0.7
        }
    }
}
```
#### Top-level parameters for ```dis_max```
``` queries(Required)```    数组查询对象，包含一个或者多个查询子句，返回的文档必须匹配一个或者多个子句查询。如果文档匹配多个查询，ES使用更高相关性得分返回。

```tie_breadker(Optional)```    浮点数，在0和1.0之间，匹配多个查询子句，增加文档相关性得分，默认时0
你可以使用```tie_breaker```的值，为文档分配更高相关性得分， 文档在多个字段中包含相同值，比文档在多个字段中仅仅匹配某个字段更好，多个字段两个不同值查询，不一定更好。

如果文档匹配多个子句，```dis_max```查询计算文档相关性得分如下:
> 1、从匹配子句中，返回相关性最高得分
> 2、从其他任何匹配子句得分乘以```tie_breaker```值
> 3、在最高得分上乘以得分

如果```tie_breaker```值大于0，所有匹配子句的和，但是子句最高得分时最重要的。