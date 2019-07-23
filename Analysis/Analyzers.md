##Analyzers
Elasticsearch有使用广泛的内置分析器，可以用在任何索引

#####Standard Analyzer
`standard` 分析器从单词边界切分文本，Unicode文本分割切分算法，消除大多数标点符号，转换成小写字符，支持移除停用词

#####Simple Analyzer
`simple` 分析器切分文本比较简单，将切分的词全部转换为小写

#####Whitespace Analyzer
`whitespace` 分析器切分文本以空格为分隔符，并不转换成小写字母

#####Stop Analyzer
`stop` 分析器像`simple`分析器，但是不支持移除停用词

#####Keyword Analyzer
`keyword`  分析器 将要分析的字段作为单独的一个词(term)，精准匹配搜索

#####Language Analyzers
Elasticsearch提供许多特定语言专用的分析器，像`english` `french`

#####Fingerprint Analyzer
`fingerprint`  分析器，增加指纹，针对重复检测

##Custom analyzers
如果你没有发现你需要的分析套件，你可以增加自定义分析套件(字符过滤，标识，标识过滤)进行组合