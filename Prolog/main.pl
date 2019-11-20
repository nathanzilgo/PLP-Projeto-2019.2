:- initialization main, halt.
:- include('./src/player.pl').
:- include('./src/playerOperations.pl').
:- include('./src/botOperations.pl').

inputOpt(1) :- playerAllocateTerritory("todo").
inputOpt(2) :- playerReallocateTrooops(0, 0, 0). %TODO
inputOpt(3) :- playerAttack(0, 0). %TODO
inputOpt(4) :- playRound(2). %TODO

%Exibe o titulo do jogo (title.txt)
showTitle() :-
    open('title.txt', read, Str),
    read_file(Str,String),
    close(Str),
    nl,nl,
    showOnScreen(String).

%Exibe as opções de jogada
showOptions :-
    nl,
    write('1) Alocar tropas'),nl,
    write('2) Realocar tropas existentes'),nl,
    write('3) Atacar'),nl,
    write('4) Encerrar jogada'),nl.

% Exibir txt na tela
showOnScreen([H|T]):- 
    write(H),nl, 
    showOnScreen(T).

playRound(Player) :-
    showOptions,
    inputOpt(getInput(_)).

getInput(Inp) :-
    read(Inp).

main :- 
    showTitle().


