##Analysis
分析其实就是是转换文本的过程，就像将任何电子邮件的正文转换成附加到反向索引的tokens(标记)或terms(条件)的过程。分析是有分析器完成，每一个索引可以使用内置的分析器或者自定义的分析器。  
###Index time analysis(索引时分析)
在这个例子中，索引时，将使用内置的 english 分析器进行第一次转换  
> "The QUICK brown foxes jumped over the lazy dog!"  

不同种类的标记(分词,切词)，每一个词都转换成小写，移除停用词(修饰词：the)，还远形容词(foxes->fox,jumped->jump,lazy->lazi),最后将分析后的词加入到倒排索引中

> [ quick, brown, fox, jump, over, lazi, dog ]

###Specifying an index time analyzer(索引时指定分析器)

在Mapping中每一个文本字段(text)都可以指定自己的分析器:
```
PUT my_index
  {"mappings": { 
    "properties": {    
      "title": {  
        "type":     "text",  
        "analyzer": "standard"  
      }  
    }  
  }  
}  
```

在索引时,如果没有指定分析器，会去查找是否在创建索引时有设置默认的分析器，不然的话，使用默认的标准分析器

###Search time analysis(搜索时分析)
分析过程应用于搜索时，在使用match query这类全文搜索，转换搜索的文档字符串，(将文档切成一个一个的单词)存储在倒排索引中。   
在这个例子中，用户可能的搜索：

>"a quick fox"

同想使用english分析器的到下面的结果:

> [ quick, fox ]

即使在查询字符串中使用精准单词，而没有在源文本中(quick vs QUICK,fox vs foxes),因为我们在文本和查询字符串应用了相同的分析器，查询字符串单词匹配倒排索引的文本中的单词，意味着这次查询匹配我们的示例文档。

###Specifying a search time analyzer(在搜索时指定分析器)

通常在搜索和索引时使用相同的分析器，使用了match query这类全文搜索中，每一个字段都使用mapping当中指定的分析器

在特定字段使用分析器，是按照： 
   
- 在查询体中指定分析器
- 使用了search_analyzer参数
- 使用了analyzer参数
- 索引设置了default_search，参数指定的分析器
- 索引设置了default，参数指定的分析器 
- 使用标准的分析器


