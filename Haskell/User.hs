{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- Definição de um User do jogo (Humano ou bot) que contem os métodos aplicados
-- ao User em si.
-- module User where
import Algoritmos

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
    sergipe:: Int
} deriving (Show, Eq)

-- Método para alocar tropas livres no início de um round para um User.
-- Params: User user, Int quantidade, String estado.
-- Return: String resultado

alocaTroops :: User -> Int -> String -> User
alocaTroops user quantidade estado
    | estado == "alagoas" = setAlagoas user quantidade 
    | estado == "bahia" = setBahia user quantidade
    | estado == "ceara" = setCeara user quantidade
    | estado == "maranhao" = setMaranhao user quantidade
    | estado == "paraiba" = setParaiba user quantidade
    | estado == "pernambuco" = setPernambuco user quantidade
    | estado == "piaui" = setPiaui user quantidade
    | estado == "riograndedonorte" = setRioGrandeDoNorte user quantidade
    | estado == "sergipe" = setSergipe user quantidade
    | otherwise = User ("erro") 0 0 0 0 0 0 0 0 0 0

-- Aloca tropas de forma aleatoria no bot\
alocaTerritoriosBot:: User -> Int -> User
alocaTerritoriosBot bot quantidadeAlocada 
    | (quantidadeAlocada < 5) = alocaTerritoriosBotAux bot quantidadeAlocada randomState
    | otherwise = bot

alocaTerritoriosBotAux:: User -> Int -> String -> User
alocaTerritoriosBotAux bot quantidadeAlocada estadoRandom 
    | (getEstado bot estadoRandom) == 0 = alocaTerritoriosBot (setEstado bot estadoRandom 1) (quantidadeAlocada + 1)
    | otherwise = alocaTerritoriosBot bot quantidadeAlocada

-- Método para realocar tropas de um User de um estado para outro.
-- Params: User user, Int quantidade, String estado_remove, String estado_add.
-- Return: String resultado.
realocaTroops :: User -> Int -> String -> String -> User
realocaTroops user quantidade estado_remove estado_add = do
    let usr = setEstado user estado_add quantidade
    setEstado usr estado_remove (-quantidade)

--Aloca territórios no usuario de acordo com os territorios ja alocados no bot
alocaTerritoriosUser:: User -> User -> User
alocaTerritoriosUser bot user 
    | (alagoas bot == 0 && alagoas user == 0) = alocaTerritoriosUser bot (setAlagoas user 1) 
    | (bahia bot == 0 && bahia user == 0) =  alocaTerritoriosUser bot (setBahia user 1)
    | (ceara bot == 0 && ceara user == 0) = alocaTerritoriosUser bot (setCeara user 1)
    | (maranhao bot == 0 && maranhao user == 0) = alocaTerritoriosUser bot (setMaranhao user 1)
    | (paraiba bot == 0 && paraiba user == 0) = alocaTerritoriosUser bot (setParaiba user 1)
    | (pernambuco bot == 0 && pernambuco user == 0) = alocaTerritoriosUser bot (setPernambuco user 1)
    | (piaui bot == 0 && piaui user == 0) = alocaTerritoriosUser bot (setPiaui user 1)
    | (riograndedonorte bot == 0 && riograndedonorte user == 0) = alocaTerritoriosUser bot (setRioGrandeDoNorte user 1)
    | (sergipe bot == 0 && sergipe user == 0) = alocaTerritoriosUser bot (setSergipe user 1)
    | otherwise = user

-- Método para remover tropas de um User (possível ataque recebido).
-- Params: User user, Int quantidade, String estado.
-- Return: String resultado.
removeTroops :: User -> Int -> String -> User
removeTroops user quantidade estado
    | (getEstado user estado) - quantidade < 0 = setEstado user estado 0
    | otherwise = alocaTroops user (-quantidade) estado


    
-- Define uma escolha de jogada aleatória para o Bot
-- randomPlay :: User -> Int -> User

-- Verifica se um User tem controle sobre um estado
-- Params: User user, String estado
-- Return: Boolean resultado
possuiEstado :: User -> String -> Bool
possuiEstado user estado
    | estado == "alagoas" = ((getAlagoas user) > 0)
    | estado == "bahia" = ((getBahia user) > 0)
    | estado == "ceara" = ((getCeara user) > 0)
    | estado == "maranhao" = ((getMaranhao user) > 0)
    | estado == "paraiba" = ((getParaiba user) > 0)
    | estado == "pernambuco" = ((getPernambuco user) > 0)
    | estado == "piaui" = ((getPiaui user)> 0)
    | estado == "riograndedonorte" = ((getRioGrandeDoNorte user) > 0)
    | estado == "sergipe" = ((getSergipe user) > 0)
    | otherwise = False


-- Verifica se um User ja ganhou a partida, olhando se todos os estados do usuario possuem uma tropa ou mais.
-- Params: User user
-- Return: Boolean resultado que define se o usuario ganhou ou nao a partida.
verificaVitoria :: User -> Bool
verificaVitoria user
    | (((getAlagoas user) > 0) && ((getBahia user) > 0) && ((getCeara user) > 0) && ((getMaranhao user) > 0) && ((getParaiba user) > 0) && ((getPernambuco user) > 0) && ((getPiaui user) > 0) && ((getRioGrandeDoNorte) user > 0) && ((getSergipe user) > 0)) = True
    | otherwise = False

-- ####################################################### SETTERS #########################################################

setEstado :: User -> String -> Int -> User
setEstado usr estado quantidade
    | estado == "alagoas" = setAlagoas usr quantidade
    | estado == "bahia" = setBahia usr quantidade
    | estado == "ceara" = setCeara usr quantidade
    | estado == "maranhao" = setMaranhao usr quantidade
    | estado == "paraiba" = setParaiba usr quantidade
    | estado == "pernambuco" = setPernambuco usr quantidade
    | estado == "piaui" = setPiaui usr quantidade
    | estado == "riograndedonorte" = setRioGrandeDoNorte usr quantidade
    | estado == "sergipe" = setSergipe usr quantidade
    | otherwise = User ("erro") 0 0 0 0 0 0 0 0 0 0

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
    let user = User (name usr) ((troops usr) + tropas) (alagoas usr) (bahia usr) (ceara usr) (maranhao usr) (paraiba usr) (pernambuco usr) (piaui usr) (riograndedonorte usr) (sergipe usr)

    user


-- #################################################### GETTERS #######################################################

getEstado :: User -> String -> Int
getEstado user estado
    | estado == "alagoas" = getAlagoas user
    | estado == "bahia" = getBahia user
    | estado == "ceara" = getCeara user
    | estado == "riograndedonorte" = getRioGrandeDoNorte user
    | estado == "maranhao" = getMaranhao user
    | estado == "piaui" = getPiaui user
    | estado == "paraiba" = getParaiba user
    | estado == "pernambuco" = getPernambuco user
    | estado == "sergipe" = getSergipe user
    | otherwise = -404
    
--Retorna a quantidade de tropas do estado de alagoas
getAlagoas:: User -> Int
getAlagoas user = alagoas user
    
--Retorna a quantidade de tropas do estado da bahia
getBahia:: User -> Int
getBahia user = bahia user
    
--Retorna a quantidade de tropas do estado do ceara
getCeara:: User -> Int
getCeara user = ceara user
    
--Retorna a quantidade de tropas do estado do maranhao
getMaranhao:: User -> Int
getMaranhao user = maranhao user

--Retorna a quantidade de tropas do estado da paraiba 
getParaiba:: User -> Int
getParaiba user = paraiba user
    
--Retorna a quantidade de tropas do estado de pernambuco
getPernambuco:: User -> Int
getPernambuco user = pernambuco user
    
--Retorna a quantidade de tropas do estado do piaui
getPiaui:: User -> Int
getPiaui user = piaui user

--Retorna a quantidade de tropas do estado do riograndedonorte
getRioGrandeDoNorte:: User -> Int
getRioGrandeDoNorte user = riograndedonorte user
    
--Retorna a quantidade de tropas do estado de sergipe
getSergipe:: User -> Int
getSergipe user = sergipe user

getEstados :: User -> [String] -> Int -> [String]
getEstados user lista flag 
    |flag == 0 = if(possuiEstado user "alagoas") 
        then
            getEstados user (lista ++ ["alagoas"]) (flag + 1)
        else getEstados user lista (flag + 1)

    | flag == 1 = if(possuiEstado user "bahia") then
        getEstados user (lista ++ ["bahia"]) (flag + 1)
        else getEstados user lista (flag + 1)

    | flag == 2 = if(possuiEstado user "ceara") then
        getEstados user (lista ++ ["ceara"]) (flag + 1)
        else getEstados user lista (flag + 1)
    
    | flag == 3 = if(possuiEstado user "maranhao") then
        getEstados user (lista ++ ["maranhao"]) (flag + 1)
        else getEstados user lista (flag + 1)

    | flag == 4 = if(possuiEstado user "paraiba") then
        getEstados user (lista ++ ["paraiba"]) (flag + 1)
        else getEstados user lista (flag + 1)
    
    | flag == 5 = if(possuiEstado user "pernambuco") then
        getEstados user (lista ++ ["pernambuco"]) (flag + 1)
        else getEstados user lista (flag + 1)    
    
    | flag == 6 = if(possuiEstado user "piaui") then
        getEstados user (lista ++ ["piaui"]) (flag + 1)
        else getEstados user lista (flag + 1)    
    
    | flag == 7 = if(possuiEstado user "riograndedonorte") then
        getEstados user (lista ++ ["riograndedonorte"]) (flag + 1)
        else getEstados user lista (flag + 1)    
    
    | flag == 8 = if(possuiEstado user "sergipe") then
        getEstados user (lista ++ ["sergipe"]) (flag + 1)
        else getEstados user lista (flag + 1)    
    
    | otherwise = lista