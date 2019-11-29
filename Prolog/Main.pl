
% inicializa o jogo com titulo, runtime(0) e se sair da runtime, halt encerra o programa.

:-use_module('./src/Player.pl').
:-use_module('./src/Fronteiras.pl').
:-use_module('./src/BotOperations.pl').
:-use_module('./src/GameOperations.pl').
:-use_module('./src/PlayerOperations.pl').
:-use_module(library(tty)). % clear screen

:- include('./src/Util.pl').

:-initialization showTitle,configPlayers, main, halt.


%Exibe o titulo do jogo (title.txt)
showTitle :-
    open('title.txt', read, Str),
    read_file(Str,String),
    /*write('teste'),*/
    nl,
    close(Str),
    nl,
    showOnScreen(String).

%Exibe as opções de jogada
showOptions :-
    nl,nl,
    write('1) Alocar tropas'),nl,
    write('2) Realocar tropas existentes'),nl,
    write('3) Atacar'),nl,
    write('4) Encerrar jogada'),nl,
    write('5) Printar status do jogo'), nl,
    write('6) Encerrar jogo'), nl,
    read(Inp),
    optChoose(Inp).

% Exibir txt na tela
showOnScreen([H|T]):- 
    write(H),nl, 
    showOnScreen(T).

showOnScreen([H|[]]):-
    write(H),nl.

getInput(Inp) :-
    read(Inp),
    Inp is Inp.

allocateTroopsView:- 
    write('Insira a quantidade de tropas: '),
    read(Troops),
    write('Insira o nome do estado:'),
    read(State),
    write(State),
    allocateTroops("PLAYER", Troops, State),
    runtime(0).

reallocateTroopsView:-
    write('Insira a quantidade de tropas para realocar'), read(Quantity), nl,
    write('De onde deseja tirar?'), read(TerritoryToLoose), nl, 
    write('Aonde deseja colocar?'), read(TerritoryToWin), nl,
    playerReallocateTroops(Quantity, TerritoryToLoose, TerritoryToWin),
    runtime(0);
    write("Não foi possivel fazer a realocação. Estados não fazem fronteira"),
    runtime(0).

playerAttackView:-
    write('De que estado deseja atacar?'), read(Atacante),
    write('Qual estado deseja atacar?'), read(Defensor),
    playerAttack(Atacante, Defensor),
    runtime(0).    % volta pra runtime do user para que ele jogue novamente

printStatus:-
    nl,
    write('******************** Você: *****************'),nl,
    write('Quantidade de tropas disponivel: '), getPlayerTotalTroops("PLAYER",Troops),write(Troops),nl,
    write('Alagoas: '), getPlayerTotalStateTroops("PLAYER", "Alagoas", R),write(R), nl, 
    write('Bahia: ' ), getPlayerTotalStateTroops("PLAYER", "Bahia", R2),write(R2), nl,
    write('Ceara: ' ), getPlayerTotalStateTroops("PLAYER", "Ceara", R3),write(R3), nl,
    write('Maranhao :'), getPlayerTotalStateTroops("PLAYER", "Maranhao", R4),write(R4), nl,
    write('Paraiba :'), getPlayerTotalStateTroops("PLAYER", "Paraiba", R5),write(R5),nl,
    write('Pernambuco :'), getPlayerTotalStateTroops("PLAYER", "Pernambuco", R6),write(R6), nl,
    write('Piaui :'), getPlayerTotalStateTroops("PLAYER", "Piaui", R7),write(R7), nl,
    write('Rio Grande do Norte: '), getPlayerTotalStateTroops("PLAYER", "RioGrandeDoNorte", R8),write(R8),nl,
    write('Sergipe: '), getPlayerTotalStateTroops("PLAYER","Sergipe", R9),write(R9), nl,nl,nl,

    write('******************** Bot: *****************'),nl,
    write('Quantidade de tropas disponivel: '), getPlayerTotalTroops("BOT",Troops2), write(Troops2), nl,
    write('Alagoas: '), getPlayerTotalStateTroops("BOT", "Alagoas", R10),write(R10), nl, 
    write('Bahia: ' ), getPlayerTotalStateTroops("BOT", "Bahia", R11),write(R11), nl,
    write('Ceara: ' ), getPlayerTotalStateTroops("BOT", "Ceara", R12), write(R12), nl,
    write('Maranhao :'), getPlayerTotalStateTroops("BOT", "Maranhao", R13), write(R13), nl,
    write('Paraiba :'), getPlayerTotalStateTroops("BOT", "Paraiba", R14), write(R14), nl,
    write('Pernambuco :'), getPlayerTotalStateTroops("BOT", "Pernambuco", R15), write(R15), nl,
    write('Piaui :'), getPlayerTotalStateTroops("BOT", "Piaui", R16), write(R16), nl,
    write('Rio Grande do Norte: '), getPlayerTotalStateTroops("BOT", "RioGrandeDoNorte", R17), write(R17), nl,
    write('Sergipe: '), getPlayerTotalStateTroops("BOT","Sergipe", R18), write(R18), nl,nl,nl.

optChoose(1) :- allocateTroopsView.
optChoose(2) :- reallocateTroopsView.
optChoose(3) :- playerAttackView.
optChoose(4) :- write('Jogada do bot'), nl, runtime(1). % passa a vez pro bot.
optChoose(5) :- printStatus, write('Digite qualquer coisa para continuar'), showOptions.
optChoose(6) :- nl, write('Encerrando jogo!!!') , nl, finish.

optChoose(Num) :- 
    tty_clear, write('Erro de opcao! De enter em qualquer input').


/*
% Define quem irá jogar em seguida.
nextRound('bot'):- runtime('player').
nextRound('player'):- runtime('bot').
*/


main :- 
    runtime(0).

% 0 é o player humano
runtime(0) :- 
    showOptions,
    /*optChoose(getInput(Input)),*/
    runtime(1).

% runtime do bot(1)
runtime(1) :-
    botAllocateTroopsRandom,
    botAttack,
    runtime(0).

runtime(2):-
    finish.

finish :-
    halt.