function output=cal_distance( x,y)
%计算损耗
[X,Y]=meshgrid(1:16,1:16);
output=sqrt( (X- x).^2 + ( Y- y ).^2);
end
