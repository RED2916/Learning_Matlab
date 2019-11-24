function Q_total=cal_cost1(  T0,T1,Q_output,S )
%计算损耗
cp=1.005*1000;
K=80;%导热系数
p=1.293;%空气密度
Q=min(Q_output,(K*S*(T0-T1)/0.3));%第一次导热，中间
n=ceil(Q_output/Q);%交换次数
m=S*n*p;
Q_total=0;
for i=1:n
    T_N=Q/(cp*m)+T1;
    Q_total=Q_total+Q+cal_cost2( T1,T_N,m,S );  
end
end
