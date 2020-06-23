%Game is played by calling the main. predicate.
%After calling the main predicate, program will ask the user to enter 1 or 2 depending on the operation user wants to accomplish.
%If user wants to turn 2 cards, user will press 1. then user will be asked the row and column indexes of the cards that user wants to turn over.
%Input will be received one by one and in the following format:

%| ?- main.
%Please select the operation you want to do.
%1)Try flipping 2 cards.
%2)Display found cards.1.
%Please select the first cards row
%1.
%Please select the first cards column
%1.
%Please select the second cards row
%1.
%Please select the second cards column
%1.

%After program calculates the output, user will be greeted with the same main menu again. 


:- dynamic(found/3).
:- dynamic(location/3).
location(1,1,book).
location(1,2,pen).
location(1,3,pencil).
location(1,4,map).
location(2,1,book).
location(2,2,pen).
location(2,3,pencil).
location(2,4,map).
location(3,1,computer).
location(3,2,bookcase).
location(3,3,file).
location(3,4,paperclip).
location(4,1,computer).
location(4,2,bookcase).
location(4,3,file).
location(4,4,paperclip).

% These facts are the locations of the items in the following format: location(row_index, column_index, item_name). User can add more locations but user must make sure that there is a pair for every newly added pair.
% The reason why location and found are specified as dynamics is after the user matches a pair of cards, program removes the location facts of the found cards from the factbase and adds 2 found facts to the database.
% After we add-remove these facts, it becomes easier to display the matched cards and to check the game over condition, which is if there exists a location fact, game continues, if there is not a location fact in the factbase, game ends meaning that user can not find any more matches.
% For simplicity the location facts are matched with (1,1 - 2,1),(1,2 - 2,2), (1,3 - 2,3), (1,4 - 2,4) and same format for 3-4 location facts.

increment(X, X1) :- 
    X1 is X+1.
%This increment increases incorrect turns when user can not find a correct pair, tries to match the same cards, tries to match a card that has been matched or if it has not been included in the factbase at the first time.
	
		
correct(A,B,C,D) :- location(A,B,X), location(C,D,Y), X == Y. %
% Correct fact checks if the given 2 locations have the same item. A and C represent row_indexes, B and D represent column_indexes,X and Y represent item_names. If X and Y are same, this fact is true.

same(A,B,C,D) :- location(A,B,X), location(C,D,Y), X == Y, \+(A = C); \+(B = D).
% In the same fact, it checks if the given 2 locations have the same item AND if they do not have the same indexes. A and C represent row_indexes, B and D represent column_indexes,X and Y represent item_names. If X and Y are same AND (A and C are different) or (B and D are different) then this fact is true.

operation(A,B,C,D,E):- (location(A,B,X) , location(C,D,Y) -> 
						% if the locations exists in the factbase
						(same(A,B,C,D) -> % if they have the same item_name in their locations
							(correct(A,B,C,D) -> 
							% if they do not have the same indexes
								nl,write('Correct pair!'),write(' You found '),write(X),write(' at '),write(A),write(','),write(B),write('.'),nl,
								write('And '), write('you found '),write(Y),write(' at '),write(C),write(','),write(D),nl,write('Incorrect turns:'),write(E),nl,
								retract(location(A,B,X)), retract(location(C,D,Y)), asserta(found(A,B,X)), asserta(found(C,D,Y)),(\+ location(K,L,M) -> nl,gameover(E),nl,nl,abort;
								main(E));
								% After user correctly fins a pair of cards, program removes the items' location facts from the factbase and adds items' found facts to the factbase.
								nl,write('Incorrect pair!'),write(' You found '),write(X),write(' at '),write(A),write(','),write(B),write('.'),nl,
								write('And '),write('you found '),write(Y),write(' at '),write(C),write(','),write(D),nl,increment(E,F), write('Incorrect turns:'),write(F),nl,nl),main(F);
								% Program increments the score in all three else statements(1 above and 2 below) because the score is the amount of incorrect turns user took.
							nl,write('You are trying to eliminate the same card, try again!.'),increment(E,F),nl, write('Incorrect turns:'),write(F),nl,nl,main(F),nl,nl);

							nl,write('One of the entered locations either does not exist or have been correctly paired. Try again!'),nl, write('Incorrect turn:'),increment(E,F),write(F),nl,main(F),nl,nl).

% Game over check is made here with the 'location(X,Y,Z)' statement, if there exists a location fact, then the game is not finished,
% if there is not a location fact then the game is finished and the program informs the user with the score amount.

				
displayinput:-
	(found(X,Y,Z) ->
		listing(found),nl,
		write('Listing all the found cards in the following format found(row_index, column_index, found_item)'),nl;
		nl,write('You have not matched any cards yet!')),nl,nl.
%displayinput displays the founded cards if the user found any matches, else it just states that user has to find a pair to make this option work.			


main :- 
	(\+ location(X,Y,Z) -> write('There is no cards on the table, please add some before starting the game.'),nl,abort;
		write('Welcome to the memory game.'),nl,
		write('In this game, there are 16 cards from indexes 1,1 to 4,4.'),nl,
		write('Your goal is to find all the same cards without making incorrect choices.'),nl,
		write('Game will finish after you found all 8 pairs. Good luck!'),nl,nl,
		write('Please select the operation you want to do.'), nl, write('1)Try flipping 2 cards.'),nl,
		write('2)Display found cards.'),nl,
		read(Choice),
		(Choice is 1 -> write('Please select the first cards row'),nl,
			read(A),
			write('Please select the first cards column'),nl,
			read(B),
			write('Please select the second cards row'),nl,
			read(C),
			write('Please select the second cards column'),nl,
			read(D),
			operation(A,B,C,D,0);
		(Choice is 2 -> displayinput,main(0);
		(nl,write('Please enter either 1. or 2.'),nl,main(E))))).
		
% We have 2 main functions because of the fact that, in the 'first' main, we initialize the score as 0 and then increment it in the upcoming calls to the main function.

	
gameover(E) :-
		write('Game over!'),nl,write('Final score: '), write(E),nl,
		write('Score is equal to the incorrect turns you took, so lower score is better.').
	
main(E) :- 
		write('There are 16 cards from indexes 1,1 to 4,4.'),nl,
		write('Please select the operation you want to do.'), nl, write('1)Try flipping 2 cards.'), nl, write('2)Display found cards.'),nl,
		read(Choice),
		(Choice is 1 -> write('Please select the first cards row'),nl,
			read(A),
			write('Please select the first cards column'),nl,
			read(B),
			write('Please select the second cards row'),nl,
			read(C),
			write('Please select the second cards column'),nl,
			read(D),
			operation(A,B,C,D,E);
		(Choice is 2 -> displayinput,main(E);
		(nl,write('Please enter either 1. or 2.'),nl,main(E)))).
