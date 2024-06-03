% mkbasis functions

% this file makes both fast and slow basis functions
function basis = mkBasis(t, nbasis, basisType)

%% example

visualize = 0;
example   = 0;

if example
    t0      = 0.01 : 0.01 : 1.2;
    t = t0(1 : 60);
    nbasis = 5;
    basisType = 'gcamp';
end

if strcmp(basisType, 'fast')
    scale2 = 1.18;%1.154;
    const = 0.00009;
    scale1 = 0.01;
    scale3 = 1;
elseif strcmp(basisType, 'slow')
    scale2 = 1.12;%0.95;%1.125;
    const  = 0.0013;
    scale1 = 0.006;
    scale3 = .99;
% 
% elseif strcmp(basisType, 'slow_gcamp')
%     scale2 = 1.13;%0.95;%1.125;
%     const  = 0.0013;
%     scale1 = 0.006;
%     scale3 = .99;
% 
% elseif strcmp(basisType, 'fb')
%     scale2 = 1.2; %1.13;
%     const = 0.00008;
%     scale1 = 0.01;
%     scale3 = 0.99;
% elseif strcmp(basisType, 'fast_fulltrial')
%     scale2 = 1.13;
%     const = 0.00009;
%     scale1 = 0.01;
%     scale3 = 0.99;
% elseif strcmp(basisType, 'fast_alternative')
%     scale2 = 1.13;%1.154;
%     const = 0.00009;
%     scale1 = 0.01;
%     scale3 = 0.99;
% elseif strcmp(basisType, 'slow_alternative')
%     scale2 = 1;%1.125;
%     const  = 0.0012;
%     scale1 = 0.006;
%     scale3 = .99;
%     
% elseif strcmp(basisType, 'gcamp')
%     scale2 = 1.19;%1.154;
%     const = 0.00027;
%     scale1 = 0.011;
%     scale3 = .97;
    
end


%% useful functions

loglin    = @(x, const, scale) log(scale * x + const);
invloglin = @(x, const, scale) (exp(x) - const)/scale;

% make basis
ff = @(x,c,dc)(cos(max(-pi,min(pi,(x-c)*pi/dc/2)))+1)/2; % raised cosine basis vector

%% make basis functions

c_min = min(loglin(t, const, scale1));
c_max = max(loglin(t, const, scale1));

centers = linspace(c_min * scale3, c_max*scale2, nbasis);
wth     = mean(diff(centers));

center_grid = repmat(centers', 1, length(t));

basis = ff(loglin(t, const, scale1), center_grid, wth);

%% zero padding to the front

if strcmp(basisType, 'fast') | strcmp(basisType, 'gcamp')
    basis = [zeros(nbasis, 1), basis(:, 1 : length(t) - 1)];
end

%% for slow basis

if strcmp(basisType, 'slow') | strcmp(basisType, 'slow_alternative')|strcmp(basisType, 'slow_gcamp')
    basis = fliplr(basis);
   % basis = [basis(:, 1 : length(t) - 1), zeros(nbasis, 1)];
    basis = [zeros(nbasis, 1), basis(:, 1 : length(t) - 1)];
end

%% zero padding to the front (feddback basis)

if strcmp(basisType, 'fb')
    basis = [zeros(nbasis, 1), basis(:, 1 : length(t) - 1)];
end

%% visualize

if visualize
    figure (1), clf
    plot(t, basis')
end
end