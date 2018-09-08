
%% Solo darle run a todo el script para ejecutar correctamente
% Tener script sphere.m en la misma carpeta

close all

Rangox1=-5:0.05:5;
Rangox2=Rangox1;
[X1,X2]=meshgrid(Rangox1,Rangox2);
z=1*X1.^2+2*X2.^2;
surf(X1,X2,z)

%%
% lb = [-5,-5];
% ub = [5,5];
x0 = [3,0.05];
options = optimoptions(@fminunc,'Algorithm','quasi-newton');
x0=[4,4];  %starting guess
[x,fval,exitflag,output]=fminunc(@sum2,x0,options)