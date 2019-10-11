{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Project where

main :: IO
main = do

-- Função para atacar um User a partir de outro
-- Params: os 2 users
-- Return: Resultado
attack :: User -> User -> IO()
