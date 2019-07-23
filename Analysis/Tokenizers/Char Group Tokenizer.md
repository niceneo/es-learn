## Char Group Tokenizer (字符组分隔符)
字符组分隔符，无论如何它遇到自定义字符集里的字符，就会进行切分。最多使用案例是在简单自定义分词器里，正则模式分词器不被使用。

#### Configuration
```char_group```分词器可以接受一下参数:
***
```tokenize_on_chars```  一个包含切分字符的字符列表，如论如何，遇到列表的字符，就是一个新分词的开始，可以接入其他切分字符，像'-',或者字符组：```whitespace```,```letter```,```digit```,```punctuation```,```symbol```.

#### Example output
```
POST _analyze
{
  "tokenizer": {
    "type": "char_group",
    "tokenize_on_chars": [
      "whitespace",
      "-",
      "\n"
    ]
  },
  "text": "The QUICK brown-fox"
}
```
returns
```
{
  "tokens": [
    {
      "token": "The",
      "start_offset": 0,
      "end_offset": 3,
      "type": "word",
      "position": 0
    },
    {
      "token": "QUICK",
      "start_offset": 4,
      "end_offset": 9,
      "type": "word",
      "position": 1
    },
    {
      "token": "brown",
      "start_offset": 10,
      "end_offset": 15,
      "type": "word",
      "position": 2
    },
    {
      "token": "fox",
      "start_offset": 16,
      "end_offset": 19,
      "type": "word",
      "position": 3
    }
  ]
}
```