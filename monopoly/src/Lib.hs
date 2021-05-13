module Lib where
import Text.Show.Functions ()
type Acciones = Participante -> Participante
type Propiedad = (String,Int)

data Participante = Unparticipante{
    nombre      :: String,
    dinero      :: Int,
    tactica     :: String,
    propiedades :: [Propiedad],
    acciones    :: [Acciones]
}deriving (Show)

pagarAAccionistas :: Acciones
pagarAAccionistas unparticipante
 |tactica unparticipante == "Accionista" = unparticipante {dinero = dinero unparticipante + 200}
 |otherwise                              = unparticipante {dinero = dinero unparticipante - 100 }

enojarse :: Acciones
enojarse unparticipante = unparticipante {dinero= dinero unparticipante + 50, acciones = acciones unparticipante ++ [gritar] }

pasarPorElBanco :: Acciones
pasarPorElBanco unparticipante = unparticipante {dinero= dinero unparticipante + 40, tactica = "Comprador compulsivo" }

gritar :: Acciones
gritar unparticipante = unparticipante {nombre= "AHHHH" ++ nombre unparticipante}

subastar :: Propiedad -> Acciones
subastar propiedad unparticipante 
 |tactica unparticipante == "Accionista" || tactica unparticipante == "Oferente singular" = unparticipante {dinero= dinero unparticipante - (snd propiedad), propiedades= propiedades unparticipante ++ [propiedad]}
 |otherwise                                                                               = unparticipante
 
cobrarAlquileres :: Acciones
cobrarAlquileres unparticipante = unparticipante {dinero = dinero unparticipante + (10 * length ( filter (<150) (map snd (propiedades unparticipante)))) + (20 * length ( filter (>150) (map snd (propiedades unparticipante))))}

sumarDiez :: Acciones
sumarDiez unparticipante = unparticipante{dinero = dinero unparticipante + 10}

hacerBerrinche :: Propiedad ->Acciones
hacerBerrinche propiedad unparticipante
 |dinero unparticipante >= (snd propiedad) = unparticipante {dinero = dinero unparticipante - (snd propiedad), propiedades = propiedades unparticipante ++ [propiedad]}
 |otherwise = (hacerBerrinche propiedad).gritar.sumarDiez $unparticipante

ultimaRonda :: Participante -> Acciones
ultimaRonda unparticipante = foldr1 (.) (acciones unparticipante)

juegoFinal :: Participante -> Participante -> String
juegoFinal unparticipante1 unparticipante2
 |dinero (ultimaRonda unparticipante1 $unparticipante1) > dinero (ultimaRonda unparticipante2 $unparticipante2) = nombre unparticipante1
 |otherwise = nombre unparticipante2

--Modelos:
carolina :: Participante
carolina = (Unparticipante "Carolina" 501 "Accionista" [] [pagarAAccionistas,hacerBerrinche propiedad1,cobrarAlquileres])

manuel :: Participante
manuel = (Unparticipante "Manuel" 500 "Oferente singular" [] [enojarse,hacerBerrinche propiedad2,cobrarAlquileres])

propiedad1 :: Propiedad
propiedad1 = ("Casita en miami",1000)

propiedad2 :: Propiedad
propiedad2 = ("Casita en Dubai",510)

propiedad3 :: Propiedad
propiedad3 = ("Casita precaria",100)