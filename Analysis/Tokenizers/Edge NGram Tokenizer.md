## Edge NGram Tokenizer(边缘连词分词器)
无论如何，当边缘连词分词器遇到指定列表内字符是，进行文本切分，接着，他返回的每个词，这每个词都从固定开始位置的分词
边缘连词分词器经常用于以你的搜索类型进行查询
- TIP 当你需要以你的搜索类型进行文本搜索，例如电影，音乐的标题，边缘连词分词器可能是一个比较好的选择，边缘分词器，高级特性，当尝试自动完成词以任何顺序完成单词匹配

#### Example output
使用默认设置，边缘连词分词器，会将文本初始化为单个分词，并且处理分词的长度最小为1，最大为2.
```
POST _analyze
{
  "tokenizer": "edge_ngram",
  "text": "Quick Fox"
}
```
上述处理结果如下:
```[ Q, Qu ]```

- NOTE edge-ngram默认设置的长度几乎没用，你需要在使用它之前进行配置。

#### Configuration
edge_ngram分词器，默认可以接入一下参数:
***
```min_gram```  分词字符最小长度，默认为1
***
```max_gram```  分词字符最大长度，默认为2
***
```token_chars``` 字符类别应该包含在一个分词中，ES切分不属于指定分词类的，默认是[]表示所有字符常见字符类
- letter —  for example a, b, ï or 京
- digit —  for example 3 or 7
- whitespace —  for example " " or "\n"
- punctuation — for example ! or "
- symbol —  for example $ or √ 

#### Example Configuration
在这个例子，我们配置边缘连词分词器，标识器为，字符和数字，处理后分词最小为2，最大长度为10.
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
          "type": "edge_ngram",
          "min_gram": 2,
          "max_gram": 10,
          "token_chars": [
            "letter",
            "digit"
          ]
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "2 Quick Foxes."
}
```
上述处理结果如下:
```[ Qu, Qui, Quic, Quick, Fo, Fox, Foxe, Foxes ]```

通常我们推荐使用相同的分词器，在索引和查询时，在这个例子中，```edge_ngram```分词器，是不同建议，仅仅是在edge_ngram分词器进行索引时，确保单词的某部分可以被有效的搜索的。在搜索时，用户输入搜索的类型，例如：Quick Fo
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "autocomplete": {
          "tokenizer": "autocomplete",
          "filter": [
            "lowercase"
          ]
        },
        "autocomplete_search": {
          "tokenizer": "lowercase"
        }
      },
      "tokenizer": {
        "autocomplete": {
          "type": "edge_ngram",
          "min_gram": 2,
          "max_gram": 10,
          "token_chars": [
            "letter"
          ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "title": {
        "type": "text",
        "analyzer": "autocomplete",
        "search_analyzer": "autocomplete_search"
      }
    }
  }
}

PUT my_index/_doc/1
{
  "title": "Quick Foxes" 
}

POST my_index/_refresh

GET my_index/_search
{
  "query": {
    "match": {
      "title": {
        "query": "Quick Fo", 
        "operator": "and"
      }
    }
  }
}
```
```autocomplete```完成分词索引:
```[qu, qui, quic, quick, fo, fox, foxe, foxes]```
```autocomplete_search```分词搜索分词```[quick, fo]```