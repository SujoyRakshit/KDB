// Closing bracket solution
//For a string "[()([]{})[{()}]]", if all brackets are closing correctly return 1b else 0b

parseBrackets:{$[0b~@[value;-2#c:x,y;{0b}];c;-2_c]};
validStr:{0=count (parseBrackets/) x};
// Hardcode
validStr_2:{0=count {$[(-2#c:x,y) in z;-2_c;c]}[;;("()";"[]";"{}")]/ [x]};

// Start from 1st character, traverse and find the closing bracket. When found remove them from the string.
// If the end result is empty, it indicates all brackets are correctly closed and placed

s:"[()([]{})[{()}]]"
s1:"[()([]{})[{()]}]"

validStr s
//1b
validStr2 s;
//1b
validStr s1;
//0b
