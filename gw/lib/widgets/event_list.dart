import 'package:flutter/material.dart';
import 'package:gw/models/timed_event.dart';
import 'package:gw/models/timer_service.dart';
import 'package:gw/widgets/event_item.dart';
import 'package:provider/provider.dart';

class EventList extends StatelessWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerService timerService = context.read<TimerService>();

    List<TimedEvent> timedEvents = timerService.timedEvents;

    return Container(
      //Task Window
      height: 370,
      padding: EdgeInsets.symmetric(vertical: 7),
      child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          scrollDirection: Axis.vertical,
          itemCount: timedEvents.length,
          itemBuilder: (context, index) {
            return EventItem(event: timedEvents[index]);
          }),
    );
  }
}
