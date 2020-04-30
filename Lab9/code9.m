clear; clc;

licz = [0,1];
A = [2,7,6,1];
B = [6,7,2,0.5];

legenda = [ "- ca³ka z kwadratu b³êdu"
           "- ca³ka z s. kw. b. i w. kw. p. b."
           "- ca³ka z modu³u regulacji"
           "- kryterium czêstotliwoœciowe" ];
%OPARE
K =  [7, 6.372,  6.371,  4.891, 31.667, 28.895, 28.859, 18.122, 7, 6.685,  6.683,  3.618, -0.667, -0.671, -0.756, -0.803];
alfa = [4, 3.175, 3.733, 1.778, 5.444, 4.207, 4.197, 2.659, 0.444, 0.404, 0.404, 0.25, 0.028, 0.027, 0.025, 0.019];
beta = 0.5;

for i = 1:4
    f = figure(6*i-5);
    f.Name = 'Charakterystyki: skokowa i czêstotliwoœciowa dla uk³adu otwartego';
    figure(f);
    
    mian = [1,A(i),B(i),1];
    G_o = tf(licz, mian);
    
    subplot(2,2,1)
    step(G_o)
    
    subplot(2,2,2)
    nyquist(G_o)
    
    subplot(2,2,[3,4])
    bode(G_o)
    
    disp("Dla obiektu "+num2str(i)+" uzyska³em nastêpuj¹ce parametry optymalne:")
    disp(legenda(1)+": K = "+num2str(K(4*i-3))+" alfa = "+num2str(alfa(4*i-3)))
    disp(legenda(2)+": K = "+num2str(K(4*i-2))+" alfa = "+num2str(alfa(4*i-2))+" dla bety = "+num2str(beta))
    disp(legenda(3)+": K = "+num2str(K(4*i-1))+" alfa = "+num2str(alfa(4*i-1)))
    disp(legenda(4)+": K = "+num2str(K(4*i))+" alfa = "+num2str(alfa(4*i)))
    
    for j = 1:4
        G_r = tf([K(4*(i-1)+j) alfa(4*(i-1)+j)], [1, 0]);
        G = feedback(G_o,G_r,-1);
        
        f = figure(6*i-(5-j));
    
        subplot(2,2,1)
        step(G)
    
        subplot(2,2,2)
        nyquist(G)
    
        subplot(2,2,[3,4])
        bode(G)
    end
    
    figure(6*i)
    hold on 
    for j = 1:4
        G_r = tf([K(4*(i-1)+j) alfa(4*(i-1)+j)], [1, 0]);
        G = feedback(G_o,G_r,-1);
        
        [y,t] = step(G);
        plot(t,y)
    end
    legend(legenda(1), legenda(2), legenda(3), legenda(4))
    hold off
end
