##Whitespace Analyzer
`whitespace`分词器，会将文本以空白字符作为分割符进行切分

#####Example output
```
POST _analyze
{
  "analyzer": "whitespace",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述文本经过处理之后如下结果:
```[ The, 2, QUICK, Brown-Foxes, jumped, over, the, lazy, dog's, bone ]```

#####Configuration
`whitespace`分词器没有其他配置选项

#####Definition(定义)
如下考虑
######Tokenizer
- Whitespace Tokenizer

如果你想自定义`whitespace`分词器，你需要重新创建，并且增加token filters, 你可以以`whitespace`分词器作为起点，增加其他功能:
```
PUT /whitespace_example
{
  "settings": {
    "analysis": {
      "analyzer": {
        "rebuilt_whitespace": {
          "tokenizer": "whitespace",
          "filter": [         #1
          ]
        }
      }
    }
  }
}
```
\#1可以增加任何Token filter.