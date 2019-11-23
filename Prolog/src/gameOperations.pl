:- module(gameOperations, [
        alocateTroops/3,
        playerAttack/3,
        botAttack/3
        ]).

:- use_module('player.pl').
:- use_module('playerOperations.pl').
:- use_module('botOperations.pl').

% Aloca Tropas em um determinado Estado
alocateTroops(Id, Troops, State) :-
    getPlayerTotalTroops(Id, R),
    R >=Troops,
    updateTotalTroops(Id, -Troops),
    getPlayerTotalStateTroops(Id, State, R1),
    NewTroops is R1 + Troops,
    updateStateTroops(Id, State, NewTroops).
