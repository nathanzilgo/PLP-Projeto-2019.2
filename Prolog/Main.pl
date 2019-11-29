
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
    optChosse(Inp).

% Exibir txt na tela
showOnScreen([H|T]):- 
    write(H),nl, 
    showOnScreen(T).

showOnScreen([H|[]]):-
    write(H),nl.

getInput(Inp) :-
    read(Inp),
    Inp is Inp.

allocateTroopsView(Id, Troops, State):- 
    write('Insira a quantidade de tropas: '),read(Troops),
    write('Insira o nome do estado:'),read(State),
    allocateTroops(Id, Troops, State),
    runtime(0).

reallocateTroopsView(Quantity, TerritoryToLoose, TerritoryToWin):-
    write('Insira a quantidade de tropas para realocar'), read(Quantity),
    write('De onde deseja tirar?'), read(TerritoryToLoose),
    write('Aonde deseja colocar?'), read(TerritoryToWin),
    playerReallocateTroops(Quantity, TerritoryToLoose, TerritoryToWin),
    runtime(0).

playerAttackView(Atacante, Defensor):-
    write('De que estado deseja atacar?'), read(Atacante),
    write('Qual estado deseja atacar?'), read(Defensor),
    playerAttack(Atacante, Defensor),
    runtime(0).    % volta pra runtime do user para que ele jogue novamente

printStatus:-
    nl,
    write(' Você: '),nl,
    write('Quantidade de tropas disponivel'), getPlayerTotalTroops("PLAYER",Troops),nl,
    write('Alagoas: '), getPlayerStateTroops("PLAYER", "Alagoas", R), nl, 
    write('Bahia: ' ), getPlayerStateTroops("PLAYER", "Bahia", R), nl,
    write('Ceara: ' ), getPlayerStateTroops("PLAYER", "Ceara", R), nl,
    write('Maranhao :'), getPlayerStateTroops("PLAYER", "Maranhao", R), nl,
    write('Paraiba :'), getPlayerStateTroops("PLAYER", "Paraiba", R),nl,
    write('Pernambuco :'), getPlayerStateTroops("PLAYER", "Pernambuco", R), nl,
    write('Piaui :'), getPlayerStateTroops("PLAYER", "Piaui", R), nl,
    write('Rio Grande do Norte: '), getPlayerStateTroops("PLAYER", "RioGrandeDoNorte", R),nl,
    write('Sergipe: '), getPlayerStateTroops("PLAYER","Sergipe", R), nl,nl,nl,
    write('******************** Bot: *****************'),nl,
    
    write('******************** Você: *****************'),nl,
    write('Quantidade de tropas disponivel: '), getPlayerTotalTroops("BOT",Troops),nl,
    write('Alagoas: '), getPlayerStateTroops("BOT", "Alagoas", R), nl, 
    write('Bahia: ' ), getPlayerStateTroops("BOT", "Bahia", R), nl,
    write('Ceara: ' ), getPlayerStateTroops("BOT", "Ceara", R), nl,
    write('Maranhao :'), getPlayerStateTroops("BOT", "Maranhao", R), nl,
    write('Paraiba :'), getPlayerStateTroops("BOT", "Paraiba", R),nl,
    write('Pernambuco :'), getPlayerStateTroops("BOT", "Pernambuco", R), nl,
    write('Piaui :'), getPlayerStateTroops("BOT", "Piaui", R), nl,
    write('Rio Grande do Norte: '), getPlayerStateTroops("BOT", "RioGrandeDoNorte", R),nl,
    write('Sergipe: '), getPlayerStateTroops("BOT","Sergipe", R), nl,nl,nl.

optChosse(1) :- allocateTroopsView("PLAYER",_,_).
optChosse(2) :- reallocateTroopsView("PLAYER",_,_).
optChoose(3) :- playerAttackView(_,_).
optChoose(4) :- write('Jogada do bot'), nl, tty_clear, runtime(1). % passa a vez pro bot.
optChoose(5) :- printStatus, write('Digite qualquer coisa para continuar'), sleep(10000), tty_clear, showOptions.
optChoose(6) :- nl, write('Encerrando jogo!!!') , nl, finish.

optChosse(Num) :- ((Num > 6) -> write('Erro de opcao! De enter em qualquer input'), sleep(10000), tty_clear, showOptions ; optChosse(Num)).
optChosse(OtherNum) :- ((OtherNum < 1) -> write('Erro de opcao! De enter em qualquer input'), sleep(1000), tty_clear, showOptions ; optChosse(Num)).

botOpt(1) :- botAllocateTroopsRandom, runtime(1).
botOpt(2) :- botAttack("TODO", "TODO"), runtime(1). % TODO: Método incompleto em BotOperations
botOpt(3) :- runtime(0). % Encerra runtime do bot e volta pra runtime do player
botOpt(_) :- runtime(1).

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
    botOpt(random(1,3)), % Escolhe o que fazer aleatoriamente
    runtime(0).

runtime(2):-
    finish.

finish :-
    halt.