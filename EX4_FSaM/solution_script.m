

addpath("C:\Users\kgl07\OneDrive\Skrivebord\Exercises_22003\exercise2_22003_SDT\data EX4")

sub1_fletcher_data = load("control_fletcher_eh_group1.dat");
sub2_fletcher_data = load("control_fletcher_kl_group1.dat");



[x,y,ystd] = pldata('fletcher', 'eh', 'group1');