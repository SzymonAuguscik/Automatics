clear; clc;

ORI = 7; %nr obiektu ró¿niczkuj¹cego idealnego

T1 = 3; T2 = 1;
k1 = 2; k2 = -3;
theta = 10; n = 5;
T1_1 = 2; T1_2 = 5;
T2_1 = 4; T2_2 = 6;
ksi1 = 2; ksi2 = 0.25;
Ti = 3; Td = 7;

[licz_op,mian_op] = pade(theta,n);

licz1_iner = [0,k1]; mian1_iner = [T1,1];
licz2_iner = [0,k2]; mian2_iner = [T2,1];

[licz1,mian1] = series(licz1_iner,mian1_iner,licz_op,mian_op);
[licz2,mian2] = series(licz2_iner,mian2_iner,licz_op,mian_op);

nazwy = [
         "Uk³ad inercyjny I rzêdu"
         "Uk³ad inercyjny I rzêdu z opóŸnieniem"
         "Uk³ad inercyjny II rzêdu"
         "Uk³ad inercyjny II rzêdu oscylacyjny"
         "Uk³ad ca³kuj¹cy idealny"
         "Uk³ad ca³kuj¹cy rzeczywisty"
         "Uk³ad ró¿niczkuj¹cy idealny"
         "Uk³ad ró¿niczkuj¹cy rzeczywisty"
         ];

legendy = [
           "k = "+num2str(k1)+", T = "+num2str(T1)
           "k = "+num2str(k2)+", T = "+num2str(T2)
           "theta = "+num2str(theta)+", T = "+num2str(T1)
           "theta = "+num2str(theta)+", T = "+num2str(T2)
           "k = "+num2str(k1)+", T1 = "+num2str(T1_1)+", T2 = "+num2str(T1_2)
           "k = "+num2str(k2)+", T1 = "+num2str(T2_1)+", T2 = "+num2str(T2_2)
           "k = "+num2str(k1)+", T = "+num2str(T1)+", ksi = "+num2str(ksi1)
           "k = "+num2str(k2)+", T = "+num2str(T2)+", ksi = "+num2str(ksi2)
           "k = "+num2str(k1)+", Ti = "+num2str(Ti)
           "k = "+num2str(k2)+", Ti = "+num2str(Ti)
           "k = "+num2str(k1)+", Ti = "+num2str(Ti)+", T = "+num2str(T1)
           "k = "+num2str(k2)+", Ti = "+num2str(Ti)+", T = "+num2str(T2)
           ""
           ""
           "Td = "+num2str(Td)+", T = "+num2str(T1)
           "Td = "+num2str(Td)+", T = "+num2str(T2)
           ];
       
obiekty = [
           tf([0,k1],[T1,1])
           tf([0,k2],[T2,1])
           tf(licz1,mian1)
           tf(licz2,mian2)
           tf([0,0,k1],[T1_1*T1_2,T1_1+T1_2,1])
           tf([0,0,k2],[T2_1*T2_2,T2_1+T2_2,1])
           tf([0,0,k1],[T1^2,2*T1*ksi1,1])
           tf([0,0,k2],[T2^2,2*T2*ksi2,1])
           tf([0,k1],[Ti,1])
           tf([0,k2],[Ti,1])
           tf([0,k1],[Ti*T1,Ti,0])
           tf([0,k2],[Ti*T2,Ti,0])
           tf([Td,0],[0,1])
           tf([Td,0],[0,1])
           tf([Td,0],[T1,1])
           tf([Td,0],[T2,1])
           ];
       
for i = 1:length(nazwy)    
    y1 = []; y2 = [];
    t1 = []; t2 = [];
    
    if i ~= ORI
        [y1,t1] = step(obiekty(2*i-1));
        [y2,t2] = step(obiekty(2*i));
    end
    
    f1 = figure(i);
    f1.Name = nazwy(i);
    figure(f1)

    subplot(1,2,1)
    plot(t1,y1,t2,y2)
    grid()
    title("Step response")
    if i ~= ORI
        legend(legendy(2*i-1),legendy(2*i))
    end
    xlabel("Time")
    ylabel("Amplitude")
    
    y1 = []; y2 = [];
    t1 = []; t2 = [];
    
    if i ~= ORI
        [y1,t1] = impulse(obiekty(2*i-1));
        [y2,t2] = impulse(obiekty(2*i));
    end
    
    subplot(1,2,2)
    plot(t1,y1,t2,y2)
    grid()
    title("Impulse response")
    if i ~= ORI
        legend(legendy(2*i-1),legendy(2*i))
    end
    xlabel("Time")
    ylabel("Amplitude")
end
