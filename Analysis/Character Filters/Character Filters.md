## Character Filters(字符过滤器)
在字符文本流送入到分词器处理之前，利用Character Filter对文本流进行预处理。

一个字符过滤器收到源文本字符时，可以进行转换，添加，改变，移除，在这个例子中，字符过滤器能够转换印度数字(٠‎١٢٣٤٥٦٧٨‎٩‎)成为对应的阿拉伯数字(0123456789)，又或者将将html标签移除，类似\<b>

ES有数个内置的字符过滤器。

[HTML Strip Character Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-htmlstrip-charfilter.html) ```html_strip```字符过滤器过滤html标签元素，像\<b>以及一些解码的html字符```&amp;```

[Mapping Character Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-mapping-charfilter.html) ```mapping```字符过滤时将任何指定的字符替换成自定义指定的字符。

[Pattern Replace Character Filter](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-pattern-replace-charfilter.html) ```pattern_replace```字符过滤，匹配任何正则模式匹配到的字符集，用指定的字符进行替换。