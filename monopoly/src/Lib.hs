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

modificarDinero :: Int -> Acciones
modificarDinero valor unparticipante = unparticipante {dinero = (+) (dinero unparticipante) valor}

pagarAAccionistas :: Acciones
pagarAAccionistas unparticipante
 |tactica unparticipante == "Accionista" = modificarDinero 200 unparticipante
 |otherwise                              = modificarDinero (-100) unparticipante

enojarse :: Acciones
enojarse = (\unparticipante -> unparticipante {acciones = acciones unparticipante ++ [gritar]}).modificarDinero 50

pasarPorElBanco :: Acciones
pasarPorElBanco unparticipante = (\unparticipante -> unparticipante {tactica = "Comprador compulsivo"}).modificarDinero 40 $unparticipante

gritar :: Acciones
gritar unparticipante = unparticipante {nombre= "AHHHH" ++ nombre unparticipante}

subastar :: Propiedad -> Acciones
subastar propiedad unparticipante 
 |elem (tactica unparticipante) ["Accionista","Oferente singular"] = (\unparticipante->unparticipante {propiedades= propiedades unparticipante ++ [propiedad]}).modificarDinero (-(snd propiedad)) $unparticipante
 |otherwise                                                                               = unparticipante

calcularAlquilerBaraOtoCaro :: (Int -> Bool) -> Participante -> Int
calcularAlquilerBaraOtoCaro valor unparticipante = 10 * length ( filter (valor) (map snd (propiedades unparticipante)))

cobrarAlquileres :: Acciones
cobrarAlquileres unparticipante = (modificarDinero (calcularAlquilerBaraOtoCaro (<150) unparticipante)).(modificarDinero (calcularAlquilerBaraOtoCaro (>=150) unparticipante)) $unparticipante

hacerBerrinche :: Propiedad ->Acciones
hacerBerrinche propiedad unparticipante
 |dinero unparticipante >= (snd propiedad) = unparticipante {dinero = dinero unparticipante - (snd propiedad), propiedades = propiedades unparticipante ++ [propiedad]}
 |otherwise = (hacerBerrinche propiedad).gritar.modificarDinero 10 $unparticipante

ultimaRonda :: Participante -> Acciones
ultimaRonda unparticipante = foldr1 (.) (acciones unparticipante)

juegoFinal :: Participante -> Participante -> String
juegoFinal unparticipante1 unparticipante2
 |dinero (ultimaRonda unparticipante1 $unparticipante1) > dinero (ultimaRonda unparticipante2 $unparticipante2) = nombre unparticipante1
 |otherwise = nombre unparticipante2

--Modelos:
carolina :: Participante
carolina = (Unparticipante "Carolina" 500 "Accionista" [] [pagarAAccionistas,hacerBerrinche propiedad1,cobrarAlquileres])

manuel :: Participante
manuel = (Unparticipante "Manuel" 500 "Oferente singular" [] [enojarse,hacerBerrinche propiedad2,cobrarAlquileres])

propiedad1 :: Propiedad
propiedad1 = ("Mansion en miameeee",1000)

propiedad2 :: Propiedad
propiedad2 = ("El Hilton",610)

propiedad3 :: Propiedad
propiedad3 = ("Casita precaria",50)