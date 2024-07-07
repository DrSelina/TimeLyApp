import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_manage/pages/homepg.dart';

final talker = TalkerFlutter.init();

class TimerPage extends StatefulWidget {
  const TimerPage({
    super.key,
    required this.status,
    required this.hours,
    required this.minutes,
    required this.title,
  });
  final String status;
  final String hours;
  final String minutes;
  final String title;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  void initState() {
    super.initState();
    durationInit();
    talker.log("timer initialized");
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      removeTime();
      isEnded();
    });
    talker.log("timer start point");
  }

  void removeTime() {}

  void isEnded() {
    //TODO:make this
    if (duration.inSeconds == 0) {
      timer?.cancel();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomePg(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  void durationInit() {
    setState(() {
      min = int.parse(widget.minutes);
      hour = int.parse(widget.hours);
      duration = Duration(minutes: min, hours: hour);
    });
    talker.log("duration initialized");
  }

  bool isPaused = false;
  bool isStarted = false;
  Timer? timer;
  int min = 0;
  int hour = 0;
  Duration duration = Duration();

  @override
  Widget build(BuildContext context) {
    int durSecondsEntry = duration.inSeconds;
    int durMinutes = duration.inMinutes - duration.inHours;
    int durHours = duration.inHours;
    int durSeconds =
        durSecondsEntry - (((durHours * 60) * 60) + (durMinutes * 60));
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title),
                    Text("P${widget.status}"),
                  ],
                ),
              ),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300),
                  color: const Color.fromARGB(255, 219, 219, 219),
                ),
                child: Center(
                  child: Text(
                    "$durHours:${(durMinutes < 10) ? '0$durMinutes' : durMinutes}:${(durSeconds < 10) ? "0$durSeconds" : durSeconds}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      isStarted
                          ? Container(
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  timer?.cancel();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => HomePg(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text("stop"),
                              ),
                            )
                          : SizedBox(
                              width: 0,
                            ),
                      Container(
                        width: isStarted ? 80 : 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey,
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (isStarted == true) {
                              if (isPaused = false) {
                                setState(() {
                                  isPaused = true;
                                });
                                timer?.cancel();
                              }
                              if (isPaused = true) {
                                setState(() {
                                  isPaused = false;
                                });
                                startTimer();
                              }
                            }
                            if (isStarted == false) {
                              startTimer();
                              setState(() {
                                isStarted = true;
                              });
                            }
                          },
                          child: Text(isStarted
                              ? (isPaused ? "resume" : "pause")
                              : "start"),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
