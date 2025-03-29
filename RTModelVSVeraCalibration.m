clear;

% goal: display Vera points, untweaked room temperature model, and tweaked
% temperature model

% Points from Vera's calibration pulled
f_vera = [300 349.1726 400.3686 443.6340 501.1245 547.0304 600.9836 643.5356 696.5057 752.2259 802.0498 905.9874 999.6090 1110.0013 1224.7050 1286.4280 1389.3420 1556.0237 1684.1017 1846.2521 1981.2048 2112.4304 2200];
M_vera = -1*[50.9763 51.3424 51.6881 51.9932 52.3797 52.6441 52.9085 53.0915 53.3153 53.4983 53.6203 53.8237 53.9358 54.0678 54.1695 54.2508 54.3525 54.5966 54.8407 55.1864 55.5525 56 56.3254];
% semilogx(f_vera,M_vera)       % test to see if points catch shape (it do)

% more complete frequency range
syms f
f_ran = 300:20:2200;

% untweaked function
bor = RTFreqResponse(f_ran, 1, 1, 1, 48.2);

% tweaked function w/ values determined by testing_groundV4.m
c_rp = 0.367;
c_lp = 0.446;
c_ru = 0.476;
S_e = 45.829;
fun = RTFreqResponse(f_ran, c_rp, c_lp, c_ru, S_e);

% plotting
semilogx(f_vera,M_vera,'*', f_ran, bor, f_ran, fun)
legend('Vera','Standard','Fitted')
xlabel('Frequency [Hz]')
ylabel('Sensitivity [dB re. V/Pa]')