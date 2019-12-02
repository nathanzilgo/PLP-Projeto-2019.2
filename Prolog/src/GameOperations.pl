:- module(gameOperations, [
    allocateTroops/3,
    playerAttack/2,
    winCheck/1,
    botAllocateTroopsRandom/0
    ]).

:- use_module('Player.pl').
:- use_module('PlayerOperations.pl').
:- use_module('BotOperations.pl').
:- use_module('Fronteiras.pl').

%Dado a ser usado nas funcoes necessarias
dadoAttack(R) :- random(1,6,R).

% Aloca Tropas em um determinado Estado
allocateTroops(Id, Troops, State) :-
    getPlayerTotalTroops(Id, R),
    R >=Troops,
    getPlayerTotalStateTroops(Id, State, R1),
    R1 >= 1,
    updateTotalTroops(Id, -Troops),
    getPlayerTotalStateTroops(Id, State, R2),
    NewTroops is R2 + Troops,
    updateStateTroops(Id, State, NewTroops).

% Metodo usado para alocar as tropas do bot em um estado aleatoriamente
botAllocateTroopsRandom :-

dadoRandom(X), 
getPlayerTotalTroops("BOT", Troops),
Troops > 0 ->
botAllocateTroopsRandomSupport(X, Troops);
updateTotalTroops("BOT", 0). 

% Metodo usado para o ataque do player.
playerAttack(AttackingTerritory, DefendingTerritory) :-
frontier(AttackingTerritory, DefendingTerritory),
frontier(DefendingTerritory, AttackingTerritory),
getPlayerTotalStateTroops("PLAYER", AttackingTerritory, R1),
R1 > 1,
getPlayerTotalStateTroops("BOT", DefendingTerritory, R2),
R2 >= 1,
dadoAttack(R3),
dadoAttack(R4),
AttackingDado is R3,
DefendingDado is R4,
AttackingDado > DefendingDado ->  playerAttackBotLosesAttack(DefendingTerritory, AttackingTerritory);
playerAttackPlayerLosesAttack(AttackingTerritory).


playerAttackPlayerLosesAttack(AttackingTerritory):-
    getPlayerTotalStateTroops("PLAYER", AttackingTerritory, R),
    R > 1,
    NewPlayerTroops is R - 1,
    updateStateTroops("PLAYER", AttackingTerritory, NewPlayerTroops).



playerAttackBotLosesAttack(DefendingTerritory, AttackingTerritory) :-
    getPlayerTotalStateTroops("BOT", DefendingTerritory, R5),
    NewBotTroops is R5 - 1,
    updateStateTroops("BOT", DefendingTerritory, NewBotTroops),
    botLooseTerritory(DefendingTerritory, AttackingTerritory).



% Metodo usado caso o bot tenha perdido o territorio por completo.
% Metodo usado caso o bot tenha perdido o territorio por completo.
botLooseTerritory(DefendingTerritory, AttackingTerritory) :-
    getPlayerTotalStateTroops("BOT", DefendingTerritory, R),
    R =:= 0,
    getPlayerTotalStateTroops("PLAYER", AttackingTerritory, R2),
    NewPlayerAttackTerritoryTroops is R2 - 1,
    updateStateTroops("PLAYER", AttackingTerritory, NewPlayerAttackTerritoryTroops),
    playerAllocateTerritory(DefendingTerritory).

winCheck("BOT") :-
    getPlayerTotalStateTroops("BOT", "Alagoas", R1),
    R1 >= 1,
    getPlayerTotalStateTroops("BOT","Bahia", R2),
    R2 >= 1,
    getPlayerTotalStateTroops("BOT", "Ceara", R3),
    R3 >= 1,
    getPlayerTotalStateTroops("BOT", "Maranhao", R4),
    R4 >= 1,
    getPlayerTotalStateTroops("BOT", "Paraiba", R5),
    R5 >= 1,
    getPlayerTotalStateTroops("BOT", "Pernambuco", R6),
    R6 >= 1,
    getPlayerTotalStateTroops("BOT", "Piaui", R7),
    R7 >= 1,
    getPlayerTotalStateTroops("BOT", "RioGrandeDoNorte", R8),
    R8 >= 1,
    getPlayerTotalStateTroops("BOT", "Sergipe", R9),
    R9 >= 1.


winCheck("PLAYER") :-
getPlayerTotalStateTroops("PLAYER", "Alagoas", R1),
R1 >= 1,
getPlayerTotalStateTroops("PLAYER","Bahia", R2),
R2 >= 1,
getPlayerTotalStateTroops("PLAYER", "Ceara", R3),
R3 >= 1,
getPlayerTotalStateTroops("PLAYER", "Maranhao", R4),
R4 >= 1,
getPlayerTotalStateTroops("PLAYER", "Paraiba", R5),
R5 >= 1,
getPlayerTotalStateTroops("PLAYER", "Pernambuco", R6),
R6 >= 1,
getPlayerTotalStateTroops("PLAYER", "Piaui", R7),
R7 >= 1,
getPlayerTotalStateTroops("PLAYER", "RioGrandeDoNorte", R8),
R8 >= 1,
getPlayerTotalStateTroops("PLAYER", "Sergipe", R9),
R9 >= 1.

% Metodo usado para alocar as tropas em um estado aleatoriamente (funcao de suporte)
botAllocateTroopsRandomSupport(Territory, TotalTroops) :-
    botGetTerritoriesTroops(Territory, TroopsTerritory), 
    TroopsTerritory > 0, TotalTroops > 0 -> botAddTroops(Territory, TotalTroops), updateTotalTroops("BOT",-TotalTroops);
    TotalTroops > 0 -> botAllocateTroopsRandom;
    updateTotalTroops("BOT",0). 
