

:- module(frontier, [
        frontier/2
        ]).

fronteira("Paraiba", "RioGrandeDoNorte").
fronteira("Paraiba", "Pernambuco").
fronteira("Paraiba", "Ceara").
fronteira("Pernambuco", "Alagoas").
fronteira("Pernambuco", "Bahia").
fronteira("Pernambuco", "Paraiba").
fronteira("Pernambuco", "Piaui").
fronteira("Pernambuco", "Ceara").
fronteira("Bahia", "Sergipe").
fronteira("Bahia", "Alagoas").
fronteira("Bahia", "Pernambuco").
fronteira("Bahia", "Piaui").
fronteira("Piaui", "Maranhao").
fronteira("Piaui", "Bahia").
fronteira("Piaui", "Ceara").
fronteira("Piaui", "Pernambuco").
fronteira("Maranhao", "Piaui").
fronteira("Ceara", "RioGrandeDoNorte").
fronteira("Ceara", "Piaui").
fronteira("Ceara", "Pernambuco").
fronteira("Ceara", "Paraiba").
fronteira("RioGrandeDoNorte", "Ceara").
fronteira("RioGrandeDoNorte", "Paraiba").
fronteira("Alagoas", "Pernambuco").
fronteira("Alagoas", "Sergipe").
fronteira("Alagoas", "Bahia").
fronteira("Sergipe", "Bahia").
fronteira("Sergipe", "Alagoas").




frontier(State1, State2) :-
    fronteira(State1, State2).
