int: n;

array[0..n-1] of var 0..n: s; 

n = 300;

constraint forall(i in 0..n-1) (
  s[i] = (sum(j in 0..n-1)(bool2int(s[j]=i)))
); 

% constraint
% sum(i in 0..n-1) (s[i]) = n;
% constraint
% sum(i in 0..n-1) (s[i]*i) = n;

solve satisfy;
output [ "s = ", show(s), ";\n" ] ;