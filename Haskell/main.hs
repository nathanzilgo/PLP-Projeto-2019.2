{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Project where

main :: IO
main = do
    let user = User "User" 5 0 0 0 0 0 0 0 0 0
    let bot = User "bot" 5 0 0 0 0 0 0 0 0 0

-- Função para atacar um User a partir de outro
-- Params: os 2 users
-- Return: Resultado
attack :: User -> User -> IO()
