:- module(botOperations, [
        botAttack/2,
        botReallocateTrooops/3,
        botAddTroops/2,
        botRemoveTroops/2,
        botAllocateTroopsRandom/0
        ]).
    
    :- use_module('player.pl').

    %Dado a ser usado nas funcoes necessarias
    dado(X) :- random(1,10,X).

    %Metodo usado para adicionar tropas em um estado manualmente   
    botAddTroops(Territory, Troops) :- 
        Territory == "alagoas" -> setPlayerAlagoas("BOT", Troops, NewValue);
        Territory == "bahia" -> setPlayerBahia("BOT", Troops, NewValue);
        Territory == "ceara" -> setPlayerCeara("BOT", Troops, NewValue);
        Territory == "maranhao" -> setPlayerMaranhao("BOT", Troops, NewValue);
        Territory == "paraiba" -> setPlayerParaiba("BOT", Troops, NewValue);
        Territory == "pernambuco" -> setPlayerPernambuco("BOT", Troops, NewValue);
        Territory == "piaui" -> setPlayerPiaui("BOT", Troops, NewValue);
        Territory == "rio grande do norte" -> setPlayerRioGrandeDoNorte("BOT", Troops, NewValue);
        Territory == "sergipe" -> setPlayerSergipe("BOT", Troops, NewValue).

    %Metodo usado para remover tropas de um estado manualmente
    botRemoveTroops(Territory, Troops) :- 
        Territory == "alagoas" -> setPlayerAlagoas("BOT", Troops * -1, NewValue);
        Territory == "bahia" -> setPlayerBahia("BOT", Troops * -1, NewValue);
        Territory == "ceara" -> setPlayerCeara("BOT", Troops * -1, NewValue);
        Territory == "maranhao" -> setPlayerMaranhao("BOT", Troops * -1, NewValue);
        Territory == "paraiba" -> setPlayerParaiba("BOT", Troops * -1, NewValue);
        Territory == "pernambuco" -> setPlayerPernambuco("BOT", Troops * -1, NewValue);
        Territory == "piaui" -> setPlayerPiaui("BOT", Troops * -1, NewValue);
        Territory == "rio grande do norte" -> setPlayerRioGrandeDoNorte("BOT", Troops * -1, NewValue);
        Territory == "sergipe" -> setPlayerSergipe("BOT", Troops * -1, NewValue).

    % Metodo para alocar tropas em um estado de forma aleatoria 
    % NAO FUNCIONA AINDA, NAO TESTEI DIREITO
    botAllocateTroopsRandom :-
        getPlayerAlagoas("BOT", Alagoas), Alagoas > 0, getPlayerTroops("BOT", Troops), Troops > 0, dado(X), X =:= 1 -> setPlayerAlagoas("BOT", Troops, NewValue);
        getPlayerBahia("BOT", Bahia), Bahia > 0, getPlayerTroops("BOT", Troops), Troops > 0, dado(X), X =:= 2 -> setPlayerBahia("BOT", Troops, NewValue);
        getPlayerCeara("BOT", Ceara), Ceara > 0, getPlayerTroops("BOT", Troops), Troops > 0, dado(X), X =:= 3 -> setPlayerCeara("BOT", Troops, NewValue);
        getPlayerMaranhao("BOT", Maranhao), Maranhao > 0, getPlayerTroops("BOT", Troops), Troops > 0, dado(X), X =:= 4 -> setPlayerMaranhao("BOT", Troops, NewValue);
        getPlayerParaiba("BOT", Paraiba), Paraiba > 0, getPlayerTroops("BOT", Troops), Troops > 0, dado(X), X =:= 5 -> setPlayerParaiba("BOT", Troops, NewValue);
        getPlayerPernambuco("BOT", Pernambuco), Pernambuco > 0, getPlayerTroops("BOT", Troops), Troops > 0, dado(X), X =:= 6 -> setPlayerPernambuco("BOT", Troops, NewValue);
        getPlayerPiaui("BOT", Piaui), Piaui > 0, getPlayerTroops("BOT", Troops), Troops > 0, dado(X), X =:= 7 -> setPlayerPiaui("BOT", Troops, NewValue);
        getPlayerRioGrandeDoNorte("BOT", RioGrandeDoNorte), RioGrandeDoNorte > 0, getPlayerTroops("BOT", Troops), Troops > 0, dado(X), X =:= 8 -> setPlayerRioGrandeDoNorte("BOT", Troops, NewValue);
        getPlayerSergipe("BOT", Sergipe), Sergipe > 0, getPlayerTroops("BOT", Troops), Troops > 0, dado(X), X =:= 9 -> setPlayerSergipe("BOT", Troops, NewValue).


    %Metodo usado para o BOT atacar
    botAttack(Troops, Territory) :-
        write("TODO").
    
    % Metodo para mover tropas de um territorio para outro territorio de um BOT
    botReallocateTrooops(Quantity, TerritoryToLoose, TerritoryToWin) :-
        write("TODO").
    
    
    