import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_manage/pages/homepg.dart';

final talker = TalkerFlutter.init();

class TimerMain extends StatefulWidget {
  const TimerMain({
    super.key,
    required this.title,
    required this.hours,
    required this.minutes,
    this.function1,
    this.function2,
    required this.status,
  });
  final String title;
  final String hours;
  final String minutes;
  final VoidCallback? function1;
  final VoidCallback? function2;
  final String status;

  @override
  State<TimerMain> createState() => _TimerMainState();
}

class _TimerMainState extends State<TimerMain> {
  bool isDStopped = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Material(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.title, ),
                        Text("P${widget.status}")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Center(
                  child: TimerCanvas(
                    isStopped: isDStopped,
                    hours: int.parse(widget.hours),
                    minutes: int.parse(widget.minutes),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 300,
                height: 80,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 219, 219),
                    borderRadius: BorderRadius.circular(40)),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (isDStopped == true) {
                        isDStopped = false;
                      }
                      if (isDStopped == false) {
                        isDStopped = true;
                      }
                    });
                  },
                  child: const Text(
                    "Pause",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 80,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 219, 219),
                    borderRadius: BorderRadius.circular(40)),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isDStopped = true;
                    });
                    talker.log("timer is stopped");
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomePg(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    "Stop",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimerCanvas extends StatefulWidget {
  TimerCanvas({
    super.key,
    required this.hours,
    required this.minutes,
    required this.isStopped,
  });
  bool isStopped;
  final int hours;
  final int minutes;

  @override
  State<TimerCanvas> createState() => _TimerCanvasState();
}

class _TimerCanvasState extends State<TimerCanvas> {
  Timer? timer;

  ///test
  Duration duration = const Duration();

  @override
  void initState() {
    super.initState();
    durationInit();
    startTimer();
    talker.log("timer initialized");
  }

  void timeLeaksCheck() {
    if (duration.inSeconds < 0 && widget.isStopped == false) {
      if (widget.isStopped == false) {
        setState(() {
          widget.isStopped = true;
        });
        talker.log("leak check works");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomePg(),
          ),
          (Route<dynamic> route) => false,
        );
      }
      talker.log("miss");
    }
    // talker.log("timeLeacksCheck log point, ${widget.isStopped}");
  }

  void durationInit() {
    if (widget.isStopped == false) {
      setState(() {
        duration = Duration(minutes: widget.minutes, hours: widget.hours);
      });
      talker.log("duration initialized");
    }
  }

  void startTimer() {
    if (widget.isStopped == false) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        removeTime();
        timeLeaksCheck();
      });
      talker.log("timer start point");
    }
  }

  void removeTime() {
    if (widget.isStopped == false) {
      setState(() {
        final seconds = duration.inSeconds - 1;
        duration = Duration(seconds: seconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int durSecondsEntry = duration.inSeconds;
    int durMinutes = duration.inMinutes - duration.inHours;
    int durHours = duration.inHours;
    int durSeconds =
        durSecondsEntry - (((durHours * 60) * 60) + (durMinutes * 60));
    return Center(
      child: Container(
        height: 300,
        width: 300,
        child: Center(
            child: Text(
          "$durHours:${(durMinutes < 10) ? '0$durMinutes' : durMinutes}:${(durSeconds < 10) ? "0$durSeconds" : durSeconds}",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300),
            color: const Color.fromARGB(255, 231, 231, 231)),
      ),
    );
  }
}
