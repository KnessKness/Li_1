#2020.12.29


roll<-function(SNPS,s,k,samp,genesite,snpsite)
{
  #---步骤A的统合函数---
  #---k为前面表头的列数-----------------
  #---SNPS为原始数据，s为一次循环选取的SNP个数
  #---samp为筛选步骤中重复的次数
  data1<-function5p3(SNPS,k)
  ans<-NULL
  dataNEW<-data1
  before<--1
  repeat{
    rlt<-function5s(ans,s,dataNEW,samp,data1,k,genesite,snpsite)
    snp<-rlt[[3]]
    anss<-unlist(snp[[1]])
    ass<-as.character(anss)
    ans<-c(ans,ass)
    sum<-snp[[2]]
    snps<-which(data1[,snpsite] %in% ans)
    if(sum==before|sum==(ncol(data1)-k))(break)
    if(sum>0)(before<-sum)
    print(before)
    data1.1<-function5p2(snps,data1,k)
    dataNEW<-function5p3(data1.1,k)
  }
  return(ans)
}

function5p2<-function(SNPs,mydata,k)
{
  #----在原始数据中去除选中的SNP--
  #----以及对应的特异单倍型------
  #---k为前面表头的列数----------------
  data<-as.data.frame(mydata)
  p<-(length(data[1,])-k)
  Q<-NULL
  ex<-NULL
  dat<-NULL
  sapply(1:p,function(j)
  {
    Q[j]<<-paste(data[c(SNPs),j+k],collapse="")
  })
  test1<-table(Q)
  test2<-as.data.frame(test1)
  test3<-as.character(test2[which(test2$Freq==1),1])
  ex<-ifelse(Q%in%test3,FALSE,TRUE)
  data1<-data[,(k+1):(p+k)]
  data2<-data[,1:k]
  data3<-data1[,ex]
  dat<-cbind(data2,data3)
  dat<-dat[-c(SNPs),]
  
  
  return(dat)
}

function5p3<-function(data,k){
  #---k为前面表头的列数-----------------
  #---对data去除样本基因型重复的SNP------
  x<-ncol(data)
  rlt<-data[!duplicated(data[,c((k+1):x)]),]
  return(rlt)
}

function5s<-function(ans,s,dataNEW,samp,data1,k,genesite,snpsite)
{
  #-------按基因分组随机抽取SNP---------------
  #----ans为原先的数据-s-抽取个数-samp-重复次数
  #----data为精简后的数据，data1为原始数据
  b<-1:s;
  p<-(length(data1[1,])-k)
  list1<-list(NULL)
  list2<-list(NULL)
  list3<-list(NULL)
  test<-NULL
  ri=0;
  rice=1;
  test<-dataNEW[,genesite]
  test<-(as.character(test))
  for(n in 1:samp){
    Q<-NULL;
    a<-1:s;
    a<-sample(unique(test),size=s,replace=TRUE);
    
    for (i in 1:s){
      b[i]=sample(as.character(dataNEW[,snpsite])[which(test==a[i])],size = 1);
    }
    
    data1x<-data1[which((as.character(data1[,snpsite]))%in%unique(c(b,ans))),]
    sapply (1:p,function(j)
    {
      Q[j]<<-paste(data1x[,j+k],collapse="")
    })
    test1<-table(Q)
    test2<-as.data.frame(test1)
    list1[n]<-list(b)
    rice<-length(test2[which(test2$Freq==1),2])
    list2[n]<-rice
    if(rice>ri)
    {
      ri<-rice;
      list3[1]<-list(c(b));
      list3[2]<-list(ri);
    }
  }
  rltlist<-list(list1,list2,list3)
  return(rltlist)
}

identifiy<-function(data1,snps,k,snpsite)
{
  
  Q<-NULL
  snp<-which(data1[,snpsite]%in%snps)
  data<-data1[c(snp),]
  p<-(length(data[1,])-k)
  for (j in 1:p)
  {
    Q[j]<-paste(data[,j+k],collapse="")
  }
  test1<-table(Q)
  test2<-as.data.frame(test1)
  rlt<-length(test2[which(test2$Freq==1),2])
  return(rlt)
}
