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
    allocateTroops(Id, Troops, State),
    main(0).

reallocateTroopsView(Quantity, TerritoryToLoose, TerritoryToWin):-
    write('Insira a quantidade de tropas para realocar'), read(Quantity),
    write('De onde deseja tirar?'), read(TerritoryToLoose),
    write('Aonde deseja colocar?'), read(TerritoryToWin),
    playerReallocateTroops(Quantity, TerritoryToLoose, TerritoryToWin),
    main(0).

playerAttackView(Atacante, Defensor):-
    write('De que estado deseja atacar?'), read(Atacante),
    write('Qual estado deseja atacar?'), read(Defensor),
    playerAttack(Atacante, Defensor),
    main(0).    % volta pra main do user para que ele jogue novamente

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
optChoose(4) :- main(1). % passa a vez pro bot.
optChoose(5) :- printStatus, main(1).

botOpt(1) :- botAllocateTroopsRandom, main(1).
botOpt(2) :- botAttack("TODO", "TODO"), main(1). % TODO: Método incompleto em BotOperations
botOpt(3) :- main(0). % Encerra main do bot e volta pra main do player

% Define quem irá jogar em seguida.
nextRound('bot'):- main('player').
nextRound('player'):- main('bot').

% 0 é o player humano
main(0) :- 
    showTitle(),
    showOptions,
    optChoose(getInput(_,_)),
    main(1),
    halt.

% main do bot(1)
main(1) :- 
    showBotOptions,
    botOpt(random(1,3)), % Escolhe o que fazer aleatoriamente
    main(0),
    halt.