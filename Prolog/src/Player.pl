:- module(
    player, 
    [player/11, 
    updateStateTroops/3,
    getPlayerTotalTroops/2,
    updateTotalTroops/2,
    getPlayerTotalStateTroops/3,
    configPlayers/0
]).



% Estrutura de um player no jogo.
%(Nome, quantidade de tropas para alocar, alagoas, bahia, ceara, maranhao, paraiba, pernambuco, piaui, riogradedonorte, sergipe)
:- dynamic(player/11).
player("PLAYER", 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0).
player("BOT", 0, 0, 0, 0, 0, 0, 0 ,0 ,0 ,0).


updateStateTroops(Id, Territory, Troops) :-
    setPlayerStateTroops(Id, Troops, Territory).
    
% Retorna a quantidade de tropas disponiveis para alocar de um determinado player.
getPlayerTotalTroops(Id, R) :-
    player(Id, Troops, _, _, _, _, _, _, _, _, _),
    R is Troops.

% Atualiza a quantidade de tropas totais para alocacao de um determinado player.
updateTotalTroops(Id, Troops) :-
    getPlayerTotalTroops(Id, R),
    R >= Troops,
    NewTotalTroops is R + Troops,
    setPlayerTotalTroops(Id, NewTotalTroops).

% Retorna o valor de um dado territorio de um dado player.
getPlayerTotalStateTroops(Id, Territory, R) :-
    getPlayerStateTroops(Id, Territory, R2),
    R is R2.

%%%%%%%% SETS %%%%%%%%%%

% Seta o valor do total de tropas Disponiveis para alocacao de um player.
setPlayerTotalTroops(Id, TotalTroops) :-
    player(Id, _, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas de alagoas de um determinado player.
setPlayerStateTroops(Id, Troops, "Alagoas") :-
    player(Id, TotalTroops, _, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Troops, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas da Bahia de um determinado player.
setPlayerStateTroops(Id, Troops, "Bahia") :-
    player(Id, TotalTroops, Alagoas, _, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Troops, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do Ceara de um determinado player.
setPlayerStateTroops(Id, Troops, "Ceara") :-
    player(Id, TotalTroops, Alagoas, Bahia, _, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Troops, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do Maranhao de um determinado player.
setPlayerStateTroops(Id, Troops, "Maranhao") :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, _, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Troops, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas da Paraiba de um determinado player.
setPlayerStateTroops(Id, Troops, "Paraiba") :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, _, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Troops, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do Pernambuco de um determinado player.
setPlayerStateTroops(Id, Troops, "Pernambuco") :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, _, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Troops, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do Piaui de um determinado player.
setPlayerStateTroops(Id, Troops, "Piaui") :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, _, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Troops, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do RioGrandeDoNorte de um determinado player.
setPlayerStateTroops(Id, Troops, "RioGrandeDoNorte") :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, _, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, Troops, Sergipe)).

% Seta o valor das tropas do Sergipe de um determinado player.
setPlayerStateTroops(Id, Troops, "Sergipe") :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, _),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Troops)).


%%%%%%%% GETS %%%%%%%%%

% Pega o valor das tropas alocadas no Alagoas de um determinado player.
getPlayerStateTroops(Id, "Alagoas", R) :-
    player(Id,_, Alagoas, _, _, _, _, _, _, _, _),
    R is Alagoas.

% Pega o valor das tropas alocadas na Bahia de um determinado player.
getPlayerStateTroops(Id, "Bahia", R) :-
    player(Id,_, _, Bahia, _, _, _, _, _, _, _),
    R is Bahia.

% Pega o valor das tropas alocadas no Ceara de um determinado player.
getPlayerStateTroops(Id, "Ceara", R) :-
    player(Id,_, _, _, Ceara, _, _, _, _, _, _),
    R is Ceara.

% Pega o valor das tropas alocadas no Maranhao de um determinado player.
getPlayerStateTroops(Id, "Maranhao", R) :-
    player(Id,_, _, _, _, Maranhao, _, _, _, _, _),
    R is Maranhao.

% Pega o valor das tropas alocadas na Paraiba de um determinado player.
getPlayerStateTroops(Id, "Paraiba", R) :-
    player(Id,_, _, _, _, _, Paraiba, _, _, _, _),
    R is Paraiba.


% Pega o valor das tropas alocadas no Pernambuco de um determinado player.
getPlayerStateTroops(Id, "Pernambuco", R) :-
    player(Id,_, _, _, _, _, _, Pernambuco, _, _, _),
    R is Pernambuco.

% Pega o valor das tropas alocadas no Piaui de um determinado player.
getPlayerStateTroops(Id, "Piaui", R) :-
    player(Id,_, _, _, _, _, _, _, Piaui, _, _),
    R is Piaui.

% Pega o valor das tropas alocadas no Rio Grande do Norte de um determinado player.
getPlayerStateTroops(Id, "RioGrandeDoNorte", R) :-
    player(Id,_, _, _, _, _, _, _, _, RioGrandeDoNorte, _),
    R is RioGrandeDoNorte.

% Pega o valor das tropas alocadas no Sergipe de um determinado player.
getPlayerStateTroops(Id, "Sergipe", R) :-
    player(Id,_, _, _, _, _, _, _, _, _, Sergipe),
    R is Sergipe.


%%%%%%%%%%%% Configuração %%%%%%%%%%%

% Seta todos os valores de um player

% Seta o valor de todas as tropas de um player.
setPlayerStates(Id, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe) :-
    player(Id, TotalTroops, _, _, _, _, _, _, _, _, _),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Faz a inicialização de um player.
setPlayer(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe) :-
    setPlayerTotalTroops(Id, TotalTroops),
    setPlayerStates(Id, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe).


% Faz a configuração inicial dos players.
configPlayers :-
    setPlayer("BOT", 5, 0, 1, 0, 1, 0, 1 ,0 ,1 ,1),
    setPlayer("PLAYER", 5, 1, 0, 1, 0, 1, 0 ,1 ,0 ,0).