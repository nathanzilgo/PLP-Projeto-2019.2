{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- Definição de um User do jogo que contem os métodos aplicados
-- ao User em si.
module Bot where

import Data.text (Text)

data Bot = Bot{
    name :: String,
    troops :: Int,
    states :: [(String, Int)]
} deriving (Show, Eq, Num)

