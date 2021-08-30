function [amplified] = amplify_frequency(Fxs,f, w0, w1, alpha)
% Amplifies frequency given a rectangular window and fourier transform
% coefficients

n = length(Fxs); % 8000*2
max_fs = max(f); % 8000

w0_index = floor(n/2) + floor((n/2)*w0/max_fs);
w1_index = floor(n/2) + floor((n/2)*w1/max_fs) - 1;

w1_index_neg = floor(n/2) - floor((n/2)*w1/max_fs) + 1;
w0_index_neg = floor(n/2) - floor((n/2)*w0/max_fs);

window = hanning(w1_index-w0_index + 1);

length(Fxs(w0_index:w1_index))
length(window)
amplified = Fxs;
amplified(w0_index:w1_index) = Fxs(w0_index:w1_index)*alpha.*window;
amplified(w1_index_neg:w0_index_neg) = Fxs(w1_index_neg:w0_index_neg)*alpha.*window;

end
