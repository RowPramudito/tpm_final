import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';
import 'dart:async';


class WorldClock extends StatefulWidget {
  @override
  _WorldClockState createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  List<String> locations = [
    'America/New_York',
    'Europe/London',
    'Asia/Tokyo',
    'Australia/Sydney',
  ];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
            child: WorldClockCard(location: locations[index]),
          );
        },
      ),
    );
  }
}

class WorldClockCard extends StatefulWidget {
  final String location;

  const WorldClockCard({Key? key, required this.location}) : super(key: key);

  @override
  _WorldClockCardState createState() => _WorldClockCardState();
}

class _WorldClockCardState extends State<WorldClockCard> {
  tz.Location? location;
  String currentTime = '';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    location = tz.getLocation(widget.location);
    updateTime();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void updateTime() {
    final now = tz.TZDateTime.now(location!);
    final format = DateFormat.Hm(); // Use only hour and minute format
    setState(() {
      currentTime = format.format(now);
    });
    timer = Timer(Duration(seconds: 1), updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.location),
        subtitle: Text(currentTime.isEmpty ? 'Loading...' : currentTime),
      ),
    );
  }
}
