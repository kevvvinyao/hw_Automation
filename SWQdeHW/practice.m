clc;clear;
load output_signal.mat
t=out_signal(1,:);
y = out_signal(2,:);
n =length(t);
b0=0.0007;
a0=0.0005;
a1=0.0001;
x0=[a1,a0,b0];
F=100;
while F>0.0001 
[x,F]= fminsearch(@wen,x0,[],y,t,n);
x0=x;
end
f
%num=b0;
%den=[a1,a0];
%sys = tf(num,den);