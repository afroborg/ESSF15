%% 1.

clc;
clear;
close all;

E = 10;
R = 2;
L = 50E-3;

out = sim("rl");

% Tidskonstant - R/L
tau = R / L;
fprintf("Tidskonstanten: %d\n", tau);

% Stationär ström
stationary = E / R;
fprintf("Stationär ström: %dA\n", stationary);

% PWM
Ts = 0.002;
Udc = 100;

figure(1);
plot(out.tdc, out.irldc);
hold on;
out = sim("rl_pwm", 'SaveOutput', 'on');
plot(out.tpwm, out.irlpwm);
legend("RL", "RL PWM");
hold off;
% medelvärdet pendlar kring referensvärdet E

figure(2);
plot(out.tpwm, out.irlpwm);
hold on;
Ts = Ts * 2; % F = 1/T => F/2 = 1/2T
out = sim("rl_pwm", 'SaveOutput', 'on');
plot(out.tpwm, out.irlpwm);
legend("Ts", "2Ts");
% Lägre frekvens => switchar mer sällan

%% 2.

clc;
clear;
close all;

% Varvtalet ändras linjärt med spänning
% Vridmomentet ökar när ström ökar, T = k*i_a och när flöde ökar, e = vBl
% omega = E_a/k och T = k*i_a => T*omega = E_a * i_a

U = 100;
Ra = 3;
La = 0.03;
psim = 1.1;
J = 0.05;
D = 0.002;
Ts = 0.002;
Udc = 200;

out_dc = sim("dcm_dc", 'SaveOutput', 'on');
out_pwm = sim("dcm_pwm", 'SaveOutput', 'on');

figure();
plot(out_dc.tdc, out_dc.iadc);
hold on;
plot(out_pwm.tpwm, out_pwm.iapwm);
legend("iadc", "iapwm");

figure();
plot(out_dc.tdc, out_dc.wdc);
hold on;
plot(out_pwm.tpwm, out_pwm.wpwm)
legend("wdc", "wpwm");

% e) Ingen värmeutveckling i en switchad regulator => mer nyttig effekt
% f) Rippelfrekvensen blir samma som switchfrekvensen, alltså 5kHz

%% 3.

clc;
clear;
close all;

E = 10;
R = 2;
L = 0.05;
Uftopp = sqrt(2)*230;
Ts = 0.001;
Udc = 400;

out = sim("rl_sin", 'SaveOutput', 'on');

figure();
plot(out.tpwm, out.irlpwm);
hold on;
F = (1./out.tpwm);
omega = F * 2 * pi;
Z = R + (1i * omega * L);
u = Z .* out.irlpwm;
plot(out.tpwm, u); 
legend("i", "u");

% b) Grundton 50Hz, 1/Ts, effektivvärde 230V, Uftopp / sqrt(2)
phi = rad2deg(atan(pi * 50 * 2 * L / R));
fprintf("Phi: %d\n", phi);

%% 4.
clc;
clear;
close all force;

t = 0:0.001:0.02;
s = 2 * pi * 50 * t;
ua = 325 * sin(s);
ub = 325 * sin(s - (2*pi/3));
uc = 325 * sin(s - (4*pi/3));

u = 3/2 * (ua + ub * exp(1i * 2 * pi / 3) + uc * exp(1i * 4 * pi / 3));
showvector(real(u),imag(u));

figure();
subplot(2, 1, 1);
plot(t, real(u));
hold on;
plot(t, imag(u));
plot(t, abs(u));
legend("Real(u)", "Imag(u)", "Abs(u)");


subplot(2, 1, 2);
plot(t, angle(u));
legend("Arg(u)");

u = 3/2 * (ua + uc * exp(1i * 2 * pi / 3) + ub * exp(1i * 4 * pi / 3));

figure();
subplot(2, 1, 1);
plot(t, real(u));
hold on;
plot(t, imag(u));
plot(t, abs(u));
legend("Real(u)", "Imag(u)", "Abs(u)");


subplot(2, 1, 2);
plot(t, angle(u));
legend("Arg(u)");

showvector(real(u),imag(u));

% c) den går åt andra hållet

%% 5.
clc;
clear;
close all;

% a) omega = 2*pi*F, E = -j*omega*phi_m

Rs = 0.5;
Ls = 0.087;
uftopp = 325;
f = 50;
Udc = 600;
Ts = 0.0002;

sim("psis_sin",'SaveOutput', 'on');

% b) sinus
% c) 1.28

%out = sim("psis_pwm", 'SaveOutput', 'on');

% d) Konstant i sin, ej i pwm
% e) uc* sinusvåg, uc switchar
% f) sinus
% g) 1.2

Ts = 0.002;

out = sim("psis_pwm", 'SaveOutput', 'on');

%showvectors(out.uspsis);

% h) hackigare av högre Ts

%% 6.

f = 50 / 2;
uftopp = 325 / 2;

out = sim("psis_pwm", 'SaveOutput', 'on');

% a) Periodtiden dubleras
% b) 2.5 
% c) Jadu


