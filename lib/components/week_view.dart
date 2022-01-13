import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toddyapp/models/task_data.dart';

class WeekView extends StatefulWidget {
  @override
  WeekViewState createState() => new WeekViewState();
}

class WeekViewState extends State<WeekView> {
  late String selectDate, selectDay;
  int selected = DateTime.now().day;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, position) {
                int day = DateTime.now().day + position;
                return GestureDetector(
                    child: FittedBox(
                        child: Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.only(right: 15.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: new Border.all(
                                    // ignore: unnecessary_null_comparison
                                    color: selected == null
                                        ? Colors.transparent
                                        : selected == day
                                            ? selected == DateTime.now().day
                                                ? Colors.transparent
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                            : Colors.transparent),
                                color: day == DateTime.now().day
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      DateTime.now()
                                          .add(Duration(days: position))
                                          .day
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: day == DateTime.now().day
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: day == DateTime.now().day
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color
                                            : Colors.grey[500],
                                      )),
                                  Text(
                                    DateFormat('EE').format(DateTime.now()
                                        .add(Duration(days: position))),
                                    style: TextStyle(
                                        color: day == DateTime.now().day
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color
                                            : Colors.black87,
                                        fontWeight: day == DateTime.now().day
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  )
                                ]))),
                    onTap: () {
                      setState(() {
                        Provider.of<TaskData>(context, listen: false)
                            .currentDayUpdate(position);
                        print(Provider.of<TaskData>(context, listen: false)
                            .dayToShow);
                        selectDate = DateTime.now()
                            .add(Duration(days: position))
                            .day
                            .toString();
                        selectDay = DateFormat('EE').format(
                            DateTime.now().add(Duration(days: position)));
                        selected = DateTime.now().day + position;
                        print('Tag' + selected.toString());
                      });
                    });
              })),
    );
  }
}
