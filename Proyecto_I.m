%% Proyecto I: Equalizador básico de audio

% Curso de Procesamiento de Señales
% Programa de Matemáticas Aplicadas y Ciencias de la Computación
% Universidad del Rosario, Agosto 2021

% Profesor: Alexander Caicedo Dorado

% En esta función pueden encontrar las funciones básicas para adquirir una
% señal de audio utiliznado MATLAB, y calcular su transformada de Fourier.
% La salida de la transformada de Fourier deben utilizarla para realizar
% las tareas indicadas en el enundciado del Proyecto

%% Aquirir señal de audio

recObj = audiorecorder; % Creando el objeto de audio

fs = recObj.SampleRate; % Extrayendo la frecuencia de muestreo del objeto de grabación.
t_grab = 2; % Especificando el tiempo de grabación en segundos. Tenga en cuenta qu ese generará
            % una grabación que se almacenara en un vector de 2*fs muestras.

disp('Comienza la grabación.')
recordblocking(recObj, t_grab);
disp('Termina la grabación.');

x= getaudiodata(recObj); % Extrayendo los datos grabados del elemento de grabación
x = x./max(x); % Normalización de la señal

% Graficando la señal obtenida
n = length(x);
t = (0:n-1)/fs; % Creando un vector de tiempo
figure,
plot(t,x);
grid on
xlabel('tiempo [s]')
ylabel('Amplitud [u.a.]')
title('Señal de sonido grabada')

% Escuchando la señal grabada
sound(x,fs)

%% Calculo de la transformada de Fourier de la señal

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

%% Obteniendo la Transformada inversa de Fourier

Fx2 = ifftshift(Fxs); % Devolviendo el corrimiento realizado con fftshift
y = real(ifft(Fx2)); % Calculando la transformada inversa (Se toma la parte real, porque debido 
                     % a errores numericos se obtiene una transformada compleja, pero los valores 
                     % complejos son muy pequeños.
y = y./max(y); % Se normaliza la señal de salida

% Graficando la señal en el tiempo
figure,
plot(t,y);
grid on
xlabel('tiempo [s]')
ylabel('Amplitud [u.a.]')
title('Señal de sonido recuperada')