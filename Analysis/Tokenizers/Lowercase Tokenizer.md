## Lowercase Tokenizer(小写字母分词器)
小写字母分词器，像字母分词器那样，切分文本成单个单词，无论如何遇到非字母，就进行切分，但是所有的分词项都会被转为小写，这个功能像是字母分词器和小写字符过滤器的组合，但是更有效率，在单个步骤中执行完

#### Example output
```
POST _analyze
{
  "tokenizer": "lowercase",
  "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```

#### Configuration
小写字母分词器没有配置选项。
