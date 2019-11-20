:- use_module('player.pl').

:- module(playerOperations, [
    playerAttack/2,
    playerAllocateTerritory/1,
    playerReallocateTrooops/3
    ]).

%Metodo usado para o player atacar
playerAttack(Troops, Territory) :-
    write("TODO").

%Metodo para alocar um determinado Territorio para um player
playerAllocateTerritory(Territory) :-
    write("TODO").

% Metodo para mover tropas de um territorio para outro do player
playerReallocateTrooops(Quantity, TerritoryToLoose, TerritoryToWin) :-
    write("TODO").


