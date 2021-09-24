#2020.12.29

Newfinish<-function(data1,samp,ans,k,snpsite){
  #-----步骤B--------
  #-----精简SNP------
  #---data1为原始数据-----
  #---samp为需要重复的次数--
  #---ans为未精简的SNP组合---
  #---k为前面表头的列数-------
snpss<-list(NULL)
gmax<-list(NULL)
list1<-list(NULL)
ge<-NULL
SNPS<-data1[which((as.character(data1[,snpsite]))%in%unique(ans)),]

  sapply(1:samp,function(j){
  T<-sample(ans,length(ans))
  i=1
    repeat {
      p<-length(T)
      t<-T[-i]
      rlt<-identifiy(SNPS,t,k,snpsite)
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
