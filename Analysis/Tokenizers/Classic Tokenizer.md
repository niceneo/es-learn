## Classic Tokenizer(经典分词器)
经典分词器分词是基于标准英语文档很好的分词器。分词器能处理一些特殊缩写，公司名称，邮件地址，网络主机，然后，这些规则并不能总是很好的工作，也不能很好的在其他更多语言更好的工作。

- 在更多的标点字符分割单词，移除标点符号，而然，点号后面跟着不是空格符号的话，被认为是分词的一部分。
- 在连字符分割，除非他们是数字，在这种情况下，分词被认为是一个产品编号而不进行分割。
- 标识邮件地址，网络主机为一个分词。

#### Example output
```
POST _analyze
{
  "tokenizer": "classic",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述处理结果如下:
```[ The, 2, QUICK, Brown, Foxes, jumped, over, the, lazy, dog's, bone ]```

#### Configuration
经典分词器可以接入以下参数:
***
```max_token_length```   分词最大长度，如果分词的最大长度超过```max_token_length```，则会在此进行分割，默认为255
***

#### Example configuration
在这个例子中，我们配置经典分词器的```max_token_length```长度为5，测试目的。
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
          "type": "classic",
          "max_token_length": 5
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述例子处理结果如下:
```[ The, 2, QUICK, Brown, Foxes, jumpe, d, over, the, lazy, dog's, bone ]```