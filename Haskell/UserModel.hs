{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- Definição de um User do jogo (Humano ou bot) que contem os métodos aplicados
-- ao User em si.
module User where

import Data.text (Text)
import Data.Tuple.Select -- Utilitários para tuplas. Precisa da dependência de tuplas instalada (veja o README)
import System.Random     

data User = User{
    name :: String,
    troops :: Int,
    alagoas :: Int,
    bahia:: Int,
    ceara:: Int,
    maranhao:: Int,
    paraiba:: Int,
    pernambuco:: Int,
    piaui:: Int,
    riograndedonorte:: Int,
    sergipe:: Int,
} deriving (Show, Eq, Num)

-- Método para alocar tropas livres no início de um round para um User.
-- Params: User user, Int quantidade, String estado.
-- Return: String resultado

alocaTroops :: User -> Int -> String -> User
alocaTroops user quantidade estado
    | estado == "alagoas" = setAlagoas user (getAlagoas user)
    | estado == "bahia" = setBahia user (getBahia user)
    | estado == "ceara" = setCeara user (getCeara user)
    | estado == "maranhao" = setMaranhao user (getMaranhao user)
    | estado == "paraiba" = setParaiba user (getParaiba user)
    | estado == "pernambuco" = setPernambuco (user getPernambuco user)
    | estado == "piaui" = setPiaui user (getPiaui user)
    | estado == "riograndedonorte" = setRioGrandeDoNorte user (getRioGrandeDoNorte user)
    | otherwhise = setSergipe user (getSergipe user)

-- Método para realocar tropas de um User de um estado para outro.
-- Params: User user, Int quantidade, String estado_remove, String estado_add.
-- Return: String resultado.

realocaTroops :: User -> Int -> String -> String -> IO()

-- Método para remover tropas de um User (possível ataque recebido).
-- Params: User user, Int quantidade, String estado.
-- Return: String resultado.
removeTroops :: User -> Int -> String -> User
removeTroops user quantidade estado =
    alocaTroops user (-quantidade) estado

-- Seleciona um estado arbitrário para o Bot
-- Params: [(String, Int)] estados
-- Return: String estado
randomState :: [(String, Int)] -> String
randomState states = out where
    r <- randomRIO (1, lenght states)   -- Gera um indice aleatorio na lista
    out = sel1 (states !! r)            -- Pega a string da tupla na posição R


-- Selectiona uma quantidade arbitrária para o Bot
-- Params: Int limiteSuperior
-- Return: Int result
randomTroops :: Int -> Int
randomTroops num = out where
    r <- randomRIO (1, num)
    out = r
    
-- Define uma escolha de jogada aleatória para o Bot
randomPlay :: User -> Int -> User

-- Verifica se um User tem controle sobre um estado
-- Params: User user, String estado, estadosUsr
-- Return: Boolean resultado
possuiEstado :: User -> String -> Boolean
possuiEstado user estado
    | estado == "alagoas" = ((getAlagoas user) > 0)
    | estado == "bahia" = ((getBahia user) > 0)
    | estado == "ceara" = ((getCeara > user) 0)
    | estado == "maranhao" = ((getMaranhao user) > 0)
    | estado == "paraiba" = ((getParaiba user) > 0)
    | estado == "pernambuco" = ((getPernambuco user) > 0)
    | estado == "piaui" = ((getPiaui user)> 0)
    | estado == "riograndedonorte" = ((getRioGrandeDoNorte user) > 0)
    | otherwhise = ((getSergipe user) > 0)


-- ####################################################### SETTERS #########################################################

-- Modifica o estado das tropas de alagoas do Usuario
setAlagoas:: User -> Int -> User
setAlagoas usr tropas = do
    let user = User (name usr) (troops usr) ((alagoas usr) + tropas) (bahia usr) (ceara usr) (maranhao usr) (paraiba usr) (pernambuco usr) (piaui usr) (riograndedonorte usr) (sergipe usr)

    user

-- Modifica o estado das tropas da bahia do Usuario    
setBahia:: User -> Int -> User
setBahia usr tropas = do
    let user = User (name usr) (troops usr) (alagoas usr) ((bahia usr) + tropas) (ceara usr) (maranhao usr) (paraiba usr) (pernambuco usr) (piaui usr) (riograndedonorte usr) (sergipe usr)

    user

-- Modifica o estado das tropas do ceara do Usuario    
setCeara:: User -> Int -> User
setCeara usr tropas = do
    let user = User (name usr) (troops usr) (alagoas usr) (bahia usr) ((ceara usr) + tropas) (maranhao usr) (paraiba usr) (pernambuco usr) (piaui usr) (riograndedonorte usr) (sergipe usr)

    user

-- Modifica o estado das tropas do maranhao do Usuario    
setMaranhao:: User -> Int -> User
setMaranhao usr tropas = do
    let user = User (name usr) (troops usr) (alagoas usr) (bahia usr) (ceara usr) ((maranhao usr) + tropas)  (paraiba usr) (pernambuco usr) (piaui usr) (riograndedonorte usr) (sergipe usr)

    user
    
-- Modifica o estado das tropas da paraiba do Usuario    
setParaiba:: User -> Int -> User
setParaiba usr tropas = do
    let user = User (name usr) (troops usr) (alagoas usr) (bahia usr) (ceara usr) (maranhao usr) ((paraiba usr) + tropas) (pernambuco usr) (piaui usr) (riograndedonorte usr) (sergipe usr)
    
    user

-- Modifica o estado das tropas do pernambuco do Usuario    
setPernambuco:: User -> Int -> User
setPernambuco usr tropas = do
    let user = User (name usr) (troops usr) (alagoas usr) (bahia usr) (ceara usr) (maranhao usr) (paraiba usr) ((pernambuco usr) + tropas) (piaui usr) (riograndedonorte usr) (sergipe usr)

    user
    
-- Modifica o estado das tropas da piaui do Usuario        
setPiaui:: User -> Int -> User
setPiaui usr tropas = do
    let user = User (name usr) (troops usr) (alagoas usr) (bahia usr) (ceara usr) (maranhao usr) (paraiba usr) (pernambuco usr) ((piaui usr) + tropas) (riograndedonorte usr) (sergipe usr)

    user

-- Modifica o estado das tropas do riograndedonorte do Usuario    
setRioGrandeDoNorte:: User -> Int -> User
setRioGrandeDoNorte usr tropas = do
    let user = User (name usr) (troops usr) (alagoas usr) (bahia usr) (ceara usr) (maranhao usr) (paraiba usr) (pernambuco usr) (piaui usr) ((riograndedonorte usr) + tropas) (sergipe usr)

    user

-- Modifica o estado das tropas de sergipe do Usuario    
setSergipe:: User -> Int -> User
setSergipe usr tropas = do
    let user = User (name usr) (troops usr) (alagoas usr) (bahia usr) (ceara usr) (maranhao usr) (paraiba usr) (pernambuco usr) (piaui usr) (riograndedonorte usr) ((sergipe usr) + tropas)

    user

-- Modifica o estado da quantidade de tropas totais   
setTroops:: User -> Int -> User
setTroops usr tropas = do
    let user = User (name usr) ((troops usr) + tropas) (alagoas usr) (bahia usr) (ceara usr) (maranhao usr) (paraiba usr) (pernambuco usr) (piaui usr) (riograndedonorte usr) (sergipe)

    user


-- #################################################### GETTERS #######################################################

getEstado :: User -> String -> Int
getEstado user estado
    | estado == "alagoas" = (alagoas user)
    | estado == "bahia" = (bahia user)
    | estado == "ceara" = (ceara user)
    | estado == "rn" = (riograndedonorte user)
    | estado == "sergipe" = (sergipe user)
    | estado == "maranhao" = (maranhao user)
    | estado == "piaui" = (piaui user)
    | estado == "paraiba" = (paraiba user)
    | estado == "pernambuco" = (pernambuco user)
    | otherwise = ">:("
    
--Retorna a quantidade de tropas do estado de alagoas
getAlagoas:: User -> Int
getAlagoas user =
    let usr = alagoas user
    usr
--Retorna a quantidade de tropas do estado da bahia
getBahia:: User -> Int
getBahia user =
    let usr = bahia user
    
    usr
--Retorna a quantidade de tropas do estado do ceara
getCeara:: User -> Int
getCeara user =
    let usr = ceara user
    
    usr
--Retorna a quantidade de tropas do estado do maranhao
getMaranhao:: User -> Int
getMaranhao user =
    let usr = maranhao user
    
    usr
--Retorna a quantidade de tropas do estado da paraiba 
getParaiba:: User -> Int
getParaiba user =
    let usr = paraiba user
    
    usr
--Retorna a quantidade de tropas do estado de pernambuco
getPernambuco:: User -> Int
getPernambuco user =
    let usr = pernambuco user
    
    usr
--Retorna a quantidade de tropas do estado do piaui
getPiaui:: User -> Int
getPiaui user =
    let usr = piaui user
    
    usr
--Retorna a quantidade de tropas do estado do riograndedonorte
getRiograndedonorte:: User -> Int
getRiograndedonorte user =
    let usr = riograndedonorte user
    
    usr
--Retorna a quantidade de tropas do estado de sergipe
getSergipe:: User -> Int
getSergipe user =
    let usr = sergipe user
    
    usr