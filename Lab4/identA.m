function blad = identA(X0)
k = X0(1);
T = X0(2);
theta = X0(3);
n = 5;

obiekt_rzecz = load("obiekt.mat");
y_rzecz = obiekt_rzecz.y;
t = [1:60]';

[licz_op,mian_op] = pade(theta,n);      %aproksymacja Padego
licz_iner = [0,k];
mian_iner = [T,1];
[licz,mian] = series(licz_iner,mian_iner,licz_op,mian_op);

obiekt = tf(licz,mian);
y_sym = step(obiekt,t);

e = y_rzecz - y_sym;
blad = sum(e.^2) / length(e);