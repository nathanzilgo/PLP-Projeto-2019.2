
:- module(playerOperations, [
    playerAllocateTerritory/1,
    playerReallocateTrooops/3
    ]).

:- use_module('player.pl').

%Metodo usado para o player atacar
playerAttack(Troops, Territory) :-
    write("TODO").

%Metodo para alocar um determinado Territorio para um player
playerAllocateTerritory(Territory) :-
    updateStateTroops("PLAYER", Territory, 1).

% Metodo para mover tropas de um territorio para outro do player
playerReallocateTrooops(Quantity, TerritoryToLoose, TerritoryToWin) :-
    getPlayerTotalStateTroops("PLAYER", TerritoryToLoose, R),
    R > Quantity,
    updateStateTroops("PLAYER", TerritoryToLoose, Quantity),
    updateStateTroops("PLAYER", TerritoryToWin, Quantity).
    



