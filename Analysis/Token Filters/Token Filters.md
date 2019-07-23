## Token Filters(token过滤器) 运行在Tokenizer之后
从[tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-tokenizers.html)，接收过来的一个一个分词项(流)，能够对其进行修改，比如转小写字母，删除分词项，例如 remove stopwords，或者增加分词项，例如: synonyms,ES有许多内置分词项过滤器可以参考使用[custom analyzers](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-custom-analyzer.html)
