// Closing bracket solution
//For a string "[()([]{})[{()}]]", if all brackets are closing correctly return 1b else 0b

f:{$[0b~@[value;-2#c:x,y;{0b}];c;-2_c]}/;
fq:{0=count f x};

// Start from 1st character, traverse and find the closing bracket. When found remove them from the string.
// If the end result is empty, it indicates all brackets are correctly closed and placed

s:"[()([]{})[{()}]]"
s1:"[()([]{})[{()]}]"

fq s
//1b
fq s1
//0b
