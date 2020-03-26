clear; clc;

%Zadanie 3.4.1

wzmocnienie=2; %zadany zapas wzmocnienia
krok=0.01; %krok o który zwiêkszamy wzmocnienie
granica=8; %granica stabilnoœci, powy¿ej której nie ma sensu szukaæ
tolerancja=0.1; %dok³adnoœæ obliczeñ

[wynik,blad] = fminsearch('wzmocnienie',1)

for K=1:krok:granica
    [licz,mian]=zp2tf([],[-1 -1 -1],K); %w ka¿dym kroku obliczamy nowa transmitancje
    [Gm,Pm]=margin(licz,mian); %liczymy zapas modu³u Gm i fazy Pm
    if abs(Gm-wzmocnienie)<=tolerancja %sprawdzamy dopuszczalny b³¹d
        fprintf(1,'Dla wzmocnienia K = %.3f zapas wzmocnienia wynosi %.3f db\n',K,Gm)
        fprintf(1,'Blad wynosi %f\n',abs(wzmocnienie-Gm))
        return
    end
end
fprintf(1,'Nie znaleziono rozwiazania.\nZwieksz tolerancje lub/i zmniejsz krok\n')

%Zwiêkszenie wartoœci kroku przyspiesza czas wykonania algorytmu.
%Zwiêkszenie tolerancji powoduje zwiêkszenie b³êdu.
%Funkcja optymalizacyjna wykonuje obliczenia szybciej i dok³adniej ni¿
%algorytm iteracyjny.