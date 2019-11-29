:- module(botOperations, [
        botAllocateTroopsRandomSupport/2,
        dadoRandom/1,
        checkAttack/2,
        checkDices/6
        ]).
    
    :- use_module('player.pl').
    :- use_module('fronteiras.pl').

    %dadoRandom a ser usado nas funcoes necessarias
    dadoRandom(X) :- random(1,10,X).

    %Metodo usado para adicionar tropas em um estado de acordo com o numero que saiu no random   
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

    % Metodo usado para pegar a quantidade de tropas de um estado de acordo com o numero que saiu no random
    botGetTerritoriesTroops(Territory, Retorno) :-
        Territory =:= 1 -> getPlayerTotalStateTroops("BOT", "Alagoas", R), Retorno is R;
        Territory =:= 2 -> getPlayerTotalStateTroops("BOT", "Bahia", R), Retorno is R;
        Territory =:= 3 -> getPlayerTotalStateTroops("BOT", "Ceara", R), Retorno is R;
        Territory =:= 4 -> getPlayerTotalStateTroops("BOT", "Maranhao", R), Retorno is R;
        Territory =:= 5 -> getPlayerTotalStateTroops("BOT", "Paraiba", R), Retorno is R;
        Territory =:= 6 -> getPlayerTotalStateTroops("BOT", "Pernambuco", R), Retorno is R;
        Territory =:= 7 -> getPlayerTotalStateTroops("BOT", "Piaui", R), Retorno is R;
        Territory =:= 8 -> getPlayerTotalStateTroops("BOT", "RioGrandeDoNorte", R), Retorno is R;
        Territory =:= 9 -> getPlayerTotalStateTroops("BOT", "Sergipe", R), Retorno is R.

    % Metodo para pegar o nome de um territorio de acordo com o numero que saiu no random
    botGetTerritoriesNames(Territory, Retorno) :-
        Territory =:= 1 -> Retorno = "Alagoas";
        Territory =:= 2 -> Retorno = "Bahia";
        Territory =:= 3 -> Retorno = "Ceara";
        Territory =:= 4 -> Retorno = "Maranhao";
        Territory =:= 5 -> Retorno = "Paraiba";
        Territory =:= 6 -> Retorno = "Pernambuco";
        Territory =:= 7 -> Retorno = "Piaui";
        Territory =:= 8 -> Retorno = "RioGrandeDoNorte";
        Territory =:= 9 -> Retorno = "Sergipe".

    % Metodo usado para alocar as tropas em um estado aleatoriamente (funcao de suporte)
    botAllocateTroopsRandomSupport(Territory, TotalTroops) :-
        botGetTerritoriesTroops(Territory, TroopsTerritory), 
        TroopsTerritory > 0, TotalTroops > 0 -> botAddTroops(Territory, TotalTroops), getPlayerTotalTroops("BOT", R), updateTotalTroops("BOT",R - TotalTroops);
        TotalTroops > 0 -> botAllocateTroopsRandom;
        halt(0).

    % Metodo para escolher um estado atacante (do bot) randomicamente
    chooseAttackTerritory(AttackTerritory) :-
        dadoRandom(X),
        botGetTerritoriesTroops(X, Retorno),
        Retorno >= 1 -> AttackTerritory is X;
        chooseAttackTerritory(AttackTerritory).

    % Metodo para escolher um estado de defesa (do player) randomicamente 
    chooseDefenseTerritory(DefenseTerritory) :-
        dadoRandom(X),
        botGetTerritoriesTroops(X, Retorno),
        Retorno == 0 -> DefenseTerritory is X;
        chooseDefenseTerritory(DefenseTerritory).

    % Metodo que verifica se as tropas do estado de ataque sao maiores ou iguais que as tropas do estado de defesa
    checkTroops(AttackTerritory, DefenseTerritory) :-
        getPlayerTotalStateTroops("BOT", AttackTerritory, R1),
        getPlayerTotalStateTroops("PLAYER", DefenseTerritory, R2),
        R1 >= R2.

    % Metodo que verifica se o ataque eh possivel, verificando a quantidade de tropas de cada um e se sao fronteiras
    checkAttack(Attack, Defense) :-
        chooseAttackTerritory(AttackTerritory),
        chooseDefenseTerritory(DefenseTerritory),
        botGetTerritoriesNames(AttackTerritory, AttackTerritoryName),
        botGetTerritoriesNames(DefenseTerritory, DefenseTerritoryName),
        checkTroops(AttackTerritoryName, DefenseTerritoryName),
        frontier(AttackTerritoryName, DefenseTerritoryName) -> Attack is AttackTerritoryName, Defense is DefenseTerritoryName;
        checkAttack(Attack, Defense).

    % Metodo que checa o valor dos dados e faz as operaçoes necessaria caso o ataque ganhe ou a defesa ganhe
    checkDices(R1, R2, AttackTerritory, AttackTerritoryTroops, DefenseTerritory, DefenseTerritoryTroops) :-
        R1 > R2 -> updateStateTroops("PLAYER", DefenseTerritory, DefenseTerritoryTroops - 1), 
        moveTroops(AttackTerritory, AttackTerritoryTroops, DefenseTerritory, DefenseTerritoryTroops - 1);
        updateStateTroops("BOT", AttackTerritory, AttackTerritoryTroops - 1).

    % Metodo que move as tropas caso o ataque tenha ganhado o territorio da defesa
    moveTroops(AttackTerritory, AttackTerritoryTroops, DefenseTerritory, DefenseTerritoryTroops) :-
        DefenseTerritoryTroops =:= 0 -> 
        updateStateTroops("PLAYER", DefenseTerritory, AttackTerritoryTroops // 2),
        updateStateTroops("BOT", AttackTerritory, AttackTerritoryTroops - (AttackTerritoryTroops // 2));
        halt(0).

    
    



       






    