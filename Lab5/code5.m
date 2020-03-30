clear; clc;

%Zadanie 1.a

licz = [0,1];
mian = [5,6,1];

figure(1)
rlocus(licz,mian)
sgrid()

%Zadanie 1.b

licz = [0.5,1];
mian = [5,6,1];

figure(2)
rlocus(licz,mian)
sgrid()

%Zadanie 1.c

licz = [0,1];
mian = [2.5,8,6.5,1];

figure(3)
rlocus(licz,mian)
sgrid()
[K,bieguny] = rlocfind(licz,mian);
disp("K = "+num2str(K))

%Zadanie 2.a

LIMIT = 5;

[licz,mian] = zp2tf([],[0 -1 -5],5);
G_o1 = tf(licz,mian);                        %G_o1 - układ otwarty(2a)
G_z1 = feedback(G_o1,1);                     %G_z1 - układ zamknięty(2a)

figure(4)
rlocus(G_o1)
line([0 -1],[1 0])
axis([-5 5 -5 5])
sgrid()
[K1,~] = rlocfind(G_o1);

%Zadanie 2.b

[licz,mian] = zp2tf(-1,-10,10);
G_c = tf(licz,mian);                         %G_c - kompensator
G_o2 = series(G_c,G_o1);                     %G_o2 - układ otwarty(2b)
G_z2 = feedback(G_o2,1);                     %G_z2 - układ zamknięty(2b)

figure(5)
rlocus(G_o2)
line([0 -LIMIT],[0 LIMIT])
axis([-LIMIT LIMIT -LIMIT LIMIT])
sgrid()
[K2,~] = rlocfind(G_o2);
disp("K1 = "+num2str(K1)+", K2 = "+num2str(K2))

figure(6)
step(G_z1,G_z2)
grid()
legend("Obiekt bez kompensatora","Obiekt z kompensatorem")

%Obiekt z kompensatorem jest lepszy. Szybciej osiąga wartość ustaloną, a
%ponadto można zaobserwować mniej oscylacji względem układu bez
%kompensatora.
