% 输入参数
load hw4top.mat
t = (out_signal(1, :))';
y = (out_signal(2, :))';

params0 = [1, 1, 1, 1, 1, 1, 1, 1]; % 给一个初始值
best_params = fminsearch(@(params) find_best_params(params, t, y), params0);

disp(best_params)


b3 = best_params(1);
b2 = best_params(2);
b1 = best_params(3);
b0 = best_params(4);
a3 = best_params(5);
a2 = best_params(6);
a1 = best_params(7);
a0 = best_params(8);
den = [a3, a2, a1, a0];
num = [b3, b2, b1, b0];
sys = tf(num, den);
step(sys);

function F = find_best_params(params, t, y)
    % 创建传递函数模型
    b3 = params(1);
    b2 = params(2);
    b1 = params(3);
    b0 = params(4);
    a3 = params(5);
    a2 = params(6);
    a1 = params(7);
    a0 = params(8);
    den = [a3, a2, a1, a0];
    num = [b3, b2, b1, b0];
    mod = tf(num, den);
    
    % 计算阶跃响应并计算误差
    ymod = step(mod, t);
    m = y - ymod;
    F = sum(m.^2);
end

