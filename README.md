# Li_1
SNP_filter 

snp_data<-read.table('snp_data.txt')
>  
>#读取测试数据
>
>#前6行为表头，行为SNP，列为品种
>
source('New_full_roll.R', encoding = 'UTF-8')
> 
source('Newfinish.R', encoding = 'UTF-8')

>#读入程序

rlt1<-roll(SNPS = snp_data,s = 20,k = 6,samp = 10,genesite = 2,snpsite = 5)

>  #---步骤A的统合函数---
 
>  #---k为前面表头的列数-----------------
	
>  #---SNPS为原始数据，s为一次循环选取的SNP个数
	
>  #---samp为筛选步骤中重复的次数
	
>  #---genesite为SNP所在的基因的列，如果没有可输入SNP名所在列
	
>  #---snpsite为SNP名所在列
>
rlt2<-Newfinish(data1 = snp_data,samp = 5,ans = rlt1,k = 6,snpsite = 5)
 
 >  #-----步骤B--------
 
 > #-----精简SNP------
	
  >#---data1为原始数据-----
	
  >#---samp为需要重复的次数--
	
 > #---ans为未精简的SNP组合---
	
  >#---k为前面表头的列数-------
	
  >#---snpsite为SNP名所在列
 >
 即可得到精简的可区分全部非EDV品种的SNP标记组合
 
 rlt2[[1]] 为samp次数精简的组合
 
 rlt2[[2]] 为组合的标记数量
 
 rlt2[[3]] 为最优结果
