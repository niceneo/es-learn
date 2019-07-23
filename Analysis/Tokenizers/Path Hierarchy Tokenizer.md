## Path Hierarchy Tokenizer(路径结构分词器)
```path_hierarchy```分词器，作用在层次结构类型的值的上，像文件系统路径，在树状结构，分割路径和返回每一个层级信息。

#### Example output
```
POST _analyze
{
  "tokenizer": "path_hierarchy",
  "text": "/one/two/three"
}
```
上述处理结果如下:
```[ /one, /one/two, /one/two/three ]```

#### Configuration
```path_hierarchy```分词器可以接入以下参数:
***
delimiter   指定路径操作符，默认是'/'.
***
replacement  可选项，使用delimiter指定的符号，替换字符。，默认是```delimiter```
***
buffer_size  一次读取字符的长度，默认是1024，缓冲池长度，直到所有文本被全消费，建议不要修改此设置。
***
reverse  如果设置为true, 返回的词项是反过来的，默认是false
***
skip    初始化跳过的字符长度，默认是0
***

#### Example configuration
在这个例子中，我们配置```path_hierarchy```分词器，分割文本字符，使用'-',并且使用'/'进行替换，跳过两个分词项。
````
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
          "type": "path_hierarchy",
          "delimiter": "-",
          "replacement": "/",
          "skip": 2
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_analyzer",
  "text": "one-two-three-four-five"
}
```
上述处理结果:
```[ /three, /three/four, /three/four/five ]```
如果我们设置```reverse```为```true```，处理结果如下:
```[ one/two/three/, two/three/, three/ ]```
