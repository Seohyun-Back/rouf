import 'package:flutter/material.dart';
import 'package:gw/models/timed_event.dart';

class EventItem extends StatelessWidget {
  final TimedEvent event;

  const EventItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(event.title),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.edit,
              color: Colors.grey,
              size: 20,
            ),
            SizedBox(height: 5),
            Text(event.time),
          ],
        )
      ]),
    );
  }
}
