% In this code, I want to fit the linear model to some
% example dataset. 

%% directories

%% make stimulus

[stim, t] = mk_stimulus();

dt = t(2) - t(1);
t_max = max(t);

%% load example data 

d = load('example_data.mat');
data = d.dt;

% concatenate data
t_lth = size(data, 1); n_conditions = size(data, 2);

% concatenate data
data   = reshape(data, [t_lth * n_conditions, 1]);

% concatenate time series and stimulus conditions
t_long    = dt : dt : t_max * n_conditions;
stim_long = reshape(stim', [t_lth * n_conditions, 1]);

%% visualize data and stimulus

figure (1), clf
plot(t_long, data, 'k-')
set(gca, 'xtick', 1.14 * linspace(1, 12, 12)), hold on
plot(t_long, stim_long *0.0005, 'b-')
title('Concatenated Data'), xlabel('time (s)'), box off

%% make basis functions

nFast = 5;
nSlow = 5;

fBasis = mkBasis(t(1 : 35), nFast, 'fast');
sBasis = mkBasis(t, nSlow, 'slow');

%% visualize basis functions

figure (2), clf
subplot(121), plot(t(1 : 35), fBasis), axis square
xlabel('time (s)'), title('fast basis functions')
subplot(122), plot(t, sBasis), axis square
xlabel('time (s)'), title('slow basis functions')

%% Linear model (or estimate weights for the basis function)

% combine the fast basis linear predictions with slow basis
basis = concatenateBasisAcrossConditions(fBasis, sBasis, stim_long, t);

% do least square analysis
weights = least_square(basis', data);

% make data predicitons
prediction = weights' * basis;

%% visualize linear model prediction

figure (1), 
plot(t_long, prediction, 'r-')