:- use_module(library(chr)).

:-chr_constraint done/1, schedule/4, week/5, dailyIntake/7, meal/7, food/11.
:- discontiguous food1/9.
schedule(Protein, Carb, Fat, NoMeals) <=> week(1, Protein, Carb, Fat, NoMeals), 
	week(2, Protein, Carb, Fat, NoMeals), 
	week(3, Protein, Carb, Fat, NoMeals), 
	week(4, Protein, Carb, Fat, NoMeals).

week(Week, Protein, Carb, Fat, NoMeals) <=> 
	bagof(food(A,B,K,D,E,M,G,H,I,J,K),food1(A,B,K,D,E,M,G,H,I,J,K),L), 
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
	meal(Week, Day, P, C, F, Order2, 1), dailyIntake(Week, Day, NProtein, NCarb, NFat, NNoMeals2, Order2).



food(X, P, C, F, Order, _, _, _, L, Category, 0) , meal(Week, Day, Protein, Carb, Fat, Order, Category) <=>  
NProtein is Protein - P, NCarb is Carb - C, NFat is Fat - F, NProtein >= -30, NCarb >= -25, NFat >= -5,
not(member((Week,Day), L)), Category2 is max(5, Category + 1) | 
food(X, P, C, F, Order, _, _, _, [(Week,Day)|L], Category, 0),
food(X, P, C, F, Order, Week, Day, Order, [], Category, 1), 
meal(Week, Day, NProtein, NCarb, NFat, Order, Category2).

meal(4, 7, Protein, Carb, Fat, 5, 5) <=> Protein =< 0, Carb =< 25, Fat =< 5 | done(1).
meal(Week, Day, Protein, Carb, Fat, Order, 5) <=> Protein =< 0, Carb =< 25, Fat =< 5 | true.

done(1) \ food(_,_,_,_,_,_,_,_,_,_,0) <=> true.

 %meal(Week, Day, NProtein, NCarb, NFat, Order) <=> false.

q([]) :- true.
q([H|T]) :- H, q(T).


food1(cheddarChs, 25, 1.3, 33, 1, _, _, _, [], 2, 0).
food1(cheddarChs, 25, 1.3, 33, 2, _, _, _, [], 2, 0).
food1(cheddarChs, 25, 1.3, 33, 5, _, _, _, [], 2, 0).
food1(goudaChs, 25, 2.2, 27, 1, _, _, _, [], 2, 0).
food1(goudaChs, 25, 2.2, 27, 2, _, _, _, [], 2, 0).
food1(goudaChs, 25, 2.2, 27, 5, _, _, _, [], 2, 0).
food1(swissChs, 27, 5, 28, 1, _, _, _, [], 2, 0).
food1(swissChs, 27, 5, 28, 2, _, _, _, [], 2, 0).
food1(swissChs, 27, 5, 28, 5, _, _, _, [], 2, 0).
food1(carrot, 0.9, 10, 0.2, 1, _, _, _, [], 3, 0).
food1(carrot, 0.9, 10, 0.2, 2, _, _, _, [], 3, 0).
food1(carrot, 0.9, 10, 0.2, 3, _, _, _, [], 3, 0).
food1(carrot, 0.9, 10, 0.2, 4, _, _, _, [], 3, 0).
food1(carrot, 0.9, 10, 0.2, 5, _, _, _, [], 3, 0).
food1(broccoli, 2.8, 7, 0.4, 1, _, _, _, [], 3, 0).
food1(broccoli, 2.8, 7, 0.4, 2, _, _, _, [], 3, 0).
food1(broccoli, 2.8, 7, 0.4, 3, _, _, _, [], 3, 0).
food1(broccoli, 2.8, 7, 0.4, 4, _, _, _, [], 3, 0).
food1(broccoli, 2.8, 7, 0.4, 5, _, _, _, [], 3, 0).
food1(spinach, 2.9, 3.6, 0.4, 2, _, _, _, [], 3, 0).
food1(spinach, 2.9, 3.6, 0.4, 3, _, _, _, [], 3, 0).
food1(spinach, 2.9, 3.6, 0.4, 4, _, _, _, [], 3, 0).
food1(spinach, 2.9, 3.6, 0.4, 5, _, _, _, [], 3, 0).
food1(whtRice, 7, 82, 0.6, 3, _, _, _, [], 4, 0).
food1(whtRice, 7, 82, 0.6, 4, _, _, _, [], 4, 0).
food1(potato, 2, 17, 0.1, 1, _, _, _, [], 4, 0).
food1(potato, 2, 17, 0.1, 2, _, _, _, [], 4, 0).
food1(potato, 2, 17, 0.1, 3, _, _, _, [], 4, 0).
food1(potato, 2, 17, 0.1, 4, _, _, _, [], 4, 0).
food1(potato, 2, 17, 0.1, 5, _, _, _, [], 4, 0).
food1(whlEgg, 13, 0.7, 10, 1, _, _, _, [], 1, 0).
food1(whlEgg, 13, 0.7, 10, 2, _, _, _, [], 1, 0).
food1(whlEgg, 13, 0.7, 10, 4, _, _, _, [], 1, 0).
food1(whlEgg, 13, 0.7, 10, 5, _, _, _, [], 1, 0).
food1(eggWht, 11, 0.7, 0.2, 1, _, _, _, [], 1, 0).
food1(eggWht, 11, 0.7, 0.2, 2, _, _, _, [], 1, 0).
food1(eggWht, 11, 0.7, 0.2, 3, _, _, _, [], 1, 0).
food1(eggWht, 11, 0.7, 0.2, 4, _, _, _, [], 1, 0).
food1(eggWht, 11, 0.7, 0.2, 5, _, _, _, [], 1, 0).
food1(swtPotato,	1.6, 20, 0, 1, _, _, _, [], 3, 0).
food1(swtPotato,	1.6, 20, 0, 2, _, _, _, [], 3, 0).
food1(swtPotato,	1.6, 20, 0, 3, _, _, _, [], 3, 0).
food1(swtPotato,	1.6, 20, 0, 4, _, _, _, [], 3, 0).
food1(swtPotato,	1.6, 20, 0, 5, _, _, _, [], 3, 0).
food1(fullFatMilk, 3.3, 4.6, 3.7, 1, _, _, _, [], 2, 0).
food1(fullFatMilk, 3.3, 4.6, 3.7, 2, _, _, _, [], 2, 0).
food1(fullFatMilk, 3.3, 4.6, 3.7, 3, _, _, _, [], 2, 0).
food1(fullFatMilk, 3.3, 4.6, 3.7, 4, _, _, _, [], 2, 0).
food1(fullFatMilk, 3.3, 4.6, 3.7, 5, _, _, _, [], 2, 0).

food1(pear, 0.4, 15, 0.1, 1, _, _, _, [], 5, 0).
food1(pear, 0.4, 15, 0.1, 2, _, _, _, [], 5, 0).
food1(pear, 0.4, 15, 0.1, 3, _, _, _, [], 5, 0).
food1(pear, 0.4, 15, 0.1, 4, _, _, _, [], 5, 0).
food1(pear, 0.4, 15, 0.1, 5, _, _, _, [], 5, 0).
food1(tuna, 26, 0, 1, 2, _, _, _, [], 1, 0).
food1(tuna, 26, 0, 1, 3, _, _, _, [], 1, 0).
food1(tuna, 26, 0, 1, 4, _, _, _, [], 1, 0).
food1(tuna, 26, 0, 1, 5, _, _, _, [], 1, 0).
food1(tomato, 0.9, 3.9, 0.2, 1, _, _, _, [], 3, 0).
food1(tomato, 0.9, 3.9, 0.2, 2, _, _, _, [], 3, 0).
food1(tomato, 0.9, 3.9, 0.2, 3, _, _, _, [], 3, 0).
food1(tomato, 0.9, 3.9, 0.2, 4, _, _, _, [], 3, 0).
food1(tomato, 0.9, 3.9, 0.2, 5, _, _, _, [], 3, 0).
food1(honey,	0, 5, 0, 1, _, _, _, [], 5, 0).
food1(honey,	0, 5, 0, 2, _, _, _, [], 5, 0).
food1(honey,	0, 5, 0, 3, _, _, _, [], 5, 0).
food1(honey,	0, 5, 0, 4, _, _, _, [], 5, 0).
food1(honey,	0, 5, 0, 5, _, _, _, [], 5, 0).
food1(oliveOil, 0, 0, 5, 1, _, _, _, [], 5, 0).
food1(oliveOil, 0, 0, 5, 2, _, _, _, [], 5, 0).
food1(oliveOil, 0, 0, 5, 3, _, _, _, [], 5, 0).
food1(oliveOil, 0, 0, 5, 4, _, _, _, [], 5, 0).
food1(oliveOil, 0, 0, 5, 5, _, _, _, [], 5, 0).
food1(pasta, 13, 75, 1.5, 3, _, _, _, [], 4, 0).
food1(pasta, 13, 75, 1.5, 4, _, _, _, [], 4, 0).
food1(salmon, 20, 0, 13, 3, _, _, _, [], 1, 0).
food1(salmon, 20, 0, 13, 4, _, _, _, [], 1, 0).
food1(fish, 19, 0, 6, 3, _, _, _, [], 1, 0).
food1(fish, 19, 0, 6, 4, _, _, _, [], 1, 0).
food1(shrimp, 20, 0, 0.5, 3, _, _, _, [], 1, 0).
food1(shrimp, 20, 0, 0.5, 4, _, _, _, [], 1, 0).
food1(skimmedMilk, 3.4, 5, 0.1, 1, _, _, _, [], 2, 0).
food1(skimmedMilk, 3.4, 5, 0.1, 2, _, _, _, [], 2, 0).
food1(skimmedMilk, 3.4, 5, 0.1, 3, _, _, _, [], 2, 0).
food1(skimmedMilk, 3.4, 5, 0.1, 4, _, _, _, [], 2, 0).
food1(skimmedMilk, 3.4, 5, 0.1, 5, _, _, _, [], 2, 0).
food1(banana, 1.1, 23, 0.3, 1, _, _, _, [], 5, 0).
food1(banana, 1.1, 23, 0.3, 2, _, _, _, [], 5, 0).
food1(banana, 1.1, 23, 0.3, 3, _, _, _, [], 5, 0).
food1(banana, 1.1, 23, 0.3, 4, _, _, _, [], 5, 0).
food1(banana, 1.1, 23, 0.3, 5, _, _, _, [], 5, 0).
food1(chkBr, 21.2, 0, 2.5, 3, _, _, _, [], 1, 0).
food1(chkBr, 21.2, 0, 2.5, 4, _, _, _, [], 1, 0).
food1(lnBeef, 20, 0, 6, 3, _, _, _, [], 1, 0).
food1(lnBeef, 20, 0, 6, 4, _, _, _, [], 1, 0).
food1(peanutButter, 2.5, 2, 5, 1, _, _, _, [], 5, 0).
food1(peanutButter, 2.5, 2, 5, 2, _, _, _, [], 5, 0).
food1(peanutButter, 2.5, 2, 5, 3, _, _, _, [], 5, 0).
food1(peanutButter, 2.5, 2, 5, 4, _, _, _, [], 5, 0).
food1(peanutButter, 2.5, 2, 5, 5, _, _, _, [], 5, 0).
food1(wheyProtein, 80, 10, 3.3, 1, _, _, _, [], 1, 0).
food1(wheyProtein, 80, 10, 3.3, 2, _, _, _, [], 1, 0).
food1(wheyProtein, 80, 10, 3.3, 3, _, _, _, [], 1, 0).
food1(wheyProtein, 80, 10, 3.3, 4, _, _, _, [], 1, 0).
food1(wheyProtein, 80, 10, 3.3, 5, _, _, _, [], 1, 0).
food1(multiGrainBread, 13, 43, 4.2, 1, _, _, _, [], 4, 0).
food1(multiGrainBread, 13, 43, 4.2, 2, _, _, _, [], 4, 0).
food1(multiGrainBread, 13, 43, 4.2, 3, _, _, _, [], 4, 0).
food1(multiGrainBread, 13, 43, 4.2, 4, _, _, _, [], 4, 0).
food1(multiGrainBread, 13, 43, 4.2, 5, _, _, _, [], 4, 0).