/Replace characters based on list
/ x -> String
/ y-> List of characters to replace
/ z-> List of characters to replace with
/ eg: fReplace["Kdb+Q is Fast";"QF+qf";"qf QF"]
fReplace:{
    (ssr/) [x;y;z]
 };


/ Create a right anlge triange
/ We use scan where
/ x -> first element of the list
/ y -> second element of the list
/ eg:  fRightTriangle[til 10],fRightTriangle[.Q.a]
fRightTriangle:{
    (,\) [x]
 };

/ Pallindrone
/ fPallindrone["abcba"] 
fPallindrone:{ x~reverse x};

/ Split and get the first element from the string
/ This is faster than splitting by vs and chosing first
/ x-> The string to be split
/ y-> List of elements to split the string
/ eg fSplit[;"oj"] each ("enjoy";"1o99")
fSplit:{("* ";y)0: x}/
