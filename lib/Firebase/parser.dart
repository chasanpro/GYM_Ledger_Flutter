var i = 0;
var result = "";
var month, t, dj;
parser(String dayte) {
  result = "";
  for (i = 0; i <= 10; i++) {
    result = result + dayte[i];
  }
  t = result[5] + result[6];
  t = int.parse(t);
  List Months = [
    "",
    "JAN",
    "FEB",
    "MARCH",
    "APRL",
    "MAY",
    "JUNE",
    "JULY",
    "AUG",
    "SEPTr",
    "OCT",
    "NOV",
    "DEC"
  ];

  for (var i = 0; i <= 12; i++) {
    if (i == t) {
      month = Months[i];
    }
  }
  dj = result[8] + result[9] + "-" + month + result[2] + result[3];
  return dj;
}

dueparse(var result) {
  t = "";
  t = result[5] + result[6];
  List Months = [
    "",
    "JAN",
    "FEB",
    "MARCH",
    "APRL",
    "MAY",
    "JUNE",
    "JULY",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];

  month = Months[int.parse(t)];

  dj = result[8] + result[9] + "-" + month + result[2] + result[3];
  return dj;
}
