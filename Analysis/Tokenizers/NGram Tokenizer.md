## NGram Tokenizer(连词分词器)
连词分词器切分文本，成字符，无论如何遇到一个指定字符列表，他们会返回连词分词的指定长度。
连词器像一个滑动窗口，移动在这个单词上，指定长度的连续序列字符，他们使用查询语言，不使用空白字符或长的合成词，像German

#### Example output
默认设置，连词分词器处理初始文本成单个分词，处理连词最小长度为1，最大长度为2(解释的好别扭，直接查看案例)
```
POST _analyze
{
  "tokenizer": "ngram",
  "text": "Quick Fox"
}
```
上述例子处理结果如下:
```[ Q, Qu, u, ui, i, ic, c, ck, k, "k ", " ", " F", F, Fo, o, ox, x ]```

#### Configuration
连词分词可以接入以下参数:
***
```min_gram```   最少长度，默认为1
***
```max_gram```   最大长度，默认为2
***
```token_chars```   字符组应该包含在分词中，ES，分割字符，不属于指定字符组中，默认为[](所有字符)。

字符组例子:
- letter ---      for example a, b, ï or 京
- digit  ---      for example 3 or 7
- whitespace ---  for example " " or "\n"
- punctuation --- for example ! or "
- symbol ---      for example $ or √


- TIP 经常设置成 min_gram 和 max_gram一样值，
***

#### Example configuration
在这个例子中，我们配置连词分词器，字母和数字分词，连词长度为3
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
          "type": "ngram",
          "min_gram": 3,
          "max_gram": 3,
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
上述处理如下:
```[ Qui, uic, ick, Fox, oxe, xes ]```
