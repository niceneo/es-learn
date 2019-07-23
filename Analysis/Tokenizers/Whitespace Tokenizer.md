## Whitespace Tokenizer(空白字符分词器)
空白字符分词器，切分文本，无论如何遇到空白字符就进行切分。

#### Example output
```
POST _analyze
{
  "tokenizer": "whitespace",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述例子处理输出:
```[ The, 2, QUICK, Brown-Foxes, jumped, over, the, lazy, dog's, bone. ]```

#### Configuration
空白字符分词器可以接入以下参数:
***
```max_token_length```   分词最大长度，如果分词长度超过这个长度，就在最大长度位置进行切分，默认为255