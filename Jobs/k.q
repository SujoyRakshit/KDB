k){[d;p;f;t;s;c;n] 
    i:<t f; 
    a:-2!'.Q.V t;
    r:+enxs[$;d;;s]`. . `\:t;
    .q.peach[{[d;t;i;c;f;a;x] .q.set[(.q.sv[`;(d;x)],c); .[#;(a[x];t[x] i);t[x] i]} [d:par[d;p;n];r;i;c;f;a;];[!r]];
[d;`.d;:;f,r@&~f=r:!r];
n}[;;;;`sym;;]

{[d;p;f;t;s;c;n] 
    i:<t f; 
    a:-2!'.Q.V t; a[f]:`p; 
    r:+.Q.enxs[$;d;;s]`. . `\:t; 
   .q.peach[{[d;t;i;c;f;a;x] .q.set[(.q.sv[`;(d;x)],c); .[#;(a[x];t[x] i);t[x] i]} [d:par[d;p;n];r;i;c;f;a;];!r]
   ];
   [d;`.d;:;f,r@&~f=r:!r];
n}[;;;;`sym;;]



k){[d;p;f;t;s;c;n] 
    i:<t f; 
    a:-2!'.Q.V t; 
    a[f]:`p; 
    r:+enxs[$;d;;s]`. . `\:t; 
    .q.peach[{[d;t;i;c;f;a;x] .q.set[(.q.sv[`;(d;x)],c);  .[#;(a[x];s:t[x] i);s]]} [d:par[d;p;n];r;i;c;f;a;];[!r]];
    @[d;`.d;:;f,r@&~f=r:!r];n}[;;;;`sym;;]


    dpftscn:{[d;p;f;t;s;c;n] i:<t f; a:-2!'.Q.V t; a[f]:`p; r:+enxs[$;d;;s]`. . `\:t; .q.peach[{[d;t;i;c;f;a;x] .q.set[(.q.sv[`;(d;x)],c);  .[#;(a[x];t[x] i);t[x] i]} [d:par[d;p;n];r;i;c;f;a;];[!r]]; @[d;`.d;:;f,r@&~f=r:!r];n};


fPrime:{if[x within 1 3;:1b]; x~{x+1}/ [{0<y mod x}[;x];2]};

 l where fPrime each l:1+til 10


{(x;floor (log y) % log x)}[;10]'[l where fPrime each l:1+til 10]


{x xexp floor (log y) % log x}[;10]'[l where fPrime each l:1+til 10]


f:{prd {x xexp floor (log y) % log x}[;x]'[
    
    l where fPrime each l:1+til 10
    
    ]}

fPrime:{}



prd xexp[a;floor (log 10)%log@\:a:l where fPrime each l:1+til 10]


prd xexp[a;floor (log 10)%log@\:a:fPrime[20]]


f:{prd xexp[y;floor (log x)%log y]}

fPrime:{a where 1=sum not a mod/: a:til x}

fPrime2:{a where 1=sum not a mod/: a:{x+2}\ [{x<y}[;x];3]}