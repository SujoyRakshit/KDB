// Closing bracket solution
//For a string "[()([]{})[{()}]]", if all brackets are closing correctly return 1b else 0b

d:("()";"[]";"{}");
f:{0=count {$[(-2#c:x,y) in z;-2_c;c]}[;;y]/ [x]};

// Start from 1st character, traverse and find the closing bracket. When found remove them from the string.
// If the end result is empty, it indicates all brackets are correctly closed and placed

s:"[()([]{})[{()}]]"
s1:"[()([]{})[{()]}]"

f[s;d]
//1b
f[s1;d]
//0b
