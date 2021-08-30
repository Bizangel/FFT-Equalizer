function [amplified] = amplify_frequency(Fxs,f, w0, w1, alpha)
% Aplica un filtro de escalado/amplificado, usando una ventana de hanning.
% Recibe un espectro de frecuencia Fxs con frecuencias f, y amplifica el
% espectro en la banda de w0 - w1, por el factor de alpha especificado, 
% según la ventana de hanning.
% Retorna el espectro amplificado, y todo lo fuera de la banda queda con un
% valor nulo.

n = length(Fxs);
max_fs = max(f); 

% Se calculan los indices más aproximados según la frecuencia especificada
w0_index = floor(n/2) + floor((n/2)*w0/max_fs);
w1_index = floor(n/2) + floor((n/2)*w1/max_fs) - 1;

% Los opuestos de los índices
w1_index_neg = floor(n/2) - floor((n/2)*w1/max_fs) + 1;
w0_index_neg = floor(n/2) - floor((n/2)*w0/max_fs);

window = hanning(w1_index-w0_index + 1);

% Se inicializa el nuevo vector a retornar
amplified = zeros([length(Fxs) 1]);
amplified(w0_index:w1_index) = Fxs(w0_index:w1_index)*alpha.*window; % Se escala ambas ventanas.
amplified(w1_index_neg:w0_index_neg) = Fxs(w1_index_neg:w0_index_neg)*alpha.*window;

end
