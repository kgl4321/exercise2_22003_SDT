C_values = [];
c0 = 100*10^(-9); %F;
for i = 1:11
C = c0*exp((i-1)/2.8854);
% Store the computed value of C in an array
    C_values(i) = C;
end

R1=150;
L1=10*10^(-3); %H
C_values(1)
delta = R1*sqrt(C_values(1)/L1)

for i=1:11
    R = delta/sqrt(C_values(i)/L1);
    R_values(i)= R;
end

