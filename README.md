AVLTrees in Haskell
===================

Included is an implementation of AVL Trees in Haskell.

The Tester.hs file contains a program to view incremental changes in a tree using GraphViz.

A sample of the Tester program
------------------------------
```
Open example.gv with GraphViz and use the following commands to interact with it:
d item	- deletes an item from the tree
i item	- inserts an item in the tree
f	- goes forward in the history
b	- goes back in the history
r a b	- creates a tree with elements in the range a...b (e.g. r 3 9)
q	- quits

>>=
``` ![an empty tree](Screenshots/t1.png "An empty tree.")

```
Open example.gv with GraphViz and use the following commands to interact with it:
d item	- deletes an item from the tree
i item	- inserts an item in the tree
f	- goes forward in the history
b	- goes back in the history
r a b	- creates a tree with elements in the range a...b (e.g. r 3 9)
q	- quits

>>= r 1 10
>>=
```

```
Open example.gv with GraphViz and use the following commands to interact with it:
d item	- deletes an item from the tree
i item	- inserts an item in the tree
f	- goes forward in the history
b	- goes back in the history
r a b	- creates a tree with elements in the range a...b (e.g. r 3 9)
q	- quits

>>= r 1 10
>>= i 13
>>=
```

```
Open example.gv with GraphViz and use the following commands to interact with it:
d item	- deletes an item from the tree
i item	- inserts an item in the tree
f	- goes forward in the history
b	- goes back in the history
r a b	- creates a tree with elements in the range a...b (e.g. r 3 9)
q	- quits

>>= r 1 10
>>= i 13  
>>= i 11
>>=
```

```
Open example.gv with GraphViz and use the following commands to interact with it:
d item	- deletes an item from the tree
i item	- inserts an item in the tree
f	- goes forward in the history
b	- goes back in the history
r a b	- creates a tree with elements in the range a...b (e.g. r 3 9)
q	- quits

>>= r 1 10
>>= i 13  
>>= i 11
>>= d 8
>>=
```

```
Open example.gv with GraphViz and use the following commands to interact with it:
d item	- deletes an item from the tree
i item	- inserts an item in the tree
f	- goes forward in the history
b	- goes back in the history
r a b	- creates a tree with elements in the range a...b (e.g. r 3 9)
q	- quits

>>= r 1 10
>>= i 13  
>>= i 11
>>= d 8
>>= b
>>=
```

```
Open example.gv with GraphViz and use the following commands to interact with it:
d item	- deletes an item from the tree
i item	- inserts an item in the tree
f	- goes forward in the history
b	- goes back in the history
r a b	- creates a tree with elements in the range a...b (e.g. r 3 9)
q	- quits

>>= r 1 10
>>= i 13  
>>= i 11
>>= d 8
>>= b
>>= f
>>=
```

```
Open example.gv with GraphViz and use the following commands to interact with it:
d item	- deletes an item from the tree
i item	- inserts an item in the tree
f	- goes forward in the history
b	- goes back in the history
r a b	- creates a tree with elements in the range a...b (e.g. r 3 9)
q	- quits

>>= r 1 10
>>= i 13  
>>= i 11
>>= d 8
>>= b
>>= f
>>= q
```
