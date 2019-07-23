##Simple Analyzer
`simple`分析器，将文本切分成一个一个单词，而不是一个一个字母，所切分出来的词全部转为小写

#####Example output
```
POST _analyze
{
  "analyzer": "simple",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上面的句子处理之后的结果:
`[ the, quick, brown, foxes, jumped, over, the, lazy, dog, s bone]`

#####Configuration
`simple`分词器是不可配置的

#####Definition(定义)
`simple`分词器包含:

######Tokenizer
- Lower Case Tokenizer

如果你需要自定义`simple`分词器，可以修修改它，经常是增加Token filters，你可以将`simple`分词器作为起点，重新增加自己功能的分词器
```
PUT /simple_example
{
  "settings": {
    "analysis": {
      "analyzer": {
        "rebuilt_simple": {
          "tokenizer": "lowercase",
          "filter": [         #1
          ]
        }
      }
    }
  }
}
```
\#1 你可以增加任何token filter