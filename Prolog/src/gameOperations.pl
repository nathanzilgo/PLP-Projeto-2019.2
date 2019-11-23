:- module(gameOperations, [
        alocateTroops/3,
        playerAttack/2,
        botAttack/3
        ]).

:- use_module('player.pl').
:- use_module('playerOperations.pl').
:- use_module('botOperations.pl').

%Dado a ser usado nas funcoes necessarias
 dadoAttack(R) :- random(1,6,R).

% Aloca Tropas em um determinado Estado
alocateTroops(Id, Troops, State) :-
    getPlayerTotalTroops(Id, R),
    R >=Troops,
    getPlayerTotalStateTroops(Id, State, R1),
    R1 >= 1,
    updateTotalTroops(Id, -Troops),
    getPlayerTotalStateTroops(Id, State, R2),
    NewTroops is R2 + Troops,
    updateStateTroops(Id, State, NewTroops).

% Metodo usado para o ataque do player.
playerAttack(AttackingTerritory, DefendingTerritory) :-
    getPlayerTotalStateTroops("PLAYER", AttackingTerritory, R1),
    R1 > 1,
    getPlayerTotalStateTroops("BOT", DefendingTerritory, R2),
    R2 >= 1,
    dadoAttack(R3),
    dadoAttack(R4),
    AttackingDado is R3,
    DefendingDado is R4,
    AttackingDado > DefendingDado,
    getPlayerTotalStateTroops("BOT", DefendingTerritory, R5),
    NewBotTroops is R5 - 1,
    updateStateTroops("BOT", DefendingTerritory, NewBotTroops),
    botLooseTerritory(DefendingTerritory).

% Metodo usado caso o bot tenha perdido o territorio por completo.
botLooseTerritory(DefendingTerritory) :-
    getPlayerTotalStateTroops("BOT", DefendingTerritory, R),
    R =:= 0,
    playerAllocateTerritory(DefendingTerritory).
