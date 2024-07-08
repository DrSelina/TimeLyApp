import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_manage/custom_widgets/homepgListItem.dart';

class HomePg extends StatefulWidget {
  const HomePg({
    super.key,
    required this.box,
  });
  final Box<dynamic> box;

  @override
  State<HomePg> createState() => _HomePg();
}

class _HomePg extends State<HomePg> {
  @override
  void initState() {
    super.initState();
    takeBoxData();
  }

  void takeBoxData() {
    try {
      final titles = widget.box.get("titles");
      if (titles != null) {
        setState(() {
          titlesCount = titles;
        });
        talker.log(widget.box.get("titles"));
      }
    } catch (error) {
      talker.log("titles not initiated");
    }
    try {
      final hours = widget.box.get("hours");
      if (hours != null) {
        setState(() {
          hoursCount = hours;
        });
        talker.log(widget.box.get("hours"));
      }
    } catch (error) {
      talker.log("hours not initiated");
    }
    try {
      final minutes = widget.box.get("minutes");
      if (minutes != null) {
        setState(() {
          minutesCount = minutes;
        });
        talker.log(widget.box.get("minutes"));
      }
    } catch (error) {
      talker.log("minutes not initiated");
    }
    try {
      final indexes = widget.box.get("indexes");
      if (indexes != null) {
        setState(() {
          indexesCount = indexes;
        });
        talker.log(widget.box.get("indexes"));
      }
    } catch (error) {
      talker.log("indexes not initiated");
    }
    try {
      final statuses = widget.box.get("statuses");
      if (statuses != null) {
        setState(() {
          statusesCount = statuses;
        });
        talker.log(widget.box.get("statuses"));
      }
    } catch (error) {
      talker.log("statuses not initiated");
    }
    try {
      final timesActivation = widget.box.get("timesActivation");
      if (timesActivation != null) {
        setState(() {
          timesActivationCount = timesActivation;
        });
        talker.log(widget.box.get("timesActivation"));
      }
    } catch (error) {
      talker.log("timesActivation not initiated");
    }
  }

  void HivePutAction() {
    widget.box.put("titles", titlesCount);
    widget.box.put("hours", hoursCount);
    widget.box.put("minutes", minutesCount);
    widget.box.put("indexes", indexesCount);
    widget.box.put("statuses", statusesCount);
    widget.box.put("timesActivation", timesActivationCount);
  }

  int currentPageIndex = 0;
  int tilesIndex = 0;
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> titlesCount = [];
  List<String> hoursCount = [];
  List<String> minutesCount = [];
  List<String> indexesCount = [];
  List<String> statusesCount = [];
  List<TimeOfDay> timesActivationCount = [];
  TextEditingController title = TextEditingController();
  TextEditingController hours = TextEditingController();
  TextEditingController minutes = TextEditingController();
  TextEditingController hoursActivation = TextEditingController();
  TextEditingController minutesActivation = TextEditingController();
  TextEditingController periodActivation = TextEditingController();
  bool homepgDialogTitleFieldFilled = false;
  bool homepgDialogHoursFieldFilled = true;
  bool homepgDialogMinutesFieldFilled = false;
  bool isDailyCheckBoxValue = true;

  final talker = TalkerFlutter.init();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.grey,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer),
            label: 'tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
      body: <Widget>[
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            title: const Text("Home"),
            centerTitle: true,
          ),
          body: Material(
            child: Center(
              child: ListView.builder(
                itemCount: titlesCount.length,
                itemBuilder: (BuildContext context, int index) {
                  return HomePgListItem(
                    box: widget.box,
                    title: titlesCount[index],
                    hours: hoursCount[index],
                    minutes: minutesCount[index],
                    status: statusesCount[index],
                  );
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                        child: Container(
                          height: 400,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextFormField(
                                    controller: title,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        hintText: "Title"),
                                  ),
                                  const Text("Timer"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 80,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: "Hours",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                          ),
                                          controller: hours,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        ":",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 80,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: "Mins",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                          ),
                                          controller: minutes,
                                          keyboardType: TextInputType.datetime,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text("Time of activation"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60,
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                          ),
                                          controller: hoursActivation,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        ":",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                          ),
                                          controller: minutesActivation,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 60,
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                          ),
                                          controller: periodActivation,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () async {
                                        final TimeOfDay? timeOfDay =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: selectedTime,
                                          initialEntryMode:
                                              TimePickerEntryMode.dial,
                                        );
                                        if (timeOfDay != null) {
                                          setState(() {
                                            selectedTime = timeOfDay;
                                            hoursActivation.text =
                                                timeOfDay.hour.toString();
                                            minutesActivation.text =
                                                timeOfDay.minute.toString();
                                            final period =
                                                timeOfDay.period.toString();
                                            if (period == "DayPeriod.am") {
                                              periodActivation.text = "am";
                                            }
                                            if (period == "DayPeriod.pm") {
                                              periodActivation.text = "pm";
                                            }
                                          });
                                        }
                                      },
                                      child: Text("set time"),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StatefulBuilder(
                                        builder:
                                            (context, StateSetter setState) {
                                          return Checkbox(
                                            value: isDailyCheckBoxValue,
                                            onChanged: (value) {
                                              setState(() {
                                                isDailyCheckBoxValue = value!;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      const Text("daily"),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 300,
                                      height: 50,
                                      child: TextButton(
                                          onPressed: () async {
                                            if (hours.text == "") {
                                              setState(() {
                                                hours.text = "0";
                                              });
                                              talker.log(
                                                  "hours space convert to 0");
                                            }
                                            if (minutes.text == "") {
                                              setState(() {
                                                minutes.text = "0";
                                              });
                                              talker.log(
                                                  "minutes space convert to 0");
                                            }
                                            if (hours.text == "0" &&
                                                minutes.text == "") {
                                              Fluttertoast.showToast(
                                                  msg: "time can't be empty");
                                              setState(() {
                                                homepgDialogHoursFieldFilled =
                                                    false;
                                                homepgDialogMinutesFieldFilled =
                                                    false;
                                              });
                                              talker.log(
                                                  "minutes space convert to 0");
                                            }
                                            if (title.text == "") {
                                              Fluttertoast.showToast(
                                                  msg: "title can't be empty");
                                              homepgDialogTitleFieldFilled =
                                                  false;
                                            }
                                            if (title.text != "") {
                                              homepgDialogTitleFieldFilled =
                                                  true;
                                            }
                                            if (minutes.text != "") {
                                              setState(() {
                                                homepgDialogMinutesFieldFilled =
                                                    true;
                                                homepgDialogHoursFieldFilled =
                                                    true;
                                              });
                                            }
                                            if (hours.text != "0") {
                                              setState(() {
                                                homepgDialogHoursFieldFilled =
                                                    true;
                                              });
                                            }
                                            var intminutes =
                                                int.parse(minutes.text);
                                            if (hours.text == "0" &&
                                                intminutes > 60) {
                                              homepgDialogMinutesFieldFilled =
                                                  false;
                                              Fluttertoast.showToast(
                                                  msg: "try set hours");
                                            }
                                            if (hours.text == "0" &&
                                                intminutes <= 60) {
                                              homepgDialogMinutesFieldFilled =
                                                  true;
                                            }
                                            if (hours.text != "0" &&
                                                intminutes > 59) {
                                              homepgDialogMinutesFieldFilled =
                                                  false;
                                              Fluttertoast.showToast(
                                                  msg: "try set hours");
                                            }
                                            if (hours.text != "0" &&
                                                intminutes <= 59) {
                                              homepgDialogMinutesFieldFilled =
                                                  true;
                                            }
                                            if (intminutes < 10) {
                                              setState(() {
                                                minutes.text =
                                                    "0${minutes.text}";
                                              });
                                              talker.log(minutes.text);
                                            }
                                            if (homepgDialogHoursFieldFilled ==
                                                    true &&
                                                homepgDialogMinutesFieldFilled ==
                                                    true &&
                                                homepgDialogTitleFieldFilled ==
                                                    true) {
                                              homepgDialogMinutesFieldFilled =
                                                  false;
                                              homepgDialogTitleFieldFilled =
                                                  false;
                                              titlesCount.add(title.text);
                                              hoursCount.add(hours.text);
                                              minutesCount.add(minutes.text);
                                              indexesCount.add(
                                                  ((minutesCount.length) - 1)
                                                      .toString());
                                              statusesCount.add("0");
                                              title.text = "";
                                              hours.text = "";
                                              minutes.text = "";
                                              HivePutAction();
                                              talker.log(
                                                  ((widget.box.get("titles")) !=
                                                          null)
                                                      ? "succ"
                                                      : "fail");
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text(
                                            "Create",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}
