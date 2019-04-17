
enum cities;
int: n; % number of cities
array[1..n,1..n] of int: dist; % city distances
cities: start_city;
cities: end_city;

array[1..n] of var cities: citta_scelte; % resulting order

constraint  citta_scelte[1] = start_city;
constraint  citta_scelte[n] = end_city;

constraint forall(i,j in 1..n where i!=j)(citta_scelte[i] != citta_scelte[j]);

var int: total_distance = sum(i in 2..n)(dist[citta_scelte[i-1],citta_scelte[i]]);

solve minimize total_distance;

% Personalized constraints
% I do not vist Bologna right after Napoli
% constraint 
% forall(i in 2..n)(citta_scelte[i] = bologna -> citta_scelte[i-1] != napoli)
% ;

% I must vist roma before napoli
% constraint forall(i,j in 1..n where j < i)(
%    citta_scelte[i] = roma ->  citta_scelte[j] != napoli
% ); 

% constraint forall(i in 1..n)(
%    citta_scelte[i] = roma ->
%    exists(j in i..n)(citta_scelte[j] = napoli)
% ); 


output[show(citta_scelte)];

% ==== input data ====
% n=5;
% cities = {milano,bologna,firenze,roma,napoli};
% dist=[|0,2,3,6,8|2,0,1,4,6|3,1,0,3,5|6,4,3,0,2|8,6,5,2,0|];
% start_city = firenze;
% end_city = milano;

% n=8;
% cities = {beijing,chengdu,chongqing,xian,shanghai,wuhan,guangzhou,hongkong};
% dist=[|0,181,180,100,120,110,210,200|
% 182,0,40,74,196,115,156,169|
% 181,40,0,75,167,85,133,146|
% 108,74,75,0,137,78,167,179|
% 121,196,167,138,0,83,145,146|
% 115,115,86,78,83,0,99,107|
% 214,156,133,168,145,99,0,13|
% 216,170,146,180,146,107,13,0|];
% start_city = beijing;
% end_city = shanghai;
