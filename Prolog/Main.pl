:- initialization main, halt.

/*
:- module(main, [
    showTitle,
    showOptions,
    showOnScreen/1,
    getInput/2,
    allocateTroopsView/3,
    optChosse/2
]).
*/
:- include('./src/Player.pl').
:- include('./src/PlayerOperations.pl').
:- include('./src/BotOperations.pl').
:- include('./src/GameOperations.pl').
:- include('./src/Util.pl').

inputOpt(1) :- playerAllocateTerritory("todo").
inputOpt(2) :- playerReallocateTrooops(0, 0, 0). %TODO
inputOpt(3) :- playerAttack(0, 0). %TODO
inputOpt(4) :- playRound(2). %TODO

%Exibe o titulo do jogo (title.txt)
showTitle :-
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

getInput(Inp, Retorno) :-
    read(Inp),
    Retorno is Inp.

allocateTroopsView(Id, Troops, State):- 
    write('Insira a quantidade de tropas: '),read(Troops),
    write('Insira o nome do estado:'),read(State),
    allocateTroops(Id, Troops, State).


optChosse(1, Call) :- Call is allocateTroops(Id, Territory).
optChosse(2, Call) :- Call is playerAllocateTerritory(Territory).

main :- 
    showTitle(),
    showOptions,
    getInput(Inp, Retorno).


