clc; clear;
obiekt_rzecz = load("obiekt.mat");
y_rzecz = obiekt_rzecz.y;
SEC = 60;
t = [1:SEC]';

%Obiekt inercyjny I rzêdu z opóŸnieniem

%Metoda 2.1

POINTS = 2;

f = figure(1);
f.Name = "Aproksymacja obiektem inercyjnym I rzêdu z opóŸnieniem";
figure(f)
plot(t,y_rzecz)

[px,py] = ginput(POINTS);

theta = px(1);
T = px(2) - px(1);
k = py(2);
n = 5;

[licz_op,mian_op] = pade(theta,n);      %aproksymacja Padego
licz_iner = [0,k];
mian_iner = [T,1];
[licz,mian] = series(licz_iner,mian_iner,licz_op,mian_op);

obiekt = tf(licz,mian);

y_iner = step(obiekt,t);

plot(t,y_rzecz,t,y_iner)
grid()
title("Step response")
xlabel("Time")
ylabel("Amplitude")
legend("Rzeczywistoœæ","Aproksymacja")
e = y_rzecz - y_iner;
blad = sum(e.^2)/length(e);
disp("Obiekt inercyjny I rzêdu z opóŸnieniem:")
disp("  Metoda 2.1")
disp("    k = " + num2str(k))
disp("    T = " + num2str(T))
disp("    theta = " + num2str(theta))
disp("    B³¹d = " +num2str(blad))

%Metoda 2.4

[parametry, blad] = fminsearch('identA',[k T theta]);
disp("  Metoda 2.4")
disp("    k = " + num2str(parametry(1)))
disp("    T = " + num2str(parametry(2)))
disp("    theta = " + num2str(parametry(3)))
disp("    B³¹d = " + num2str(blad))

%Obiekt inercyjny II rzêdu z opóŸnieniem

%Metoda 2.2

GAIN_CONST = 0.714;
RATIO_CONST = 0.1;
TIME_CONST = 1.2;
COEFS = [0.26 0.2 0.174 0.15 0.135 0.131 0.126 0.125 0.124 0.123 0.122]';

t_tmp = [1:SEC-round(theta)]';            %usuniêcie opóŸnienia
y_tmp = y_rzecz(floor(theta):SEC);
y_a = GAIN_CONST*k;

index1 = findIndex(y_tmp,y_a);
t_a = t_tmp(index1);

index2 = findIndex(t_tmp,t_a/4);

COEFS = COEFS*k;
index3 = findIndex(COEFS,y_tmp(index2));

frac = 0; % T2/T1

for i = 1:index3-1
   frac = frac + RATIO_CONST;
end

T1 = t_a/(TIME_CONST*(1+frac));
T2 = t_a/TIME_CONST - T1;

licz = [0,0,k];
mian = [T1*T2,T1+T2,1];

obiekt = tf(licz,mian);
set(obiekt,'outputdelay',theta);

y_iner = step(obiekt,t);

f = figure(2);
f.Name = "Aproksymacja obiektem inercyjnym II rzêdu z opóŸnieniem - metoda 2.2";
figure(f)
plot(t,y_rzecz,t,y_iner)
grid()
title("Step response")
xlabel("Time")
ylabel("Amplitude")
legend("Rzeczywistoœæ","Aproksymacja")
e = y_rzecz - y_iner;
blad = sum(e.^2)/length(e);
disp("Obiekt inercyjny II rzêdu z opóŸnieniem:")
disp("  Metoda 2.2")
disp("    k = " + num2str(k))
disp("    T1 = " + num2str(T1))
disp("    T2 = " + num2str(T2))
disp("    theta = " + num2str(theta))
disp("    B³¹d = " +num2str(blad))

%Metoda 2.3

TIME_PERCENT = 0.73;
TIME_CONST = 1.3;

y_t = TIME_PERCENT*k;

index1 = findIndex(y_tmp,y_t);

sumT = t_tmp(index1)/TIME_CONST; % T1+T2
t_H = 0.5*sumT;

index2 = findIndex(t_tmp,t_H);

y_H = y_tmp(index2);

frac = 0.93; %odczytane z wykresu T1/(T1+T2)

T1 = frac*sumT;
T2 = sumT - T1;

licz = [0,0,k];
mian = [T1*T2,T1+T2,1];

obiekt = tf(licz,mian);
set(obiekt,'outputdelay',theta);

y_iner = step(obiekt,t);

f = figure(3);
f.Name = "Aproksymacja obiektem inercyjnym II rzêdu z opóŸnieniem - metoda 2.3";
plot(t,y_rzecz,t,y_iner)
grid()
title("Step response")
xlabel("Time")
ylabel("Amplitude")
legend("Rzeczywistoœæ","Aproksymacja")
e = y_rzecz - y_iner;
blad = sum(e.^2)/length(e);
disp("  Metoda 2.3")
disp("    k = " + num2str(k))
disp("    T1 = " + num2str(T1))
disp("    T2 = " + num2str(T2))
disp("    theta = " + num2str(theta))
disp("    B³¹d = " +num2str(blad))

%Metoda 2.4

[parametry, blad] = fminsearch('identB',[k T1 T2 theta]);
disp("  Metoda 2.4")
disp("    k = " + num2str(parametry(1)))
disp("    T1 = " + num2str(parametry(2)))
disp("    T2 = " + num2str(parametry(3)))
disp("    theta = " + num2str(parametry(4)))
disp("    B³¹d = " + num2str(blad))

%Obiekt wieloinercyjny bez opóŸnienia

%Metoda 2.4

n = 3;

[parametry, blad] = fminsearch('identC',[k T n]);
disp("Obiekt wieloinercyjny bez opóŸnieñ:")
disp("  Metoda 2.4")
disp("    k = " + num2str(parametry(1)))
disp("    T = " + num2str(parametry(2)))
disp("    n = " + num2str(round(parametry(3))))
disp("    B³¹d = " + num2str(blad))