##Stop Analyzer
`stop`分词器，与`simple analyzer`一样，但是增加了支持移除停用词，默认是采用`_english`类的停用词

#####Example output
```
POST _analyze
{
  "analyzer": "stop",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述文本指令经过处理之后，切词结果为:
`[ quick, brown, foxes, jumped, over, lazy, dog, s, bone ]`

#####Configuration
停用词分词器可以接入一下参数:  
***
`stopwords` 预定义停用词是`english`或者是包含停用词的一个列表数组，默认是`_english_`.   
***
`stopwords_path`  配置停用词文件路径，这个路径是相对于在Elasticsearch配置文件当中，config配置的目录而言。
***
查看关于[Stop Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-stop-tokenfilter.html)更多关于停用词配置

#####Example configuration
在这个例子中，我们配置停用词分词器，指定停用词列表
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_stop_analyzer": {
          "type": "stop",
          "stopwords": ["the", "over"]
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_stop_analyzer",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述例子处理完后的结果:
```[ quick, brown, foxes, jumped, lazy, dog, s, bone ]```

#####Definition(定义)
包含以下套件:
######Tokenizer
- Lower Case Tokenizer
######Token filters
- Stop Token Filter

如果你需要自定义自己的停用词分词器，，你可以通过配置参数选项，增加，修改自定义分词器，你也可以以停用词分析器作为起点进行自定义
```
PUT /stop_example
{
  "settings": {
    "analysis": {
      "filter": {
        "english_stop": {
          "type":       "stop",
          "stopwords":  "_english_"     #1
        }
      },
      "analyzer": {
        "rebuilt_stop": {
          "tokenizer": "lowercase",
          "filter": [
            "english_stop"          #2
          ]
        }
      }
    }
  }
}
```

\#1 利用stopwords或者stopwords_path重写默认的停用词
\#2 你可以在english_stop后，增加任何token filter