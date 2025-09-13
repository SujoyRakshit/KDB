// Find all sym columns to enumerate
en_sym_cols:{$[11h=type first x;(&/)11h=type peach x;11h=type x]};

// Try to enum with sym domain in memory
en_try:{[t;c;s] 
     res:@[t;c;{$[0h=type z;(-1_sums 0,(count')z)_x[y;raze z];x[y;z]]}[$;s]];
     (res;1b)
 };

// Enumerate 1 table
en_one:{[d;t;s]
     c:c where en_sym_cols peach t c:key flip t;
     res:@[en_try[t;c];s;0b];
     if[98h=type res;show "Symbols already in enum domain";:res];
     r:distinct raze distinct peach {$[0h=type x;raze x;x]}'[t c];
     if[count r;(` sv d,s)?r];
     en_try[t;c;s]
 };

// Enum Fast
enf:{[d;t;s]
     if[98h=type t;:en_one[d;t;s]];
     c:{c where en_sym_cols peach x c:key flip x} peach t;
     res:.[en_try[;;s];;0b] peach data:flip (t;c);
     if[all 98h=(type')res;show "Symbols already in enum domain";:res];
     r:raze {distinct raze distinct peach {$[(count x)&0h=type x; raze x;x]} peach x} peach t@'c;
     if[count r;(` sv d,s)?r];
     .[en_try[;;s]] peach data
 };
