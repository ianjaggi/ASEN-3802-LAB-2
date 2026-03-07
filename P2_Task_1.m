clear;
close all;
clc;

H_Al = 91.09;

k = 130; 
cp = 960;
rho = 2810;

alpha = k / (rho * cp);

t1 = 1;
t2 = 1000;

L = 0.034925 + 0.0889 + 0.0254;
T0 = 17.0501; % K
x = 0.034925 + 0.0889; % m

t = [t1, t2];

%% Section 1: Temperature vs n iterations for two times

figure();
hold on;
grid on;

for i = 1:length(t)
    
    n_vals = 0:10;
    u_vals = zeros(size(n_vals));
    u_vals(1) = T0 + H_Al * x;
    summation = 0;

    for n = 1:10
        
        lambda_n = ((2 * n - 1) * pi) / (2 * L);
        bn = ((8 * L * H_Al) / (((2 * n) - 1)^2 * (pi^2))) * (-1)^n;
        summation = summation + bn * sin(lambda_n * x) * exp(-(lambda_n^2) * alpha * t(i));
        u_vals(n+1) = T0 + H_Al * x + summation;

    end

    plot(n_vals, u_vals, '-o', 'LineWidth', 1.5);
end

xlabel('n Iterations');
ylabel('T (K)');
title('Temperature for Varying n at Two Times');
legend(sprintf('t = %g s', t1), sprintf('t = %g s', t2), 'Location', 'best');
hold off;


%% Section 2: Temperature vs time for 8 different x values

t_time = linspace(0, 3500, 3500);

x_vals = linspace(0, x, 7);

figure();
hold on;
grid on;

n_chosen = 3;

for j = 1:length(x_vals)
    
    x_current = x_vals(j);
    T_time = zeros(size(t_time));

    for i = 1:length(t_time)
        summation = 0;

        for n = 1:n_chosen
            lambda_n = ((2 * n - 1) * pi) / (2 * L);
            bn = ((8 * L * H_Al) / (((2 * n) - 1)^2 * (pi^2))) * (-1)^n;

            summation = summation + bn * sin(lambda_n * x_current) * exp(-(lambda_n^2) * alpha * t_time(i));
        end

        T_time(i) = T0 + H_Al * x_current + summation;
    end

    plot(t_time, T_time, 'LineWidth', 1.5);
end

xlabel('Time (s)');
ylabel('T (K)');
title('Temperature vs Time for 8 Different x Values');
legendStrings = arrayfun(@(k) sprintf('x_{%d} = %.4f m', k, x_vals(k)), 1:min(8,length(x_vals)), 'UniformOutput', false);
legend(legendStrings, 'Location', 'best');
hold off;
