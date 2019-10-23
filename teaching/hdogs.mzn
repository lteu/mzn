set of int: stores = 0..4; % 0 means no store
enum roles = {NONE,PL,PLBB,PLLB,VRS,DRS};

int: owm = 2; % overtime wage multiplier
int: n_staff;
array[1..n_staff,roles] of 0..1: qualifications;


array[1..n_staff] of 1000..3000: wages; % for integer purpose, it has been multiplied by 100
array[1..n_staff] of 1..40: max_daytime;
array[1..n_staff] of 1..40: min_daytime;
array[1..n_staff,1..hpd*nday] of 0..1: staff_availability;

% daytime range 7:00 - 20:00; 13 hours/d; 91 hours/w
int: hpd = 13; % hours per day
% int: nday = 2;
int: nday = 1;
array[roles,1..hpd*nday] of 0..10: day_req1;
array[roles,1..hpd*nday] of 0..10: day_req2;

array[1..n_staff,1..hpd*nday] of var stores: staff_assignment_store;
array[1..n_staff,1..hpd*nday] of var roles: staff_assignment_role;
array[1..n_staff,1..hpd*nday] of var 0..1: staff_assignment_slot;

% objective function
var int: cost = sum(staff in 1..n_staff)(
      wages[staff] * sum(slot in 1..hpd*nday)(staff_assignment_slot[staff,slot])
  );

% channel constraint
constraint forall(staff in 1..n_staff, slot in 1..hpd*nday)(
    staff_assignment_store[staff,slot] > 0 <-> staff_assignment_slot[staff,slot] = 1
  );


% store requirement for store X; X = 1
constraint forall(role in roles, slot in 1..hpd*nday)(
    day_req1[role,slot] = sum(staff in 1..n_staff)(
      if staff_assignment_store[staff,slot]=1 /\ staff_assignment_role[staff,slot] = role  
      then 1 else 0 endif
    )
);
constraint forall(role in roles, slot in 1..hpd*nday)(
    day_req2[role,slot] = sum(staff in 1..n_staff)(
      if staff_assignment_store[staff,slot]=2 /\ staff_assignment_role[staff,slot] = role  
      then 1 else 0 endif
    )
);

% store and role constraint
constraint forall(staff in 1..n_staff, slot in 1..hpd*nday)(
  staff_assignment_store[staff,slot] = 0 -> staff_assignment_role[staff,slot] = NONE
);

% role and qualification constraint
constraint forall(staff in 1..n_staff, slot in 1..hpd*nday, role in roles)(
  staff_assignment_role[staff,slot] = role ->  qualifications[staff,role] = 1
);

% availability constraint 
constraint forall(staff in 1..n_staff, slot in 1..hpd*nday)(
  % staff_assignment_store[staff,slot] > 0 -> staff_availability[staff,slot] = 1
  staff_assignment_slot[staff,slot] = 1 -> staff_availability[staff,slot] = 1
);

% overall time constraint 
constraint 
  forall(staff in 1..n_staff)(
    let {
      var int: staff_daytime = sum(slot in 1..hpd*nday)(
        staff_assignment_slot[staff,slot]
      );
    } in 
    min_daytime[staff] < staff_daytime 
    /\
    staff_daytime < max_daytime[staff]
  );
  

solve minimize cost;

%  ----------
%   instance
%  ----------
% n_staff = 5;
n_staff = 2;

% qualifications = [|
%   1,1,1,1,1|
%   1,1,1,1,1|
%   1,1,1,0,1|
%   1,1,1,1,0|
%   1,1,1,1,1|];

wages = [1500,1800];
max_daytime = [30,10];
min_daytime = [1,2];
staff_availability = [|
  1,1,1,1,1,1,1,1,1,1,1,1,1|
  1,1,1,1,1,1,1,1,1,1,1,1,0|];

qualifications = [|
  1,1,1,1,1,1|
  1,1,1,1,1,1|];

day_req1 = [|
  0,0,0,0,0,0,0,0,0,0,0,0,0|
  1,1,1,1,2,2,2,1,1,1,1,1,0|
  0,0,0,0,0,0,0,1,1,1,1,1,0|
  0,0,0,0,0,0,0,0,0,0,0,0,0|
  0,0,0,0,0,0,0,0,0,0,0,0,0|
  0,0,0,0,0,0,0,0,0,0,0,0,0|
  |];

day_req2 = [|
  0,0,0,0,0,0,0,0,0,0,0,0,0|
  0,0,0,0,0,0,0,0,0,0,0,0,0|
  0,0,0,0,0,0,0,0,0,0,0,0,0|
  0,0,0,0,0,0,0,0,0,0,0,0,1|
  0,0,0,0,0,0,0,0,0,0,0,0,0|
  0,0,0,0,0,0,0,0,0,0,0,0,0|
  |];


% % output[show(teacher1),show(assignment),"\n"];
% output["Day:"];
% output [ show(assegnamento[i]) ++ if i mod 8 == 0 /\ i != 40 then "\nDay:" else " " endif |
%             i in 1..40];