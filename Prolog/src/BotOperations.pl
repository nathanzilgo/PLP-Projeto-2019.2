:- module(botOperations, [
    dadoRandom/1,
    checkAttack/0,
    checkDices/6,
    botAddTroops/2,
    botGetTerritoriesTroops/2
    ]).

:- use_module('Player.pl').
:- use_module('Fronteiras.pl').

%dadoRandom a ser usado nas funcoes necessarias
dadoRandom(X) :- random(1,10,X).

dadoAttack(X) :- random(1, 7, X).

%Metodo usado para adicionar tropas em um estado de acordo com o numero que saiu no random   
botAddTroops(Territory, Troops) :- 
    Territory =:= 1 -> getPlayerTotalStateTroops("BOT", "Alagoas", R1), updateStateTroops("BOT", "Alagoas", R1 + Troops);
    Territory =:= 2 -> getPlayerTotalStateTroops("BOT", "Bahia", R2), updateStateTroops("BOT", "Bahia", R2 + Troops);
    Territory =:= 3 -> getPlayerTotalStateTroops("BOT", "Ceara", R3), updateStateTroops("BOT", "Ceara", R3 + Troops);
    Territory =:= 4 -> getPlayerTotalStateTroops("BOT", "Maranhao", R4), updateStateTroops("BOT", "Maranhao", R4 + Troops);
    Territory =:= 5 -> getPlayerTotalStateTroops("BOT", "Paraiba", R5), updateStateTroops("BOT", "Paraiba", R5 + Troops);
    Territory =:= 6 -> getPlayerTotalStateTroops("BOT", "Pernambuco", R6), updateStateTroops("BOT", "Pernambuco", R6 + Troops);
    Territory =:= 7 -> getPlayerTotalStateTroops("BOT", "Piaui", R7), updateStateTroops("BOT", "Piaui", R7 + Troops);
    Territory =:= 8 -> getPlayerTotalStateTroops("BOT", "RioGrandeDoNorte", R8), updateStateTroops("BOT", "RioGrandeDoNorte", R8 + Troops);
    Territory =:= 9 -> getPlayerTotalStateTroops("BOT", "Sergipe", R9), updateStateTroops("BOT", "Sergipe", R9 + Troops).

% Metodo usado para pegar a quantidade de tropas de um estado de acordo com o numero que saiu no random
botGetTerritoriesTroops(Territory, Retorno) :-
    Territory =:= 1 -> getPlayerTotalStateTroops("BOT", "Alagoas", R1), Retorno is R1;
    Territory =:= 2 -> getPlayerTotalStateTroops("BOT", "Bahia", R2), Retorno is R2;
    Territory =:= 3 -> getPlayerTotalStateTroops("BOT", "Ceara", R3), Retorno is R3;
    Territory =:= 4 -> getPlayerTotalStateTroops("BOT", "Maranhao", R4), Retorno is R4;
    Territory =:= 5 -> getPlayerTotalStateTroops("BOT", "Paraiba", R5), Retorno is R5;
    Territory =:= 6 -> getPlayerTotalStateTroops("BOT", "Pernambuco", R6), Retorno is R6;
    Territory =:= 7 -> getPlayerTotalStateTroops("BOT", "Piaui", R7), Retorno is R7;
    Territory =:= 8 -> getPlayerTotalStateTroops("BOT", "RioGrandeDoNorte", R8), Retorno is R8;
    Territory =:= 9 -> getPlayerTotalStateTroops("BOT", "Sergipe", R9), Retorno is R9.

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
    Retorno =:= 0 -> DefenseTerritory is X;
    chooseDefenseTerritory(DefenseTerritory).

% Metodo que verifica se as tropas do estado de ataque sao maiores ou iguais que as tropas do estado de defesa
checkTroops(AttackTerritory, DefenseTerritory) :-
    getPlayerTotalStateTroops("BOT", AttackTerritory, R1),
    getPlayerTotalStateTroops("PLAYER", DefenseTerritory, R2),
    R1 >= R2.

% Metodo que verifica se o ataque eh possivel, verificando a quantidade de tropas de cada um e se sao fronteiras
checkAttack :-
    chooseAttackTerritory(AttackTerritory),
    chooseDefenseTerritory(DefenseTerritory),
    botGetTerritoriesNames(AttackTerritory, AttackTerritoryName),
    botGetTerritoriesNames(DefenseTerritory, DefenseTerritoryName),
    checkTroops(AttackTerritoryName, DefenseTerritoryName),
    frontier(AttackTerritoryName, DefenseTerritoryName) -> botAttack(AttackTerritoryName, DefenseTerritoryName);
    checkAttack.

% Metodo que checa o valor dos dados e faz as operaçoes necessaria caso o ataque ganhe ou a defesa ganhe
checkDices(R1, R2, AttackTerritory, AttackTerritoryTroops, DefenseTerritory, DefenseTerritoryTroops) :-
    R1 > R2 -> updateStateTroops("PLAYER", DefenseTerritory, DefenseTerritoryTroops - 1), 
    moveTroops(AttackTerritory, AttackTerritoryTroops, DefenseTerritory, DefenseTerritoryTroops - 1, TroopsToMove);
    updateStateTroops("BOT", AttackTerritory, AttackTerritoryTroops - 1).

% Metodo que move as tropas caso o ataque tenha ganhado o territorio da defesa
moveTroops(AttackTerritory, AttackTerritoryTroops, DefenseTerritory, DefenseTerritoryTroops, TroopsToMove) :-
    DefenseTerritoryTroops =:= 0 -> TroopsToMove is AttackTerritoryTroops // 2,
    updateStateTroops("PLAYER", DefenseTerritory, TroopsToMove),
    updateStateTroops("BOT", AttackTerritory, AttackTerritoryTroops - TroopsToMove);
    updateTotalTroops("BOT", 0).

% Metodo usado para o ataque do bot
botAttack(Attack, Defense) :- 
    getPlayerTotalStateTroops("BOT", Attack, AttackTerritoryTroops),
    getPlayerTotalStateTroops("PLAYER", Defense, DefenseTerritoryTroops),
    dadoAttack(R1),
    dadoAttack(R2),
    AttackTerritoryTroops > 1 -> checkDices(R1, R2, Attack, AttackTerritoryTroops, Defense, DefenseTerritoryTroops);
    updateTotalTroops("BOT", 0).
    