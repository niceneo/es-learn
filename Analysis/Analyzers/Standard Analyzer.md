##Standard Analyzer(标准分词器)
如果没有特别指定，默认都是采用`standard`分词器。提供基于语法的词语切分(基于unicode文本切分算法)，在更多的语言中支持的很好

#####Example output
```
POST _analyze
{
  "analyzer": "standard",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述的文本语句将会被处理成下面字段:
`[ the, 2, quick, brown, foxes, jumped, over, the, lazy, dog's, bone ]`

#####Configuration
`standard`分词器支持接入以下参数:

`max_token_length` 分词最大长度，如果切分的词超过这个长度将会被忽略，默认是255

`stopwords`  预定义stop words,比如`_english_`,或者包含stop words的列表，默认是`_none_`

`stopwords_path`  包含stop words的文件路径

查看关于`stop token filter`了解更多关于stop word配置信息

#####Example configuration
在这个例子中，我们配置`standard`分析器，配置`max_token_lenth`参数为5(为了测试的目的),使用预定义的english停用词

```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_english_analyzer": {
          "type": "standard",
          "max_token_length": 5,
          "stopwords": "_english_"
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_english_analyzer",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
关于上面例子，处理后结果是: 过滤英文修饰性的词，并且每个标识词长度都不超过5个字符
`[ 2, quick, brown, foxes, jumpe, d, over, lazy, dog's, bone ]`


#####Definition(解释)
标准分析器的构成：

######Tokenizer
- Standard Tokenizer  
  
######Token Filters
- Lower Case Token Filter  (小写标识过滤)
- Stop Token Filter(disabled by default)  (停用词过滤，默认没启用)
  
如果你需要自定义标准分析器配置，你可以重新增加自定义，并且修改它，比如增加 Token filters, 你可以从修改内置的标准分析器开始，重新增加。

```
PUT /standard_example
{
  "settings": {
    "analysis": {
      "analyzer": {
        "rebuilt_standard": {
          "tokenizer": "standard",
          "filter": [
            "lowercase"       #1
          ]
        }
      }
    }
  }
}
```
\#1 你可以在lowrcase后面增加任何的标识过滤