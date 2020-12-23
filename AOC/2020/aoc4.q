l:read0 `:aoc4.txt;
validFields:`ecl`pid`eyr`hcl`byr`iyr`hgt;

d:{(!). "S: "0:x}'[ssr[;";";" "]'[";;" vs ";" sv l]];
aoc4_1:{sum all'[validFields in/: key'[x]]};

aoc4_2:{
    tab:flip (,'/) enlist''[x];
    exec count i from tab
    where within["J"$byr;(1920;2002)],
    within["J"$iyr;(2010;2020)],
    within["J"$eyr;(2020;2030)],
    ecl in ("amb";"blu";"brn";"gry";"grn";"hzl";"oth"),
    9=count'[pid],
    ?[hgt like "*cm";
        within["J"$(-2_)'[hgt];(150;193)];
        within["J"$(-2_)'[hgt];(59;76)]],
    hcl like "#*",
    7=count'[hcl],
    all'[(1_)'[hcl] in\: .Q.an]
 };
 
 (aoc4_1[d];aoc4_2[d])
