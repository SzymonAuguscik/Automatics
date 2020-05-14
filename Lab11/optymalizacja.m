function blad = optymalizacja(X)
a = X(1);
b = X(2);
theta = X(3);
n = X(4);
t = [1:60]';

G_in = zpk([],[-5 -5 -5 -5 -5 -5 -5 -5 -5 -5], 5^10);   %obiekt inercyjny 10. rzêdu

G = tf([0 1], [a b 1]);                     %tworzenie przybli¿onego obiektu z opóŸnieniem
[licz,mian] = pade(theta,n);
G_pade = tf(licz,mian);

G_p = series(G, G_pade);

y_in = step(G_in,t);
y_p = step(G_p,t);

e = y_in - y_p;
blad = sum(e.^2)/length(e);