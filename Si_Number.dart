
int counter = 0;

String SiNumber() {
  DateTime now = DateTime.now();
  String formattedDate = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
  

  counter++;
  String formattedCounter = counter.toString().padLeft(4, '0');

  return '#$formattedDate$formattedCounter';
}

