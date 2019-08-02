## Function score query (得分方法查询)
```function_score```允许你修改文档的得分，从一个查询中。
这可能是有用的，例如，算分方法计算是昂贵的，他是一套计算得分的文档。

使用```function_score```,用户可以定义一个查询的一个或者多个方法，查询返回的每一个文档，都是重新计算的得分。

```function_score```只使用一个方法的例子:
```
GET /_search
{
    "query": {
        "function_score": {
            "query": { "match_all": {} },
            "boost": "5",
            "random_score": {}, 
            "boost_mode":"multiply"
        }
    }
}
```

此外，多个方法可以合并，在这个案例中，一个随意选择应用的方法，如果在给出的filtering查询中，文档匹配
```
GET /_search
{
    "query": {
        "function_score": {
          "query": { "match_all": {} },
          "boost": "5", 
          "functions": [
              {
                  "filter": { "match": { "test": "bar" } },
                  "random_score": {}, 
                  "weight": 23
              },
              {
                  "filter": { "match": { "test": "cat" } },
                  "weight": 42
              }
          ],
          "max_boost": 42,
          "score_mode": "max",
          "boost_mode": "multiply",
          "min_score" : 42
        }
    }
}
```
如果在方法中，没有给定filter，相当于指定了```"match_all":{}```
首先，定义方法，计算每一个文档的得分，```score_mode```参数指定怎么计算得分的:
***
```multiply```    得分相乘，默认
***
```sum```         得分相加
***
```avg```         平均得分
***
```first```       过滤匹配后的第一个得分方法算出的得分。
***
```max```         使用最大得分
***
```min```         使用最小得分
***
因为得分会弹性不同，(例如，在0和1衰退的方法，但是任意字段值是重要因素)，因为有时候，不同影响方法，得分是合适的。算分的每一个方法可以调整用户定的权重```weight```,```weight```能定义每个方法在方法组中，各自方法得分相乘，如果权重没有给出在任何方法中声明。简单的返回方法中的权重值。

案例中，```score_mode```设置了```avg```,将根据权重计算平均得分，例如，如果两个方法返回的得分是1和2，并且他们各自的权重值是3和4，然后合并得分是```(1*3+2*4)/(3+4)```而不是```(1*3+2*4)/2```

新的得分被限制不能超过```max_boost```参数的限制设置， 默认的```max_boost```是FLT_MAX。

新的计算得分联合一个查询。```boost_mode```参数定义如下:
***
```multipy```     查询得分和方法得分相乘  默认
***
```replace```     只有方法的得分被使用，忽略查询的得分
***
```sum```         查询得分与方法的得分相加
***
```avg```         平均值
***
```max```         查询得分与方法得分的最大值
***
```min```         查询得分与方法得分的最小值
***

默认,修改得分不会改变文档的匹配.排除那些不超过```min_score```参数设置的阈值的文档。

```function_score```查询提供几个类型的算分方法：
> [script_score](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html#function-script-score)
> [weight](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html#function-weight)
> [random_score](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html#function-random)
> [field_value_factor](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html#function-field-value-factor)
> [decay functions](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html#function-decay) ```gauss```,```linear```,```exp```

#### Script score
```script_score```方法允许你封装其他查询或者自定义算法，这个选项计算从其他数字字段值，使用脚本文档的方式，例子:
```
GET /_search
{
    "query": {
        "function_score": {
            "query": {
                "match": { "message": "elasticsearch" }
            },
            "script_score" : {
                "script" : {
                  "source": "Math.log(2 + doc['likes'].value)"
                }
            }
        }
    }
}
```





