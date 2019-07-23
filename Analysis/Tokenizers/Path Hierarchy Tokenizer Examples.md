## Path Hierarchy Tokenizer Example(路径分隔符案例)
通常使用```path_hierarchy```分词器过滤文件路径，如果索引长的文件路径数据，使用```path_hierarchy```分词器，分析路径，允许结果包括不同的路径部分字符串。

案例索引配置2个自定义分词器和应用在多个字段的```file_path```字段的文本上，其中一个分词器使用反转分词器，一些案例文档，他们索引不同的照片文件路径在两个不同的用户里。

```
PUT file-path-test
{
  "settings": {
    "analysis": {
      "analyzer": {
        "custom_path_tree": {
          "tokenizer": "custom_hierarchy"
        },
        "custom_path_tree_reversed": {
          "tokenizer": "custom_hierarchy_reversed"
        }
      },
      "tokenizer": {
        "custom_hierarchy": {
          "type": "path_hierarchy",
          "delimiter": "/"
        },
        "custom_hierarchy_reversed": {
          "type": "path_hierarchy",
          "delimiter": "/",
          "reverse": "true"
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "file_path": {
        "type": "text",
        "fields": {
          "tree": {
            "type": "text",
            "analyzer": "custom_path_tree"
          },
          "tree_reversed": {
            "type": "text",
            "analyzer": "custom_path_tree_reversed"
          }
        }
      }
    }
  }
}

POST file-path-test/_doc/1
{
  "file_path": "/User/alice/photos/2017/05/16/my_photo1.jpg"
}

POST file-path-test/_doc/2
{
  "file_path": "/User/alice/photos/2017/05/16/my_photo2.jpg"
}

POST file-path-test/_doc/3
{
  "file_path": "/User/alice/photos/2017/05/16/my_photo3.jpg"
}

POST file-path-test/_doc/4
{
  "file_path": "/User/alice/photos/2017/05/15/my_photo1.jpg"
}

POST file-path-test/_doc/5
{
  "file_path": "/User/bob/photos/2017/05/16/my_photo1.jpg"
}
```
在所有案例文档，搜索特殊文件路径字符串，在文本字段匹配。Bob's文档匹配相关度排名最高，有标准分词器计算得分
```
GET file-path-test/_search
{
  "query": {
    "match": {
      "file_path": "/User/bob/photos/2017/05"
    }
  }
}
```
简单匹配或过滤文档，文件路径，存在特别明细目录内部，使用```file_path.tree```字段.
```
GET file-path-test/_search
{
  "query": {
    "term": {
      "file_path.tree": "/User/alice/photos/2017/05/16"
    }
  }
}
```
这个分词器的反转参数，通常用于匹配文件路径结束或其他位置，例如：单独文件名字，或者深层次的子目录，下述配置例子搜索所有文件名字为```my_photo1.jpg```,在任何目录内。```file_path.tree_reversed```字段，配置使用反转参数在mapping中。
```
GET file-path-test/_search
{
  "query": {
    "term": {
      "file_path.tree_reversed": {
        "value": "my_photo1.jpg"
      }
    }
  }
}
```
增加相同的file path路径值，来用不同的分词器解析
```
POST file-path-test/_analyze
{
  "analyzer": "custom_path_tree",
  "text": "/User/alice/photos/2017/05/16/my_photo1.jpg"
}

POST file-path-test/_analyze
{
  "analyzer": "custom_path_tree_reversed",
  "text": "/User/alice/photos/2017/05/16/my_photo1.jpg"
}
```
当结合其他类型搜索时，经常在file path进行过滤。比如这个例子，在Alice's 照片目录下，任何配置文件路径包含16的。
```
GET file-path-test/_search
{
  "query": {
    "bool" : {
      "must" : {
        "match" : { "file_path" : "16" }
      },
      "filter": {
        "term" : { "file_path.tree" : "/User/alice" }
      }
    }
  }
}
```