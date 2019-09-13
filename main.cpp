#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

/**
 * User MODEL
 * */
typedef struct userTag
{
    char name[20];
    int totalTroops;
    int avaliable_army_per_round;
    map<int, int> statesAndArmy;

} user;

// IDs dos estados disponiveis (GLOBAL)
vector<int> estadosDisponiveis = {1, 2, 3, 4, 5, 6, 7, 8, 9};

//GLOBAL
user player = {"Jogador", 4, 5, {{0, 0}}};
user bot = {"Bot", 5, 5, {{0, 0}}};

void rules(); // Exibe uma VIEW com todas as regras
int getOption();
void allocateTerritories();
int winCheck(user player, user bot);
void play();

void estados_view(user player);
void first_menu();
string color(string cor);
void second_screen(user player, user bot, vector<int> estados); // done
void estados_view(user player);
void third_screen(user player, user bot, int state, vector<int> estados);
void fourth_screen(user player, user bot, vector<int> estados);
void fifth_screen(user player, user bot, vector<int> estados);
void sixth_screen(user player, user bot, vector<int> estados);
void seventh_screen(user player, user bot, vector<int> estados);
void eigth_screen();
void nineth_screen();

//--------------------------------------CONTROLLER---------------------------------------------
/**
 * Coloca os estados e exercitos iniciais no player e no bot
 * */
//DONE
void allocateTerritories()
{
    int quantidadePlayer = 3;

    srand(time(NULL));

    while (quantidadePlayer >= 0)
    {

        int estadoId = (rand() % (estadosDisponiveis.size() + 1) + 1);
        // Se o estadoId random estiver contido nos estados disponiveis:
        if (find(estadosDisponiveis.begin(), estadosDisponiveis.end(), estadoId) != estadosDisponiveis.end())
        {

            player.statesAndArmy.erase(estadoId);
            player.statesAndArmy.insert(pair<int, int>(estadoId, 1));
            // Apaga o id do estado no indice que ele estiver no vetor:
            for (vector<int>::iterator it = estadosDisponiveis.begin(); it != estadosDisponiveis.end(); it++)
            {
                if (*it == estadoId)
                {
                    estadosDisponiveis.erase(it);
                    break;
                }
            }
            quantidadePlayer = quantidadePlayer - 1;
        }
    }

    for (vector<int>::iterator it = estadosDisponiveis.begin(); it != estadosDisponiveis.end(); it++)
    {
        bot.statesAndArmy.erase(*it);
        bot.statesAndArmy.insert(pair<int, int>(*it, 1));
    }

    estadosDisponiveis.clear();
}

//Adiciona tropas a cada rodada aos jogadores.
void addTroops(user &player, user &bot)
{
    player.avaliable_army_per_round += player.statesAndArmy.size() / 2;
    bot.avaliable_army_per_round += player.statesAndArmy.size() / 2;
}

// Recebe um usuário (bot ou player) e verifica se o mesmo ja ganhou a partida
//DONE

//DONE
vector<int> getTroops(user jogador)
{
    vector<int> troops(9);

    for (pair<int, int> element : jogador.statesAndArmy)
    {
        if (element.second > 0)
        {
            troops[element.first] = element.second;
        }
    }

    return troops;
}
//opcoes
//CHECK
int getOption()
{
    string opt = "";
    int response = -1;
    while (response == -1)
    {
        cout << ">>>>> ";
        cin >> opt;

        if (opt == "1")
            response = 1;
        else if (opt == "2")
            response = 2;
        else if (opt == "3")
            response = 3;

        else if (opt == "4")
            response = 4;
        else
            response = -1;

        if (response == -1)
            cout << color("red_b") + "Resposta Invalida!!" << endl;
    }
    return response;
}

//Funcao que aloca um determinado numero de tropas em um estado
//DONE
void allocateTroops(user &jogador, int state, int troopsValue)
{   
    jogador.statesAndArmy[state] += troopsValue;
}

//Retorna os territorios de um determinado usuario
//DONE
vector<int> getTerritories(user jogador)
{
    vector<int> territorios(9);

    for (pair<int, int> element : jogador.statesAndArmy)
    {
        if (element.second > 0)
        {
            territorios[element.first - 1] = element.first;
        }
    }

    return territorios;
}


//CHECK
string getState(int state)
{
    if (state == 1)
        return color("padrao") + "1 - Alagoas";
    if (state == 2)
        return color("padrao") + "2 - Bahia";
    if (state == 3)
        return color("padrao") + "3 - Ceara";
    if (state == 4)
        return color("padrao") + "4 - Maranhao";
    if (state == 5)
        return color("padrao") + "5 - Paraiba";
    if (state == 6)
        return color("padrao") + "6 - Pernambuco";
    if (state == 7)
        return color("padrao") + "7 - Piaui";
    if (state == 8)
        return color("padrao") + "8 - Rio Grande do Norte";
    if (state == 9)
        return color("padrao") + "9 - Sergipe";
}

//  attack controller

void attack(user &p1, user &p2, int e1, int e2)
{

    int e1Troops = p1.statesAndArmy[e1];
    int e2Troops = p2.statesAndArmy[e2];

    srand(time(NULL));

    while (true)
    {

        if (e1Troops <= 1)
        {
            break;
        }

        else if (e2Troops <= 0)
        {
            p2.statesAndArmy.erase(e2);
            break;
        }

        //dado do ataque
        int random1 = rand() % 6 + 1;
        //dado da defesa
        int random2 = rand() % 6 + 1;

        //se dado do ataque for maior que o da defesa, ataque ganha
        if (random1 > random2)
        {
            p2.totalTroops--;
            e2Troops--;
        }
        //se dado da defesa for maior ou igual o do ataque, defesa ganha
        else if (random1 <= random2)
        {
            p1.totalTroops--;
            e1Troops--;
        }
    }

    if (e1Troops > 1)
    {
        p1.statesAndArmy.erase(e2);
        p1.statesAndArmy.insert(pair<int, int>(e2, e1Troops / 2));

        p1.statesAndArmy.erase(e1);
        p1.statesAndArmy.insert(pair<int, int>(e1, e1Troops / 2));

        p2.statesAndArmy.erase(e2);
        //p2.statesAndArmy.insert(pair<int, int>(e2, 0));
    }

    else
    {
        p1.statesAndArmy.erase(e1);
        p1.statesAndArmy.insert(pair<int, int>(e1, e1Troops));

        p2.statesAndArmy.erase(e2);
        p2.statesAndArmy.insert(pair<int, int>(e2, e2Troops));
    }
}
// Inicia o jogo
//CHECK
void play()
{
    cout << "Iniciando jogo...\n"
         << flush;
    system("clear");

    vector<int> estados(9);
    estados = getTerritories(player);
    estados_view(player);
    estados_view(bot);

    second_screen(player, bot, estados);
}
// ---------------------------------------- VIEW -----------------------------------------

//CHECK
void estados_view(user jogador)
{
    // alagoas = 1
    // bahia = 2
    // ceara = 3
    // maranhao = 4
    // paraiba = 5
    // pernambuco = 6
    // piaui = 7
    // rio_grande_do_norte = 8
    // sergipe = 9
    int i;
    cout << color("roxo_b") << "# Estados do " << jogador.name << endl;
    for (pair<int, int> estado : jogador.statesAndArmy)
    {
        i = estado.first;

        if (i == 1)
            cout << color("padrao") << "  1 - Alagoas             - " << estado.second << endl;
        if (i == 2)
            cout << color("padrao") << "  2 - Bahia               - " << estado.second << endl;
        if (i == 3)
            cout << color("padrao") << "  3 - Ceara               - " << estado.second << endl;
        if (i == 4)
            cout << color("padrao") << "  4 - Maranhao            - " << estado.second << endl;
        if (i == 5)
            cout << color("padrao") << "  5 - Paraiba             - " << estado.second << endl;
        if (i == 6)
            cout << color("padrao") << "  6 - Pernambuco          - " << estado.second << endl;
        if (i == 7)
            cout << color("padrao") << "  7 - Piaui               - " << estado.second << endl;
        if (i == 8)
            cout << color("padrao") << "  8 - Rio Grande do Norte - " << estado.second << endl;
        if (i == 9)
            cout << color("padrao") << "  9 - Sergipe             - " << estado.second << endl;
    }
    cout << endl;
}

// primeira tela
//DONE
void first_menu()
{
    cout << color("verde_b") << "<--------------------  WARXENTE -------------------->\n";

    cout << "\n";

    cout << color("padrao") << "1. Iniciar jogo\n";
    cout << "2. Ler regras\n\n";

    int opt = getOption();
    if (opt == 1)
        play();
    else if (opt == 2)
    {
        rules();
        first_menu();
    }
    else
        ;
}

void second_screen(user player, user bot, vector<int> estados)
{
    cout << color("roxo_b") << "------------------------------------------------------------------------------------------" << endl
         << endl;
    cout << color("padrao") << "Coloque seus exercitos (" << player.avaliable_army_per_round << " disponiveis)" << endl
         << endl;
    cout << "ESTADOS DISPONIVEIS:" << endl
         << endl;
    estados_view(player);

    cout << ">> ";
    int state;
    cin >> state;

    third_screen(player, bot, state, estados);
    system("clear");
}

void third_screen(user player, user bot, int state, vector<int> estados)
{

    cout << "Quantos exércitos deseja posicionar no estado "
         << "< " << getState(state) << " > ? ";
    int troops;
    cin >> troops;

    if(troops <= player.avaliable_army_per_round){
        allocateTroops(player, state, troops);
    }
    else{
        cout << color("red_b") + "ENTRADA INVALIDA" << endl;
        third_screen(player, bot, state, estados);
    }

    player.avaliable_army_per_round = player.avaliable_army_per_round - troops;

    if (player.avaliable_army_per_round <= 0)
    {
        fourth_screen(player, bot, estados);
    }
    else
    {
        second_screen(player, bot, estados);
    }
    cout << endl;
}

void fourth_screen(user player, user bot, vector<int> estados)
{
    string fourth = "";
    string tmp;

    fourth += color("roxo_b") + "\nSUA RODADA\n";
    fourth += "\n";
    fourth += color("padrao") + " 1 - Visualizar os territórios/exércitos atuais\n";
    fourth += " 2 - Iniciar rodada\n";
    fourth += " 3 - Regras\n";
    fourth += " 4 - Alocar tropas\n";

    cout << fourth << endl;

    int opt = getOption();
    if (opt == 1)
    {
        system("clear");
        estados_view(player);
        estados_view(bot);

        cout << "Digite 'c' para continuar" << endl;
        cin >> tmp;

        fourth_screen(player, bot, estados);
    }

    else if (opt == 2)
    {
        fifth_screen(player, bot, estados);
    }
    else if (opt == 3)
    {
        rules();
        fourth_screen(player, bot, estados);
    }
    else if (opt == 4 && player.avaliable_army_per_round > 0)
    {
        second_screen(player, bot, estados);
    }else{
        cout << color("red_b") + "\n ENTRADA INVALIDA!" << endl;
        fourth_screen(player, bot, estados);
    }
}

// iniciando rodada
void fifth_screen(user player, user bot, vector<int> estados)
{
    cout << "Deseja atacar? (s/n)" << endl;
    string result;
    cin >> result;

    if (result == "s")
    {
        sixth_screen(player, bot, estados);
    }
    else if (result == "n")
    {   
        seventh_screen(player, bot, estados);
    }
}

// ataque
void sixth_screen(user player, user bot, vector<int> estados)
{
    //recursive
    system("clear");
    string sixth = "";

    sixth += color("verde_b") + "Escolha o estado atacante:\n";
    cout << sixth << endl;

    estados_view(player);
    cout << "0 - não atacar" << endl;
    cout << ">";

    int estadoAtacante;
    cin >> estadoAtacante;

    if (estadoAtacante == 0)
        seventh_screen(player, bot, estados);

    sixth = color("verde_b") + "Escolha o estado que deseja atacar:\n";
    cout << sixth << endl;
    estados_view(bot);
    // <lista de territórios inimigos>
    // n - <Estado no qual o jogador pode atacar, seguido de seus respectivos exércitos>
    cout << "0 - não atacar" << endl;
    cout << ">";
    int estadoDefesa;
    cin >> estadoDefesa;
    if (estadoDefesa == 0)
        sixth_screen(player, bot, estados);

    attack(player, bot, estadoAtacante, estadoDefesa);
    // bot.avaliable_army_per_round += 5;
    // player.avaliable_army_per_round += 5;

    //TO DO randomiza os dados, e exibe se o jogador conquistou o perdeu todos os territorios

    int win = winCheck(player, bot);
    //win = true; // TESTE
    if (win == 1)
    {
        seventh_screen(player, bot, estados);
    }
    else
    {
        fifth_screen(player, bot, estados);
    }
}

void botRound(user player, user bot, vector<int> estados)
{
    vector<int> estadosBot(9);
    estadosBot = getTerritories(bot);

    int state;
    for (int i = 0; i < 9; i++){
        if (estadosBot[i] != 0){
            state = i;
            break;
        }
    }
    int stateDefesa;
    for (int i = 0; i < 9; i++){
        if (estados[i] != 0){
            stateDefesa = i;
            break;
        }
    }

    allocateTroops(bot, estadosBot[0], bot.avaliable_army_per_round);

    attack(player, bot, estadosBot[0], stateDefesa);

    int win = winCheck(player, bot);
    if (win == 1)
    {
        eigth_screen();
    }
    else if (win == 2)
    {
        nineth_screen();
    }
    
}

void seventh_screen(user player, user bot, vector<int> estados)
{
    string seventh = "";
    seventh += "Fim de rodada: \n";

    cout << seventh;
    
    addTroops(player, bot);

    int win = winCheck(player, bot);
    
    if (win == 1)
    {
        eigth_screen();
    }
    else if (win == 2)
    {
        nineth_screen();
    }
    else
    {
        botRound(player, bot, estados);
        fourth_screen(player, bot, estados);
    }
}

void eigth_screen()
{
    string tecla;
    cout << color("red_b") + "VOCE PERDEU!\n";

    cout << "Ate mais! digite qualquer tecla para fechar\n\n";
    cin >> tecla;
    exit(0);
    
}

void nineth_screen()
{
    string tecla;
    cout << color("red_b") + "VOCE GANHOU!\n";

    cout << "Ate mais! digite qualquer tecla para fechar\n\n";
    cin >> tecla;
    exit(0);
}
// exibe na tela as regras do jogo
//DONE
void rules()
{
    // TO DO adicionar comando de limpar tela
    string regra = "";

    regra += color("roxo_b") + "COMO JOGAR\n";

    regra += color("padrao") + "Ao começar a partida, o jogador receberá, de forma aleatória, seu objetivo, sendo conquistar todos os estado.\n";

    regra += "Com o seu objetivo definido, o jogador irá receber 4 territórios e a máquina começa com 5 territórios, espalhados de forma aleatória no mapa do Nordeste, cada um com um exército.\n";

    regra += "Em seguida, a primeira rodada começará, com as seguintes etapas que se repetirão ao longo do jogo:\n a) receber novos exércitos e os colocar de acordo com a sua estratégia;\n b) se desejar, atacar o seu adversário e \n c) deslocar seus exércitos se houver conveniência.\n";

    regra += "\n";
    regra += "Etapa A: Colocação de exércitos\n";
    regra += "O jogador, no início de sua jogada, recebe exércitos da seguinte forma: soma-se o número total de seus territórios e divide-se por 2, só se considerando a parte inteira do resultado. \n";

    regra += "\n";
    regra += "Etapa B: Ataques\n";
    regra += "É necessário que haja pelo menos 1 exército em cada território ocupado. Assim, para atacar a partir de um território, são necessários ao menos 2 exércitos neste mesmo território. O exército de ocupação não tem o direito de atacar.\n";

    regra += "Regras de ataque\n";
    regra += "  1. O ataque, a partir de um território qualquer possuído, só pode ser dirigido a um território adversário que tenha fronteiras em comum (territórios contíguos).\n";
    regra += "  2. O número de exércitos que poderá participar de um ataque será igual ao número de exércitos situados no território atacante menos um, que é o exército de ocupação.\n";
    regra += "  3. O número máximo de exércitos participantes em cada ataque é de 3, mesmo que o número de exércitos possuídos no território seja superior a 4.\n";
    regra += "  4. Um jogador pode atacar tantas vezes quantas quiser para conquistar um território adversário, até ficar só um exército no seu território ou, ainda, até quando achar conveniente não atacar.\n";
    regra += "  5. Após uma batalha, a decisão de quem ganha e quem perde exércitos é feita da seguinte forma: o jogo de forma aleatória escolhe um número entre 1 e 6 para o(s) dado(s) do ataque e da defesa, compara-se o maior ponto do dado atacante com o maior ponto do dado defensor e o maior deles ganha, sendo que o empate é sempre da defesa. Em seguida compara-se o 2o. maior ponto atacante com o 2o. maior do defensor, e a decisão de vitória é como no caso anterior. Por fim, comparam os menores valores, baseando-se na mesma regra.\n";

    regra += "\n";
    regra += "Se após a batalha o atacante destruir todos os exércitos do território do defensor, terá então conquistado o território e deverá, após a conquista, deslocar seus exércitos atacantes para o território conquistado. A quantidade de exércitos que poderão se deslocar variam entre 1 e 3, dependendo da quantidade de exércitos que ainda restam no território atacante. \n";

    regra += "\n";
    regra += "Etapa C: Remanejamentos\n";
    regra += "Ao finalizar seus ataques o jogador poderá, de acordo com a sua estratégia, efetuar deslocamentos de exércitos entre os seus territórios contíguos. \n Estes deslocamentos deverão obedecer às seguintes regras:\n  1. em cada território deve permanecer sempre pelo menos um exército (de ocupação) que nunca pode ser deslocado;\n   2. um exército pode ser deslocado uma única vez, isto é, não se pode deslocar um exército para um território contíguo e deste para outro, também contíguo, numa mesma jogada.\n";

    regra += "\n";
    regra += "Final do Jogo\n";
    regra += "O jogo termina quando o jogador ou computador conquista todos os estados.\n";

    cout << regra << endl;

    cout << color("roxo_b") + "------------------------------------------------------------------------------------------" << endl
         << endl;

}

/**
 * Método para adicionar cor ao texto do terminal
 * */
string color(string nome)
{

    if (nome == "verde")
    {
        return "\033[0;32m";
    }
    else if (nome == "padrao")
    {
        return "\033[0m";
    }
    else if (nome == "verde_b")
    { // VERDE BOLD
        return "\033[1;32m";
    }
    else if (nome == "roxo_b")
    {
        return "\033[1;35m";
    }
    else if (nome == "red_b")
    {
        return "\033[1;31m";
    }
    else
    {
        return "\033[0;32m";
    }
}

int winCheck(user player, user bot)
{

    int win = 0; // 0 se ninguem ganhou, 1 se o player ganhou, 2 se a maquina ganhou;

    // Varre o mapa de estados e exercitos que um usuário possui e verifica se possui algum estado que ele não possui exercito.
    // Caso não possua exercito naquele estado, significa que o estado ainda não foi conquistado pelo usuário,portando ainda não ganhou a partida.
    vector<int> statesPlayer(9);
    statesPlayer = getTerritories(player);
    vector<int> statesBot(9);
    statesPlayer = getTerritories(bot);
    int winPlayer = 0;
    int winBot = 0;

    for(int i = 0; i < 9; i++){
        if(statesPlayer[i] != 0){
            winPlayer++;
        }else{
            winBot++;
        }
    }

    if (winPlayer == 9)
        win = 1;
    else if (winBot == 9)
        win = 2;
    else
        win = 0;

    return win;
}
int main()
{
    allocateTerritories();
    first_menu();

    return 0;
}