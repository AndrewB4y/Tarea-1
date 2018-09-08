close all

R=50;           %x(1)
L=1e-6;         %x(2)
C=1e-6;         %x(3)

t = [0:1e-8:5e-4];
num=[1/(L*C)];
den = [1 R/L 1/(L*C)];
sys = tf(num,den);
step(sys)
%%
syms r l c s
%tra=1/(l*c*s^2+r*c*s+1);
tra=((1/l*c)/(s^2+(r/l)*s+1/(l*c)))*(1/s)
%tra2=1/(L*C*s^2+R*C*s+1);
tra2=((1/L*C)/(s^2+(R/L)*s+1/(L*C)))*(1/s)
pretty(tra)
pretty(tra2)
temp=ilaplace(tra)
temp2=ilaplace(tra2)

%%
p=0;
for i=0:1e-6:5e-4
    p=p+1;
    respTemp(p) = (2*C^(3/2)*sin((i*(- C*R^2 + 4*L)^(1/2))/(2*C^(1/2)*L))*exp(-(R*i)/(2*L)))/(4*L - C*R^2)^(1/2);
    respTempSTP(p)=C^2 - C^2*exp(-(R*i)/(2*L))*(cosh((i*((C*R^2)/4 - L)^(1/2))/(C^(1/2)*L)) + (C^(1/2)*R*sinh((i*((C*R^2)/4 - L)^(1/2))/(C^(1/2)*L)))/(2*((C*R^2)/4 - L)^(1/2)));
end
t2=[0:1e-6:5e-4];
plot(t2,respTemp)

%%
t = [0:1e-9:3e-7];
%respTemp = (2*exp(-(R.*t)/(2*L)).*sin((t.*(- C*R^2 + 4*L)^(1/2))./(2*C^(1/2)*L)))./(C^(1/2)*(4*L - C*R^2)^(1/2));
respTemp=(2*C^(3/2).*exp(-(R.*t)./(2*L)).*sin((t.*(- C*R^2 + 4*L)^(1/2))./(2*C^(1/2)*L)))./(4*L - C*R^2)^(1/2);
plot(t,respTemp)
%respTemp2 = (250000*39^(1/2).*exp(-25000000.*t).*sinh(4000000*39^(1/2).*t))/39;
respTemp2=(39^(1/2).*exp(-25000000.*t).*sinh(4000000*39^(1/2).*t))./156000000;
figure();
plot(t,respTemp2)

respTempSTEP=C^2 - C^2.*exp(-(R.*t)./(2*L)).*(cosh((t.*((C*R^2)/4 - L)^(1/2))./(C^(1/2)*L)) + (C^(1/2)*R.*sinh((t.*((C*R^2)/4 - L)^(1/2))./(C^(1/2)*L)))./(2*((C*R^2)/4 - L)^(1/2)));
figure();
plot(t,respTempSTEP)
%%
close all
syms C R t L
% respTemp = -(exp(t.*((-((sqrt(C*R^2-4*L))/(2*sqrt(C)*L))-((R)/(2*L)))))-exp(t.*((((sqrt(C*R^2-4*L))/(2*sqrt(C)*L))-((R)/(2*L))))))/(sqrt(C)*sqrt(C*R^2-4*L));
% plot(t,respTemp)
respTemp = -(exp(t*((-((sqrt(C*R^2-4*L))/(2*sqrt(C)*L))-((R)/(2*L)))))-exp(t*((((sqrt(C*R^2-4*L))/(2*sqrt(C)*L))-((R)/(2*L))))))/(sqrt(C)*sqrt(C*R^2-4*L));
pretty(respTemp)

%%
close all
fun = @(x)((2*x(3)^(3/2).*exp(-(x(1).*t)./(2*x(2))).*sin((t.*(- x(3)*x(1)^2 + 4*x(2))^(1/2))./(2*x(3)^(1/2)*x(2))))./(4*x(2) - x(3)*x(1)^2)^(1/2) )-respTemp;
 
lb = [0,0,0];
ub = [100,1e-3,1e-3];
x0 = [10,1e-4,1e-4];
options = optimoptions(@lsqnonlin,'Display','iter');
x = lsqnonlin(fun,x0,lb,ub,options)
figure
plot(t,respTemp,'ob',t,fun(x)+respTemp,'or')

