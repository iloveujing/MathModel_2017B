function y = first(x)
load('D:\FOLDER\����\У��ģ\2017B\L-I-20C.mat')
T = 273.15 + 20;
P = P./1000;
I = I./1000;
Pi = x(1).*(I - x(2) - x(4) - x(5).*(T + (I.*U - P).*x(3) ) - x(6).*(T + (I.*U - P).*x(3) ).^2 - x(7).*(T + (I.*U - P).*x(3) ).^3 - x(8).*(T + (I.*U - P).*x(3) ).^4);
y = sum((P - Pi).^2./1401);
end