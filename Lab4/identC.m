function blad = identC(X0)
k = X0(1);
T = X0(2);
n = X0(3);

obiekt_rzecz = load("obiekt.mat");
y_rzecz = obiekt_rzecz.y;
t = [1:60]';

p = [];

for i = 1:n
   p = [p -1/T]; 
end

[licz,mian] = zp2tf([],p,k/T^n);
obiekt = tf(licz,mian);
y_sym = step(obiekt,t);

e = y_rzecz - y_sym;
blad = sum(e.^2) / length(e);