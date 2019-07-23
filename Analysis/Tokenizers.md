## Tokenizers (分词器) 运行在character Filters之后
标识器收到字符流，切分成单个单词(通常是单个单词)和输出单个单词，例如，```whitespace```标识器切割文本成单个单词(空白分隔符)，他它可以转换文本```Quick brown fox!```成单个单词```[ Quick, brown, fox ]```    
标识器也响应关于每一个单词的记录序号或者位置，单词在源字符文本中的起始和结束位置(用于搜索关键词的高亮)    
ES许多内置的分词器可以使用，也可以自定义
## Word Oriented Tokenizers
下述是经常使用到的全文本分词器：

#### [Standard Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-standard-tokenizer.html)   
标准的分词器从单词边界切分文本成单词，定义Unicode Text文本切分算法，移除更多的标识符号，它是更多语言更好的选择

#### [Letter Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-letter-tokenizer.html)  
字母标识器，切分文本成单个单词，无论如何看到的都是单个单词，而不是一个字母

#### [Lowercase Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-lowercase-tokenizer.html)
小写字符分词器，像字母分词器，切分文本成单个单词，无论如何，它都是一个单个单词，而不是一个个的字母，但是，所有单词会全部转成小写

#### [Whitespace Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-whitespace-tokenizer.html)
空白字符分词器，空白字符分词器将文本分析，遇到任何空白字符，切分单个单词

#### [UAX URL Email Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-uaxurlemail-tokenizer.html)
```uax_url_email```分词器像标准分词器，除了它能识别出URL和email地址成单个标识(单个单词项)

#### [Classic Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-classic-tokenizer.html)    
类分词器处理是基于英文语言的分词器，连字符号的短语会被切开

#### [Thai Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-thai-tokenizer.html)
泰语分词器，将泰语文本分词单个单词字段

## Partial Word Tokenizers
这些分词器将文本切分成更小的短，部分单词匹配
#### [N-Gram Tokenizer]
连词分词器当遇到任何指定列表的字符时，切分文本成单个单词(比如空白或者标点字符)，接着返回每个单词字符连接字符，比如```quick``` --> ```[ qu, ui, ic, ck]```

#### [Edge N-Gram Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-edgengram-tokenizer.html)
例如: ```quick``` --> ```[q, qu, qui, quic, quick]```

## Structured Text Tokenizers
下述文本结构化分词器，经常使用像在全文本里面的标识符，邮件地址，zip codes和路径

#### [Keyword Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-keyword-tokenizer.html)

#### [Pattern Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-pattern-tokenizer.html)

#### [Simple Pattern Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-simplepattern-tokenizer.html)

#### [Char Group Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-chargroup-tokenizer.html)

#### [Simple Pattern Split Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-simplepatternsplit-tokenizer.html)

#### [Path Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-pathhierarchy-tokenizer.html)