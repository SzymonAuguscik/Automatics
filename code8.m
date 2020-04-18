clear; clc;

%parametr_k - parametr po kompensacji
%parametr_bk - parametr bez kompensacji

licz_bk = [0 0 10];
mian_bk = [1 1 0];

MO = 25;

figure(1)
disp("Zaznacz ksi dla MO = "+num2str(MO)+"%")
ezplot('100*exp((-ksi*pi)/sqrt(1-ksi^2))',[0 1])
ylabel('MO [%]'), xlabel('\xi')
[ksi_k,~] = ginput(1);            %dla MO

disp("Zaznacz PM dla ksi = "+num2str(ksi_k))
ezplot('atand(2*ksi/sqrt(sqrt(1+4*ksi^2)-2*ksi^2))',[0 1])
ylabel('PM [deg]'), xlabel('\xi')
[~,PM_k] = ginput(1);             %dla ksi_k odczytanego wy¿ej

[~,PM_bk] = margin(licz_bk, mian_bk);

phi = PM_k - PM_bk;
a = (1+sind(phi))/(1-sind(phi));

A = -10*log(a);

disp("Zaznacz omegê dla A = "+num2str(A))
margin(licz_bk,mian_bk)
[omega,x] = ginput(1);             %dla Magn

T_k = 1/(sqrt(a)*omega);

K = a;
p = 1/T_k;
z = 1/(a*T_k);

G_bk = tf(licz_bk,mian_bk);        %uk³ad bez kompensacji

[licz_k,mian_k] = zp2tf(-z,-p,K);    %uk³ad z kompensacj¹
G_c = tf(licz_k,mian_k);
G_k = series(G_bk,G_c);           

G_k = feedback(G_k,1);             %zamykanie uk³adów
G_bk = feedback(G_bk,1);

figure(2)
step(G_bk)
xlabel("t")
ylabel("y(t)")
title("OdpowiedŸ skokowa uk³adu bez kompensacji")

figure(3)
step(G_k)
xlabel("t")
ylabel("y(t)")
title("OdpowiedŸ skokowa uk³adu z kompensacj¹")