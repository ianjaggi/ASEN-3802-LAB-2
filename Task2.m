clc;
close all;
clear;


p_Al = 2810; % kg/m^3
p_Brass = 8500;
p_Steel = 8000;

cp_Al = 960; % J/(kg*K)
cp_Brass = 380;
cp_Steel = 500;

k_Al = 130; % W/(m*K)
k_Brass = 115;
k_Steel = 16.2;

diam = 0.0254; % m

% Thermo couple percision +- 2 deg C

x = [0 0.015 0.030 0.045 0.060 0.075 0.090 0.105];
a = dir('*mA');

Mexp  = zeros(length(a),1);
Tinit = zeros(length(a),1);

for i = 1:length(a)
    data = readmatrix(a(i).name,'NumHeaderLines',1);

    b = strsplit(a(i).name,'_');
    v = strsplit(b{2},'V');
    ampval = strsplit(b{3},'mA');
    volts(i) = str2double(v{1});
    amps(i)  = str2double(ampval{1});

    time = data(:,1);

    T = data(:,2:9);

    T0 = T(1,:); 

    p = polyfit(x, T0, 1);
    m = p(1);
    b = p(2);

    Mexp(i) = m;
    
    figure; 
    hold on; 
    grid on;
    plot(x, T0, 'o', 'MarkerSize',4, 'Color','b','DisplayName','Initial Temperature');
    xfit = linspace(min(x), max(x), 100);
    Tfit = polyval(p, xfit);
    plot(xfit, Tfit, '-', 'LineWidth',1.5, 'Color','k', 'DisplayName', 'Initial temp Fit');
    plot(xfit, Tfit + 2, '--', 'LineWidth',1.5, 'Color','r','DisplayName', '+ 2 [°C]');
    plot(xfit, Tfit - 2, '--', 'LineWidth',1.5, 'Color','r','DisplayName', '- 2 [°C]');

    ylim([10,25])
    xlabel('x [m]');
    ylabel('Temperature [^\\circC]');

    title(sprintf('Initial Temperature Distribution: %s', a(i).name),'Interpreter','none');
    legend('Location','best');

 
end