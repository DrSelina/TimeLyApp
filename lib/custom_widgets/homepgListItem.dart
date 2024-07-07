import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_manage/pages/timerMain.dart';

class HomePgListItem extends StatelessWidget {
  const HomePgListItem({
    super.key,
    required this.title,
    required this.hours,
    required this.minutes,
    this.function,
    required this.status,
  });
  final String title;
  final String hours;
  final String minutes;
  final VoidCallback? function;
  final String status;

  @override
  Widget build(BuildContext context) {
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
                  child: Center(child: Text(title)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: 190,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("P$status"),
                      SizedBox(
                        width: 30,
                      ),
                      Text("$hours:$minutes"),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => TimerMain(
                                title: title,
                                hours: hours,
                                minutes: minutes,
                                status: status,
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
