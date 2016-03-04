# Ansible 官方文档中文本地化小组

## 官方原文档:

[https://docs.ansible.com/ansible/index.html](https://docs.ansible.com/ansible/index.html)

## 翻译后的文档地址:

[http://www.178linux.com/doc/ansible/](http://www.178linux.com/doc/ansible/)

## 翻译进度:

请参见  http://www.178linux.com/doc/ansible/

## 目前贡献者列表(qq群无序排名):

 >主要贡献者:  薛定谔的章鱼 & guli & 以马内利 & 黄博文 & stanley
 >所有贡献者: 薛定谔的章鱼 & guli & 以马内利 & 黄博文 & evanescunt & stanley & Daniel & gateray & MR❤Lan   & - 透彻🐬  & Linux 学习 & 啪嗒碰 


# Ansible 中文排版指北

統一翻译样式

-----

## 目录

- [空格](#spacing)
  - [中英文之间需要增加空格](#spacing-c1)
  - [中文和数字之间需要增加空格](#spacing-c2)
  - [数字各单位之间需要增加空格](#spacing-c3)
  - [全形标点各其他字符之间不加空格](#spacing-c4)
  - [`-ms-text-autospace` to the rescue?](#spacing-c5)

## 空格

### 中英文之间需要增加空格

正确：

> 在 LeanCloud 上，数据存储是围绕 `AVObject` 进行的。

错误：

> 在LeanCloud上，数据存储是围绕`AVObject`进行的。

> 在 LeanCloud上，数据存储是围绕`AVObject` 进行的。

完整的正确用法：

> 在 LeanCloud 上，数据存储是围绕 `AVObject` 进行的。每个 `AVObject` 都包含了与 JSON 兼容的 key-value 对应的数据。数据是 schema-free 的，你不需要在每个 `AVObject` 上提前指定存在哪些键，只要直接设定对应的 key-value 即可。

:exclamation: 例外：「豆瓣FM」等產品名词，按照官方所定義的格式書寫。

<a name="spacing-c2"></a>

### 中文各数字之间需要增加空格

正确：

> 今天出去买菜花了 5000 元。

错误：

> 今天出去买菜花了 5000元。

> 今天出去买菜花了5000元。

<a name="spacing-c3"></a>

### 数字各单位之间需要增加空格

正确：

> 我家的光纤入屋宽频有 10 Gbps，SSD 一共有 20 TB。

错误：

> 我家的光纤入屋宽频有 10Gbps，SSD 一共有 20TB。

:exclamation: 例外：度／百分比各数字之间不需要增加空格：

正确：

> 今天是 233° 的高溫。

> 新 MacBook Pro 有 15% 的 CPU 性能提升。

错误：

> 今天是 233 ° 的高溫。

> 新 MacBook Pro 有 15 % 的 CPU 性能提升。

<a name="spacing-c4"></a>

### 全形标点各其他字符之间不加空格

正确：

> 剛剛买了一部 iPhone，好開心！

错误：

> 剛剛买了一部 iPhone ，好開心！

<a name="spacing-c5"></a>

### `-ms-text-autospace` to the rescue?

Microsoft 有个 [`-ms-text-autospace`](http://msdn.microsoft.com/en-us/library/ie/ms531164(v=vs.85).aspx) 的 CSS 属性可以实现自动为中英文之间增加空白。不过目前並未普及，另外在其他应用场景，例如 OS X、iOS 的用户见面目前并不存在这个特性，所以请继续保持随手加空格的习惯。

<a name="punctuation-marks"></a>

## 标点符号

<a name="punctuation-marks-c1"></a>

### 不重复使用标点符号

# Build webdoc

## zh-cn

1. Build.

        $ make webdocs
    
2. Open the `htmlout/index.html`.

## zh-tw
    
1. Inatall the [OpenCC](https://github.com/BYVoid/OpenCC).    
        
        # Debian, Ubuntu
        $ sudo apt-get install opencc
        
        # Mac OS X
        $ brew install opencc

2. Build.

        $ make zhtw_webdocs
        
3. Open the `htmlout-zhtw/index.html`.
