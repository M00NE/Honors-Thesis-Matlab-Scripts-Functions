clear

% data points I pulled from Vera's plot
f_vera = [300 349.1726 400.3686 443.6340 501.1245 547.0304 600.9836...
    643.5356 696.5057 752.2259 802.0498 905.9874 999.6090 1110.0013...
    1224.7050 1286.4280 1389.3420 1556.0237 1684.1017 1846.2521...
    1981.2048 2112.4304 2200];
M_vera = -1*[50.9763 51.3424 51.6881 51.9932 52.3797 52.6441 52.9085...
    53.0915 53.3153 53.4983 53.6203 53.8237 53.9358 54.0678 54.1695...
    54.2508 54.3525 54.5966 54.8407 55.1864 55.5525 56 56.3254];

fun = @(x, f_vera) RTFreqResponse(f_vera, x(1), x(2), x(3), x(4));

% lower bounds and upper bounds for c_rp, c_lp, c_ru, S_e
% respectively (tighter bounds mean faster run time)
lb = [0, 0, 0, 0];
ub = [5, 5, 5, 100];

% options to use with lsqcurvefit in the for loop below
options = optimoptions('lsqcurvefit', ...
    'MaxFunctionEvaluations', 1e5, ...
    'MaxIterations', 1e7, ...
    'FunctionTolerance', 1e-11, ...
    'StepTolerance', 1e-11, ...
    'Display', 'off');

num_starts = 20;        % number of interations
x_fit_best = [];        % an empty set to hold the best fitted x values
resnorm_best = 9999;    % set initial residual really high

for ii = 1:num_starts

    % creates the initial x (somewhere random between the lower and upper
    % bounds) to use in lsqcurvefit
    x0 = lb + (ub - lb) .* rand(1, 4);

    % outputs fitted x, the residual, and information about how lsqcurvefit
    % worked for the iteration
    [x_fit, resnorm, ~, exitflag, output] = lsqcurvefit(fun, x0, f_vera, M_vera, lb, ub, options);
    
    % compares the latest and best residuals, updating the best residual
    % and best fitted x as needed
    if resnorm < resnorm_best
        x_fit_best = x_fit;
        resnorm_best = resnorm;
    end
    
    % displays the iteratinon numer, the residual of the iteration, and the
    % starting x used in the iteration
    fprintf('Start %d: Residual norm = %f    Params:', ii, resnorm);
    disp(x0)

end

% give more meaningful names to the fitted x values
c_rp_fit = x_fit_best(1);
c_lp_fit = x_fit_best(2);
c_ru_fit = x_fit_best(3);
S_e_fit = x_fit_best(4);

% prints out the best fitted coefficients and the residual they gave
fprintf('\nBest fitted coefficients:\n');
fprintf('c_rp = %.3f\n', c_rp_fit);
fprintf('c_lp = %.3f\n', c_lp_fit);
fprintf('c_ru = %.3f\n', c_ru_fit);
fprintf('S_e = %.3f\n', S_e_fit);
fprintf('Best_Residual =%.3f\n', resnorm_best);

% plots the resulting curve on top of the points from Vera's plot
M_fit = fun(x_fit_best, f_vera);
semilogx(f_vera, M_vera, 'b.', f_vera, M_fit, 'r-');
legend('Ideal Curve', 'Fitted Curve');
xlabel('fvera');
ylabel('Mvera');
title('Curve Fitting Results');

% calculating max dB difference
dif = M_fit - M_vera;
dif = abs(dif);
diff = max(dif);