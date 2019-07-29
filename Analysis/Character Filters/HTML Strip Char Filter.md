## HTML Strip Char Filter(HTML标签过滤)
```html_strip```字符过滤将HTML标签元素从文本中，进行替换成解码形式就像(替换:&amp; 和 &)

#### Example output
```
POST _analyze
{
  "tokenizer":      "keyword", 
  "char_filter":  [ "html_strip" ],
  "text": "<p>I&apos;m so <b>happy</b>!</p>"
}
```
上述例子分词器时```keyword```输出:
```[ \nI'm so happy!\n ]```
相同的例子，如果时```standard```分词器将会返回下述:
```[ I'm, so, happy ]```

#### Configuration
```html_strip```字符过滤器可以接入一下参数:
***
escaped_tags    指定HTML标签，以数组格式，不会被剔除，从源文本当中
***

#### Example Configuration
在这个例子中，我们配置```html_strip```字符过滤器不会移除\<b>标签
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "tokenizer": "keyword",
          "char_filter": ["my_char_filter"]
        }
      },
      "char_filter": {
        "my_char_filter": {
          "type": "html_strip",
          "escaped_tags": ["b"]
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "<p>I&apos;m so <b>happy</b>!</p>"
}
```
上述例子输出如下：
```[ \nI'm so <b>happy</b>!\n ]```