## Pattern Tokenizer
正则分词器，根据正则模式匹配，切分文本，无论如何遇到匹配单词，或捕获匹配文本。
默认的正则模式是，```\W```匹配任何非单词字符```[^A-Za-z0-9_]```
#### Example output
```
POST _analyze
{
  "tokenizer": "pattern",
  "text": "The foo_bar_size's default is 5."
}
```
上述处理结果如下:
```[ The, foo_bar_size, s, default, is, 5 ]```

#### Configuration
```pattern``` 分词器可以接入以下参数:
***
```pattern``` 基于[Java regular expression](http://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html),默认是```\W+```
***
```flags```JAVA正则模式里面的[flags](http://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html#field.summary),flags标致，应该通过管道符隔开，例如: ```"CASE_INSENSITIVE|COMMENTS"```
***
```group```   捕获组提取作为分词。默认是-1

#### Example Configuration
在这个例子中，我们配置模式```pattern```分词器
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
          "type": "pattern",
          "pattern": ","
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "comma,separated,values"
}
```
上述处理结果:
```[ comma, separated, values ]```
接下来例子中，我们配置正则模式分词器，捕获值，在两个双引号当中，(反斜线标识正则转义)，正则模式如下: ``` "((?:\\"|[^"]|\\")*)" ```   

当指定模式配置是JSON，"和\ 字符时需要进行转义。
```   \"((?:\\\\\"|[^\"]|\\\\\")+)\"   ```

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
          "type": "pattern",
          "pattern": "\"((?:\\\\\"|[^\"]|\\\\\")+)\"",
          "group": 1
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "\"value\", \"value with embedded \\\" quote\""
}
```
上述处理结果:
```[ value, value with embedded \" quote ]```