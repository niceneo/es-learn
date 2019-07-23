## Normalizers
排除正常相似的分词器，我们可能仅仅要单个标识符，因此，他们不使用标识器，只接入一些有效的字符过滤和标识过滤，只有过滤器被允许在每个字符上工作，lowercasing过滤器也被允许，不允许词干过滤，这需要将关键字看做一个整体，当前列出了过滤器可以被使用正常：
arabic_normalization, asciifolding, bengali_normalization, cjk_width, decimal_digit, elision, german_normalization, hindi_normalization, indic_normalization, lowercase, persian_normalization, scandinavian_folding, serbian_normalization, sorani_normalization, uppercase.

## Custom normalizers
ES目前为止没有内置的标准化，所以只能自定义构建，自定义标准化可以是字符过滤器和标识过滤器
```
PUT index
{
  "settings": {
    "analysis": {
      "char_filter": {
        "quote": {
          "type": "mapping",
          "mappings": [
            "« => \"",
            "» => \""
          ]
        }
      },
      "normalizer": {
        "my_normalizer": {
          "type": "custom",
          "char_filter": ["quote"],
          "filter": ["lowercase", "asciifolding"]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "foo": {
        "type": "keyword",
        "normalizer": "my_normalizer"
      }
    }
  }
}
```