module Tests.TestsPred ( ) where
    
import Test.HUnit ( assertEqual, Test(TestList, TestCase) )

import Pred (Pred, cambiar, anyDib, allDib, orP, andP)

import Dibujo (Dibujo, figura, rotar, espejar, rot45, apilar,
                juntar, encimar, foldDib, mapDib, figuras)

-- Test de cambiar

predi :: Eq a => Num a => Pred a
predi a = a == 1

dibujo :: Dibujo Int
dibujo  = espejar (apilar 0 0 (encimar (figura 1) (figura 2))
            (juntar 0 0 (rot45 (figura 1)) (rotar (figura 3))))


dibujo2 :: Dibujo Int
dibujo2  = espejar (apilar 0 0 (encimar (figura 1) (figura 1))
            (juntar 0 0 (rot45 (figura 1)) (rotar (figura 1))))

expectedcambiar :: String
expectedcambiar =
    "Espejar (Apilar 0.0 0.0 (Encimar (Rotar (Figura 1)) (Figura 2)) (Juntar 0.0 0.0 (Rot45 (Rotar (Figura 1))) (Rotar (Figura 3))))"

testcambiar :: Test
testcambiar = TestCase (assertEqual "cambiar" 
                          expectedcambiar 
                            (show $ cambiar predi (rotar . figura) dibujo))

-- Test de anyDib

testanyDibTrue :: Test
testanyDibTrue = TestCase (assertEqual "anyDibTrue" True (anyDib predi dibujo))

predianyDibFalse :: Eq a => Num a => Pred a
predianyDibFalse a = a == 4

testanyDibFalse :: Test
testanyDibFalse = TestCase (assertEqual "anyDibFalse" False 
                                        (anyDib predianyDibFalse dibujo))

-- Test de allDib

testallDibTrue :: Test
testallDibTrue = TestCase (assertEqual "allDibTrue" True (allDib predi dibujo2))

testallDibFalse :: Test
testallDibFalse = TestCase (assertEqual "allDibFalse" False (allDib predi dibujo))

-- Test de andP

prediPos :: Eq a => Ord a => Num a => Pred a
prediPos a = a > 0

testandPTrue :: Test
testandPTrue = TestCase (assertEqual "andPTrue" True (andP predi prediPos 1))

testandPFalse :: Test
testandPFalse = TestCase (assertEqual "andPFalse" False (andP predi prediPos 2))

-- Test de orP

prediNeg :: Eq a => Ord a => Num a => Pred a
prediNeg a = a < 0

testorPTrue :: Test
testorPTrue = TestCase (assertEqual "orPTrue" True (orP predi prediNeg 1))

testorPFalse :: Test
testorPFalse = TestCase (assertEqual "orPFalse" False (orP predi prediNeg 2))


tests = TestList[testcambiar, testanyDibTrue, testanyDibFalse,
                    testallDibTrue, testallDibFalse, testandPTrue,
                    testandPFalse, testorPTrue, testorPFalse]