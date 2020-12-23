l:read0 `:aoc3.txt;

func:{[l;right;down] 
     count {[x;y;z] ((y+1)#z[x])[y]}[;;l]'[down*i;right*i:til count l] inter "#"
     };

/ (func[l;3;1];prd {func[l;x;y]}'[1 3 5 7 1;1 1 1 1 2])
/ (216;6708199680)

aoc3:{[l;right;down] 
     count(l ./: flip (down*i;(right*i:til count l) mod 31))  inter "#"
     };

/Fastest iterating on 31 columns instead of all the rows.
aoc3_1:{[l;right;down]
  d:group (down*i!((right*i:til count l) mod count first l));
  count (raze l ./: flip (value d;key d)) inter "#"
  };

/aoc3_1[l;3;1]
/ 216
