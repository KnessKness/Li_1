# SNP_filter 

## Install

Dnwnload the file and source it using R

```
source('New_full_roll.R', encoding = 'UTF-8')
source('Newfinish.R', encoding = 'UTF-8')
```

## Usage

The file has three programs:

Function 'roll' is used to filter SNP combination that can distinguish all samples from the data

Function 'Newfinish' is used to simplify SNP combination that can distinguish between all samples

Function 'identifiy' is used to test whether SNP combination can distinguish all samples


## Example 

I provide a demonstration data to explain how to use the program

```
snp_data<-read.table('snp_data.txt')
```

test data : The first six rows are table headers, the rows of the data are SNPS, and the columns are samples

run program roll
```
rlt1<-roll(SNPS = snp_data,s = 20,k = 6,samp = 10,genesite = 2,snpsite = 5)
```
>  K is the columns number in the previous table header
	
>  SNPS is the original data, and S is the number of SNPS selected in once cycle
	
>  samp is the number of repetitions in the filter step,The larger the samp is, the better the result will be, but the more time will be spent 
	
>  genesite is the column of the gene in which the SNP is located. If there is no column in which the SNP name can be entered  
	
>  snpsite is the column where the SNP name resides  

```
rlt2<-Newfinish(data1 = snp_data,samp = 5,ans = rlt1,k = 6,snpsite = 5)
``` 
> data1 is the original data
	
> samp is the number of repetitions required
	
> ans is the unsimplified SNP combination  
	
> k is the number of columns in the previous table header
	
> snpsite is the column where the SNP name resides  
 >
 
 rlt2[[1]] is condensed combination for SAMP times
 
 rlt2[[2]] is the number of SNP combination
 
 rlt2[[3]] is the optimal result
