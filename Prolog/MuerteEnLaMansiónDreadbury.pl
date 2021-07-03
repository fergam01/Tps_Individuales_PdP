%1)a)
vivenEnLamansion(tiaAgatha).
vivenEnLamansion(elMayordomo).
vivenEnLamansion(charles).

odia(tiaAgatha,Odiado):-
    vivenEnLamansion(Odiado),
    Odiado \= elMayordomo.

odia(charles,Odiado):-
    vivenEnLamansion(Odiado),
    not(odia(tiaAgatha,Odiado)).

odia(elMayordomo,Odiado):-
    odia(tiaAgatha,Odiado).

esMasRico(Persona,OtraPersona):-
    not(odia(elMayordomo,Persona)),
    vivenEnLamansion(Persona).

mata(Asesino,Victima):-
    odia(Asesino,Victima),
    not(esMasRico(Asesino,Victima)),
    vivenEnLamansion(Asesino).

/*1)b)
- Quién mató a la tía Agatha?. 
    ?- mata(Asesino,tiaAgatha).
    Asesino = tiaAgatha .

2)b)
- Si existe alguien que odie a milhouse.
    ?- odia(Odiador,milhouse).
    false.

- A quién odia charles.
    ?- odia(charles,Odiado).   
    Odiado = elMayordomo 

- El nombre de quien odia a tía Ágatha.
    ?- odia(Odiador,tiaAgatha). 
    Odiador = tiaAgatha ;
    Odiador = elMayordomo.

- Todos los odiadores y sus odiados.
    ?- odia(Odiador,Odiado).    
    Odiador = Odiado, Odiado = tiaAgatha ;
    Odiador = tiaAgatha,
    Odiado = charles ;
    Odiador = charles,
    Odiado = elMayordomo ;
    Odiador = elMayordomo,
    Odiado = tiaAgatha ;
    Odiador = elMayordomo,
    Odiado = charles.

- Si es cierto que el mayordomo odia a alguien.
    ?- odia(elMayordomo,Odiado). 
    Odiado = tiaAgatha ;
    Odiado = charles.
*/