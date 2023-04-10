import Dibujo
import Graphics.Gloss (Vector, Rectangle (Rectangle))
import Interp (Conf(..), interp)
import FloatingPic (FloatingPic, Output)
import Dibujos.Feo (BasicaSinColor(Rectangulo))
import Grilla (grilla)

{-
type FloatingPic = Vector -> Vector -> Vector -> Picture
type Output a = a -> FloatingPic

Output a -> Output (Dibujo a)

a -> Vector -> Vector -> Vector -> Picture -> (Dibujo a) -> Vector -> Vector -> Vector -> Picture 
-}

fig1 :: Dibujo Vector
fig1 = figura (2, 4)


testConf :: Conf
testConf = Conf {
    name = "Test",
    pic = interp grilla [fig1]
}


