## Lowercase Token Filter (小写字符过滤器)
```lowercase```将每个分词转换成正常的小写字母。    
小写字母过滤器能够通过配置language参数，配置支持多个语言。    
配置使用列子:
```
PUT /lowercase_example
{
  "settings": {
    "analysis": {
      "analyzer": {
        "standard_lowercase_example": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": ["lowercase"]
        },
        "greek_lowercase_example": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": ["greek_lowercase"]
        }
      },
      "filter": {
        "greek_lowercase": {
          "type": "lowercase",
          "language": "greek"
        }
      }
    }
  }
}
```