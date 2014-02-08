AVLTrees in Haskell
===================

Included is an implementation of AVL Trees in Haskell.

The Tester.hs file contains a program to view incremental changes in a tree using GraphViz.

A sample output of the Tester program `./Tester example.gv`
-----------------------------------------------------------
```
Open example.gv with GraphViz and use the following commands to interact with it:
d item	- deletes an item from the tree
i item	- inserts an item in the tree
f	- goes forward in the history
b	- goes back in the history
r a b	- creates a tree with elements in the range a...b (e.g. r 3 9)
q	- quits

>>=
```
![t1](./Screenshots/t1.png "t1")

```
>>= r 1 10
```
![t2](./Screenshots/t2.png "t2")

```
>>= i 13
```
![t3](./Screenshots/t3.png "t3")

```
>>= i 11
```
![t4](./Screenshots/t4.png "t4")

```
>>= d 8
```
![t5](./Screenshots/t5.png "t5")

```
>>= b
```
![t4](./Screenshots/t4.png "t4")

```
>>= f
```
![t5](./Screenshots/t5.png "t5")

```
>>= q
```
