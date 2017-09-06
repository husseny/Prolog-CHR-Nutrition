:- use_module(library(chr)).

:-chr_constraint done/1, schedule/4, week/5, dailyIntake/7, meal/6, food/9, fooditem/6.
:- discontiguous foodsrc/6.
schedule(Protein, Carb, Fat, NoMeals) <=> week(1, Protein, Carb, Fat, NoMeals), 
	week(2, Protein, Carb, Fat, NoMeals), 
	week(3, Protein, Carb, Fat, NoMeals), 
	week(4, Protein, Carb, Fat, NoMeals).

week(Week, Protein, Carb, Fat, NoMeals) <=> 
	bagof(fooditem(A,B,K,D,E,M),foodsrc(A,B,K,D,E,M),L), 
	random_permutation(L,L1), q(L1), 
	dailyIntake(Week, 1, Protein, Carb, Fat, NoMeals, 0),
	random_permutation(L,L2), q(L2),
	dailyIntake(Week, 2, Protein, Carb, Fat, NoMeals, 0),
	random_permutation(L,L3), q(L3),
	dailyIntake(Week, 3, Protein, Carb, Fat, NoMeals, 0),
	random_permutation(L,L4), q(L4),
	dailyIntake(Week, 4, Protein, Carb, Fat, NoMeals, 0),
	random_permutation(L,L5), q(L5),
	dailyIntake(Week, 5, Protein, Carb, Fat, NoMeals, 0),
	random_permutation(L,L6), q(L6),
	dailyIntake(Week, 6, Protein, Carb, Fat, NoMeals, 0),
	random_permutation(L,L7), q(L7),
	dailyIntake(Week, 7, Protein, Carb, Fat, NoMeals, 0).

dailyIntake(Week, Day, Protein, Carb, Fat, 0, _) <=> true.
dailyIntake(Week, Day, Protein, Carb, Fat, NoMeals, Order) <=> P is div(Protein, NoMeals), 
	NProtein is Protein - P, 
 	C is div(Carb, NoMeals), NCarb is Carb - C,
	F is div(Fat, NoMeals), NFat is Fat - F, NNoMeals2 is NoMeals - 1, Order2 is Order + 1 |
	meal(Week, Day, P, C, F, Order2), dailyIntake(Week, Day, NProtein, NCarb, NFat, NNoMeals2, Order2).

%User Editing the schedule
food(X, P, C, F, Prefs, Week, Day, Order, 2), 
fooditem(X, P, C, F, Prefs, L) , meal(Week, Day, Protein, Carb, Fat, Order) <=>  
NProtein is Protein - P, NCarb is Carb - C, NFat is Fat - F, NProtein >= -30, NCarb >= -25, NFat >= -5,
not(member((Week,Day), L)), member(Order, Prefs) | 
fooditem(X, P, C, F, Prefs, [(Week,Day)|L]),
food(X, P, C, F, Prefs, Week, Day, Order, 1), meal(Week, Day, NProtein, NCarb, NFat, Order).

%Scheduling
fooditem(X, P, C, F, Prefs, L) , meal(Week, Day, Protein, Carb, Fat, Order) <=>  
NProtein is Protein - P, NCarb is Carb - C, NFat is Fat - F, NProtein >= -30, NCarb >= -25, NFat >= -5,
not(member((Week,Day), L)), member(Order, Prefs) | 
fooditem(X, P, C, F, Prefs, [(Week,Day)|L]),
food(X, P, C, F, Prefs, Week, Day, Order, 1), meal(Week, Day, NProtein, NCarb, NFat, Order).

%Cleaning up the output
meal(4, 7, Protein, Carb, Fat, 3) <=> Protein =< 0, Carb =< 25, Fat =< 5 | done(1).
done(1) \ fooditem(_, _, _, _, _, _) <=> true.

%Halting
meal(Week, Day, Protein, Carb, Fat, Order) <=> Protein =< 0, Carb =< 25, Fat =< 5 | true.

q([]) :- true.
q([H|T]) :- H, q(T).


foodsrc(cheddarChs, 25, 1.3, 33, [1,2,5], []).

foodsrc(goudaChs, 25, 2.2, 27, [1,2,5], []).

foodsrc(swissChs, 27, 5, 28, [1,2,5], []).

foodsrc(carrot, 0.9, 10, 0.2, [1,2,3,4,5], []).

foodsrc(broccoli, 2.8, 7, 0.4, [1,2,3,4,5], []).

foodsrc(spinach, 2.9, 3.6, 0.4, [2,3,4,5], []).

foodsrc(whtRice, 7, 82, 0.6, [3,4], []).

foodsrc(potato, 2, 17, 0.1, [3,4], []).

foodsrc(whlEgg, 13, 0.7, 10, [1,2,4,5], []).

foodsrc(eggWht, 11, 0.7, 0.2, [1,2,4,5], []).

foodsrc(swtPotato,	1.6, 20, 0, [1,2,3,4,5], []).

foodsrc(fullFatMilk, 3.3, 4.6, 3.7, [1,2,3,4], []).

foodsrc(pear, 0.4, 15, 0.1, [1,2,3,4,5], []).

foodsrc(tuna, 26, 0, 1, [2,3,4,5], []).

foodsrc(tomato, 0.9, 3.9, 0.2, [1,2,3,4,5], []).

foodsrc(honey,	0.3, 82, 0, [1,2,3,4,5], []).

foodsrc(oliveOil, 0, 0, 100, [1,2,3,4,5], []).

foodsrc(pasta, 13, 75, 1.5, [3,4], []).

foodsrc(salmon, 20, 0, 13, [3,4], []).

foodsrc(fish, 19, 0, 6, [3,4], []).

foodsrc(shrimp, 20, 0, 0.5, [3,4], []).

%foodsrc(skimmedMilk, 3.4, 5, 0.1, [1,2,3,4,5], []).

foodsrc(banana, 1.1, 23, 0.3, [1,2,3,4,5], []).

foodsrc(chkBr, 21.2, 0, 2.5, [3,4], []).

foodsrc(lnBeef, 20, 0, 6, [3,4], []).

foodsrc(peanutButter, 25, 20, 50, [1,2,3,4], []).

foodsrc(wheyProtein, 80, 10, 3.3, [1,2,3,4,5], []).

foodsrc(multiGrainBread, 13, 43, 4.2, [1,2,3,4,5], []).
