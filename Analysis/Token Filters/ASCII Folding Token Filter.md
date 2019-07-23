## ASCII Folding Token Filter
一个```asciifolding```分词过滤器，在不属于127的ASCII字符里，转换成字母，数字，Unicode符号，例子如下:
```
PUT /asciifold_example
{
    "settings" : {
        "analysis" : {
            "analyzer" : {
                "default" : {
                    "tokenizer" : "standard",
                    "filter" : ["asciifolding"]
                }
            }
        }
    }
}
```
配置```preserve_original```默认为false,如果为true,将保持源token,并返回处理后的token.
```
PUT /asciifold_example
{
    "settings" : {
        "analysis" : {
            "analyzer" : {
                "default" : {
                    "tokenizer" : "standard",
                    "filter" : ["my_ascii_folding"]
                }
            },
            "filter" : {
                "my_ascii_folding" : {
                    "type" : "asciifolding",
                    "preserve_original" : true
                }
            }
        }
    }
}
```