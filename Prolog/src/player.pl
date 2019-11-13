:- module(
    players, 
    [player/9, 
    getPlayer/1,
    configPlayers/0,
    setPlayer/11,
    setPlayerTotalTroops/2,
    setPlayerAlagoas/2,
    setPlayerBahia/2,
    setPlayerCeara/2,
    setPlayerMaranhao/2,
    setPlayerParaiba/2,
    setPlayerPernambuco/2,
    setPlayerPiaui/2,
    setPlayerRioGrandeDoNorte/2,
    setPlayerSergipe/2
]).



% Estrutura de um player no jogo.
%(Nome, quantidade de tropas para alocar, alagoas, bahia, ceara, maranhao, paraiba, pernambuco, piaui, riogradedonorte, sergipe)
:- dynamic(player/11).
player("PLAYER", 5, 0, 0, 0, 0, 0, 0 ,0 ,0 ,0).
player("BOT", 5, 0, 0, 0, 0, 0, 0 ,0 ,0 ,0).

% Retorna o player relacionado ao ID ("BOT" ou "PLAYER")
getPlayer(Id) :-
    player(Id,_, _, _, _, _, _, _, _, _, _).

% Seta todos os valores de um player
setPlayer(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe) :-
    setPlayerTotalTroops(Id, TotalTroops),
    setPlayerStates(Id, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe).

% Seta o valor do total de tropas de um player.
setPlayerTotalTroops(Id, TotalTroops) :-
    player(Id, _, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).


% Seta o valor de todas as tropas de um player.
setPlayerStates(Id, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe) :-
    player(Id, TotalTroops, _, _, _, _, _, _, _, _, _),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas de alagoas de um determinado player.
setPlayerAlagoas(Id, Alagoas) :-
    player(Id, TotalTroops, _, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas da Bahia de um determinado player.
setPlayerBahia(Id, Bahia) :-
    player(Id, TotalTroops, Alagoas, _, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).

% Seta o valor das tropas do Ceara de um determinado player.
setPlayerCeara(Id, Ceara) :-
    player(Id, TotalTroops, Alagoas, Bahia, _, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe),
    retract(player(Id, _, _, _, _, _, _, _, _, _, _)),
    asserta(player(Id, TotalTroops, Alagoas, Bahia, Ceara, Maranhao, Paraiba, Pernambuco, Piaui, RioGrandeDoNorte, Sergipe)).


% Faz a configuração inicial dos players.
configPlayers :-
    setPlayer("BOT", 5, 0, 1, 0, 1, 0, 1 ,0 ,1 ,1),
    setPlayer("PLAYER", 5, 1, 0, 1, 0, 1, 0 ,1 ,0 ,0).
    