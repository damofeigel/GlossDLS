{-# LANGUAGE LambdaCase #-}
module Dibujo (
    Dibujo,
    figura, rotar, espejar, rot45, apilar, juntar, encimar,
    r180, r270,
    (.-.), (///), (^^^),
    cuarteto, encimar4, ciclar,
    foldDib, mapDib,
    figuras
) where


{-
Gramática de las figuras:
<Fig> ::= Figura <Bas> | Rotar <Fig> | Espejar <Fig> | Rot45 <Fig>
    | Apilar <Float> <Float> <Fig> <Fig> 
    | Juntar <Float> <Float> <Fig> <Fig> 
    | Encimar <Fig> <Fig>
-}


data Dibujo a = Borrar -- Completar
    deriving (Eq, Show)

-- Agreguen los tipos y definan estas funciones

-- Construcción de dibujo. Abstraen los constructores.

figura :: a -> Dibujo a  
figura = Figura 

rotar :: Dibujo a -> Dibujo a 
rotar = Rotar 

espejar :: Dibujo a -> Dibujo a 
espejar = Espejar

rot45 :: Dibujo a -> Dibujo a 
rot45 = Rot45

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a 
apilar = Apilar

juntar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a 
juntar = Juntar 

encimar :: Dibujo a -> Dibujo a -> Dibujo a 
encimar = Encimar 


-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 dib = rotar(rotar dib)

r270 :: Dibujo a -> Dibujo a
r270 = rotar(r180 dib)

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) = apilar 1.0 1.0 

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) = juntar 1.0 1.0 

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) = encimar 

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto = (///) ((.-.) d1 d2) ((.-.) d3 d4)

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 = undefined

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar = undefined

-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de Floatro a la lógica
foldDib :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
       (Float -> Float -> b -> b -> b) -> 
       (Float -> Float -> b -> b -> b) -> 
       (b -> b -> b) ->
       Dibujo a -> b
foldDib fig _ _ _ _ _ _ (Figura dib) = fig dib
foldDib fig rot esp rot45 api jut enc (Rotar dib) = rot (foldDib fig rot esp rot45 api jut enc dib)
foldDib fig rot esp rot45 api jut enc (Espejar dib) = esp (foldDib fig rot esp rot45 api jut enc dib)
foldDib fig rot esp rot45 api jut enc (Rot45 dib) = rot45 (foldDib fig rot esp rot45 api jut enc dib)
foldDib fig rot esp rot45 api jut enc (Apilar x y dib1 dib2) = api x y (foldDib fig rot esp rot45 api jut enc dib1)
                                                                       (foldDib fig rot esp rot45 api jut enc dib2)

foldDib fig rot esp rot45 api jut enc (Juntar x y dib1 dib2) = jut x y (foldDib fig rot esp rot45 api jut enc dib1)
                                                                       (foldDib fig rot esp rot45 api jut enc dib2)

foldDib fig rot esp rot45 api jut enc (Encimar dib1 dib2) = enc (foldDib fig rot esp rot45 api jut enc dib1)
                                                                (foldDib fig rot esp rot45 api jut enc dib2)

-- Demostrar que `mapDib figura = id`
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib = undefined

-- Junta todas las figuras básicas de un dibujo.
figuras :: Dibujo a -> [a]
figuras dib =
            foldDib
            (: [])                              -- Figura 
            id                                  -- Rotar
            id                                  -- Espejar
            id                                  -- Rot45
            (\f1 f2 dib1 dib2 -> dib1 ++ dib2)  -- Apilar
            (\f1 f2 dib1 dib2 -> dib1 ++ dib2)  -- Juntar
            (++)                                -- Encimar
            dib

