## Mapping Char Filter
```mapping```过滤器，接入map的一个key和values值，无论如何，当字符流遇到遇到相同的key，会将他们替换成value值。

匹配是贪婪模式，最长的模式匹配是```.```的方式，允许替换成空字符串。

#### Configuration
```mapping```字符过滤器可以接入一下参数：
***
mappings  一个数组mappings，每一项都是```key => value```形式、
***
mapping_path  一个路径，绝对路径或者相对于```config```目录的路径。utf-8编码，文本映射文件内容是以```key => value```，一行。
***
此两项参数必须提供一项

#### Example Configuration
在这个例子中，我们配置将拉丁数字替换成阿拉伯数字
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "tokenizer": "keyword",
          "char_filter": [
            "my_char_filter"
          ]
        }
      },
      "char_filter": {
        "my_char_filter": {
          "type": "mapping",
          "mappings": [
            "٠ => 0",
            "١ => 1",
            "٢ => 2",
            "٣ => 3",
            "٤ => 4",
            "٥ => 5",
            "٦ => 6",
            "٧ => 7",
            "٨ => 8",
            "٩ => 9"
          ]
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "My license plate is ٢٥٠١٥"
}
```
上述例子输出结果如下:
```[ My license plate is 25015 ]```

keys 和 values字符，可以是多字符，下述例子将表情符号替换成对应的文字描述。
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "tokenizer": "standard",
          "char_filter": [
            "my_char_filter"
          ]
        }
      },
      "char_filter": {
        "my_char_filter": {
          "type": "mapping",
          "mappings": [
            ":) => _happy_",
            ":( => _sad_"
          ]
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "I'm delighted about it :("
}
```
上述例子输出:
```
[ I'm, delighted, about, it, _sad_ ]
```
