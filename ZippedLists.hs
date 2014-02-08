module ZippedLists (ZList, singleton, focus, back, forward, insert, append, atStart, atEnd, isLast) where

data ZList a = Zipped [a] [a] deriving (Show)

singleton :: a -> ZList a
singleton a = Zipped [] [a]

focus :: ZList a -> a
focus (Zipped _ []) = error "End of zipped list"
focus (Zipped _ (x:_)) = x

back :: ZList a -> ZList a
back (Zipped [] _ ) = error "Start of zipped list"
back (Zipped (b:bs) fs) = Zipped bs (b:fs)

forward :: ZList a -> ZList a
forward (Zipped _ []) = error "End of zipped list"
forward (Zipped bs (f:fs)) = Zipped (f:bs) fs

insert :: ZList a -> a -> ZList a
insert (Zipped bs fs) x = Zipped bs (x:fs)

append :: ZList a -> a -> ZList a
append zl = insert (forward zl)

atStart :: ZList a -> Bool
atStart (Zipped [] _ ) = True
atStart _ = False

atEnd :: ZList a -> Bool
atEnd (Zipped _ []) = True
atEnd _ = False

isLast :: ZList a -> Bool
isLast (Zipped _ [_]) = True
isLast _ = False
