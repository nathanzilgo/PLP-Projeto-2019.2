

:- module(botOperations, [
        botAttack/2,
        botAddTroops/2,
        botGetAllTerritories/2,
        botAllocateTroopsRandom/0
        ]).
    /*
    :- use_module('Player.pl').
    */
    :- include('Player.pl').

    %Dado a ser usado nas funcoes necessarias
    dado(X) :- random(1,10,X).

    %Metodo usado para adicionar tropas em um estado manualmente   
    botAddTroops(Territory, Troops) :- 
        Territory =:= 1 -> getPlayerTotalStateTroops("BOT", "Alagoas", R), updateStateTroops("BOT", "Alagoas", R + Troops);
        Territory =:= 2 -> getPlayerTotalStateTroops("BOT", "Bahia", R), updateStateTroops("BOT", "Bahia", R + Troops);
        Territory =:= 3 -> getPlayerTotalStateTroops("BOT", "Ceara", R), updateStateTroops("BOT", "Ceara", R + Troops);
        Territory =:= 4 -> getPlayerTotalStateTroops("BOT", "Maranhao", R), updateStateTroops("BOT", "Maranhao", R + Troops);
        Territory =:= 5 -> getPlayerTotalStateTroops("BOT", "Paraiba", R), updateStateTroops("BOT", "Paraiba", R + Troops);
        Territory =:= 6 -> getPlayerTotalStateTroops("BOT", "Pernambuco", R), updateStateTroops("BOT", "Pernambuco", R + Troops);
        Territory =:= 7 -> getPlayerTotalStateTroops("BOT", "Piaui", R), updateStateTroops("BOT", "Piaui", R + Troops);
        Territory =:= 8 -> getPlayerTotalStateTroops("BOT", "RioGrandeDoNorte", R), updateStateTroops("BOT", "RioGrandeDoNorte", R + Troops);
        Territory =:= 9 -> getPlayerTotalStateTroops("BOT", "Sergipe", R), updateStateTroops("BOT", "Sergipe", R + Troops).

    % Metodo usado para pegar a quantidade de tropas de um estado manualmente
    botGetAllTerritories(Territory, Retorno) :-
        Territory =:= 1 -> getPlayerTotalStateTroops("BOT", "Alagoas", R), Retorno is R;
        Territory =:= 2 -> getPlayerTotalStateTroops("BOT", "Bahia", R), Retorno is R;
        Territory =:= 3 -> getPlayerTotalStateTroops("BOT", "Ceara", R), Retorno is R;
        Territory =:= 4 -> getPlayerTotalStateTroops("BOT", "Maranhao", R), Retorno is R;
        Territory =:= 5 -> getPlayerTotalStateTroops("BOT", "Paraiba", R), Retorno is R;
        Territory =:= 6 -> getPlayerTotalStateTroops("BOT", "Pernambuco", R), Retorno is R;
        Territory =:= 7 -> getPlayerTotalStateTroops("BOT", "Piaui", R), Retorno is R;
        Territory =:= 8 -> getPlayerTotalStateTroops("BOT", "RioGrandeDoNorte", R), Retorno is R;
        Territory =:= 9 -> getPlayerTotalStateTroops("BOT", "Sergipe", R), Retorno is R.

    % Metodo usado para alocar as tropas em um estado aleatoriamente (funcao de suporte)
    botAllocateTroopsRandomSupport(Territory, TotalTroops) :-
        botGetAllTerritories(Territory, TroopsTerritory), 
        TroopsTerritory > 0, TotalTroops > 0 -> botAddTroops(Territory, TotalTroops), getPlayerTotalTroops("BOT", R), updateTotalTroops("BOT",R - TotalTroops);
        TotalTroops > 0 -> botAllocateTroopsRandom;
        halt(0).
    
    % Metodo usado para alocar as tropas em um estado aleatoriamente
    botAllocateTroopsRandom :-
        dado(X), 
        getPlayerTotalTroops("BOT", Troops),
        Troops > 0 ->
        botAllocateTroopsRandomSupport(X, Troops);
        halt(0).
        
    %Metodo usado para o BOT atacar
    botAttack(Troops, Territory) :-
        write("TODO").
    
    