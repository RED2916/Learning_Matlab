function number_output=deal_number(number_output,n1,n2,n3,n4)
%处理数据
number_output(1:n1)=max(number_output(1:n1));
number_output(n1+1:n1+n2)=max(number_output(n1+1:n1+n2));
number_output(n1+n2+1:n1+n2+n3)=max(number_output(n1+1:n1+n2));
number_output(n1+n2+n3+1:n1+n2+n3+n4)=max(number_output(n1+n2+n3+1:n1+n2+n3+n4));
end
