function y2 = fitness_2(x)
    load('D:\FOLDER\桌面\校数模\2017B\L-I-20C.mat')
    load('D:\FOLDER\桌面\校数模\2017B\S21_5.mat')
F = f(1138:end).*1e9;
Hf = S21(1138:end);
P_train = P(39:end)/1000;
I_train = I(39:end)/1000;
U_train = U(39:end);
init = [0.7, 1E-5, 9.6E-9, 1.5E-8, 1.8E6, 4.97E5, 3.8E-12, 4.7E-8];
lambda = 0.324413652820912;
q = 1.6E-19;
Ith0 = 0.000219244267062602;
Rth = 3.249149910157457e+03;
a_0 = 0.000745355211885121;
a_1 = -2.70751304651695e-05;
a_2 = 2.76422683018535e-07;
a_3 = -2.22732107765099e-10;
a_4 = 1.34775894084846e-12;
T =  293.15 + (I_train.*U_train - P_train).*Rth;
Ioff = a_0 + a_1.*T + a_2.*T.^2 + a_3.*T.^3 + a_4.*T.^4;
x = init;
Ns = (P_train./(x(4).*x(7)) + x(5).*x(6).*P_train./(x(4) + x(8).*P_train))./(x(2)./x(3) + x(5).*P_train./(x(4) + x(8).*P_train));
test1 = q./x(1).*(Ns./x(3) + x(5).*(Ns - x(6)).*P_train./(x(4) + x(8).*P_train)) + Ith0 + Ioff - I_train;
% test1 = test1./(I_train)

Ss = ((x(1).*(I_train - Ith0 - Ioff)./q) - (Ns./x(3)))./(x(5).*(Ns - x(6)));
Ps = x(4).*Ss;
test2 = x(4).*Ss - P_train;
% test2 = test2./P_train

Ns1 = (1.904172485e-3./(x(4).*x(7)) + x(5).*x(6).*1.904172485e-3./(x(4) + x(8).*1.904172485e-3))./(x(2)./x(3) + x(5).*1.904172485e-3./(x(4) + x(8).*1.904172485e-3));
T1 = 293.15 + (7.5e-3.*2.464597008 - 1.904172485e-3).*Rth;
Ioff1 = a_0 + a_1.*T + a_2.*T.^2 + a_3.*T.^3 + a_4.*T.^4;
Ss1 = ((x(1).*(7.5e-3 - Ith0 - Ioff1)./q) - (Ns1./x(3)))./(x(5).*(Ns1 - x(6)));
Ps1 = x(4).*Ss1;
C = 1./x(7) + 1./x(3) + x(5).*Ps1./(x(4) + x(8).*Ps1) - x(5).*(Ns1 - x(6))./(1 + x(8).*Ps1./x(4)); %% 是否平方
Z = 1./(x(7).*x(3)) + x(5).*Ps1./(x(7).*(x(4) + x(8).*Ps1)) - (1 - x(2)).*x(5).*(Ns1 - x(6))./(x(3).*(1 + x(8).*Ps1./x(4))); %% 是否平方

A = (Z.^2 - 4.*pi.^2.*F.^2.*Z)./(Z.^2 - 8.*pi.^2.*F.^2.*Z + 16.*pi.^4.*F.^4 - 4.*pi.^2.*F.^2.*C.^2);
B = 2.*pi.*F.*Z.*C./(Z.^2 - 8.*pi.^2.*F.^2.*Z + 16.*pi.^4.*F.^4 - 4.*pi.^2.*F.^2.*C.^2);
HF = sqrt(A.^2 + B.^2);
% test3 = HF - exp(Hf/10);
test3 = HF - Hf;
% test3 = test3./(Hf);
y2 = sum(test1.^2 + test2.^2 + test3.^2);
end