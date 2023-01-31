clear
clc
close all

amplitude = 220;
freq_hz = 50;
freq = freq_hz * 2 * pi;
L = 95 * 10^-3;
R = 40;

tolerance = 1e-7;
stop_time = 0.1;

out_one = sim('enfas');

%% Uppgift 1 - Växelspänning och växelström i en fas
clc

% a) L/R

u = out_one.u1;
i = out_one.i1;
t = out_one.tout;

figure(1);
plot(t, u, 'b');
hold on;
plot(t, i, 'r');
hold off

% spänning på komplex form
u_top = max(u(2:end)); % ta bort första toppvärdena
u_complex = u_top * exp(1i*0);

% b)
fprintf("Spänning på komplex form: %f * exp(j0) = %f V\n", u_top, u_complex);

% ström på komplex form
i_top = max(i(2:end));
phase_diff = acos(dot(i, u)/(norm(i)*norm(u))); % rad
i_complex = i_top * exp(-1i * phase_diff);

% c)
fprintf("Ström på komplex form: %f * exp(-j%f) = %f A\n", i_top, phase_diff, i_complex);

% komplex impedans
Z = u_complex / i_complex;

% d)
fprintf("Kretsens komplexa impedans: %f\n", abs(Z));

% e)
R_from_complex = real(Z);
L_from_complex = imag(Z);

fprintf("Resistans från komplexa värden: %f Ohm\n", R_from_complex);
fprintf("Induktans från komplexa värden: %f mH\n", L_from_complex);

%% Uppgift 2 - Effekt i fas
clc

% a)
S_ = u_complex * conj(i_complex); % skenbar effekt
P = real(S_); % aktiv effekt
Q = imag(S_); % reaktiv effekt
S = abs(S_);


fprintf("Skenbar effekt: %f VA\n", S);
fprintf("Aktiv effekt: %f W\n", P);
fprintf("Reaktiv effekt: %f VAr\n", Q);

% b)
effect_factor = P / S; % cos(phi)

% c)
multiplied = u .* i;
plot(t, multiplied, 'b');

% d) 873 - utläst från grafen, aktiv effekt
mean_ = mean(multiplied);

% e) Energi återgår till källan

%% Uppgift 3 - Växelspänning i tre faser 
clc

phase_1 = 0;
phase_2 = 2*pi / 3; % 120 deg
phase_3 = 4*pi / 3; % 240 deg

out_three = sim('trefas');

% a) Fas

% b)

u_arr = [out_three.u1, out_three.u2, out_three.u3];
i_arr = [out_three.i1, out_three.i2, out_three.i3];
t = out_three.tout;

figure(2);
hold on;

for i = 1:size(u_arr, 2)
    plot(t, u_arr(:,i));
end

i_tot = sum(i_arr, 2);
plot(t, i_tot);
hold off;

i_tot_value = sum(i_tot); % ungefär 0

% e)

first_two_u = sum(u_arr(:, 1:2), 2);
figure(3);
plot(t, first_two_u);

% f)

p = u_arr .* i_arr;

figure(4);
hold on;

for i = 1:size(p, 2)
    plot(t, sum(p(:,1:i),2));
end

legend('p1', 'p1 + p2', 'p1 + p2 + p3');

%% 4 - Infasning av synkrongenerator
clc
clear
close all

out = sim('infasning','SaveOutput', 'on');

figure(5);
hold on;
t = out.tout;
plot(t, out.uelnat);
plot(t, out.usg);
plot(t, out.u_over_brytare);
legend('Nätspänning', 'Generatorspänning', 'Skillnadsspänning');

