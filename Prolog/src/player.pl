:- module(
    player, 
    [player/11, 
    configPlayers/0,
    setPlayer/11,
    setPlayerTotalTroops/2,
    setPlayerTroops/3,
    setPlayerAlagoas/3,
    setPlayerBahia/3,
    setPlayerCeara/3,
    setPlayerMaranhao/3,
    setPlayerParaiba/3,
    setPlayerPernambuco/3,
    setPlayerPiaui/3,
    setPlayerRioGrandeDoNorte/3,
    setPlayerSergipe/3,
    getPlayerStateTroops/3,
    getPlayerTroops/2
]).



% Estrutura de um player no jogo.
%(Nome, quantidade de tropas para alocar, alagoas, bahia, ceara, maranhao, paraiba, pernambuco, piaui, riogradedonorte, sergipe)
:- dynamic(player/11).
player("PLAYER", 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0).
player("BOT", 0, 0, 0, 0, 0, 0, 0 ,0 ,0 ,0).


% Seta todos os valores de um player
setPlayer(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe) :-
    setPlayerTotalTroops(Id, TotalTroops),
    setPlayerStates(Id, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe).

% Seta o valor do total de tropas de um player.
setPlayerTotalTroops(Id, TotalTroops) :-
    player(Id, _, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Modifica o valor de tropas de um player de acordo com a adiçao/remoçao das mesmas durante o jogo.
setPlayerTroops(Id, Troops, NewValue) :-
    player(Id, ValueTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    NewValue is ValueTroops + Troops,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, NewValue, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).


% Seta o valor de todas as tropas de um player.
setPlayerStates(Id, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe) :-
    player(Id, TotalTroops, _, _, _, _, _, _, _, _, _),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas de alagoas de um determinado player.
setPlayerAlagoas(Id, Troops, NewValue) :-
    player(Id, TotalTroops, ValueAlagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    NewValue is ValueAlagoas + Troops,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, NewValue, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas da Bahia de um determinado player.
setPlayerBahia(Id, Troops, NewValue) :-
    player(Id, TotalTroops, Alagoas, ValueBahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    NewValue is ValueBahia + Troops,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, NewValue, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do Ceara de um determinado player.
setPlayerCeara(Id, Troops, NewValue) :-
    player(Id, TotalTroops, Alagoas, Bahia, ValueCeara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    NewValue is Troops + ValueCeara,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, NewValue, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do Maranhao de um determinado player.
setPlayerMaranhao(Id, Troops, NewValue) :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, ValueMaranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    NewValue is Troops + ValueMaranhao,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, NewValue, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas da Paraiba de um determinado player.
setPlayerParaiba(Id, Troops, NewValue) :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, ValueParaiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    NewValue is Troops + ValueParaiba,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, NewValue, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do Pernambuco de um determinado player.
setPlayerPernambuco(Id, Troops, NewValue) :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, ValuePernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    NewValue is Troops + ValuePernambuco,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, NewValue, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do Piaui de um determinado player.
setPlayerPiaui(Id, Troops, NewValue) :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, ValuePiaui, RioGrandeDoNorte, Sergipe),
    NewValue is Troops + ValuePiaui,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, NewValue, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do RioGrandeDoNorte de um determinado player.
setPlayerRioGrandeDoNorte(Id, Troops, NewValue) :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, ValueRioGrandeDoNorte, Sergipe),
    NewValue is Troops + ValueRioGrandeDoNorte,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, NewValue, Sergipe)).

% Seta o valor das tropas do Sergipe de um determinado player.
setPlayerSergipe(Id, Troops, NewValue) :-
    player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, ValueSergipe),
    NewValue is Troops + ValueSergipe,
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, NewValue)).

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

% Retorna a quantidade de tropas disponiveis para alocar de um determinado player.
getPlayerTroops(Id, R) :-
    player(Id, Troops, _, _, _, _, _, _, _, _, _),
    R is Troops.

% Faz a configuração inicial dos players.
configPlayers :-
    setPlayer("BOT", 5, 0, 1, 0, 1, 0, 1 ,0 ,1 ,1),
    setPlayer("PLAYER", 5, 1, 0, 1, 0, 1, 0 ,1 ,0 ,0).
