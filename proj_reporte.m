clear all
% Sampling frequency is 8khz
[vector1, ~] = audioread('samples/fur_elise_crop.wav');
[vector2, ~] = audioread('samples/cars1.wav');
[vector3, fs] = audioread('samples/habito6.wav');

vector1 = vector1/max(vector1);
vector2 = vector2/max(vector2);
vector3 = vector3/max(vector3);

%% plotsitos
% fourier_plot(vector1, fs)

% plot(vector2)
% plot(vector3)

%% fourierizacion

n = length(vector1);
Fx = fft(vector1); % Algoritmo para calcular los valores de la Transformada de Fourier
Fxs = fftshift(Fx); % Corrimiento de la transformada para obtener valores negativos y positivos. 
f = (-n/2:n/2-1)*fs/n; % Creación del vector de Frecuencias

Fxs = amplify_frequency(Fxs,f,3000,4000,2);

% hold on
% plot(f,abs(Fxs));
% Fxs = amplify_frequency(Fxs,f,1000,2000,10);
% plot(f,abs(Fxs));
% hold off

Fx2 = ifftshift(Fxs); % Devolviendo el corrimiento realizado con fftshift
y = real(ifft(Fx2)); % Calculando la transformada inversa (Se toma la parte real, porque debido 
                     % a errores numericos se obtiene una transformada compleja, pero los valores 
                     % complejos son muy pequeños.
y = y./max(y); % Se normaliza la señal de salida


sound(y,fs)
function fourier_plot(x, fs)
n = length(x);
Fx = fft(x); % Algoritmo para calcular los valores de la Transformada de Fourier
Fxs = fftshift(Fx); % Corrimiento de la transformada para obtener valores negativos y positivos. 
f = (-n/2:n/2-1)*fs/n; % Creación del vector de Frecuencias

% Grafica de la magnitud de la transformada de Fourier
figure, subplot(211)
plot(f,abs(Fxs))
xlabel('Frecuencia [Hz]')
ylabel('Amplitud [u.a.]')
title ('Magnitud de la Transformada de Fourier de la Señal')
grid on

% Grafica de la magnitud de la transformada de Fourier
subplot(212)
plot(f,angle(Fxs))
xlabel('Frecuencia [Hz]')
ylabel('Fase [radianes]')
title ('Fase de la Transformada de Fourier de la Señal')
grid on
end