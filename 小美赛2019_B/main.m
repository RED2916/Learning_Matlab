%[X,Y]=meshgrid(1:160,1:160);
%axis([0,160,0,160,0,2.6])
%mesh(X,Y,z);
%z=1/2*z;
%y=zeros(16,16);
%x=zeros(16,16);
%w=cat(3,z,x,y);
%image(w);
z=zeros(16,16);%初始化模拟
z(4:13,2:3)=2;
z(4:13,6:7)=2;
z(4:13,10:11)=2;
z(4:13,14:15)=2;
imagesc(z);
hold on;
[X,Y]=meshgrid(1:16,1:16);
T0=25;%室温
T1=20;%冷气温度
Q1=1000;%格机生热量
S1=0.6*0.6;
S2=2*0.6;
S_1=S1+S2;%中间面积
S_2=S1+S2*2;%两边面积
Q_1=cal_cost1(T0,T1,Q1,S_1);
Q_2=cal_cost1(T0,T1,Q1,S_2);
Q_1=ceil(Q_1);
Q_2=ceil(Q_2);
Q_EVERY=cat(2,Q_1,Q_2);%不同面积需要的冷量，都是近2000
S_EVERY=cat(2,S_1,S_2);%不同面积
d=0.3;%传热距离
temperate=1000;
cooling_rate=0.95;%退火算法准备
record_output=zeros(1,9);
the_one=0;
previous_output=10000;
diff=0;
T=1;
for n1=1:3
    for n2=1:3
        for n3=1:3
            for n4=1:3
                  number_total=n1+n2+n3+n4;%计算出风口总数
                  w1=3/n1;%计算权重
                  w2=3/n2;
                  w3=3/n3;
                  w4=3/n4;
                  number_weight=zeros(1,number_total);
                  number_weight(1:n1)=w1;
                  number_weight(n1+1:n1+n2)=w2;
                  number_weight(n1+n2+1:n1+n2+n3)=w3;
                  number_weight(n1+n2+n3+1:n1+n2+n3+n4)=w4;
                  the_one=the_one+1;
                  while temperate>1%退火算法
                      judge=0;
                      number_output=zeros(1,number_total);
                      distance=zeros(16,16,number_total);%距离矩阵
                      weight_total=zeros(16,16);%全权重矩阵
                      %deal_weight=zeros(16,16);%用于判断的矩阵
                      hang=ceil(randperm(8,number_total)+4);
                      lie=ceil(randperm(8,number_total)+4);
                      plot(hang,lie,'r.');
                      drawnow;
                      for n5=1:number_total
                          distance(:,:,n5)=cal_distance( hang(n5),lie(n5));
                      end
                      for n6=1:number_total
                          weight_total=weight_total+(distance(:,:,n6)<6)*number_weight(n6);
                      end
                      deal_weight=(z(:,:)>0).*(weight_total(:,:)>0)*2;%处理，判断是否每一个都被覆盖
                      if deal_weight(:,:)==z(:,:)
                          judge=1;
                      end
                      if judge==1
                          for n7=1:number_total
                            temp2=(weight_total(:,:)==0);%去除分母中0
                            temp=sum((z(:,:)>0).*(distance(:,:,n7)<6).*number_weight(n7)./(weight_total(:,:)+temp2));
                            temp(find(isnan(temp)==1))=0;
                            number_output(n7)=sum(temp);
                          end
                          number_output=deal_number(number_output,n1,n2,n3,n4);
                          current_output=sum(number_output);
                          diff=current_output-previous_output;
                          if ( diff<0 )|| ( rand<exp(-diff/temperate) )
                              record_output(the_one)=current_output;
                              previous_output=current_output;
                              T=T+1;
                          end
                          if T>=10
                              temperate=cooling_rate*temperate;
                              T=0;
                          end
                      end
                  end
            end
        end
    end
end
