function dx = zbiornik_stan(~,x,wi,w,Ti,Q)
% Argumenty wejœciowe:
% t - czas
% x - wektor stanu uk³adu
% wi - dop³yw
% w - wyp³yw
% Ti - temperatura cieczy dop³ywaj¹cej
% Q - moc dostarczana (grzanie)
%----------------------------- zmienne stanu ------------------------------
%objêtoœæ
x1 = x(1);
%temperatura
x2 = x(2);
%------------------------------- parametry --------------------------------
% ciep³o w³aœciwe [J/(Kg*K)]
C = 1820;
% gêstoœæ [kg/m3] 
ro = 1000; 
%---------------------------- równania stanu ------------------------------
dx1 = 1 / ro * (wi-w);
dx2 = wi * (Ti - x2) / (ro * x1) + Q / (ro * x1 * C);
dx = [dx1;dx2];