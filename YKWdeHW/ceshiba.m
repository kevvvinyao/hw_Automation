% 输入参数
load hw4top.mat
t = (out_signal(1, :))';
y = (out_signal(2, :))';

params0 = [1, 1, 1, 1, 1, 1, 1, 1]; % 给一个初始值
best_params = fminsearch(@(params) find_best_params(params, t, y), params0);

disp(best_params)
function F = find_best_params(params, t, y)
    % 创建传递函数模型
    a3 = params(1);
    a2 = params(2);
    a1 = params(3);
    a0 = params(4);
    b3 = params(5);
    b2 = params(6);
    b1 = params(7);
    b0 = params(8);
    den = [a3, a2, a1, a0];
    num = [b3, b2, b1, b0];
    mod = tf(num, den);
    
    % 计算阶跃响应并计算误差
    ymod = step(mod, t);
    m = y - ymod;
    F = sum(m.^2);
end

