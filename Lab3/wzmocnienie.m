function e = wzmocnienie(K)
wzmocnienie=2;
[licz,mian]=zp2tf([],[-1 -1 -1],K);
[Gm,~]=margin(licz,mian);
e=abs(Gm-wzmocnienie);