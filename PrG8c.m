function y = PrG8c(x)
% Matlab Code by A. Hedar (Nov. 23, 2005).
% Constraints
y(1) = x(1)^2-x(2)+1;
y(2) = 1-x(1)+(x(2)-4)^2;
% Variable lower bounds
y(3) = -x(1);
y(4) = -x(2);
% Variable upper bounds
y(5) = x(1)-10;
y(6) = x(2)-10;
% *************************************************************************
% y=y'; 