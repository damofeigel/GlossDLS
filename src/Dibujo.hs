
module Dibujo (
    Dibujo,
    figura, rotar, espejar, rot45, apilar, juntar, encimar,
    r180, r270,
    (.-.), (///), (^^^),
    cuarteto, encimar4, ciclar,
    foldDib, mapDib,
    figuras
) where


data Dibujo a = Figura a | Rotar (Dibujo a) | Espejar (Dibujo a)
            | Rot45 (Dibujo a) | Apilar Float Float (Dibujo a) (Dibujo a)
            | Juntar Float Float (Dibujo a) (Dibujo a)
            | Encimar (Dibujo a) (Dibujo a)
        deriving(Eq, Show)


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
r270 dib = rotar(r180 dib)

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) = apilar 100.0 100.0

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) = juntar 100.0 100.0

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) = encimar

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto d1 d2 d3 d4 = (.-.) ((///) d1 d2) ((///) d3 d4)

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 a = encimar (r270 a) (encimar (encimar a (rotar a)) (r180 a))

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
--ciclar a = juntar 1 1 (r270 a) (apilar 1 1 (r180 a) (juntar 1 1 a (rotar a)))
ciclar p = cuarteto p (rotar p ) (r180 p) (r270 p) 


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
mapDib fun (Figura dib) = fun dib
mapDib fun (Rotar dib) = Rotar (mapDib fun dib)
mapDib fun (Espejar dib) = Espejar (mapDib fun dib)
mapDib fun (Rot45 dib) = Rot45 (mapDib fun dib)
mapDib fun (Apilar x y dib1 dib2) = Apilar x y (mapDib fun dib1) (mapDib fun dib2)
mapDib fun (Juntar x y dib1 dib2) = Juntar x y (mapDib fun dib1) (mapDib fun dib2)
mapDib fun (Encimar dib1 dib2) = Encimar (mapDib fun dib1) (mapDib fun dib2)

-- Junta todas las figuras básicas de un dibujo.
figuras :: Dibujo a -> [a]
figuras =
        foldDib
        (: [])
        id
        id
        id
        (\f1 f2 dib1 dib2 -> dib1 ++ dib2)
        (\f1 f2 dib1 dib2 -> dib1 ++ dib2)
        (++)