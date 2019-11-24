function Q_output=cal_cost2( T0,T_P,m,S )
%计算损耗
cp=1.005*1000;
A=20;%空气对流导热率
Q_D=A*S*(T_P-T0);
if Q_D>0.0001
    T_N=T_P-Q_D/(cp*m);
    Q_output=Q_D+cal_cost2(  T0,T_N,m,S );   
else
    Q_output=0;
end
end
