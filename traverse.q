/ Function is used to traverse to get the root node
/ Will return the same node if its the root
/ Uses a dictionary and over to get the root node
/ If the dict is already created, we can use .Q.fu to apply unique.
traverseFunc:{[col;prevCol]
              dict:col!col^prevCol;
              (dict/) col
             };
                   
/
/q)data:([] sym:`a`s`d`f`w`e`r; prevSym:``a`s`d```e);
/q)
/q)update origSym:traverseFunc[sym;prevSym] from data
/sym prevSym origSym
/-------------------
/a           a      
/s   a       a      
/d   s       a      
/f   d       a      
/w           w      
/e           e      
/r   e       e      
/q)data:([] sym:10000?`a`s`d`f`w`e`r; prevSym:10000?``a`s`d```e);
/q)\ts update origSym:traverseFunc[sym;prevSym] from data
/0 524960

