#2021.09.29

CRS_SNP<-function(data_o,s,k,rep,genesite,snpsite)
{
  #CRS_SNP函数功能为筛选能够区分全部样本的SNP标记组合
  #CRS_SNP包含function_p1,function_p2,function_p3共3个子函数
  #以下为参数解释：
  #---data_o为原始数据
  #---s为一次循环选取的SNP个数
  #---k为前面表头的列数
  #---rep为筛选步骤中重复的次数
  #---genesite为gene名称所在位置
  #---snpsite为SNP名称所在位置

  data1<-function_p3(data_o,k)
  ans<-NULL
  dataNEW<-data1
  before<--1
  repeat{
    rlt<-function_p1(ans,s,dataNEW,rep,data1,k,genesite,snpsite)
    snp<-rlt[[3]]
    anss<-unlist(snp[[1]])
    ass<-as.character(anss)
    ans<-c(ans,ass)
    sum<-snp[[2]]
    snps<-which(data1[,snpsite] %in% ans)
    if(sum==before|sum==(ncol(data1)-k))(break)
    if(sum>0)(before<-sum)
    print(before)
    data1.1<-function_p2(snps,data1,k)
    dataNEW<-function_p3(data1.1,k)
  }
  return(ans)
}

function_p2<-function(SNPs,mydata,k)
{
  #在mydata数据中去除选中的SNP标记组合

  #---mydata为目标数据
  #---SNPs为标记组合
  #---k为前面表头的列数
  
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

function_p3<-function(data,k){

  #对data去除样本基因型重复的SNP
  #---k为前面表头的列数
  
  x<-ncol(data)
  rlt<-data[!duplicated(data[,c((k+1):x)]),]
  return(rlt)
}

function_p1<-function(ans,s,dataNEW,rep,data1,k,genesite,snpsite)
{
  #按基因分组随机抽取SNP组合进行样本区分，并挑选最优结果
  #--ans为上次循环中保存的SNP标记组合，s为抽取SNP标记个数，rep为重复次数
  #--data为程序精简后的数据集，data1为输入程序的数据集
  #---k为前面表头的列数
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
  for(n in 1:rep){
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

identify_variety<-function(data1,snps,k,snpsite)
{
  #测试输入的SNP标记组合能够区分data1数据集中多少样本
  #---data1为SNP数据集
  #---snps为SNP标记组合
  #---k为前面表头的列数
  
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
