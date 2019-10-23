set of int: teachers = 1..3;
array[1..40] of var 0..3: assegnamento;
int: tot_ore_teacher = 12;

var int: teacher1 = sum(i in 1..40 where assegnamento[i]=1)(1);
var int: teacher2 = sum(i in 1..40 where assegnamento[i]=2)(1);
var int: teacher3 = sum(i in 1..40 where assegnamento[i]=3)(1);

constraint teacher1 = tot_ore_teacher;
constraint teacher2 = tot_ore_teacher;
constraint teacher3 = tot_ore_teacher;

% Prof 1
constraint 
  forall(i in 1..8)(assegnamento[i] != 1)
  /\
  forall(i in 29..40)(assegnamento[i] != 1);

% Prof 2
constraint 
  forall(i in 29..40)(assegnamento[i] != 2);

constraint 
  forall(i in 37..40)(assegnamento[i] = 0);
  
constraint 
  forall(i in 2..30)(
  assegnamento[i] = assegnamento[i-1]
  \/
  assegnamento[i] = assegnamento[i+1]
  );

solve satisfy;
% output[show(teacher1),show(assignment),"\n"];
output["Day:"];
output [ show(assegnamento[i]) ++ if i mod 8 == 0 /\ i != 40 then "\nDay:" else " " endif |
            i in 1..40];