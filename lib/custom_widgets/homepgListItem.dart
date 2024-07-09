import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_manage/pages/timerNormalized.dart';

class HomePgListItem extends StatefulWidget {
  const HomePgListItem({
    super.key,
    required this.title,
    required this.hours,
    required this.minutes,
    this.function,
    required this.status,
    required this.box,
    required this.timeOfDay,
  });
  final String title;
  final String hours;
  final String minutes;
  final VoidCallback? function;
  final String status;
  final Box<dynamic> box;
  final TimeOfDay timeOfDay;

  @override
  State<HomePgListItem> createState() => _HomePgListItemState();
}

class _HomePgListItemState extends State<HomePgListItem> {
  ///TODO: make checker constantly checkable
  void timeCheck() {
      if (TimeOfDay.now() == widget.timeOfDay) {
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TimerPage(
        //       box: box,
        //       title: title,
        //       hours: hours,
        //       minutes: minutes,
        //       status: status,
        //     ),
        //   ),
        //   (Route<dynamic> route) => false,
        // );
        talker.log("time check - inner class");
      }
      talker.log("time check - TOD = ${widget.timeOfDay}, ${TimeOfDay.now()}");
    }

  @override
  Widget build(BuildContext context) {
    timeCheck();

    return Card(
      child: Container(
        height: 100,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: 80,
                  width: 90,
                  child: Center(child: Text(widget.title)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: 190,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("P${widget.status}"),
                      SizedBox(
                        width: 30,
                      ),
                      Text("${widget.hours}:${widget.minutes}"),
                      IconButton(
                        onPressed: () {
                          talker.log(widget.timeOfDay);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => TimerPage(
                                box: widget.box,
                                title: widget.title,
                                hours: widget.hours,
                                minutes: widget.minutes,
                                status: widget.status,
                              ),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        icon: Icon(Icons.arrow_circle_right),
                      )
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
