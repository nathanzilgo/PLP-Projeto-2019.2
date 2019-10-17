{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import User
import System.Random     

module Project where

main :: IO
main = do
    let user = User "User" 5 0 0 0 0 0 0 0 0 0
    let bot = User "bot" 5 0 0 0 0 0 0 0 0 0
    


runtime :: User -> User -> (User, User)
runtime jogador bot = do
    putStrLn("Insira o numero da jogada: ")
    putStrLn("1. Realocar tropas")
    putStrLn("2. Atacar")
    putStrLn("3. Terminar jogada")
    put
    
{- 
   Função root da aplicação onde todas as outras funções são chamadas
   Params: User jogador, User bot, Int jogadaId
   Return: (User jogador, User bot)
-}
runtime :: User -> User -> Int -> Int -> (User, User)
runtime jogador bot jogada userId
    | if(jogada == 1)
        then 

-- Função para atacar um User a partir de outro
-- Params: User atacante, User atacado, Estado atacante, Estado atacado
-- Return: (Atacante, atacado)
attack :: User -> User -> String -> String -> (User, User)
attack atacante atacado estado1 estado2
    | (User.getEstado atacante estado1) > 1 && (User.getEstado atacado estado2) > 0 = tupla where 

        exibeJogada( (name atacante) ++ " está atacando " ++ (name atacado) ++ " de " ++ (estado1) ++ " para " ++ (estado2) ++ "!!" )
        let dado1 = dados
        let dado2 = dados
        
        if(dado1 <= dado2)
            then 
                exibeJogada( (name atacante) ++ " perde a disputa com valor " ++ dado1 ++ " nos dados, contra " ++ dado2)
                let new_atacante = removeTroops (atacante 1 estado1)
        else
            then 
                exibeJogada( (name atacado) ++ " perde a disputa com valor " ++ dado2 ++ " nos dados, contra " ++ dado1)
                let new_atacado = removeTroops (atacado 1 estado2)
        
        tupla = attack new_atacante new_atacado estado1 estado2

    | otherwise = (new_atacante, new_atacado)

-- Resultados de dados aleatórios
-- Return numero
dados :: Int
dados = randomRIO(1, 6)

-- Função auxiliar para exibir resultados durante jogadas
-- Params: String texto
-- Return: IO() texto
exibeJogada :: String -> IO()
exibeJogada texto = print(texto)

-- Exibe um User vitorioso no jogo
-- Params: User user
-- Return: IO() texto
win :: User -> IO()
win user = print(name user ++ " venceu o jogo!")

-- ####################################################### VIEW #########################################################

estados_view :: User -> IO()
estados_view user = print("Lista de estados")
    | 


-- PRIMEIRO MENU
-- exibe as opcoes "Iniciar jogo" e "Regras"
-- params: User player, User bot, [(String, Int)] states
first_menu :: User -> User -> [(String, Int)] -> IO()
first_menu player bot states = do
    putStrLn("<--------------------  WARXENTE -------------------->")
    putStrLN("1 - Iniciar jogo")
    putStrLN("2 - Regras")
    op <- readLn
    if op == "1" then
        second_screen player bot states 5
    else if op == "2" then
        -- regras
        first_menu player bot states
    else
        putStrLn("-- ENTRADA INVALIDA! --")
        putStrLn("Digite 'c' para continuar")
        temp <- readLn
        first_menu player bot states


-- SECUNDA TELA
-- primeira parte da alocacao de tropas, no qual o jogador escolhe o 
-- estado em que ele deseja alocar as tropas
-- params: User player, User bot, [(String, Int)] states, Int troopsAvaliable
-- return: third_screen
second_screen :: User -> User -> [(String, Int)] -> Int -> IO()
second_screen player bot states troopsAvaliable = do
        putStrLn("-- Coloque seus exercitos " ++ troopsAvaliable ++ " disponiveis")
        putStrLn("-- ESTADOS DISPONIVEIS --")
        -- exibir a lista de estados
        -- TO DO estado_view
        estado_view player
        putStrLn("> ")
        state <- readLn
        third_screen player bot state states troopsAvaliable

-- TERCEIRA TELA
-- segunda parte da alocacao de tropas, no qual o jogador escolhe a quantidade tropas
-- que ele deseja colocar no estado escolhido
-- params: User player, User bot, Int state, [(String, Int)] states, Int troopsAvaliable
third_screen :: User -> User -> String -> [(String, Int)] -> Int -> IO()
third_screen player bot state states troopsAvaliable = do
        putStrLn("-- Quantos exércitos deseja posicionar no estado <" ++ state ++ "> ? ")
        troops <- readLn
        if troops <= troopsAvaliable then
            alocaTroops player troops state
        else
            putStrLn("-- ENTRADA INVALIDA --")
            third_screen player bot state states troopsAvaliable

        if troopsAvaliable <= 0 then
            fourth_screen player bot states troopsAvaliable
        else
            second_menu player bot states (troopsAvaliable-troops)

-- QUARTA TELA
-- menu que decide se o jogador irá visualizar suas tropas e exercitos
-- iniciar a rodada de ataque
-- ou alocar tropas se ele ainda tiver tropas sobrando
-- params: User player, User bot, [(String, Int)] states, Int troopsAvaliable
fourth_screen :: User -> User -> [(String, Int)] -> Int -> IO()
fourth_screen player bot states troopsAvaliable = do
    putStrLn("-- SUA RODADA --")
    putStrLn(" 1 - Visualizar os territórios/exércitos atuais")
    putStrLn(" 2 - Iniciar rodada")
    putStrLn(" 3 - Alocar tropas")
    opt <- readLn

    if opt == "1" then
        -- TO DO estado_view
        estados_view player
        estados_view bot 
        putStrLn("Digite 'c' para continuar")
        temp <- readLn
        fourth_screen player bot states troopsAvaliable
    else if opt == "2" then
        fifth_screen player bot states
    else if opt == 4 && troopsAvaliable > 0 then
        second_screen player bot estados troopsAvaliable
    else
        putStrLn("-- ENTRADA INVALIDA! --")
        fourth_screen player bot states troopsAvaliable

-- QUINTA TELA
-- pergunta se o jogador deseja atacar
-- params: User player, User bot, [(String, Int)] states
fifth_screen :: User -> User -> [(String, Int)] -> IO()
fifth_screen player bot states = do
    putStrLn("Deseja atacar? (s/n)")
    result <- readLn
    if result == "s" then
        sixth_screen player bot states false 
    else if result == "n" then
        seventh_screen player bot states 


-- SEXTA TELA
-- a tela de ataque
-- ele escolhe o territorio atacante e o territorio que o bot vai defender
-- os dados rodam e decide quem ganhou  
-- params: User player, User bot, [(String, Int)] states, Bool win
sixth_screen :: User -> User -> [(String, Int)] -> Bool -> IO()
sixth_screen player bot states win = do
    putStrLn("-- Escolha o estado atacante:")
    -- TO DO estados_view
    estados_view player -- lista de territórios atuais do jogador
    putStrLn("0 - nao atacar")
    putStrLn(">")
    estadoAtacante <- readLn
    if estadoAtacante == 0 then
        seventh_screen player bot states
    else
        putStrLn("-- Escolha o estado que deseja atacar")
        -- TO DO estados_view
        estados_view bot -- lista de territorios atuais do inimigo
        putStrLn("0 - nao atacar")
        putStrLn(">")
        estadoDefesa <- readLn
        if estadoDefesa == 0 then
            sixth_screen player bot states
        else 
            -- attack tem que retornar o user que ganhou
            attack player bot estadoAtacante estadoDefesa
            -- bot.avaliable_army_per_round += 5;
            -- player.avaliable_army_per_round += 5;

            -- exibir quem ganhou
            if verificaVitoria player win == true then
                eigth_screen
            else 
                seventh_screen player bot states false



-- RODADA DO BOT
botRound :: User -> User -> [(String, Int)] -> Bool -> IO()
botRound player bot states win = do

-- SETIMA TELA
{- termina a rodada do jogador e verfica se o jogador ganhou
 se ele tiver ganhado exibe VOCE GANGOU
 se o bot tiver ganhado nesta rodada exibe VOCE PERDEU
 se nenhum tiver ganhado na rodada ele iniciara a rodada do bot
 e logo em seguinda volta para a QUARTA TELA -}
-- params: User player, User bot, [(String, Int)] states, Bool win
seventh_screen :: User -> User -> [(String, Int)] -> Bool -> IO()
seventh_screen player bot states win = do
    putStrLn("-- FIM DE RODADA --")
    -- addTroops player bot
    if (verificaVitoria player win) == true then
        eigth_screen
    else if (verificaVitoria bot win) == true then
        nineth_screen
    else 
        botRound player bot states
        fourth_screen player bot states 5

-- OITAVA TELA
-- exibe VOCE PERDEU
eigth_screen :: IO()
eigth_screen = do
    putStrLn("-- VOCE PERDEU! --")
    putStrLn(" Ate mais! Digite qualquer tecla para fechar")
    tecla <- readLn

-- NONA TELA
-- exibe VOCE GANHOU
nineth_screen :: IO()
nineth_screen = do
    putStrLn("VOCE GANHOU!")
    putStrLn(" Ate mais! Digite qualquer tecla para fechar")
    tecla <- readLn
