% make stimulus

function [stim, t] = mk_stimulus()

visualize = 0;

%% make time series

t = 0.01 : 0.01 : 1.14;

%% set durations and ISI (in number of frames)

nConditions = 12;

duration = [2, 4, 8, 16, 32, 64];
isi      = [2, 4, 8, 16, 32, 64];

%% make stimulus

stim = zeros(nConditions, length(t)); 

% make stimulus that changes in durations
for k = 1 : length(duration)
    stim(k, 1 : duration(k)) = 1;
end

% make stimulus that changes in ISI
for k = 1 : length(isi)
    stim(k + length(duration), 1 : 16) = 1; % stimulus presented for 16 number of frames
    stim(k + length(duration), 17 + isi(k) + 1: 16 * 2 + isi(k) + 1) = 1;
end

%% visualize

if visualize
    figure,
    for k = 1 : 12
        subplot(2, 6, k),
        plot(t, stim(k, :), 'k-', 'linewidth', 1.5), axis square, box off
        set(gca, 'ytick', [0, 1]), xlabel('time'), title(k)
    end
    
end

end