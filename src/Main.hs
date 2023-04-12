module Main (main) where

import Data.Maybe (fromMaybe)
import System.Console.GetOpt (ArgDescr(..), ArgOrder(..), OptDescr(..), getOpt)
import System.Environment (getArgs)
import Text.Read (readMaybe)

import Interp (Conf(name), initial)
import Dibujos.Ejemplo (ejemploConf)
import Dibujos.Feo (feoConf)
import Dibujos.Escher (escherConf)
import Tests (testConf)
-- Lista de configuraciones de los dibujos
configs :: [Conf]
configs = [ejemploConf, feoConf, testConf, escherConf]

-- Lista con los nombres de cada dibujo
names :: [String]
names = ["Ejemplo", "Feo", "Test", "Escher"]

-- Dibuja el dibujo n
initial' :: [Conf] -> String -> IO ()
initial' [] n = do
    putStrLn $ "No hay un dibujo llamado " ++ n
initial' (c : cs) n = 
    if n == name c then
        initial c 400
    else
        initial' cs n

-- Loop para manejar inputs del usuario
handleInput :: IO ()
handleInput = do
    nombreDib <- getLine
    case nombreDib of
        "Ejemplo" -> initial ejemploConf 400
        "Feo"     -> initial feoConf 400
        "Test"    -> initial testConf 400
        "Escher"  -> initial escherConf 400
        "quit"    -> return ()
        _ -> do
            putStrLn $ "No hay un dibujo llamado " ++ nombreDib
            handleInput

-- Modo de uso: Una vez en ghci, llamas ":main 'Nombre del dibujo'" o ":main --lista"
main :: IO ()
main = do
    args <- getArgs
    case args of
        ["--lista"] -> do
            mapM_ putStrLn names 
            print "Que dibujo desea mostrar?"
            handleInput
        _           -> initial' configs $ head args
            
