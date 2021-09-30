# SNP_filter 

## 安装 Install

Dnwnload the file and source it using R

下载文件并用R语言source下载文件

```
source('CRS_SNP.R.R', encoding = 'UTF-8')
source('simplify_SNP.R', encoding = 'UTF-8')
```

## 使用 Usage

The file has three programs:

Function 'CRS_SNP' is used to filter SNP combination that can distinguish all samples from the data

Function 'simplify_SNP' is used to simplify SNP combination that can distinguish between all samples

Function 'identify_variety' is used to test whether SNP combination can distinguish all samples

文件有三个程序：

程序'CRS_SNP'是用来筛选能够区分数据集内全部样本的SNP标记组合

程序'simplify_SNP'是在确保剩余标记够区分数据集内的全部样本情况下精简SNP标记组合

程序'identify_variety'是用来检验SNP标记组合能够区分的样本数量

## 例子 Example 

I provide a demonstration data to explain how to use the program

这里提供了用来演示程序的示范数据

```
snp_data<-read.table('snp_data.txt')
```

test data : The first five columns are table headers, the rows of the data are SNPS, and the columns are samples

测试数据:前五列为表头，用于提供数据集的基本信息，数据集行为SNP标记，列为品种信息

### run program CRS_SNP   运行程序 CRS_SNP


```
rlt1<-CRS_SNP(data_o = snp_data,s = 20,k = 5,rep = 10,genesite = 3,snpsite = 4)
```
>  K is the columns number in the previous table header
>  
> k为前面表头的列数
> 
>  SNPS is the original data, and S is the number of SNPS selected in once cycle
>  
> data_o为原始数据,s为一次循环选取的SNP个数
> 
>  rep is the number of repetitions in the filter step,The larger the rep is, the better the result will be, but the more time will be spent 
>  
> rep为筛选步骤中重复的次数，重复的次数越多，结果越好，程序的运行时间也会增加
> 
>  genesite is the column of the gene in which the SNP is located. If there is no column in which the SNP name can be entered  
>  
> genesite为gene名称所在位置，如果没有这一列信息可以选取SNP名称的所在列
> 
>  snpsite is the column where the SNP name resides  
>  
> snpsite为SNP名称所在位置
> 

### run program simplify_SNP  运行程序 simplify_SNP

```
rlt2<-simplify_SNP(data1 = snp_data,rep = 5,SNPs = rlt1,k = 5,snpsite = 4)
``` 
> data1 is the original data
> 
> data1 为原始数据集
> 
> rep is the number of repetitions required
> 
> rep为需要重复的次数	
> 
> SNPs is the unsimplified SNP combination  
> 
> SNPs为未精简的SNP组合
> 
> k is the number of columns in the previous table header
> 
> k为前面表头的列数
> 
> snpsite is the column where the SNP name resides  
> 
 >snpsite为SNP名称所在位置
 
 rlt2[[1]] is condensed combination for REP times
 
  rlt2[[1]] 是REP个SNP精简标记组合
  
 rlt2[[2]] is the number of SNP combination
 
  rlt2[[2]] 是每个SNP标记组合的标记数量
 
 rlt2[[3]] is the optimal result

 rlt2[[3]] 是其中最好的结果
 
 
 ### run program identify_variety   运行程序 identify_variety
 
 Save the SNP marker combination and verify whether the SNP marker combination can distinguish all samples of the dataset
 
 保存SNP标记组合，并验证SNP标记组合是否能够区分数据集全部样本
 
 ```
 SNPs<-rlt2[[3]][[2]][[1]]
identify_variety(data1 = snp_data,snps = SNPs,k = 5,snpsite = 4)
```
> data1 is the original data
> 
> data1 为原始数据集
> 
> k is the number of columns in the previous table header
> 
> k为前面表头的列数
> 
> SNPs is the SNP combination  
> 
> SNPs为SNP组合
> 
> snpsite is the column where the SNP name resides  
> 
 >snpsite为SNP名称所在位置
