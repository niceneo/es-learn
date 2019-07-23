## Keyword Tokenizer(关键字分词器)
```keyword```分词器不对文本进行切分，按文本原样输出

#### Example output
```
POST _analyze
{
  "tokenizer": "keyword",
  "text": "New York"
}
```
上述处理结果如下:
```[ New York ]```

#### Configuration
```keyword```分词器可以接入一下参数:
***
```buff```   单次读取buff字符长度为默认256
```er_s```   这个词缓冲区将增加到这个大小，直到文本字符被消耗完
```ize```    建议不要更改此设置
***