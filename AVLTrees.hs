module AVLTrees (AVLTree(Empty), height, makeLeaf, isEmpty, infold, postfold, prefold, dotFormat, find, insert, delete) where

data AVLTree a = AVLTree {levels :: Int,
                          value :: a,
                          left :: AVLTree a,
                          right :: AVLTree a} |
                 Empty
               deriving (Show)
               
height :: AVLTree a -> Int
height Empty = 0
height t = levels t

balance :: AVLTree a -> Int
balance (AVLTree _ _ l r) = height l - height r

makeTree :: a -> AVLTree a -> AVLTree a -> AVLTree a
makeTree x Empty Empty = AVLTree 1 x Empty Empty
makeTree x l Empty     = AVLTree (height l + 1) x l Empty
makeTree x Empty r     = AVLTree (height r + 1) x Empty r
makeTree x l r         = AVLTree (max (height l) (height r) + 1) x l r

makeLeaf :: a -> AVLTree a
makeLeaf x = AVLTree 1 x Empty Empty

isEmpty :: AVLTree a -> Bool
isEmpty Empty = True
isEmpty _ = False

rotateLeft :: AVLTree a -> AVLTree a
rotateLeft Empty = error "Rotating an empty tree"
rotateLeft (AVLTree _ _ _ Empty) = error "Rotating an empty tree to root position"
rotateLeft tree = makeTree (value $ right tree) (makeTree (value tree) (left tree) (left $ right tree)) (right $ right tree)

rotateRight :: AVLTree a -> AVLTree a
rotateRight Empty = error "Rotating an empty tree"
rotateRight (AVLTree _ _ Empty _ ) = error "Rotating an empty tree to root position"
rotateRight tree = makeTree (value $ left tree) (left $ left tree) (makeTree (value $ tree) (right $ left tree) (right tree))

infold :: (b -> a -> b) -> b -> AVLTree a -> b
infold _ acc Empty = acc
infold f acc (AVLTree _ x l r) = infold f (f (infold f acc l) x) r 

postfold :: (b -> a -> b) -> b -> AVLTree a -> b
postfold _ acc Empty = acc
postfold f acc (AVLTree _ x l r) = f (postfold f (postfold f acc r) l) x

prefold :: (a -> b -> b) -> b -> AVLTree a -> b
prefold _ acc Empty = acc
prefold f acc (AVLTree _ x l r) = f x (prefold f (prefold f acc r) l)


treemap :: (Ord a, Ord b) => (a -> b) -> AVLTree a -> AVLTree b
treemap f Empty = Empty
treemap f tree = infold (\ acc x -> insert acc (f x)) Empty tree

dotFormat :: (Show a) => String -> AVLTree a -> String
dotFormat name tree = "digraph "++name++" {\ngraph [ordering=\"out\"]\n" ++ (connections "" tree) ++ "}"
  where connections _ Empty = "null [shape=point];\n"
        connections nulls (AVLTree _ x Empty Empty) = show x ++ " -> " ++ makeNull (nulls++"L") ++ ";\n" ++
                                                      show x ++ " -> " ++ makeNull (nulls++"R")  ++ ";\n"
        connections nulls (AVLTree _ x l Empty) = show x ++ " -> " ++ show (value l) ++ ";\n" ++
                                                  show x ++ " -> " ++ makeNull (nulls++"R") ++ ";\n" ++
                                                  connections (nulls++"L") l
        connections nulls (AVLTree _ x Empty r) = show x ++ " -> " ++ makeNull (nulls++"L") ++";\n" ++
                                                  show x ++ " -> " ++ show (value r) ++ ";\n" ++
                                                  connections (nulls++"R") r
        connections nulls (AVLTree _ x l r) = show x ++ " -> " ++ show (value l) ++ ";\n" ++
                                              show x ++ " -> " ++ show (value r) ++ ";\n" ++
                                              connections (nulls++"L") l ++
                                              connections (nulls++"R") r
        makeNull path = "null"++path++";\n"++
                        "null"++path++" [shape=point]"

find :: (Ord a) => AVLTree a -> a -> Maybe a
find Empty _ = Nothing
find tree x | x < value tree  = find (left tree) x
            | x > value tree  = find (right tree) x
            | x == value tree = Just (value tree)
                                
insert :: (Ord a) => AVLTree a -> a -> AVLTree a
insert Empty x = makeLeaf x
insert tree x | isEmpty tree    = makeLeaf x 
              | x < value tree  = rebalance $ makeTree (value tree) (insert (left tree) x) (right tree)
              | x > value tree  = rebalance $ makeTree (value tree) (left tree) (insert (right tree) x)
              | x == value tree = tree

rebalance :: AVLTree a -> AVLTree a
rebalance Empty = Empty
rebalance tree@(AVLTree _ _ Empty Empty) = tree
rebalance tree | abs (balance tree) < 2 = tree
               | balance tree == 2 && (balance $ left tree) == -1 = rotateRight $ (makeTree (value tree) (rotateLeft $ left tree) (right tree))
               | balance tree == 2 = rotateRight tree
               | balance tree == (-2) && (balance $ right tree) == 1 = rotateLeft $ (makeTree (value tree) (left tree) (rotateRight $ right tree))
               | balance tree == (-2) = rotateLeft tree

delete :: Ord a => AVLTree a -> a -> AVLTree a
delete Empty _ = Empty
delete tree x | x < value tree = rebalance $ makeTree (value tree) (delete (left tree) x) (right tree)
              | x > value tree = rebalance $ makeTree (value tree) (left tree) (delete (right tree) x)
              | x == value tree = rebalance $ deleteRoot tree
  where deleteRoot (AVLTree _ _ Empty Empty) = Empty
        deleteRoot (AVLTree _ _ l Empty) = l
        deleteRoot (AVLTree _ _ Empty r) = r
        deleteRoot (AVLTree _ _ l r) = let (newl, i) = extractLargestChild l
                                         in makeTree i newl r
        extractLargestChild (AVLTree _ x l Empty) = (l, x)
        extractLargestChild (AVLTree _ x l r)     = let (nr, i) = extractLargestChild r 
                                                    in (makeTree x l nr, i)



