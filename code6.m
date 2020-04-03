clear;clc;

%Zadanie 1.

%wspó³czynniki z podstawowej metody Z-N
COEF_P1 = 0.5;

COEF_P2 = 0.45;
COEF_I2 = 1.2;

COEF_P3 = 0.6;
COEF_I3 = 2;
COEF_D3 = 8;

LIMIT = 2;

[licz,mian] = zp2tf([],[-1 -1 -1],1);
G = tf(licz,mian);

figure(1)
rlocus(G)
sgrid()
axis([-LIMIT LIMIT -LIMIT LIMIT])
[K_kr,~] = rlocfind(G);

P1 = K_kr;

sim('P_controller.slx');
%open_system('P_controller/Scope') - do okreœlenia P_kr

P_kr = 3.7; %odczytane z wykresu z symulacji wy¿ej

%regulator P
P1 = COEF_P1*K_kr;
%regulator PI
P2 = COEF_P2*K_kr;
I2 = P_kr/COEF_I2;
%regulator PID
P3 = COEF_P3*K_kr;
I3 = P_kr/COEF_I3;
D3 = P_kr/COEF_D3;

sim('P_PI_PID.slx');
open_system('P_PI_PID/Scope')

%Zadanie 2.

%wspó³czynniki ze zmodyfikowanej metody Z-N
COEF_P1 = 0.6;
COEF_I1 = 2;
COEF_D1 = 8;

COEF_P2 = 0.33;
COEF_I2 = 2;
COEF_D2 = 3;

COEF_P3 = 0.2;
COEF_I3 = 2;
COEF_D3 = 3;

P1 = COEF_P1*K_kr;
I1 = P_kr/COEF_I1;
D1 = P_kr/COEF_D1;
P2 = COEF_P2*K_kr;
I2 = P_kr/COEF_I2;
D2 = P_kr/COEF_D2;
P3 = COEF_P3*K_kr;
I3 = P_kr/COEF_I3;
D3 = P_kr/COEF_D3;

sim('THREE_PID.slx');
open_system('THREE_PID/Scope')