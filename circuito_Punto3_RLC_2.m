%% Solo darle run a todo el script para ejecutar correctamente
close all

R=50;           %x(1)
L=1e-6;         %x(2)
C=1e-6;         %x(3)
% C=100e-6;
t = [0:1e-8:5e-4];
num=[1/(L*C)];
den = [1 R/L 1/(L*C)];
sys = tf(num,den);
step(sys)

alpha=R/(2*L);
ome=1/(sqrt(L*C));
s1=-alpha+sqrt(alpha^2-ome^2);
s2=-alpha-sqrt(alpha^2-ome^2);
A2=1;
A1=A2*alpha;
Vs=1;
vcZ=0;
iLZ=0;
%% criticamente amortiguado
vcMed=Vs+t.*A1.*exp(s1.*t)+A2.*exp(s2.*t);
figure();
plot(t,vcMed)
%% subamortiguado
% ome=sqrt((1/(L*C))-(alpha));
% vc2=exp(-alpha.*t).*(vcZ*cos(ome.*t)+((1/ome)*(alpha*vcZ+(iLZ/C))*sin(ome.*t)));
% 
% figure();
% plot(t,vc2)
%%
% alpha = x(1)/(2*x(2))
%ome=1/(sqrt(x(2)*x(3)))
%s1=(-(x(1)/(2*x(2)))+sqrt((x(1)/(2*x(2)))^2-(1/(sqrt(x(2)*x(3))))^2))
%s2=-(x(1)/(2*x(2)))-sqrt((x(1)/(2*x(2)))^2-(1/(sqrt(x(2)*x(3))))^2);

fun=@(x)(Vs+t.*(A2*(x(1)/(2*x(2)))).*exp((-(x(1)/(2*x(2)))+sqrt((x(1)/(2*x(2)))^2 ...
    -(1/(sqrt(x(2)*x(3))))^2)).*t)+A2.*exp((-(x(1)/(2*x(2)))-sqrt((x(1)/(2*x(2)))^2 ...
    -(1/(sqrt(x(2)*x(3))))^2)).*t))-vcMed;

%% lsqnonlin

lb = [0,0,0];
ub = [1000,1e-4,1e-4];
x0 = [10,10e-6,10e-6];
% options = optimoptions(@lsqnonlin,'Display','iter','MaxFunctionEvaluations',1500);
options = optimoptions(@lsqnonlin,'Display','iter','MaxFunctionEvaluations',1500);
x = lsqnonlin(fun,x0,lb,ub,options)
figure
plot(t,vcMed,'-b',t,fun(x)+vcMed,'or')

%% fminunc

options = optimoptions(@fminunc,'Algorithm','quasi-newton');
x0=[10,100e-6,100e-6];  %starting guess
[x,fval,exitflag,output]=fminunc(@sphere,x0,options)

figure
plot(t,vcMed,'ob',t,fun(x)+vcMed,'or')
axis([0 5e-4 0 1000])
