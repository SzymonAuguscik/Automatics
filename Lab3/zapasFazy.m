clear; clc;

%Zadanie 3.4.1

faza=45; %zadany zapas fazy
krok=0.01; %krok o kt�ry zwi�kszamy wzmocnienie
granica=8; %granica stabilno�ci, powy�ej kt�rej nie ma sensu szuka�
tolerancja=0.1; %dok�adno�� oblicze�

[wynik,blad] = fminsearch('faza',1)

for K=1:krok:granica
    [licz,mian]=zp2tf([],[-1 -1 -1],K); %w ka�dym kroku obliczamy nowa transmitancje
    [Gm,Pm]=margin(licz,mian); %liczymy zapas modu�u Gm i fazy Pm
    if abs(Pm-faza)<=tolerancja %sprawdzamy dopuszczalny b��d
        fprintf(1,'Dla wzmocnienia K = %.3f zapas fazy wynosi %.3f stopnie\n',K,Pm)
        fprintf(1,'Blad wynosi %f\n',abs(faza-Pm))
        return
    end
end
fprintf(1,'Nie znaleziono rozwiazania.\nZwieksz tolerancje lub/i zmniejsz krok\n')

%Zwi�kszenie warto�ci kroku przyspiesza czas wykonania algorytmu.
%Zwi�kszenie tolerancji powoduje zwi�kszenie b��du.
%Funkcja optymalizacyjna wykonuje obliczenia szybciej i dok�adniej ni�
%algorytm iteracyjny.