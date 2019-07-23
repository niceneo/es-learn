##Pattern Analyzer(模式分词器)
模式分词器使用正则表达式，分割文本为许多term字段，正则表示式，切分后的字段标识是不包括正则表达式自己，正则表达式默认使用`\W+`作为分隔符，(匹配一个或多个任何非单词字符)

```
谨防不正常的正则表达式，模式分词器使用的是[Java Regular Expressions](http://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html),不正常的正则表达式运行非常慢，经常抛出StackOverFlow错误。
```

#####Example output(例子输出)
```
POST _analyze
{
    "analyzer": "pattern",
    "text": "The 2 QUICK Brown-Foxes jumped over the lazy dog's bone."
}
```
上述例子处理之后的结果:
```[ the, 2, quick, brown, foxes, jumped, over, the, lazy, dog, s, bone ]```

#####Configuration
模式分词器，可以接入以下参数:

***
```pattern``` Java正则表达式，默认是\W+  (匹配一个或多个非单词字符)
***
```flags``` Java正则表达式标记[flag](http://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html#field.summary)，标记使用管道符分割，例如```"CASE_INSENSITIVE|COMMENTS"```
***
```lowercase``` 转换为小写字符，或不转换，默认是true，即转换为小写。
***
```stopwords``` 预定义停用词想_english_或者包含停用词的一个数组列表，默认为_none_.
***
```stopwords_path``` 包含停用词文件的路径
***

查看[Stop Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-stop-tokenfilter.html),更多关于停用词相关配置

#####Example configuration
在这个案例中，我们配置模式分词器，分割email地址，使用了匹配非任何字符```(\w|_)```，转换小写，

```
PUT my_index
{
    "setting": {
        "analysis": {
            "analyzer": {
                "my_email_analyzer": {
                    "type": "pattern",
                    "pattern": "\\W|_",   #1
                    "lowercase": true
                }
            }
        }
    }
}

POST my_index/_analyze
{
    "analyzer": "my_email_analyzer",
    "text": "John_Smith@foo-bar.com"
}
```

\#1 在JSON字符串里，指定模式时，需要用反斜线转义

上述例子处理完之后：
```[ john, smith, foo, bar, com ]```

#####CamelCase tokenizer(驼峰标识)
下述编译例子将驼峰文本分割成标识

```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "camel": {
          "type": "pattern",
          "pattern": "([^\\p{L}\\d]+)|(?<=\\D)(?=\\d)|(?<=\\d)(?=\\D)|(?<=[\\p{L}&&[^\\p{Lu}]])(?=\\p{Lu})|(?<=\\p{Lu})(?=\\p{Lu}[\\p{L}&&[^\\p{Lu}]])"
        }
      }
    }
  }
}

GET my_index/_analyze
{
  "analyzer": "camel",
  "text": "MooseX::FTPClass2_beta"
}
```
上述例子处理后的字段为:
```[ moose, x, ftp, class, 2, beta]```

上述正则分解:

```
  ([^\p{L}\d]+)                   # 匹配一个或多个非 字母和数字
| (?<=\D)(?=\d)                   # 匹配非数字 到 数字之间的内容
| (?<=\d)(?=\D)                   # 匹配数字 到 非数字之间的内容
| (?<=[ \p{L} && [^\p{Lu}]])      # 小写字符
  (?=\p{Lu})                      # 其次是大写字符
| (?<=\p{Lu})                     # 大写字符
  (?=\p{Lu}                       # 后面跟着大写字符
    [\p{L}&&[^\p{Lu}]]            # 最后跟着小写字符
  )
```
#####Definition
模式分词器包括:
######Tokenizer
- [Pattern Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-pattern-tokenizer.html)

######Token Filters
- [Lower Case Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lowercase-tokenfilter.html)
- [Stop Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-stop-tokenfilter.html)(disabled by default)

如果你需要自定义模式分词器，你可以以内置的模式分词器，作为起点，通过增添，删除，标识过滤，来自定义分词器。
```
PUT /pattern_example
{
  "settings": {
    "analysis": {
      "tokenizer": {
        "split_on_non_word": {
          "type":       "pattern",  
          "pattern":    "\\W+"    #1
        }
      },
      "analyzer": {
        "rebuilt_pattern": {
          "tokenizer": "split_on_non_word",
          "filter": [
            "lowercase"         #2
          ]
        }
      }
    }
  }
}

\#1 默认是\W+作为模式，你可以修改成自己想要的模式
\#2 你可以添加任何其他的标识过滤
