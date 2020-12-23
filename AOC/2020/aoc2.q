l:read0 `:aoc2.txt;
fmtStr:{{ssr[x;y;" "]}/ [x;(":";"-")]}'[l];
tab:flip `mn`mx`c`str!("JJC *";" ")0: fmtStr;
/select count i from tab where sum'[c=str] within (mn;mx);
sum sum'[tab[`c]=tab`str] within (tab`mn;tab`mx);
/422
/select count i from tab where 1=sum'[c={(x@y;x@z)}'[str;mn-1;mx-1]]
sum 1=sum each tab[`c]={(x@y;x@z)}'[tab[`str];tab[`mn]-1;tab[`mx]-1];
/451


sum {within[sum y=z;x] }.'l1:{("J"$"-" vs x;first y;z)}.'" " vs'l;
/422
sum {1=sum y=z x-1}.'l1;
/451
