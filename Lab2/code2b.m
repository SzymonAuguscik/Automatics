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
         "Uk�ad inercyjny I rz�du"
         "Uk�ad inercyjny I rz�du z op�nieniem"
         "Uk�ad inercyjny II rz�du"
         "Uk�ad inercyjny II rz�du t�umiony"
         "Uk�ad inercyjny II rz�du oscylacyjny"
         "Uk�ad ca�kuj�cy rzeczywisty"
         "Uk�ad r�niczkuj�cy rzeczywisty"
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

%1. Uk�ad inercyjny I rz�du

%Uk�ad jest stabilny, poniewa� charakterystyka nie obejmuje punktu (-1,0).
%Uk�ad jest filtrem dolnym.
%Op�nienie sygna�u ro�nie wraz z cz�stotliwo�ci�.

%2. Uk�ad inercyjny I rz�du z op�nieniem

%Uk�ad jest niestabilny (wykres obejmuje punkt (-1,0)).
%Uk�ad jest filtrem dolnym.
%Przyspieszenie sygna�u maleje wraz z cz�stotliwo�ci�.

%3. Uk�ad inercyjny II rz�du 

%Uk�ad jest stabilny, poniewa� charakterystyka nie obejmuje punktu (-1,0).
%Uk�ad jest filtrem dolnym.
%Op�nienie sygna�u ro�nie wraz z cz�stotliwo�ci�.

%4. Uk�ad inercyjny II rz�du t�umiony

%Uk�ad jest stabilny, poniewa� charakterystyka nie obejmuje punktu (-1,0).
%Uk�ad jest filtrem dolnym.
%Op�nienie sygna�u ro�nie wraz z cz�stotliwo�ci�.

%5. Uk�ad inercyjny II rz�du oscylacyjny

%Uk�ad jest stabilny, poniewa� charakterystyka nie obejmuje punktu (-1,0).
%Uk�ad jest filtrem dolnym.
%Op�nienie sygna�u ro�nie wraz ze wzrostem cz�stotliwo�ci.

%6. Uk�ad ca�kuj�cy rzeczywisty

%Uk�ad jest stabilny, poniewa� charakterystyka nie obejmuje punktu (-1,0).
%Uk�ad jest filtrem dolnoprzepustowym.
%Przyspieszenie sygna�u maleje wraz ze wzrostem cz�stotliwo�ci.

%7. Uk�ad r�niczkuj�cy rzeczywisty

%Uk�ad jest stabilny, poniewa� charakterystyka nie obejmuje punktu (-1,0).
%Uk�ad jest filtrem g�rnoprzepustowym.
%Przyspieszenie sygna�u maleje wraz ze wzrostem cz�stotliwo�ci.