##Keyword Analyzer(关键字分词器)
关键字分词器，是无操作的分词器，返回输入字符串的单个单词字符，
######Example output
```
POST _analyze
{
  "analyzer": "keyword",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述例子，经过处理输出单个单词项：
```[ The 2 QUICK Brown-Foxes jumped over the lazy dog's bone. ]```

#####Configuration
关键字分词器没有配置选项
#####Definition
关键字分词器组成:
######Tokenizer
- Keyword Tokenizer

如果你需要自定义关键字分词器，可以增加或者修改token filter组件，经常，当你想字符串不被分割，你会更喜欢[keyword type](https://www.elastic.co/guide/en/elasticsearch/reference/current/keyword.html)
,你也可以以keyword分词器作为起点，自定义新功能的keyword分词器
```
PUT /keyword_example
{
  "settings": {
    "analysis": {
      "analyzer": {
        "rebuilt_keyword": {
          "tokenizer": "keyword",
          "filter": [         #1
          ]
        }
      }
    }
  }
}
```
\#1 你可以在这个位置增加任何的token filter