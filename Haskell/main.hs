{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Project where

main :: IO
main = do
    let user = User "User" 5 0 0 0 0 0 0 0 0 0
    let bot = User "bot" 5 0 0 0 0 0 0 0 0 0

-- Função para atacar um User a partir de outro
-- Params: User atacante, User atacado
-- Return: (Atacante, atacado)
attack :: User -> User -> (User, User)
