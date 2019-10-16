{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Project where

main :: IO
main = do
    let user = User "User" 5 0 0 0 0 0 0 0 0 0
    let bot = User "bot" 5 0 0 0 0 0 0 0 0 0

    
-- Função para atacar um User a partir de outro
-- Params: User atacante, User atacado, Estado atacante, Estado atacado
-- Return: (Atacante, atacado)
attack :: User -> User -> String -> String -> (User, User)
attack atacante atacado estado1 estado2
    | (getEstado atacante estado1) > 1 && (getEstado atacado estado2) > 0 = tupla where 

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