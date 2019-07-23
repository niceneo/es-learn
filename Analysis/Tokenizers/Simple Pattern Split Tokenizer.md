## Simple Pattern Split Tokenizer(简单模式分割分词器)
```simple_patttern_split```分词器，使用正则表达式进行分割文本，当遇到模式匹配时。设置正则表达式分词器比模式分词器[pattern tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-pattern-tokenizer.html)更多限制，但是这个运行更快。

这个分词器不能处理，匹配他们自己的项，从处理terms，使用模式匹配在同一个正则表达式受限制。查看[simple_pattern](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-simplepattern-tokenizer.html)分词器

这个分词器使用[Lucene regular expression](http://lucene.apache.org/core/8_0_0/core/org/apache/lucene/util/automaton/RegExp.html),解释支持的特性和语法，查看[Regular Expression Syntax](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-regexp-query.html#regexp-syntax)

默认的模式是空字符串，对输出的全文本，被当作一个分词。这个分词器应该总是要配置非默认模式

#### Configuration
```simple_pattern_split```分词器可以接入一下参数:
***
pattern   [Lucene regular expression](http://lucene.apache.org/core/8_0_0/core/org/apache/lucene/util/automaton/RegExp.html),默认是空字符串.
***

#### Example configuration
这个配置例子，```simple_pattern_split```分词器，对输入文本使用 下划线 进行切分。
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
          "type": "simple_pattern_split",
          "pattern": "_"
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "an_underscored_phrase"
}
```
上述例子处理:
```[ an, underscored, phrase ]```

