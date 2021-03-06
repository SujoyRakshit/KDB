\d .Q

/ Modified version of .Q.dpft(s), which uses peach to save the columns on disk
/ Features:
/ 1. All columns can be stored in parallel on disk
/ 2. Uses compression to be stored on disk
/ 3. We can save the table with a different name on disk
/ Params:
/ d -> Directory
/ p -> Partition
/ f -> Field to perform part on
/ t -> Table in Root to save
/ s -> Enumeration domain
/ c -> Compression parameters
/ n -> Table name to be saved as, older version we can only save the table with the same name

k)dpftscn:{[d;p;f;t;s;c;n] 
    i:<t f; 
    a:.q.peach[.q.attr;.Q.V t]; 
    a[f]:`p; 
    r:+enxs[$;d;;s]`. . `\:t; 
    .q.peach[{[d;t;i;c;f;a;x] .q.set[(.q.sv[`;(d;x)],c);  .[#;(a[x];t[x] i);t[x] i]]} [d:par[d;p;n];r;i;c;f;a;];[!r]];
    @[d;`.d;:;f,r@&~f=r:!r];
    n};
    
/ Params:
/ d -> Directory
/ p -> Partition
/ f -> Field to perform part on
/ t -> Table in Root to save
/ s -> Enumeration domain (default to sym)
/ c -> Compression parameters
/ n -> Table name to be saved as, older version we can only save the table with the same name
/ eg: .Q.dpftcn[`:.;2021.01.05;`sym;`t;17 2 5;`tab]

k)dpftcn:dpftscn[;;;;`sym;;];

/ .Q.dpftc
/ eg: .Q.dpftc[`:.;2021.01.05;`sym;`t;17 2 5]

k)dpftc:{[d;p;f;t;c] dpftscn[d;p;f;t;`sym;c;t]};

/ Appends data on disk to the table
/ Params:
/ d -> Directory
/ p -> Partition
/ f -> Field to query next to date
/ t -> Table in Root to save
/ s -> Enumeration domain (default to sym)
/ n -> Table name to be saved as, older version we can only save the table with the same name

k)dpftsnAppend:{[d;p;f;t;s;n] r:+enxs[$;d;;s]`. . `\:t; .q.peach[{[d;t;x] .q.upsert[.q.sv[`;(d;x)];t[x]]} [d:par[d;p;n];r;];[!r]];@[d;`.d;:;f,r@&~f=r:!r];n};

/ Another version of .Q.dpft(s), which uses peach to Append data on disk
/ Features:
/ 1. All columns can be stored in parallel on disk
/ 2. Uses compression to be stored on disk
/ 3. We can save the table with a different name on disk
/ If the data does not exist, will set it first time for compression to work
/ Post first time, the data will be appended
/ Params:
/ d -> Directory
/ p -> Partition
/ f -> Field to query next to date
/ t -> Table in Root to save
/ s -> Enumeration domain (default to sym)
/ c -> Compression parameters (Used for the first time save, post upserts do not require compression parameter)
/ n -> Table name to be saved as, older version we can only save the table with the same name

k)dpftscnAppend:{[d;p;f;t;s;c;n] path:!par[d;p;n]; $[()~path;dpftscn[d;p;f;t;s;c;n];dpftsnAppend[d;p;f;t;s;n]]};

/ We do not apply attribute to f (as we pass :: to .Q.dpftscna) because,
/ If a column has attribute, the entire column is copied in memory and then appended, on disk. Thus, the compression will be lost on the column, if attribute exists on the field.
/ If required use disksort and apply attribute as required.
/ eg: .Q.dpftcnAppend[`:.;2021.01.05;`sym;`t;17 2 5;`tab]

k)dpftcnAppend:dpftscnAppend[;;;;`sym;;];

\d .
