## Pattern Replace Char Filter(模式替换字符)
正则模式匹配到字符串，替换成指定的字符集.

#### Configuration
可以接入一下参数:
***
```pattern``` java正则模式
***
```replacement```  替换字符串，可以采用捕获分组的方式 ```$1..$9```语法  
***
```flags``` 支持标识符，用管道符号分割
***

#### Example configuration
在这个案例中，我们配置```pattern_replace```字符过滤，替换任何数字之间连接符为下划线。i.e ```123-456-789``` -> ```123_456_789```
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "tokenizer": "standard",
          "char_filter": [
            "my_char_filter"
          ]
        }
      },
      "char_filter": {
        "my_char_filter": {
          "type": "pattern_replace",
          "pattern": "(\\d+)-(?=\\d)",
          "replacement": "$1_"
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "My credit card is 123-456-789"
}
```
上述例子处理如下:
```[ My, credit, card, is, 123_456_789 ]```
这个案例，无论如何遇到小写字母后面跟着大写字母，插入空格，像是分隔开驼峰书写方式。(i.e.```fooBarBaz``` ->```foo Bar Baz```)
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "tokenizer": "standard",
          "char_filter": [
            "my_char_filter"
          ],
          "filter": [
            "lowercase"
          ]
        }
      },
      "char_filter": {
        "my_char_filter": {
          "type": "pattern_replace",
          "pattern": "(?<=\\p{Lower})(?=\\p{Upper})",
          "replacement": " "
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "text": {
        "type": "text",
        "analyzer": "my_analyzer"
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "The fooBarBaz method"
}
```
上述处理结果如下:
```[ the, foo, bar, baz, method ]```

查询```bar```将发现当前这个文档，但是高亮在结果处理中不正确，因为我们character filter过滤器，改变了源字符集的长度。
```
PUT my_index/_doc/1?refresh
{
  "text": "The fooBarBaz method"
}

GET my_index/_search
{
  "query": {
    "match": {
      "text": "bar"
    }
  },
  "highlight": {
    "fields": {
      "text": {}
    }
  }
}
```
输出如下:
```
{
  "timed_out": false,
  "took": $body.took,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped" : 0,
    "failed": 0
  },
  "hits": {
    "total" : {
        "value": 1,
        "relation": "eq"
    },
    "max_score": 0.2876821,
    "hits": [
      {
        "_index": "my_index",
        "_type": "_doc",
        "_id": "1",
        "_score": 0.2876821,
        "_source": {
          "text": "The fooBarBaz method"
        },
        "highlight": {
          "text": [
            "The foo<em>Ba</em>rBaz method" 
          ]
        }
      }
    ]
  }
}
```