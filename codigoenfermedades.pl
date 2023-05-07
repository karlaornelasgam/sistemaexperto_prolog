enfermedad(difteria).
enfermedad(tosferina).
enfermedad(gastroenteritis).

sintomasde(membranagrusaygris, difteria).
sintomasde(dolordegarganta, difteria).
sintomasde(ronquera, difteria).
sintomasde(glandulasinflamadas, difteria).
sintomasde(dificultadpararespirar, difteria).

sintomasde(estornudos, tosferina).
sintomasde(secrecionnasal, tosferina).
sintomasde(fiebre, tosferina).
sintomasde(tos, tosferina).
sintomasde(silbidoagudo, tosferina).

sintomasde(vomito, gastroenteritis).
sintomasde(diarrea, gastroenteritis).
sintomasde(calambresstomacales, gastroenteritis).

medicamentosde(eritromicina, tosferina).
medicamentosde(claritromicina, tosferina).
medicamentosde(azitromicina, tosferina).
medicamentosde(penicilina, difteria).
medicamentosde(eritromicina, difteria).
medicamentosde(antitoxina, difteria).
medicamentosde(loperamida, gastroenteritis).
medicamentosde(subsalicilatodebismuto, gastroenteritis).

doctoresde(pediatra, tosferina).
doctoresde(medicogeneral, tosferina).
doctoresde(pediatra, difteria).
doctoresde(otolaringologo, difteria).
doctoresde(enfermedadinfecciosa, difteria).
doctoresde(medicogeneral, gastroenteritis).

sintoma(X, E) :- sintomasde(X, E).

buscar([], _, 0).
buscar([X|Xs], E, P) :- sintoma(X, E), buscar(Xs, E, S2), P is 1 + S2.
buscar([_|Xs], E, P) :- buscar(Xs, E, P).

cantSint(E, C) :- findall(X, sintoma(X, E), L), length(L, R), C is R.

diagnostico(Sintomas, Enfermedad, K) :- buscar(Sintomas, Enfermedad, P), cantSint(Enfermedad, T), K is P * 100 / T.

recetade(M, S) :- sintomasde(S, E), medicamentosde(M, E).

atiende_especialista(E, S) :- sintomasde(S, Z), doctoresde(E, Z).

mereceta(Es, M, E) :- medicamentosde(M, E), sintomasde(S, E), atiende_especialista(Es, S).

sistema_experto :-
    write("Ingresa los síntomas separados por coma: "),
    read(Sintomas),
    write("Ingresa la enfermedad a diagnosticar: "),
    read(Enfermedad),
    diagnostico(Sintomas, Enfermedad, K),
    format("La probabilidad de que el paciente tenga ~w es del ~2f%", [Enfermedad, K]).
