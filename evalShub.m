
%% Solo darle run a todo el script para ejecutar correctamente
% Tener script sphere.m en la misma carpeta

close all
Rangox1=-10:0.06:10;
Rangox2=Rangox1;
[X1,X2]=meshgrid(Rangox1,Rangox2);
fun = shub(X1,X2);
% esp=[[-5:0.05:5]' [-5:0.05:5]'];
%  for i=1:size(esp,1)
%      fun(i)=shub([esp(i,1),esp(i,2)])
%  end
 surf(X1,X2,fun);
% Rangox1=-5:0.05:5;
% Rangox2=Rangox1;
% [X1,X2]=meshgrid(Rangox1,Rangox2);
% z=1*X1.^2+2*X2.^2;
% surf(X1,X2,z)

%%
lb = [-10,-10];
ub = [10,10];
options = optimoptions(@fminunc,'Algorithm','quasi-newton');
x0=[1,2];  %starting guess
[x,fval,exitflag,output]=fminunc(@shub2,x0,options)