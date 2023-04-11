import Test.HUnit

import Dibujo (Dibujo, figura, rotar, espejar, rot45, apilar,
                juntar, encimar, foldDib, mapDib, figuras)


varDibujo :: Int -> Dibujo Int
varDibujo = figura

testfigura :: Test
testfigura = TestCase (assertEqual "figura"  "Figura 1" (show $ figura 1))

testrotar :: Test
testrotar = TestCase (assertEqual "rotar" "Rotar (Figura 1)" (show $ rotar $ varDibujo 1))

testespejar :: Test
testespejar = TestCase (assertEqual "espejar" "Espejar (Figura 1)" (show $ espejar $ varDibujo 1))

testrot45 :: Test
testrot45 = TestCase (assertEqual "rotar45"  "Rot45 (Figura 1)" (show $ rot45 $ varDibujo 1))

testapilar :: Test
testapilar = TestCase (assertEqual "apilar" "Apilar 0.0 0.0 (Figura 1) (Figura 2)"
                        (show $ apilar 0 0 (varDibujo 1) (varDibujo 2)))

testjuntar :: Test
testjuntar = TestCase (assertEqual "juntar" "Juntar 0.0 0.0 (Figura 1) (Figura 2)"
                        (show $ juntar 0 0 (varDibujo 1) (varDibujo 2)))

testencimar :: Test
testencimar = TestCase (assertEqual "encimar" "Encimar (Figura 1) (Figura 2)"
                            (show $ encimar (varDibujo 1) (varDibujo 2)))


expectedfoldDib :: String
expectedfoldDib = "Espejar (Apilar 0.0 0.0 (Encimar (Figura 1) (Figura 2)) (Juntar 0.0 0.0 (Rot45 (Figura 3)) (Rotar (Figura 4))))"


dibujo :: Dibujo Int
dibujo  = espejar (apilar 0 0 (encimar (varDibujo 1) (varDibujo 2))
                                (juntar 0 0 (rot45 (varDibujo 3)) (rotar (varDibujo 4))))

testfoldDib :: Test
testfoldDib = TestCase (assertEqual "foldDib" expectedfoldDib
                            (show $ foldDib figura rotar espejar rot45 apilar juntar encimar dibujo))


expectedmadDibId :: String
expectedmadDibId = "Espejar (Apilar 0.0 0.0 (Encimar (Figura 1) (Figura 2)) (Juntar 0.0 0.0 (Rot45 (Figura 3)) (Rotar (Figura 4))))"

testmapDibId :: Test
testmapDibId = TestCase (assertEqual "mapDibId" expectedmadDibId (show $ mapDib figura dibujo))

funMap :: a -> Dibujo a
funMap a = rotar (figura a)

expectedmadDib :: String
expectedmadDib = "Espejar (Apilar 0.0 0.0 (Encimar (Rotar (Figura 1)) (Rotar (Figura 2))) (Juntar 0.0 0.0 (Rot45 (Rotar (Figura 3))) (Rotar (Rotar (Figura 4)))))"

testmapDib :: Test
testmapDib = TestCase (assertEqual "mapDib" expectedmadDib (show $ mapDib funMap dibujo))

expectedValuefiguras :: Int
expectedValuefiguras = sum[1,2,3,4]

testfiguras :: Test
testfiguras = TestCase (assertEqual "figuras" expectedValuefiguras (sum (figuras dibujo)))

tests = TestList [testfigura, testrotar, testespejar, testrot45,
                    testapilar, testjuntar, testencimar, testfoldDib,
                    testmapDibId, testmapDib, testfiguras]
