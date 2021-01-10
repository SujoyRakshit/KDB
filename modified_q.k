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
/ a -> Attribute to be applied on f

k)dpftscna:{[d;p;f;t;s;c;n;a] i:<t f; r:+enxs[$;d;;s]`. . `\:t; .q.peach[{[d;t;i;c;f;a;x] .q.set[(.q.sv[`;(d;x)],c);$[x~f;a;::] t[x] i]} [d:par[d;p;n];r;i;c;f;a;];[!r]];@[d;`.d;:;f,r@&~f=r:!r];n};

/ Params:
/ d -> Directory
/ p -> Partition
/ f -> Field to perform part on
/ t -> Table in Root to save
/ s -> Enumeration domain (default to sym)
/ c -> Compression parameters
/ n -> Table name to be saved as, older version we can only save the table with the same name
/ a -> Attribute to be applied on f (default to `p#)
/ eg: .Q.dpftcn[`:.;2021.01.05;`sym;`t;17 2 5;`tab]

k)dpftcn:dpftscna[;;;;`sym;;;`p#];

/ Appends data on disk to the table
/ Params:
/ d -> Directory
/ p -> Partition
/ f -> Field to query next to date
/ t -> Table in Root to save
/ s -> Enumeration domain (default to sym)
/ n -> Table name to be saved as, older version we can only save the table with the same name

k)dpftsnAppend:{[d;p;f;t;s;n] r:+enxs[$;d;;s]`. . `\:t; .q.peach[{[d;t;x] .q.upsert[.q.sv[`;(d;x)];t[x]]} [d:par[d;p;n];r;];[!r]];@[d;`.d;:;f,r@&~f=r:!r];n};

/ If the data does not exist, will set it first time for compression
/ Post first time, the data will be appended
/ Params:
/ d -> Directory
/ p -> Partition
/ f -> Field to query next to date
/ t -> Table in Root to save
/ s -> Enumeration domain (default to sym)
/ c -> Compression parameters (Used for the first time save, post upserts do not require compression parameter)
/ n -> Table name to be saved as, older version we can only save the table with the same name

k)dpftscnAppend:{[d;p;f;t;s;c;n] path:!par[d;p;n]; $[()~path;dpftscna[d;p;f;t;s;c;n;::];dpftsnAppend[d;p;f;t;s;n]]};

/ We do not apply attribute to f (as we pass :: to .Q.dpftscna) because,
/ If a column has attribute, the entire column is copied in memory and then appended, on disk. Thus, the compression will be lost on the column, if attribute exists on the field.
/ If required use disksort and apply attribute as required.
/ eg: .Q.dpftcnAppend[`:.;2021.01.05;`sym;`t;17 2 5;`tab]

k)dpftcnAppend:dpftscnAppend[;;;;`sym;;];

\d .
