l:read0 `:aoc5.txt;

f:{first 2 0N#x};
b:{last 2 0N#x};
d:("F";"B";"R";"L")!(f;b;b;f);
func:{y[x]}/ ;

funcSeatId:{[dict;list] 
    func [til 8;dict[-3#list]] + func [til 128;dict[7#list]] * 8
 }[d;];

max i:asc funcSeatId'[l]
