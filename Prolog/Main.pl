:- initialization showTitle, main(0), halt.
% inicializa o jogo com titulo, main(0) e se sair da main, halt encerra o programa.
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
    write('4) Encerrar jogada'),nl,
    write('5) Printar status do jogo'), nl,
    write('6) Encerrar jogo'), nl.

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

reallocateTroopsView(Quantity, TerritoryToLoose, TerritoryToWin):-
    write('Insira a quantidade de tropas para realocar'), read(Quantity),
    write('De onde deseja tirar?'), read(TerritoryToLoose),
    write('Aonde deseja colocar?'), read(TerritoryToWin),
    playerReallocateTroops(Quantity, TerritoryToLoose, TerritoryToWin).

playerAttackView(Atacante, Defensor):-
    write('De que estado deseja atacar?'), read(Atacante),
    write('Qual estado deseja atacar?'), read(Defensor),
    playerAttack(Atacante, Defensor).

optChosse(1, Call) :- Call is allocateTroopsView(_,_,_).
optChosse(2, Call) :- Call is reallocateTroopsView(_,_,_).
optChoose(3, Call) :- Call is playerAttackView(_,_).
optChoose(4, Call) :- Call is nextRound().

% Define quem irá jogar em seguida.
nextRound('bot'):- main('player').
nextRound('player'):- main('bot').

% 0 é o player humano
main(0) :- 
    showTitle(),
    showOptions,
    getInput(Inp, Retorno),
    main.

% main do bot(1)
main(1) :- 
    showOptions,
    getInput(Inp, Retorno),
    main.