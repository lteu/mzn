% lezione va da 11 a 15 Mar 2019 inclusi
% Prof. Pontil. disponibile solo a 12,13,14(mattino), parte il 14 pomeriggio
% Prof. Piessens. 11-14.
% Prof. Bononi

include "globals.mzn";
set of int:teachers = 1..3;
array[1..40] of var 0..3: assignment;
int:tot_hours_teacher = 12;


var int: teacher1 = sum(i in 1..40 where assignment[i] = 1)(1);
var int: teacher2 = sum(i in 1..40 where assignment[i] = 2)(1);
var int: teacher3 = sum(i in 1..40 where assignment[i] = 3)(1);

constraint teacher1 = tot_hours_teacher;
constraint teacher3 = tot_hours_teacher;
constraint teacher2 = tot_hours_teacher;

% first lessson of each day
constraint forall(i in 1..5)(
   assignment[(i-1)*8+1]=assignment[(i-1)*8+2]
);

% constraint assignment[9] = 3;

% Prof. 1
constraint
  forall(i in 1..8)(
    assignment[i] != 1
  )  
  /\
  forall(i in 29..40)(
    assignment[i] != 1
  ) 
;

% Prof. 2
constraint
  forall(i in 1..8)(
    assignment[i] != 1
  )  
  /\
  forall(i in 32..40)(
    assignment[i] != 2
  ) 
;

% alternate the courses, first half morning
constraint
  forall(i in 1..6)(
    assignment[(i-1)*4 + 1] != assignment[(i-1)*4 + 3] 
    /\
    assignment[(i-1)*4 + 2] != assignment[(i-1)*4 + 4]
 
  );

% alternate the courses, second half morning
constraint
  forall(i in 1..4)(
    assignment[(i-1)*8 + 3] != assignment[(i-1)*8 + 5] 
    /\
    assignment[(i-1)*8 + 4] != assignment[(i-1)*8 + 6]
 
  );
  
% last day, half-day lessons
constraint assignment[40]=0 /\ assignment[39]=0
  /\assignment[38]=0 /\ assignment[37]=0;

% Each lesson must be at least 2 consecutive hours (except for the first hour of each day)
constraint forall(i in 2..39)( 
  assignment[i] = assignment[i-1]\/assignment[i] = assignment[i+1]
); 

% each Prof teaches less than 4 hours per day
constraint forall(i in 1..3)(
  forall(k in 1..5)(
  let {var int: c = sum(j in 1..8 where assignment[(k-1)*8+j] = i)(1) } in
        c <= 4
  )
);

solve satisfy;
% output[show(teacher1),show(assignment),"\n"];
output["Day:"];
output [ show(assignment[i]) ++ if i mod 8 == 0 /\ i != 40 then "\nDay:" else " " endif |
            i in 1..40];
          