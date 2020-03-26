function e = faza(K)
faza=45;
[licz,mian]=zp2tf([],[-1 -1 -1],K);
[~,Pm]=margin(licz,mian);
e=abs(Pm-faza);