##Fingerprint Analyzer(指纹分析器)
指纹分析器实现是依靠OpenRefinex项目的[fingerprinting algorithm](https://github.com/OpenRefine/OpenRefine/wiki/Clustering-In-Depth#fingerprint)实现
输入小写文本，正常的移除扩展字符，排序，去重，在单个token进行索引，如果配置了停用词，停用词也会被移除

#####Example output
```
POST _analyze
{
  "analyzer": "fingerprint",
  "text": "Yes yes, Gödel said this sentence is consistent and."
}
```
上述语句处理结果如下：
```[ and consistent godel is said sentence this yes ]```

##### Configuration
这指纹分词器，可以接入以下参数:
***
```separator```  单词字符连接符，默认使用空格
***
```max_output_size```  最大切分成255单词字符项，最大Tokens限制，将会被废弃
***
```stopwords```  预定义停用词，像_english_或者包含停用词的数组列表，默认是_none_.
***
```stopwords_path``` 停用词配置文件路径
***
更多关于停用词配置信息[Stop Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-stop-tokenfilter.html)

##### Example configuration
在这个例子中，我们配置指纹分词器，使用预定义的English停用词。
```
PUT my_index
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_fingerprint_analyzer": {
          "type": "fingerprint",
          "stopwords": "_english_"
        }
      }
    }
  }
}

POST my_index/_analyze
{
  "analyzer": "my_fingerprint_analyzer",
  "text": "Yes yes, Gödel said this sentence is consistent and."
}
```
上述例子处理完：
``` [ consistent godel said sentence yes ] ```

##### Definition(定义)
指纹分析器，包括如下组成：
###### Tokenizer
- [Standard Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-standard-tokenizer.html)
  
###### Token Filters(in order)
- [Lower Case Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lowercase-tokenfilter.html)
- [ASCII Folding Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-asciifolding-tokenfilter.html)
- [Stop Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-stop-tokenfilter.html)(disabled by default)
- [Fingerprint Token Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-fingerprint-tokenfilter.html)

如果你需要自定义分词器，根据你的需要，自定义增加过滤器，可以使用fingerprint分词器作为起点进行自定义。
```
PUT /fingerprint_example
{
  "settings": {
    "analysis": {
      "analyzer": {
        "rebuilt_fingerprint": {
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "asciifolding",
            "fingerprint"
          ]
        }
      }
    }
  }
}
```


