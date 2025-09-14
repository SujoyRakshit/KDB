// Given a date, find next x weekend dates

getSat:{ c:mod[x;7]; $[0<c;x+7-c;x]};
getWeekends:{r:getSat x; except[;x] raze {7+x}\ [y;r,r+1]};

getWeekends[.z.D;10]
