
class TimeService {

  TimeService();

  DateTime now() => DateTime.now();

  int nowMillis() => now().millisecondsSinceEpoch;

}
