h:neg hopen`::5001;

sym:`computeSum`getTradeData;
chunk:2;

f:{[n;p;s]
    ([] time:p+"u"$til n;sym:n?s;jobTime:.z.t+n?00:10)
 }[;.z.n;sym];

genData:{[chunk;f;n]
        {h(`.u.upd;`jobs;x)} each chunk sublist f[n]
        }[chunk;f;];

/ genData[4] generates random Jobs sends in chunks of 2 a batch