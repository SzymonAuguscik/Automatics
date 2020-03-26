clear; clc;

%Zadanie 2.3

K1 = 30; K2 = 250;

figure(1)
h = nyquistplot(tf([0,0,0,K1],[1,12,20,0]));
p = getoptions(h);
p.FreqUnits = 'Hz';
p.ShowFullContour = 'off';
setoptions(h,p)

figure(2)
h = nyquistplot(tf([0,0,0,K2],[1,12,20,0]));
p = getoptions(h);
p.FreqUnits = 'Hz';
p.ShowFullContour = 'off';
setoptions(h,p)
%Uk³ad nr 1 - stabilny
%Uk³ad nr 2 - niestabilny

%Zadanie 2.4

K = 10; T1 = 0.1; T2 = 0.5; T3 = 0.8;

figure(3)
h = nyquistplot(tf([0,0,K],[T1*T2,T1+T2,1]),tf([0,0,0,K],[T1*T2*T3,T1*T2+T2*T3+T1*T3,T1+T2+T3,1]));
p = getoptions(h);
p.FreqUnits = 'Hz';
p.ShowFullContour = 'off';
setoptions(h,p)
legend("Dwa bieguny","Trzy bieguny")
%Dodawanie biegunów zmniejsza zapas stabilnoœci

%Zadanie 2.5

K = 1; z = []; p = -1;

figure(4)
for i = 1:4
    [licz,mian] = zp2tf(z,p,K);
    subplot(2,2,i)
    h = nyquistplot(tf(licz,mian));
    q = getoptions(h);
    q.FreqUnits = 'Hz';
    q.ShowFullContour = 'off';
    setoptions(h,q)
    p = [p 0];
end
%Dodawanie biegunów powoduje utratê stabilnoœci

%Zadanie 2.6

K = 2; T1 = 0.1; T2 = 0.9; Td = 0.7;

figure(5)
h = nyquistplot(tf([0,K],[T1*T2,T1+T2,1,0]),tf([K*Td,K],[T1*T2,T1+T2,1,0]));
q = getoptions(h);
q.FreqUnits = 'Hz';
q.ShowFullContour = 'off';
setoptions(h,q)
legend("Brak zer", "Jedno zero")
%Dodawanie zer zwiêksza zapas stabilnoœci
