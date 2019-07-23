## UAX URL Email Tokenizer
```uax_url_email```分词器像是将```standard tokenizer```分词器，将URL和Email地址作为单个分词标识。

#### Example output
```
POST _analyze
{
  "tokenizer": "uax_url_email",
  "text": "Email me at john.smith@global-international.com"
}
```
上述例子输出如下:
```[ Email, me, at, john.smith@global-international.com ]```

如果是标准分词器，处理如下：
```[ Email, me, at, john.smith, global, international.com ]```

#### Configuration
```uax_url_email```分词器可以接入以下参数选项:
***
```max_token_length```    分词最大长度，如果分词最大长度超过了max_token_length，就会在此位置进行切分，默认为255

#### Example Configuration
在这个例子中，我们配置```uax_url_email```分词器的```max_token_length```长度为5.(测试目的)
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
          "type": "uax_url_email",
          "max_token_length": 5
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "john.smith@global-international.com"
}
```
上述例子处理完：
```[ john, smith, globa, l, inter, natio, nal.c, om ]```