/ Used to calculate Twap and Vwap for the given Trades table
/ For the interval in minutes, we calculate the open, close, high and low prices, average price used for Twap
/ For Vwap, its standard ts wavg tp
/ The function uses wj1, and returns table
/ eg Call: calcTwapVwap[trades;15]
/ @params
/ t : Table with time, sym, tp and ts columns
/ interval : Interval in minutes
calcTwapVwap:{[t;interval]
    if[`g=attr t`sym;'"Grouped attribute found on sym column, this will give unpredictable result"];
    w:@[{`minute$x};interval;{e:"Error due to ", x;'e}];
    w:(neg;::)@\:w;
    t:![t;();`sym`time!(`sym;(xbar;interval;($;enlist `minute;`time)));`openPrice`lastPrice`highPrice`lowPrice!((first;`tp);(last;`tp);(max;`tp);(min;`tp))];
    t:wj1[w +\: exec time from t;
        `sym`time;
        trades;
    (select sym,time,ts,
    dTime:deltas[first time;time],
    twapPrice:avg@/: flip (openPrice;lastPrice;highPrice;lowPrice),
    vwapPrice:tp
    from t;
    (wavg;`dTime;`twapPrice);
    (wavg;`ts;`vwapPrice))
    ];
    t
 };

/ Defining table trades
trades:asc ([] sym:500?`USD`CAD`EUR`GBP; time:.z.D+500?00:00:00; tp:500?90.9; ts:500?100);

/Calculating 15 minutes Twap and vwap for the trades table.
calcTwapVwap[trades;15]
