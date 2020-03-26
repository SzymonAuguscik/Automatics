clear; clc;

k = 3; T = 5;
T1 = 3; T2 = 5; 
ksi1 = 2; ksi2 = 0.5;
Ti = -2;
Td = 1;
theta = 10; n = 5;

[licz_op,mian_op] = pade(theta,n);

licz_iner = [0,k]; mian_iner = [T,1];

[licz,mian] = series(licz_iner,mian_iner,licz_op,mian_op);

nazwy = [
         "Uk³ad inercyjny I rzêdu"
         "Uk³ad inercyjny I rzêdu z opóŸnieniem"
         "Uk³ad inercyjny II rzêdu"
         "Uk³ad inercyjny II rzêdu t³umiony"
         "Uk³ad inercyjny II rzêdu oscylacyjny"
         "Uk³ad ca³kuj¹cy rzeczywisty"
         "Uk³ad ró¿niczkuj¹cy rzeczywisty"
         ];

obiekty = [
           tf([0,k],[T,1])
           tf(licz,mian)
           tf([0,0,k],[T1*T2,T1+T2,1])
           tf([0,0,k],[T^2,2*T*ksi1])
           tf([0,0,k],[T^2,2*T*ksi2])
           tf([0,0,k],[Ti*T,Ti,0])
           tf([Td,0],[T,1])
          ];
         
legendy = [
           "k = "+num2str(k)+", T = "+num2str(T)
           "theta = "+num2str(theta)+", T = "+num2str(T)
           "k = "+num2str(k)+", T1 = "+num2str(T1)+", T2 = "+num2str(T2)
           "k = "+num2str(k)+", T = "+num2str(T)+", ksi = "+num2str(ksi1)
           "k = "+num2str(k)+", T = "+num2str(T)+", ksi = "+num2str(ksi2)
           "k = "+num2str(k)+", Ti = "+num2str(Ti)+", T = "+num2str(T)
           "Td = "+num2str(Td)+", T = "+num2str(T)
          ];

for i = 1:length(obiekty)
    f1 = figure(i);
    f1.Name = nazwy(i);
    figure(f1)

    subplot(1,2,1)
    nyquist(obiekty(i))
    legend(legendy(i))

    subplot(1,2,2)
    bode(obiekty(i))
    grid()
end

%1. Uk³ad inercyjny I rzêdu

%Uk³ad jest stabilny, poniewa¿ charakterystyka nie obejmuje punktu (-1,0).
%Uk³ad jest filtrem dolnym.
%OpóŸnienie sygna³u roœnie wraz z czêstotliwoœci¹.

%2. Uk³ad inercyjny I rzêdu z opóŸnieniem

%Uk³ad jest niestabilny (wykres obejmuje punkt (-1,0)).
%Uk³ad jest filtrem dolnym.
%Przyspieszenie sygna³u maleje wraz z czêstotliwoœci¹.

%3. Uk³ad inercyjny II rzêdu 

%Uk³ad jest stabilny, poniewa¿ charakterystyka nie obejmuje punktu (-1,0).
%Uk³ad jest filtrem dolnym.
%OpóŸnienie sygna³u roœnie wraz z czêstotliwoœci¹.

%4. Uk³ad inercyjny II rzêdu t³umiony

%Uk³ad jest stabilny, poniewa¿ charakterystyka nie obejmuje punktu (-1,0).
%Uk³ad jest filtrem dolnym.
%OpóŸnienie sygna³u roœnie wraz z czêstotliwoœci¹.

%5. Uk³ad inercyjny II rzêdu oscylacyjny

%Uk³ad jest stabilny, poniewa¿ charakterystyka nie obejmuje punktu (-1,0).
%Uk³ad jest filtrem dolnym.
%OpóŸnienie sygna³u roœnie wraz ze wzrostem czêstotliwoœci.

%6. Uk³ad ca³kuj¹cy rzeczywisty

%Uk³ad jest stabilny, poniewa¿ charakterystyka nie obejmuje punktu (-1,0).
%Uk³ad jest filtrem dolnoprzepustowym.
%Przyspieszenie sygna³u maleje wraz ze wzrostem czêstotliwoœci.

%7. Uk³ad ró¿niczkuj¹cy rzeczywisty

%Uk³ad jest stabilny, poniewa¿ charakterystyka nie obejmuje punktu (-1,0).
%Uk³ad jest filtrem górnoprzepustowym.
%Przyspieszenie sygna³u maleje wraz ze wzrostem czêstotliwoœci.