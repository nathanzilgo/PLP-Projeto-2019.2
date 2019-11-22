:- module(botOperations, [
        botAttack/2,
        botReallocateTrooops/3,
        botAddTroops/2,
        botRemoveTroops/2,
        botGetAllTerritories/2,
        botAllocateTroopsRandomSupport/2,
        botAllocateTroopsRandom/0,
        botAllocateTroopsRandom/0
        ]).
    
    :- use_module('player.pl').

    %Dado a ser usado nas funcoes necessarias
    dado(X) :- random(1,10,X).

    %Metodo usado para adicionar tropas em um estado manualmente   
    botAddTroops(Territory, Troops) :- 
        Territory =:= 1 -> setPlayerAlagoas("BOT", Troops, NewValue);
        Territory =:= 2 -> setPlayerBahia("BOT", Troops, NewValue);
        Territory =:= 3 -> setPlayerCeara("BOT", Troops, NewValue);
        Territory =:= 4 -> setPlayerMaranhao("BOT", Troops, NewValue);
        Territory =:= 5 -> setPlayerParaiba("BOT", Troops, NewValue);
        Territory =:= 6 -> setPlayerPernambuco("BOT", Troops, NewValue);
        Territory =:= 7 -> setPlayerPiaui("BOT", Troops, NewValue);
        Territory =:= 8 -> setPlayerRioGrandeDoNorte("BOT", Troops, NewValue);
        Territory =:= 9 -> setPlayerSergipe("BOT", Troops, NewValue).

    %Metodo usado para remover tropas de um estado manualmente
    botRemoveTroops(Territory, Troops) :- 
        Territory =:= 1 -> setPlayerAlagoas("BOT", Troops * -1, NewValue);
        Territory =:= 2 -> setPlayerBahia("BOT", Troops * -1, NewValue);
        Territory =:= 3 -> setPlayerCeara("BOT", Troops * -1, NewValue);
        Territory =:= 4 -> setPlayerMaranhao("BOT", Troops * -1, NewValue);
        Territory =:= 5 -> setPlayerParaiba("BOT", Troops * -1, NewValue);
        Territory =:= 6 -> setPlayerPernambuco("BOT", Troops * -1, NewValue);
        Territory =:= 7 -> setPlayerPiaui("BOT", Troops * -1, NewValue);
        Territory =:= 8 -> setPlayerRioGrandeDoNorte("BOT", Troops * -1, NewValue);
        Territory =:= 9 -> setPlayerSergipe("BOT", Troops * -1, NewValue).

    % Metodo usado para pegar a quantidade de tropas de um estado manualmente
    botGetAllTerritories(Territory, Retorno) :-
        Territory =:= 1 -> getPlayerAlagoas("BOT", Alagoas), Retorno is Alagoas;
        Territory =:= 2 -> getPlayerBahia("BOT", Bahia), Retorno is Bahia;
        Territory =:= 3 -> getPlayerCeara("BOT", Ceara), Retorno is Ceara;
        Territory =:= 4 -> getPlayerMaranhao("BOT", Maranhao), Retorno is Maranhao;
        Territory =:= 5 -> getPlayerParaiba("BOT", Paraiba), Retorno is Paraiba;
        Territory =:= 6 -> getPlayerPernambuco("BOT", Pernambuco), Retorno is Pernambuco;
        Territory =:= 7 -> getPlayerPiaui("BOT", Piaui), Retorno is Piaui;
        Territory =:= 8 -> getPlayerRioGrandeDoNorte("BOT", RioGrandeDoNorte), Retorno is RioGrandeDoNorte;
        Territory =:= 9 -> getPlayerSergipe("BOT", Sergipe), Retorno is Sergipe.

    % Metodo usado para alocar as tropas em um estado aleatoriamente (funcao de suporte)
    botAllocateTroopsRandomSupport(Territory, TotalTroops) :-
        botGetAllTerritories(Territory, TroopsTerritory), 
        TroopsTerritory > 0, TotalTroops > 0 -> botAddTroops(Territory, TotalTroops), setPlayerTotalTroops("BOT", TotalTroops * -1, NewValue);
        TotalTroops > 0 -> botAllocateTroopsRandom;
        halt(0).
    
    % Metodo usado para alocar as tropas em um estado aleatoriamente
    botAllocateTroopsRandom :-
        dado(X), 
        getPlayerTroops("BOT", Troops),
        Troops > 0 ->
        botAllocateTroopsRandomSupport(X, Troops);
        halt(0).
        
    %Metodo usado para o BOT atacar
    botAttack(Troops, Territory) :-
        write("TODO").
    
    % Metodo para mover tropas de um territorio para outro territorio de um BOT
    botReallocateTrooops(Quantity, TerritoryToLoose, TerritoryToWin) :-
        write("TODO").
    
    
    