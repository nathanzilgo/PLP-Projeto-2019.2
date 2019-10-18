{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import User
import System.Random
import User     

main :: IO()
main = do
    let users = config

    putStrLn(show (users))


config :: (User, User)
config = do
    let bot = User "bot" 5 0 1 0 1 1 0 1 0 1
    let user = User "User" 5 0 0 0 0 0 0 0 0 0

    let user_final = alocaTerritoriosUser bot user

    (bot, user)

runtime :: User -> User -> (User, User)
runtime jogador bot
    putStrLn("Insira o numero da jogada: ")
    putStrLn("1. Realocar tropas")
    putStrLn("2. Atacar")
    putStrLn("3. Terminar jogada")
    putStrLn("4. Encerrar partida")
    opt <- getLine :: Int

    if(opt == 1)then
        User.realocaTroops 
    
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

