module Tests (
    testConf
) where

import Dibujo
import Graphics.Gloss
    ( Vector, Rectangle(Rectangle), Picture(..), line, text)
import Interp (Conf(..), interp)
import FloatingPic (FloatingPic, Output)
import Dibujos.Feo (BasicaSinColor(Rectangulo))
import Grilla (grilla)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V


fig :: Vector -> Dibujo String
fig (x,y) = figura (show (round x, round y))

testAll :: Dibujo String
testAll = grilla [
                  [fig(0,0), fig(0,1), fig(0,2), fig(0,3), fig(0,4), fig(0,5), fig(0,6), fig(0,7)],
                  [fig(1,0), fig(1,1), fig(1,2), fig(1,3), fig(1,4), fig(1,5), fig(1,6), fig(1,7)],
                  [fig(3,0), fig(3,1), fig(3,2), fig(3,3), fig(3,4), fig(3,5), fig(3,6), fig(3,7)],
                  [fig(4,0), fig(4,1), fig(4,2), fig(4,3), fig(4,4), fig(4,5), fig(4,6), fig(4,7)],
                  [fig(5,0), fig(5,1), fig(5,2), fig(5,3), fig(5,4), fig(5,5), fig(5,6), fig(5,7)],
                  [fig(6,0), fig(6,1), fig(6,2), fig(6,3), fig(6,4), fig(6,5), fig(6,6), fig(6,7)],
                  [fig(6,0), fig(6,1), fig(6,2), fig(6,3), fig(6,4), fig(6,5), fig(6,6), fig(6,7)],
                  [fig(7,0), fig(7,1), fig(7,2), fig(7,3), fig(7,4), fig(7,7), fig(7,6), fig(7,7)]
                 ]

interpText :: Output String
interpText string _ _ _= text string 

testConf :: Conf
testConf = Conf {
    name = "Test",
    pic = interp interpText testAll
}

{-

[fig00, fig01, fig02, fig03, fig04, fig05, fig06, fig07],
                  [fig10, fig11, fig12, fig13, fig14, fig15, fig16, fig17],
                  [fig20, fig21, fig22, fig23, fig24, fig25, fig26, fig27],
                  [fig30, fig31, fig32, fig33, fig34, fig35, fig36, fig37],
                  [fig40, fig41, fig42, fig43, fig44, fig45, fig46, fig47],
                  [fig50, fig51, fig52, fig53, fig54, fig55, fig56, fig57],
                  [fig60, fig61, fig62, fig63, fig64, fig65, fig66, fig67],
                  [fig70, fig71, fig72, fig73, fig74, fig75, fig76, fig77]


fig00 :: Dibujo String
fig00 = figura "(0,0)"

fig01 :: Dibujo String
fig01 = figura "(0,1)"

fig02 :: Dibujo String
fig02 = figura "(0,2)"

fig03 :: Dibujo String
fig03 = figura "(0,3)"

fig04 :: Dibujo String
fig04 = figura "(0,4)"

fig05 :: Dibujo String
fig05 = figura "(0,5)"

fig06 :: Dibujo String
fig06 = figura "(0,6)"

fig07 :: Dibujo String
fig07 = figura "(0,7)"

fig10 :: Dibujo String
fig10 = figura "(1,0)"

fig11 :: Dibujo String
fig11 = figura "(1,1)"

fig12 :: Dibujo String
fig12 = figura "(1,2)"

fig13 :: Dibujo String
fig13 = figura "(1,3)"

fig14 :: Dibujo String
fig14 = figura "(1,4)"

fig15 :: Dibujo String
fig15 = figura "(1,5)"

fig16 :: Dibujo String
fig16 = figura "(1,6)"

fig17 :: Dibujo String
fig17 = figura "(1,7)"

fig20 :: Dibujo String
fig20 = figura "(2,0)"

fig21 :: Dibujo String
fig21 = figura "(2,1)"

fig22 :: Dibujo String
fig22 = figura "(2,2)"

fig23 :: Dibujo String
fig23 = figura "(2,3)"

fig24 :: Dibujo String
fig24 = figura "(2,4)"

fig25 :: Dibujo String
fig25 = figura "(2,5)"

fig26 :: Dibujo String
fig26 = figura "(2,6)"

fig27 :: Dibujo String
fig27 = figura "(2,7)"

fig30 :: Dibujo String
fig30 = figura "(3,0)"

fig31 :: Dibujo String
fig31 = figura "(3,1)"

fig32 :: Dibujo String
fig32 = figura "(3,2)"

fig33 :: Dibujo String
fig33 = figura "(3,3)"

fig34 :: Dibujo String
fig34 = figura "(3,4)"

fig35 :: Dibujo String
fig35 = figura "(3,5)"

fig36 :: Dibujo String
fig36 = figura "(3,6)"

fig37 :: Dibujo String
fig37 = figura "(3,7)"

fig40 :: Dibujo String
fig40 = figura "(4,0)"

fig41 :: Dibujo String
fig41 = figura "(4,1)"

fig42 :: Dibujo String
fig42 = figura "(4,2)"

fig43 :: Dibujo String
fig43 = figura "(4,3)"

fig44 :: Dibujo String
fig44 = figura "(4,4)"

fig45 :: Dibujo String
fig45 = figura "(4,5)"

fig46 :: Dibujo String
fig46 = figura "(4,6)"

fig47 :: Dibujo String
fig47 = figura "(4,7)"

fig50 :: Dibujo String
fig50 = figura "(5,0)"

fig51 :: Dibujo String
fig51 = figura "(5,1)"

fig52 :: Dibujo String
fig52 = figura "(5,2)"

fig53 :: Dibujo String
fig53 = figura "(5,3)"

fig54 :: Dibujo String
fig54 = figura "(5,4)"

fig55 :: Dibujo String
fig55 = figura "(5,5)"

fig56 :: Dibujo String
fig56 = figura "(5,6)"

fig57 :: Dibujo String
fig57 = figura "(5,7)"

fig60 :: Dibujo String
fig60 = figura "(6,0)"

fig61 :: Dibujo String
fig61 = figura "(6,1)"

fig62 :: Dibujo String
fig62 = figura "(6,2)"

fig63 :: Dibujo String
fig63 = figura "(6,3)"

fig64 :: Dibujo String
fig64 = figura "(6,4)"

fig65 :: Dibujo String
fig65 = figura "(6,5)"

fig66 :: Dibujo String
fig66 = figura "(6,6)"

fig67 :: Dibujo String
fig67 = figura "(6,7)"

fig70 :: Dibujo String
fig70 = figura "(7,0)"

fig71 :: Dibujo String
fig71 = figura "(7,1)"

fig72 :: Dibujo String
fig72 = figura "(7,2)"

fig73 :: Dibujo String
fig73 = figura "(7,3)"

fig74 :: Dibujo String
fig74 = figura "(7,4)"

fig75 :: Dibujo String
fig75 = figura "(7,5)"

fig76 :: Dibujo String
fig76 = figura "(7,6)"

fig77 :: Dibujo String
fig77 = rot45 (figura "(7,7)")

-}

