clear;
% goal: script to plot all the high temperature models and the room
% temperature model

% frequency domain of interest
f_dom = 300:2:2200;

% untweaked 22.25 C curve for comparison
RT = RTFreqResponse(f_dom, 1, 1, 1, 48.2);

% untweaked 200 C curve for comparison
curve200 = HT200CFreqResponse(f_dom, 1, 1, 1, 48.2);

% untweaked 400 C curve for comparison
curve400 = HT400CFreqResponse(f_dom, 1, 1, 1, 48.2);

% untweaked 600 C curve for comparison
curve600 = HT600CFreqResponse(f_dom, 1, 1, 1, 48.2);

% untweaked 800 C curve for comparison
curve800 = HT800CFreqResponse(f_dom, 1, 1, 1, 48.2);

% Plotting
semilogx(f_dom, RT, f_dom, curve200, f_dom, curve400, f_dom, curve600, f_dom, curve800)
legend('RT 22.25 C Curve', '200C Curve', '400 C Curve', '600 C Curve', '800 C Curve')
xlabel('Frequency [Hz]')
ylabel('Sensitivity [dB re. 1 V/Pa]')