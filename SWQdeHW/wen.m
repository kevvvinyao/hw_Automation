function [F]=wen(x,y,t,n)
b0=x(3);
a1=x(1);
a0=x(2);
num=[b0];
den=[a1,a0];
mod = tf(num,den);
[ymod,t_mod] = step(mod,t(n));
y_origin_interp = interp1(t',y,t_mod,'spline');
m = y_origin_interp-ymod;
F = m'*(m);
end
