import qualified AVLTrees as A
import qualified ZippedLists as Z
import System.IO
import System.Environment
import Data.Char

itoa :: String->Int
itoa num@(x:xs) = if x == '-'
                  then (negate $ itoa' xs)
                  else itoa' num
  where itoa' = foldl (\acc x -> acc*10 + digitToInt x) 0

flush :: IO ()
flush = hFlush stdout

makeTrees :: String -> Z.ZList (A.AVLTree Int) -> IO()
makeTrees filename trees = do
  putStr ">>= "
  flush
  (command:args) <- fmap words getLine
  if command == "q"
  then return ()
  else do
    let (ntrees, message) = handle trees command args
    putStr $ message
    flush
    writeFile filename (A.dotFormat "g" $ Z.focus ntrees)
    makeTrees filename ntrees

handle :: Z.ZList (A.AVLTree Int) -> String -> [String] -> (Z.ZList (A.AVLTree Int), String)
handle zl "d" [item] = (Z.append zl $ A.delete (Z.focus zl) (itoa item), "")
handle zl "i" [item] = (Z.append zl $ A.insert (Z.focus zl) (itoa item), "")
handle zl "f" _ = if Z.isLast zl
                  then (zl, "Can't go anyfurther forward.\n")
                  else (Z.forward zl, "")
handle zl "b" _ = if Z.atStart zl
                  then (zl, "Can't go any further back.\n")
                  else (Z.back zl, "")
handle zl "r" [start, end] = (Z.append zl $ foldl A.insert A.Empty [itoa start..itoa end], "")
handle zl _ _ = (zl, "Invalid command or command usage.\n");

commands :: [(String, String)]
commands = [("d item", "deletes an item from the tree"),
            ("i item", "inserts an item in the tree"),
            ("f", "goes forward in the history"),
            ("b", "goes back in the history"),
            ("r a b", "creates a tree with elements in the range a...b (e.g. r 3 9)"),
            ("q", "quits")]
main = do
  [filename] <- getArgs
  writeFile filename $ A.dotFormat "g" (A.Empty :: A.AVLTree Int)
  putStrLn $ "Open " ++ filename ++ " with GraphViz and use the following commands to interact with it:"
  putStrLn $ unlines . map (\(a,b) -> a++"\t- "++b) $ commands
  makeTrees filename $ Z.singleton A.Empty

  
