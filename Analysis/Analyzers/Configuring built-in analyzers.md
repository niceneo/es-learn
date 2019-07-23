##Configuring built-in analyzers
内置的分析器不需要任何配置，然后支持一些配置选项来修改他们的行为，以下例子，`standard analyzer` 能配置支持停用词列表

```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "std_english": {    #1
          "type":      "standard",
          "stopwords": "_english_"
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "my_text": {
        "type":     "text",
        "analyzer": "standard",    #2
        "fields": {
          "english": {
            "type":     "text",
            "analyzer": "std_english"    #3
          }
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "field": "my_text",    #4
  "text": "The old brown cow"
}

POST my_index/_analyze
{
  "field": "my_text.english",    #5
  "text": "The old brown cow"
}

```

\#1  我们基于`standard`分析器自定义了`std_english`分析器，但是配置了预定义 English stopwords 进行删除 (在stopwords位置使用了english，意思会删除英文类的停用词，修饰性的词)

\#2|#4  `my_text`字段直接使用了标准的分析器，没有任何配置，没有stop words，会从这个字段移除，分词结果为`[ the, old, brown, cow ]`


\#3|#5 `my_text.english`字段使用了自定义的`std_english`分析器，所以English停用词将会被移除,分词结果为`[ old, brown, cow ]`