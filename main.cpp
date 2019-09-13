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
    map<int, int> estado_e_exercitos;

} user;

// IDs dos estados disponiveis (GLOBAL)
vector<int> estadosDisponiveis = {0, 1, 2, 3, 4, 5, 6, 7, 8};

//GLOBAL
user bot;
user player;

void rules(); // Exibe uma VIEW com todas as regras
int getOption();
map<int, int> inicializateTroops();
void allocateTerritories(user &u, user &u2);
bool winCheck(user &u);
void play();
void estados_view(user &player);
void first_menu();

void allocateTerritories()
{
    int quantidadePlayer = 4;

    srand(time(NULL));

    while (quantidadePlayer >= 0)
    {

        int estadoId = (rand() % estadosDisponiveis.size());

        // Se o estadoId random estiver contido nos estados disponiveis:
        if (find(estadosDisponiveis.begin(), estadosDisponiveis.end(), estadoId) != estadosDisponiveis.end())
        {

            player.estado_e_exercitos.erase(estadoId);
            player.estado_e_exercitos.insert(pair<int, int>(estadoId, 1));
            // Apaga o id do estado no indice que ele estiver no vetor:
            for (vector<int>::iterator it = estadosDisponiveis.begin(); it != estadosDisponiveis.end(); it++)
            {
                if (*it == estadoId)
                {
                    estadosDisponiveis.erase(it);
                    break;
                }
            }
            quantidadePlayer--;
        }
    }

    for (vector<int>::iterator it = estadosDisponiveis.begin(); it != estadosDisponiveis.end(); it++)
    {
        bot.estado_e_exercitos.erase(*it);
        bot.estado_e_exercitos.insert(pair<int, int>(*it, 1));
        estadosDisponiveis.erase(it);
    }
}
