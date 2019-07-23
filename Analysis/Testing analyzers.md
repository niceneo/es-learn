##Testing analyzers
analyzer API是展示分析器处理分词过程非常棒的工具，在指定请求行中指定内置分析器，(或者组合内置的标识器，标识过滤，字符过滤)   

```
POST _analyze
{
  "analyzer": "whitespace",
  "text":     "The quick brown fox."
}

POST _analyze
{
  "tokenizer": "standard",
  "filter":  [ "lowercase", "asciifolding" ],
  "text":      "Is this déja vu?"
}
```

##位置点与字符偏移量
```
从 analyze API输出来看，分析器不仅仅转换，切分单词，他们也记录每次词的位置, 
(使用短语查询，或词近距离查询),
记录每个分词在源文本中的起始结束，字符偏移
```

或者，在指定索引，调 analyze API,选择自定义组合的分析器

```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "std_folded": {    #1
          "type": "custom",
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "asciifolding"
          ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "my_text": {
        "type": "text",
        "analyzer": "std_folded"   #2
      }
    }
  }
}

GET my_index/_analyze   #3
{
  "analyzer": "std_folded",   #4
  "text":     "Is this déjà vu?" 
}

GET my_index/_analyze   #5
{
  "field": "my_text",    #6
  "text":  "Is this déjà vu?"
}
```

\#1  自定义名字叫 std_folded 分析器
\#2  my_text 字段采用 std_folder 分析器
\#3|#5  要涉及到这个分析器，analyze API必须指定索引名字
\#4  分析器名字
\#5  分析器分析的字段名称
