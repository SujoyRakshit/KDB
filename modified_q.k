\d .Q

/ Modified version of .Q.dpft(s), which uses peach to save the columns on disk
/ Post Enumeration all columns are free to be stored in parallel on disk
/ Params:
/ d -> Directory
/ p -> Partition
/ f -> Field to perform part on
/ t -> Table in Root to save
/ s -> Enumeration domain
/ c -> Compression parameters
/ n -> Table name to be saved as, older version we can only save the table with the same name
k)dpftscn:{[d;p;f;t;s;c;n] i:<t f; r:+enxs[$;d;;s]`. . `\:t; .q.peach[{[d;t;i;c;f;x] .q.set[(.q.sv[`;(d;x)],c);$[x~f;`p#;::] t[x] i]} [d:par[d;p;n];r;i;c;f;];[!r]];@[d;`.d;:;f,r@&~f=r:!r];n};

/ Params:
/ d -> Directory
/ p -> Partition
/ f -> Field to perform part on
/ t -> Table in Root to save
/ s -> Enumeration domain (default to sym)
/ c -> Compression parameters
/ n -> Table name to be saved as, older version we can only save the table with the same name
k)dpftcn:dpftscn[;;;;`sym;;];

\d .
