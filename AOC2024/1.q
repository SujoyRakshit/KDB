data:(asc')("JJ";" ")0:system"cat 1.txt|cut -d' ' -f1,4";
// Part 1
f:sum abs(-/) ::;

//Part 2
f1:{sum x[0]*(sum')(=\:). x} //Slower
f1:{sum x[1](&)(in) .(|:)x}; //Faster
f1:.[{sum y (&) y in x}] // Fastest

