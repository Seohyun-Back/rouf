import 'package:gw/models/timed_event.dart';

class TimerService {
  final List<TimedEvent> timedEvents = [
    TimedEvent(title: 'My Event 1', time: '01:24:17'),
    TimedEvent(title: 'My Event 2', time: '01:24:18'),
    TimedEvent(title: 'My Event 3', time: '01:24:19'),
    TimedEvent(title: 'My Event 4', time: '01:24:20')
  ];

  void save() {
    TimedEvent event = TimedEvent(title: 'My Event 2', time: '01:24:18');
    print(TimedEvent.toMap(event));
  }
}
