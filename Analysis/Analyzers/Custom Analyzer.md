## Custom Analyzer(自定义分词器)
当内置的分词器不符合你的需要，你可以自定义增加分词，包含以下组件:
- 0个或多个字符过滤器[character filters](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-charfilters.html)
- 一个标识器[tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-tokenizers.html)
- 0个或多个标识过滤器[token filters](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-tokenfilters.html)

##### Configuration
自定义分词器可以接入以下参数:
***
```tokenizer```   内置或自定义[tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-tokenizers.html) 必须
***
```char_filter``` 一个数组参数，可以内置或者自定义字符过滤器[character filters](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-charfilters.html)
***
```filter```    一个数组参数，可以是内置或者自定义的[token filters](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-tokenfilters.html)
***
```position_increment_gap``` 当索引文本的数组值时，ES会在首项和末项插入一个假"gap",避免解析查询，不会匹配两terms项，从不同的element数组中,默认是100，更多关于[position_increment_gap](https://www.elastic.co/guide/en/elasticsearch/reference/current/position-increment-gap.html)
***
##### Example configuration
如下例子:
###### Character Filter(字符过滤器)
- [HTML Strip Character Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-htmlstrip-charfilter.html)

##### Tokenizer(标识器)
- [Standard Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-standard-tokenizer.html)

##### Token Filters(标识过滤器)
- [Lowercase Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lowercase-tokenfilter.html)
- [ASCII-Folding Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-asciifolding-tokenfilter.html)

```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_custom_analyzer": {
          "type":      "custom",    #1
          "tokenizer": "standard",
          "char_filter": [
            "html_strip"
          ],
          "filter": [
            "lowercase",
            "asciifolding"
          ]
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_custom_analyzer",
  "text": "Is this <b>déjà vu</b>?"
}
```
\#1 ```type```字段设置为```custom```告诉ES，我们自定义分词器，与内置分词器比较配置，type字段设置分词器的name,像```standard```或```simple```.

上述例子处理如下:
```[ is, this, deja, vu]```

上述例子，使用tokenizer,token filter和character filters,他们都是默认配置，但是在自定义分词器有使用他们自己的版本
更多复杂例子，结合使用：

###### Character Filter(字符过滤器)
- [Mapping Character Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-mapping-charfilter.html),配置替换```:)```成```happy```和```:(```替换成```sad```

###### Tokenizer(标识器)
- [Pattern Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-pattern-tokenizer.html),配置分割字符串

##### Token Filters(标识过滤器)
- [Lowercase Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lowercase-tokenfilter.html)
- [Stop Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-stop-tokenfilter.html),预定义配置使用English 停用词

这里有个例子:
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_custom_analyzer": {
          "type": "custom",
          "char_filter": [
            "emoticons"    #1
          ],
          "tokenizer": "punctuation",   #2
          "filter": [
            "lowercase",
            "english_stop"    #3
          ]
        }
      },
      "tokenizer": {
        "punctuation": {     #4
          "type": "pattern",
          "pattern": "[ .,!?]"
        }
      },
      "char_filter": {
        "emoticons": {     #5
          "type": "mapping",
          "mappings": [
            ":) => _happy_",
            ":( => _sad_"
          ]
        }
      },
      "filter": {
        "english_stop": {     #6
          "type": "stop",
          "stopwords": "_english_"
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_custom_analyzer",
  "text":     "I'm a :) person, and you?"
}
```
\#1,2,3,4,5,6  表情字符过滤器，标点符号标识和```english_stop```标识过滤自定义实现，
上述处理结果如下：
```[ i'm, _happy_, person, you ]```