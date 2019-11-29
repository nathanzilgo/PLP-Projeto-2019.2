:- module(playerOperations, [
    playerAllocateTerritory/1,
    playerReallocateTroops/3
    ]).

:- use_module('Player.pl').
:- use_module('Fronteiras.pl').

%Metodo para alocar um determinado Territorio para um player
playerAllocateTerritory(Territory) :-
    getPlayerTotalStateTroops("BOT", Territory, R),
    R =:= 0,
    updateStateTroops("PLAYER", Territory, 1).

% Metodo para mover tropas de um territorio para outro do player
playerReallocateTroops(Quantity, TerritoryToLoose, TerritoryToWin) :-
    frontier(TerritoryToWin, TerritoryToLoose),
    getPlayerTotalStateTroops("PLAYER", TerritoryToLoose, R),
    getPlayerTotalStateTroops("PLAYER", TerritoryToWin, R2),
    R > 1,
    R2 >= 1,
    R > Quantity,
    NewLoosingTerritoriesTroops is R - Quantity,
    NewGainingTerritoriesTroops is R2 + Quantity,
    updateStateTroops("PLAYER", TerritoryToLoose, NewLoosingTerritoriesTroops),
    updateStateTroops("PLAYER", TerritoryToWin, NewGainingTerritoriesTroops).
    



