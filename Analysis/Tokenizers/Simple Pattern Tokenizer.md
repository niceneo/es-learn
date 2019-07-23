## Simple Pattern Tokenizer (简单匹配模式分词器)
- WARNING 这个功能在Lucene里是实验性功能。

```simple_pattern```分词器，使用正则模式捕获匹配文本，对正则模式匹配的支持受限制于```pattern``` tokenizer分词器，但是这个匹配总体速度会更快。

这个分词器不支持输入的切分，从模式匹配里，不像```patttern```分词器，这个切分，在正则模式匹配里使用相同的正则表达式的限制，具体查看[simple_pattern_split](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-simplepatternsplit-tokenizer.html) tokenizer

分词器使用[Lucene regular expressions](http://lucene.apache.org/core/8_0_0/core/org/apache/lucene/util/automaton/RegExp.html),解释支持的功能和语法，查看[Regular Expression Syntax](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-regexp-query.html#regexp-syntax)

默认模式是空字符串在处理，这个分词器应该总是不使用默认配置。

#### Configuration
简单模式分词器，可以接入以下参数:
***
```pattern```  [Lucene regular expreesion](http://lucene.apache.org/core/8_0_0/core/org/apache/lucene/util/automaton/RegExp.html), 默认使用空字符串
***

#### Example Configuration
这个配置例子```simple_pattern```分词器处理匹配三个数字。
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "tokenizer": "my_tokenizer"
        }
      },
      "tokenizer": {
        "my_tokenizer": {
          "type": "simple_pattern",
          "pattern": "[0123456789]{3}"
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "fd-786-335-514-x"
}
```
上述处理结果：
```[ 786, 335, 514 ]```