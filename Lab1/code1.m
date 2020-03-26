clear; clc;

% Zadanie 1
% a)
% bieguny - nie
% stabilność - tak
% układ nieminifazowalny - nie

licz = [0 0 1];
mian1 = [1000 500 400];
mian2 = [10 900 30];
t1 = tf(licz,mian1);
t2 = tf(licz,mian2);

figure(1)
pzmap(t1)

% b)
[z,p,k] = tf2zp(licz,mian1);
disp(z)
disp(p)
disp(k)

% c)
figure(2)
step(t1)
figure(3)
step(t2)

% Zadanie 2

M = 1000;
a = 500;
c = 400;

sim('model1.slx');

% Zadanie 3

t3 = zpk(-0.25,[0 -5 -0.1],2)

% Zadanie 4

[A1,B1,C1,D1] = zp2ss(z,p,k);
[A2,B2,C2,D2] = tf2ss(licz,mian1);

figure(4)
step(A1,B1,C1,D1)
figure(5)
step(A2,B2,C2,D2)
% Macierze nie są takie same, jednak odpowiedzi skokowe już tak

% Zadanie 5

z = [];
p = [-1  -1  -1  -1  -1  -1  -1  -1  -1  -1];
k = 1;

[licz,mian] = zp2tf(z,p,k);
[z1,p1,k1] = tf2zp(licz,mian);
% Pojawiają się liczby zespolone o części rzeczywistej zbliżonej do -1

% Zadanie 6

licz1 = [1 1];
mian1 = [1 5 1];
licz2 = [1];
mian2 = [1 1 -2 1];

sys1 = tf(licz1,mian1);
sys2 = tf(licz2,mian2);

G_series = series(sys1,sys2)
G_parallel = parallel(sys1,sys2)
G_feedback = feedback(sys1,sys2)

