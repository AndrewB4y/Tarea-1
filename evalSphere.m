
%% Solo darle run a todo el script para ejecutar correctamente
% Tener script sphere.m en la misma carpeta

close all

%  esp=[[-5:0.05:5]' [-5:0.05:5]'];
%  for i=1:size(Rangox1,2)
%      fun(i)=sphere([esp(i,1),esp(i,2)]);
%  end
%  
Rangox1=-5:0.05:5;
Rangox2=Rangox1;
[X1,X2]=meshgrid(Rangox1,Rangox2);
z=X1.^2+X2.^2;
surf(X1,X2,z)

%%
lb = [-5,-5];
ub = [5,5];
x0=[4,4];  %starting guess
options = optimoptions(@fminunc,'Algorithm','quasi-newton');
[x,fval,exitflag,output]=fminunc(@sphere,x0,options)
