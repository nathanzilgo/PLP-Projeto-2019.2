{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import User
import System.Random
import Algortimos   

main :: IO()
main = do
    let users = config
    first_menu user bot (getEstados player [] 0)
    putStrLn(show (users))


config :: (User, User)
config = do
    let bot = User "bot" 5 0 1 0 1 1 0 1 0 1
    let user = User "User" 5 0 0 0 0 0 0 0 0 0

    let user_final = alocaTerritoriosUser bot user

    (bot, user_final)


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
-}

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

getNeighbours :: [String] -> String -> [String]
getNeighbours states state
getNeighbours [] state = []
getNeighbours (a:as) state
    if neighbor state (a:as) then
        [state] ++ getNeighbours hs state
    else
        getNeighbours as state

statesAndTroops_view :: User -> [String] -> [(String, Int)]
statesAndTroops_view user states
statesAndTroops_view user [] = []
statesAndTroops_view user (a:as) = ((a, getEstado a player) ++ statesAndTroops_view user as

-- PRIMEIRO MENU
-- exibe as opcoes "Iniciar jogo" e "Regras"
-- params: User player, User bot, [String] states
first_menu :: (User, User) -> [String] -> IO()
first_menu (player, bot) states = do
    putStrLn("<--------------------  WARXENTE -------------------->")
    putStrLn("1 - Iniciar jogo")
    putStrLn("2 - Regras")
    op <- getLine
    if op == "1" then
        second_screen (player, bot) states 5
    else if op == "2" then
        rules
        first_menu (player, bot) states
    else
        putStrLn("-- ENTRADA INVALIDA! --")
        putStrLn("Digite 'c' para continuar")
        temp <- getLine
        first_menu (player, bot) states

-- SECUNDA TELA
-- primeira parte da alocacao de tropas, no qual o jogador escolhe o 
-- estado em que ele deseja alocar as tropas
-- params: User player, User bot, [String] states, Int troopsAvaliable
-- return: third_screen
second_screen :: (User, User) -> [String] -> Int -> IO()
second_screen (player, bot) states troopsAvaliable = do
        putStrLn("-- Coloque seus exercitos " ++ troopsAvaliable ++ " disponiveis")
        putStrLn("-- ESTADOS DISPONIVEIS --")
        -- exibir a lista de estados
        putStrLn(statesAndTroops_view(getEstados player [] 0))
        putStrLn("> ")
        state <- getLine
        if (state `elem` (getEstados player [] 0)) then
            third_screen (player, bot) state states troopsAvaliable
        else
            putStrLn("-- ESTADO INDISPONIVEL --")
            second_screen (player, bot) states troopsAvaliable
        
-- TERCEIRA TELA
-- segunda parte da alocacao de tropas, no qual o jogador escolhe a quantidade tropas
-- que ele deseja colocar no estado escolhido
-- params: User player, User bot, Int state, [String] states, Int troopsAvaliable
third_screen :: (User, User) -> String -> [String] -> Int -> IO()
third_screen (player, bot) state states troopsAvaliable = do
        putStrLn("-- Quantos exércitos deseja posicionar no estado <" ++ state ++ "> ? ")
        troops <- readLn :: IO Int
        if troops <= troopsAvaliable then
            alocaTroops player troops state
        else
            putStrLn("-- ENTRADA INVALIDA --")
            third_screen (player, bot) state states troopsAvaliable

        if troopsAvaliable <= 0 then
            fourth_screen (player, bot) states troopsAvaliable
        else
            second_menu (player, bot) states (troopsAvaliable-troops)

-- QUARTA TELA
-- menu que decide se o jogador irá visualizar suas tropas e exercitos
-- iniciar a rodada de ataque
-- ou alocar tropas se ele ainda tiver tropas sobrando
-- params: User player, User bot, [String] states, Int troopsAvaliable
fourth_screen :: (User, User) -> [String] -> Int -> IO()
fourth_screen (player, bot) states troopsAvaliable = do
    putStrLn("-- SUA RODADA --")
    putStrLn(" 1 - Visualizar os territórios/exércitos atuais")
    putStrLn(" 2 - Iniciar rodada")
    putStrLn(" 3 - Alocar tropas")
    putStrLn(" 4 - Realocar tropas")
    opt <- getLine

    if opt == "1" then
        putStrLn("Seus estados")
        putStrLn(statesAndTroops_view(getEstados player [] 0))
        putStrLn("Estados inimigos")
        putStrLn(statesAndTroops_view(getEstados bot [] 0))
        putStrLn("Digite 'c' para continuar")
        temp <- getLine
        fourth_screen (player, bot) states troopsAvaliable
    else if opt == "2" then
        fifth_screen (player, bot) states
    else if opt == "3" && troopsAvaliable > 0 then
        second_screen (player, bot) estados troopsAvaliable
    else if opt == "4" then
        putStrLn("REALOCAR TROPAS")
        putStrLn(statesAndTroops_view(getEstados player [] 0)) -- lista de territórios atuais do jogador
        putStr(" de: ")
        stateFrom <- getLine
        if (getEstado stateFrom player) > 1 then
            putStr("quantidade de tropas: ")
            quant <- readLn :: IO Int
            if quant < (getEstado stateFrom player) - 1 then
                putStrLn(statesAndTroops_view(getNeighbours (getEstados player [] 0) stateFrom)) -- lista de territórios adjacentes ao territorio escolhido
                putStr(" para:")    
                stateTo <- getLine
                realocaTroopsView "player" quant stateFrom stateTo
                -- realocar tropas chamando a quarta tela
        else 
            putStrLn("-- ENTRADA INVALIDA! --")
            fourth_screen (player, bot) states troopsAvaliable
    else
        putStrLn("-- ENTRADA INVALIDA! --")
        fourth_screen (player, bot) states troopsAvaliable

-- QUINTA TELA
-- pergunta se o jogador deseja atacar
-- params: User player, User bot, [String] states
fifth_screen :: (User, User) -> [String] -> IO()
fifth_screen (player, bot) states = do
    putStrLn("Deseja atacar? (s/n)")
    result <- getLine
    if result == "s" then
        sixth_screen (player, bot) states false 
    else if result == "n" then
        seventh_screen (player, bot) states 

-- SEXTA TELA
-- a tela de ataque
-- ele escolhe o territorio atacante e o territorio que o bot vai defender
-- os dados rodam e decide quem ganhou  
-- params: User player, User bot, [String] states, Bool win
sixth_screen :: (User, User) -> [String] -> Bool -> IO()
sixth_screen (player, bot) states win = do
    putStrLn("-- Escolha o estado atacante:")
    putStrLn("Seus estados: ")
    putStrLn(getEstados player [] 0) -- lista de territórios atuais do jogador
    putStrLn("0 - nao atacar")
    putStrLn(">")
    estadoAtacante <- getLine
    if (state `elem` (getEstados player [] 0)) then
        if estadoAtacante == 0 then
            seventh_screen (player, bot) states
        else
            putStrLn("-- Escolha o estado que deseja atacar")
            putStrLn("Estados inimigos: ")
            putStrLn(getNeighbours (getEstados bot [] 0) estadoAtacante) -- lista de territorios atuais do inimigo que fazem fronteira
            putStrLn("0 - nao atacar")
            putStrLn(">")
            estadoDefesa <- getLine
            if estadoDefesa == 0 then
                sixth_screen (player, bot) states
            else 
                
                seventh_screen (attack player bot estadoAtacante estadoDefesa) states false
    else
        putStrLn("-- ESTADO INDISPONIVEL --")
        sixth_screen (player, bot) states false

-- SETIMA TELA
{- termina a rodada do jogador e verfica se o jogador ganhou
 se ele tiver ganhado exibe VOCE GANGOU
 se o bot tiver ganhado nesta rodada exibe VOCE PERDEU
 se nenhum tiver ganhado na rodada ele iniciara a rodada do bot
 e logo em seguinda volta para a QUARTA TELA -}
-- params: User player, User bot, [String] states, Bool win
seventh_screen :: (User, User) -> [String] -> Bool -> IO()
seventh_screen (player, bot) states win = do
    putStrLn("-- FIM DE RODADA --")
    -- addTroops (player, bot)
    if (verificaVitoria player win) == true then
        win player
        putStrLn("-- Ate mais! Digite qualquer tecla para fechar")
        tecla <- getLine
    else if (verificaVitoria bot win) == true then
        win bot
        putStrLn("-- Ate mais! Digite qualquer tecla para fechar")
        tecla <- getLine
    else 
        -- botRound (player, bot) states 5 false
        fourth_screen (player, bot) states 5

rules -> IO()
rules = do
    putStrLn("------------------------ COMO JOGAR ------------------------")

    putStrLn("Ao começar a partida, o jogador receberá, de forma aleatória, seu objetivo, sendo conquistar todos os estado.")
    putStrLn("Com o seu objetivo definido, o jogador irá receber 4 territórios e a máquina começa com 5 territórios, espalhados de forma aleatória no mapa do Nordeste, cada um com um exército.")
    putStrLn("Em seguida, a primeira rodada começará, com as seguintes etapas que se repetirão ao longo do jogo:")
    putStrLn("a) receber novos exércitos e os colocar de acordo com a sua estratégia;")
    putStrLn("b) se desejar, atacar o seu adversário e ")
    putStrLn("c) deslocar seus exércitos se houver conveniência.")

    putStrLn("")
    putStrLn("Etapa A: Colocação de exércitos")
    putStrLn("O jogador, no início de sua jogada, recebe exércitos da seguinte forma: soma-se o número total de seus territórios e divide-se por 2, só se considerando a parte inteira do resultado. ")

    putStrLn("")
    putStrLn("Etapa B: Ataques")
    putStrLn("É necessário que haja pelo menos 1 exército em cada território ocupado. Assim, para atacar a partir de um território, são necessários ao menos 2 exércitos neste mesmo território. O exército de ocupação não tem o direito de atacar.")

    putStrLn("Regras de ataque")
    putStrLn("  1. O ataque, a partir de um território qualquer possuído, só pode ser dirigido a um território adversário que tenha fronteiras em comum (territórios contíguos).")
    putStrLn("  2. O número de exércitos que poderá participar de um ataque será igual ao número de exércitos situados no território atacante menos um, que é o exército de ocupação.")
    putStrLn("  3. O número máximo de exércitos participantes em cada ataque é de 3, mesmo que o número de exércitos possuídos no território seja superior a 4.")
    putStrLn("  4. Um jogador pode atacar tantas vezes quantas quiser para conquistar um território adversário, até ficar só um exército no seu território ou, ainda, até quando achar conveniente não atacar.")
    putStrLn("  5. Após uma batalha, a decisão de quem ganha e quem perde exércitos é feita da seguinte forma: o jogo de forma aleatória escolhe um número entre 1 e 6 para o(s) dado(s) do ataque e da defesa, compara-se o maior ponto do dado atacante com o maior ponto do dado defensor e o maior deles ganha, sendo que o empate é sempre da defesa. Em seguida compara-se o 2o. maior ponto atacante com o 2o. maior do defensor, e a decisão de vitória é como no caso anterior. Por fim, comparam os menores valores, baseando-se na mesma regra.")

    putStrLn("")
    putStrLn("Se após a batalha o atacante destruir todos os exércitos do território do defensor, terá então conquistado o território e deverá, após a conquista, deslocar seus exércitos atacantes para o território conquistado. A quantidade de exércitos que poderão se deslocar variam entre 1 e 3, dependendo da quantidade de exércitos que ainda restam no território atacante. ")

    putStrLn("")
    putStrLn("Etapa C: Remanejamentos")
    putStrLn("Ao finalizar seus ataques o jogador poderá, de acordo com a sua estratégia, efetuar deslocamentos de exércitos entre os seus territórios contíguos. \n Estes deslocamentos deverão obedecer às seguintes regras:\n  1. em cada território deve permanecer sempre pelo menos um exército (de ocupação) que nunca pode ser deslocado;\n   2. um exército pode ser deslocado uma única vez, isto é, não se pode deslocar um exército para um território contíguo e deste para outro, também contíguo, numa mesma jogada.")

    putStrLn("")
    putStrLn("Final do Jogo")
    putStrLn("O jogo termina quando o jogador ou computador conquista todos os estados.")

    putStrLn("------------------------------------------------------------------------------------------")
