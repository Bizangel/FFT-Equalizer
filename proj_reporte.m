clear all
%% Lectura de datos
% Se leen las distintas señales de audios, todas con frecuencia de muestreo
% de 8khz, Se trabajara con el vector1, un fragmento de fur elise
[vector1, ~] = audioread('samples/fur_elise_crop.wav');
[vector2, ~] = audioread('samples/cars1.wav');
[vector3, fs] = audioread('samples/habito6.wav');

% Se normalizan los vectores
vector1 = vector1/max(vector1);
vector2 = vector2/max(vector2);
vector3 = vector3/max(vector3);



%% Plot Señal Original

% plot(vector1)
% title('Señal original')
% xlabel('Tiempo (t)')
% ylabel('Amplitud')
% ax = gca;
% exportgraphics(ax,'senaloriginal.png','Resolution',800)


%% Aplicación Transformada de Fourier

n = length(vector1);
Fx = fft(vector1); % Algoritmo para calcular los valores de la Transformada de Fourier
Fxs = fftshift(Fx); % Corrimiento de la transformada para obtener valores negativos y positivos. 
f = (-n/2:n/2-1)*fs/n; % Creación del vector de Frecuencias

%% Plot Transformada de Fourier

% plot(f,abs(Fxs))
% title('Espectro de Frecuencias')
% xlabel('Frecuencia (w)')
% ylabel('Magnitud')
% ax = gca;
% exportgraphics(ax,'senaloriginal_fourier.png','Resolution',800)

%% Amplificación de la señal
Fxs_mod = amplify_frequency(Fxs,f,3500,4000-1,100) + Fxs; % Amplificación ventana rectangular

%% Plot del espectro amplificado

% plot(f,abs(Fxs_mod))
% title('Espectro de Frecuencias Modificado')
% xlabel('Frecuencia (w)')
% ylabel('Magnitud')
% ax = gca;
% exportgraphics(ax,'senalmodificada_fourier.png','Resolution',800)

%% Reconstrucción de la señal original
Fx2 = ifftshift(Fxs); % Devolviendo el corrimiento realizado con fftshift
y = real(ifft(Fx2)); % Calculando la transformada inversa (Se toma la parte real, porque debido 
                     % a errores numericos se obtiene una transformada compleja, pero los valores 
                     % complejos son muy pequeños.
y = y./max(y); % Se normaliza la señal de salida

%% Plot Señal Reconstruida

% plot(y)
% title('Espectro de Frecuencias Modificado')
% xlabel('Frecuencia (w)')
% ylabel('Magnitud')
% ax = gca;
% exportgraphics(ax,'senalmodificada.png','Resolution',800)