## Language Analyzers(语言分词器)
一套语言文本分析器，支持一下类型语言:
[arabic](#arabic),[armenian](#armenian),[basque](#basque),[bengali](#bengali),[brazilian](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lang-analyzer.html#brazilian-analyzer),[bulgarian](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lang-analyzer.html#bulgarian-analyzer),[catalan](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lang-analyzer.html#catalan-analyzer),[cjk](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lang-analyzer.html#cjk-analyzer),

#### Configuring language analyzers(配置语言分析器)
##### Stopwords
所有的语言分词器支持自定义在内部设置停用词，或者使用外部停用词，以stopwaords_path的方式提供停用词文件路径，检查更多关于停用词[Stop Analyzer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-stop-analyzer.html)

##### Excluding words from stemming(从词干排除单词)
```stem_exclusion```参数允许你指定小写单词数组，不是用词干，在内部实现这个功能需要增加```keyword_marker```这个token filter在keywords设置，```stem_exclusion```参数,意思是在ketwords配置参数下配置一个数组来实现stem_exclusion的功能


##### Reimplementing language analyzers(重新实现语言分词器)

内置的语言分词器，允许重新实现，增加功能的基础上，自定语言分词器，


##### <span id="arabic">arabic</span> analyzer
阿拉伯语言分词器，重新自定义实现方式如下:
```
PUT /arabic_example
{
  "settings": {
    "analysis": {
      "filter": {
        "arabic_stop": {
          "type":       "stop",
          "stopwords":  "_arabic_"     #1
        },
        "arabic_keywords": {
          "type":       "keyword_marker",
          "keywords":   ["مثال"]      d#2
        },
        "arabic_stemmer": {
          "type":       "stemmer",
          "language":   "arabic"
        }
      },
      "analyzer": {
        "rebuilt_arabic": {
          "tokenizer":  "standard",
          "filter": [
            "lowercase",
            "decimal_digit",
            "arabic_stop",
            "arabic_normalization",
            "arabic_keywords",
            "arabic_stemmer"
          ]
        }
      }
    }
  }
}
```
\#1 采用stopwords或者stopwords_path参数替换默认的停用词
\#2 这个过滤器，从词干排除指定的关键词
 
 ##### <span id="armenian">armenian analyzer</span>
亚美尼亚语言分词器：
```
PUT /armenian_example
{
  "settings": {
    "analysis": {
      "filter": {
        "armenian_stop": {
          "type":       "stop",
          "stopwords":  "_armenian_"      #1
        },
        "armenian_keywords": {
          "type":       "keyword_marker",
          "keywords":   ["օրինակ"]         #2
        },
        "armenian_stemmer": {
          "type":       "stemmer",
          "language":   "armenian"
        }
      },
      "analyzer": {
        "rebuilt_armenian": {
          "tokenizer":  "standard",
          "filter": [
            "lowercase",
            "armenian_stop",
            "armenian_keywords",
            "armenian_stemmer"
          ]
        }
      }
    }
  }
}
```
\#1 采用stopwords或者stopwords_path参数替换默认的停用词
\#2 这个过滤器，从词干排除指定的关键词

##### <span id="basque">basque analyzer</span>
巴斯克语分词器自定义：
```
PUT /basque_example
{
  "settings": {
    "analysis": {
      "filter": {
        "basque_stop": {
          "type":       "stop",
          "stopwords":  "_basque_"    #1
        },
        "basque_keywords": {
          "type":       "keyword_marker",
          "keywords":   ["Adibidez"]    #2
        },
        "basque_stemmer": {
          "type":       "stemmer",
          "language":   "basque"
        }
      },
      "analyzer": {
        "rebuilt_basque": {
          "tokenizer":  "standard",
          "filter": [
            "lowercase",
            "basque_stop",
            "basque_keywords",
            "basque_stemmer"
          ]
        }
      }
    }
  }
}
```
\#1 采用stopwords或者stopwords_path参数替换默认的停用词
\#2 这个过滤器，从词干排除指定的关键词

##### <span id="bengali">bengali analyzer</span>
孟加拉语分词器自定义方式：
```
PUT /bengali_example
{
  "settings": {
    "analysis": {
      "filter": {
        "bengali_stop": {
          "type":       "stop",
          "stopwords":  "_bengali_"   #1
        },
        "bengali_keywords": {
          "type":       "keyword_marker",
          "keywords":   ["উদাহরণ"]    #2
        },
        "bengali_stemmer": {
          "type":       "stemmer",
          "language":   "bengali"
        }
      },
      "analyzer": {
        "rebuilt_bengali": {
          "tokenizer":  "standard",
          "filter": [
            "lowercase",
            "decimal_digit",
            "bengali_keywords",
            "indic_normalization",
            "bengali_normalization",
            "bengali_stop",
            "bengali_stemmer"
          ]
        }
      }
    }
  }
}
```
\#1 采用stopwords或者stopwords_path参数替换默认的停用词
\#2 这个过滤器，从词干排除指定的关键词

......官网查看


