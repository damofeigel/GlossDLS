module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

import Graphics.Gloss(Picture, Display(InWindow), makeColorI, color, pictures, translate, white, display)
import Dibujo (Dibujo, foldDib, figura)
import FloatingPic (FloatingPic, Output, grid, half)
import Graphics.Gloss.Data.Point.Arithmetic as V

-- Interpretación de un dibujo
-- formulas sacadas del enunciadoFloatingPic.
-- No se si se puede, pero importe de nuevo aca half y el choclo ese de Gloss

{-
    TODO: * todo lo que tenga que ver con los puntos moverlo a Floating pics!!
          * el dibujo feo esta mas feo de lo que deberia! esta chato!
-}

interp :: Output a -> Output (Dibujo a)
interp f = foldDib 
    f                                                                          -- figura                                    
    (\f x w h -> f (x V.+ w) h (V.negate w))                                   -- Rotar
    (\f x w h -> f (x V.+ w) (V.negate w) h )                                  -- espejar
    (\f x w h -> f (x V.+ half(w V.+ h)) (half (w V.+ h)) (half (h V.- w)))    -- rotar45
    auxApilar                                                                  -- Apilar
    auxJuntar                                                                  -- Juntar
    (\f g x w h -> pictures[f x w h, g x w h])                                 -- encimar
 

auxApilar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic         
auxApilar n m f g x w h = pictures [f (x V.+ h') w (r V.* h),
                                    g x w h']
                        where r' = n / (m Prelude.+ n)       
                              r  = m / (m Prelude.+ n)
                              h' = r V.* h  
                              
auxJuntar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
auxJuntar n m f g x w h = pictures [f x  w' h, g (x V.+ w') (r' V.* w) h]
                        where r' = n / (m Prelude.+ n)       
                              r  = m / (m Prelude.+ n)
                              w' = r V.* w  


-- Configuración de la interpretación
data Conf = Conf {
        name :: String,
        pic :: FloatingPic
    }

interpConf :: Conf -> Float -> Float -> Picture 
interpConf (Conf _ p) x y = p (0, 0) (x,0) (0,y)

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial cfg size = do
    let n = name cfg
        win = InWindow n (ceiling size, ceiling size) (0, 0)
    display win white $ withGrid (interpConf cfg size size) size size
  where withGrid p x y = translate (-size/2) (-size/2) $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
        grey = makeColorI 120 120 120 120