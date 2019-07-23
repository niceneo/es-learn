## Standard Tokenizer(标准分词器)
标准分词器提供的语法是基于标记(Unicode文本分割算法，例如[Unicode Standard Annes #29](http://unicode.org/reports/tr29/)),可以更好的工作在多个语言中。

#### Example output
```
POST _analyze
{
  "tokenizer": "standard",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述例子处理完后：
```[ The, 2, QUICK, Brown, Foxes, jumped, over, the, lazy, dog's, bone ]```

#### Configuration
标准分词器可以接入配置参数：
***
```max_token_length```  配置分词最大长度,如果一个分词超过max_token_length长度，就会在此处分割，默认为255.
***

#### Example configuration(配置案例)
在这个例子中，我们配置标准分词器的```max_token_length```值为5，
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
          "type": "standard",
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
上述案例处理之后：
```[ The, 2, QUICK, Brown, Foxes, jumpe, d, over, the, lazy, dog's, bone ]```