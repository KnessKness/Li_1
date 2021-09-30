#2021.09.29

simplify_SNP<-function(data1,rep,SNPs,k,snpsite){
  #精简SNP标记组合
  #需要函数identify_variety
  #---data1为SNP数据集
  #---rep为需要重复的次数
  #---SNPs为未精简的SNP组合
  #---k为前面表头的列数
  #---snpsite为SNP名称所在位置
snpss<-list(NULL)
gmax<-list(NULL)
list1<-list(NULL)
ge<-NULL
SNPS<-data1[which((as.character(data1[,snpsite]))%in%unique(SNPs)),]

  sapply(1:rep,function(j){
  T<-sample(SNPs,length(SNPs))
  i=1
    repeat {
      p<-length(T)
      t<-T[-i]
      rlt<-identify_variety(SNPS,t,k,snpsite)
      if(rlt==(length(SNPS[1,])-k)){T<-t;rlt=0;}else(i=i+1)
      if(p==(i-1))(break)
      print(i)
    }
  snpss[j]<<-list(as.character(T))
  ge[j]<<-length(as.character(T))
})
gmax[1]<-list(min(ge))
gmax[2]<-list(snpss[which.min(ge)])
list1<-list(snpss,ge,gmax)
return(list1)
}
