function dx = zbiornik_stan(~,x,wi,w,Ti,Q)
% Argumenty wej�ciowe:
% t - czas
% x - wektor stanu uk�adu
% wi - dop�yw
% w - wyp�yw
% Ti - temperatura cieczy dop�ywaj�cej
% Q - moc dostarczana (grzanie)
%----------------------------- zmienne stanu ------------------------------
%obj�to��
x1 = x(1);
%temperatura
x2 = x(2);
%------------------------------- parametry --------------------------------
% ciep�o w�a�ciwe [J/(Kg*K)]
C = 1820;
% g�sto�� [kg/m3] 
ro = 1000; 
%---------------------------- r�wnania stanu ------------------------------
dx1 = 1 / ro * (wi-w);
dx2 = wi * (Ti - x2) / (ro * x1) + Q / (ro * x1 * C);
dx = [dx1;dx2];