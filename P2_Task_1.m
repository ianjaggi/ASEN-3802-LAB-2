clear all;
close all;
clc;

H_Al = 91.09;

k = 130; 
cp = 960;
rho = 2810;

alpha = k / (rho * cp);

t1 = 1;
t2 = 1000;

L = 0.041275+0.0889+0.0254;
T0 = 17.0501; %K
x = 0.041275+0.0889;

t = [t1,t2];


    figure();
    hold on;
    grid on;

% n = 0:10
for i = 1:2
    summation = 0;

    % Hold the number of modes and corresponding temperatures
    n_vals = [];
    u_vals = [];
   

        for n = 1:10
            lambdan = ((2 * n - 1) * pi) / (2 * L);
            bn = ((8 * L * H_Al) / (((2 * n) - 1)^2 * (pi^2))) * (-1)^n;
    
            summation = summation + bn * sin(lambdan * x) * exp(-(lambdan^2) * alpha * t(i));
            u = T0 + H_Al * x + summation;
    
            n_vals = [0,n_vals, n];
            u_vals = [T0+H_Al*x,u_vals, u];
 
        end
    
    plot(n_vals, u_vals, '-o');
    xlabel('n Iterations');
    ylabel('T (K)');
    title(sprintf('Steady State Temp for Varying n (Time = %g) seconds', t(i)));

end    

legend
hold off;
