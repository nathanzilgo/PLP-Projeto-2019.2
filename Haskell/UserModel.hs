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
    | estado == "alagoas" = setAlagoas user getAlagoas
    | estado == "bahia" = setBahia user getBahia
    | estado == "ceara" = setCeara user getCeara
    | estado == "maranhao" = setMaranhao user getMaranhao
    | estado == "paraiba" = setParaiba user getParaiba
    | estado == "pernambuco" = setPernambuco user getPernambuco
    | estado == "piaui" = setPiaui user getPiaui
    | estado == "riograndedonorte" = setRioGrandeDoNorte user getRioGrandeDoNorte
    | otherwhise = setSergipe user getSergipe

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
    out <- randomRIO (1, num)
    
-- Define uma escolha de jogada aleatória para o Bot
randomPlay :: Int -> Int

-- Verifica se um User tem controle sobre um estado
-- Params: User user, String estado, [(String, Int)] estadosUsr
-- Return: Boolean resultado
possuiEstado :: User -> String -> [(String, Int)] -> Boolean
possuiEstado user estado h:t
    | h == () = False                                         -- Fim da lista (condição de parada)
    | estado == sel1 h = True                                 -- Se o estado for igual a String da head (tupla)
    | estado != sel1 h = possuiEstado user estado t           -- Passo recursivo (user, estado, tail da lista)


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