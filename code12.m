clear; clc;

MAX = 5;

%Zadanie 1.

t0 = 600;
T0 = [293 193 0 393 512];
Ti = [293 93 100 512 61];
V0 = [0.04 0.06 0.051 0.056 0.09];
w = [0.4 0.3 0.3 0.9 1.1];
wi = [0.4 0.2 0.5 1 1];
Q = [8000 10000 4000 2000 5000];

for i=1:MAX
    [t,x] = ode45(@zbiornik_stan, [0 t0], [V0(i),T0(i)], [], wi(i), w(i), Ti(i), Q(i));

    figure(i)

    subplot(1,2,1)
    plot(t,x(:,1))
    legend("Objêtoœæ cieczy")
    
    subplot(1,2,2)
    plot(t,x(:,2))
    legend("Temperatura cieczy")
end

%Zadanie 2.

IX = [];
IU = [1;2;3];
IY = [1;2];

for i=1:MAX
    V1 = V0(i);
    T1 = T0(i);
    X0 = [V1;T1];
    U0 = [wi(i);w(i);Ti(i);Q(i)];
    Y0 = [V1+0.1; T1+10];
    [x0,u,~,dx] = trim('zbiornik_sys',X0,U0,Y0,IX,IU,IY);
    [t,x] = ode45(@zbiornik_stan, [0 t0], [V1,T1], [], u(1), u(2), u(3), u(4));
    t_s = (0:(t0/(length(t)-1)):t0)';
    
    U = [];
    for j=1:length(t_s)
        U = [U u];
    end

    [A,B,C,D] = linmod('zbiornik_sys', x0, u);
    [y,t1] = lsim(A,B,C,D,U,t_s,X0);
    
    figure(i+MAX)

    subplot(2,2,1)
    hold on
    plot(t,x(:,1))
    plot(t_s,y(:,1))
    hold off
    legend("system nieliniowy","system zlinearyzowany")
    
    subplot(2,2,2)
    hold on
    plot(t,x(:,2))
    plot(t_s,y(:,2))
    hold off
    legend("system nieliniowy","system zlinearyzowany")
    
    subplot(2,2,3)
    plot(t,x(:,1)-y(:,1))
    legend("B³¹d objêtoœci")
    
    subplot(2,2,4)
    plot(t,x(:,2)-y(:,2))
    legend("B³¹d temperatury")
end