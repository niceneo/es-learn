## Letter Tokenizer(字母分词器)
字母分词器，切分文本成分词，任何时候遇到只要不是字母就进行切分，对于大多数欧洲语言是合理的。但是对于亚洲语言是不友好的，他们不是以空格符号分割。
#### Example output
```
POST _analyze
{
  "tokenizer": "letter",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述例子输出：
```[ The, QUICK, Brown, Foxes, jumped, over, the, lazy, dog, s, bone ]```

#### Configuration
字母分词器没有其他配置参数选项。