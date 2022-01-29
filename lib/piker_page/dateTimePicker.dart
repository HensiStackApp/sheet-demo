import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:sheet_widget_demo/commonWidget/commonButton.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({Key key}) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  static var unavailableDates = [
    "2021-10-18",
    "2021-10-20",
    "2021-10-25",
    "2021-10-21",
    "2021-11-23"
  ];
  static int currentIndex = 0;

  static DateTime initialDate = DateTime.now();
  static DateFormat dateFormat = new DateFormat("yyyy-MM-dd");
  String formattedDate = dateFormat.format(initialDate);

  DateTime selectedDate = DateTime.now();
  DateTime selectedMonth = DateTime.now();
  DateTime selectedYear = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 00);
  var year;
  var month;

  bool setDayPredicate(DateTime val) {
    //this allows certain dates to be greyed out based on availability
    String dates = dateFormat.format(val); //formatting passed in value
    return !unavailableDates.contains(dates);
  }

  Future<void> _selectDate(BuildContext context) async {
    unavailableDates.sort(((a, b) => a.compareTo(b)));
    DateTime fromStringDate;
    for (var unavdate in unavailableDates) {
      if (unavdate.compareTo(formattedDate) == 0) {
        formattedDate = unavdate;
        fromStringDate = DateTime.parse(formattedDate);
        initialDate = fromStringDate.add(new Duration(days: 1));
        formattedDate = dateFormat.format(initialDate);
      }
    }

    DateTime date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: new DateTime.now(),
      lastDate: new DateTime.now().add(new Duration(days: 30)),
      selectableDayPredicate: setDayPredicate,
    );
    print(date);

    /*  */ /* final DateTime picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: themeColor,
                onSurface: grey,
              ),
              dialogBackgroundColor: white,
            ),
            child: child,
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });*/ /*
    List<String> list = ['2021-10-21'];

    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      onTapDay: (DateTime dateTime, bool available) {
        if (!available) {
          showDialog(
              context: context,
              builder: (c) => CupertinoAlertDialog(
                    title: Text("This date cannot be selected."),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ));
        }
        return available;
      },
      */
    /*   selectableDayPredicate: (DateTime dateTime) {
        if (dateTime == DateTime(2021, 10, 21)) {
          return false;
        }
        return true;
      },*/
    /*
      listDateDisabled: [DateTime.parse("2021-10-28")],
      selectableDayPredicate: (DateTime dateTime) {
        if (dateTime != null) {
          list.forEach((element) {
            List array = element.split('-');
            print(array);
            print(array[0]);
            print(array[1]);
            print(array[2]);
            print("${int.parse(array[0])},${int.parse(array[1])},${int.parse(array[2])}");
            print(dateTime.toString().substring(0, 10));
            print(DateTime(int.parse(array[0]), int.parse(array[1]), int.parse(array[2]))
                .toString()
                .substring(0, 10));
            print(dateTime.toString().substring(0, 10) ==
                DateTime(
                        int.parse(array[0].toString().trim()),
                        int.parse(array[1].toString().trim()),
                        int.parse(array[2].toString().trim()))
                    .toString()
                    .substring(0, 10));

            if (dateTime.toString().substring(0, 10) ==
                DateTime(
                        int.parse(array[0].toString().trim()),
                        int.parse(array[1].toString().trim()),
                        int.parse(array[2].toString().trim()))
                    .toString()
                    .substring(0, 10)) {
              return false;
            } else {
              print("else");
            }
          });
        }
        return true;
      },
    );*/
  }

  Future<void> _selectmonth(BuildContext context) async {
    final DateTime picked = await showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 2, 9),
      initialDate: selectedMonth,
    );
    if (picked != null && picked != selectedMonth)
      setState(() {
        print(picked);
        selectedMonth = picked;
        print(selectedMonth);
      });
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: themeColor,
                onSurface: grey,
              ),
              dialogBackgroundColor: white,
            ),
            child: child,
          );
        },
        initialDatePickerMode: DatePickerMode.year,
        initialDate: selectedYear,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedYear)
      setState(() {
        selectedYear = picked;
        print(selectedYear);
        print(picked);
      });
  }

  Future _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: themeColor,
              onSurface: grey,
            ),
            dialogBackgroundColor: white,
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        print(selectedTime);
        print(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Time Picker"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("select date -- " +
                  "${selectedDate.toLocal()}".substring(0, 10)),
              SizedBox(
                height: 20.0,
              ),
              elevatedButton(() => _selectDate(context), 'Select date'),
              SizedBox(
                height: 30.0,
              ),
              Text("select month -- " + "${month = Jiffy(selectedMonth).MMM}"),
              SizedBox(
                height: 20.0,
              ),
              elevatedButton(() => _selectmonth(context), 'Select month'),
              SizedBox(
                height: 30.0,
              ),
              Text("select year -- " + "${year = Jiffy(selectedYear).year}"),
              SizedBox(
                height: 20.0,
              ),
              elevatedButton(() => _selectYear(context), 'Select Year'),
              SizedBox(
                height: 30.0,
              ),
              Text("select time -- " +
                  "${selectedTime.hour} : ${selectedTime.minute} "),
              SizedBox(
                height: 20.0,
              ),
              elevatedButton(() => _selectTime(context), 'Select Time'),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                  onPressed: () {
                    // DatePicker.showTimePicker(context, showTitleActions: true,
                    //     onChanged: (date) {
                    //       print('change $date in time zone ' +
                    //           date.timeZoneOffset.inHours.toString());
                    //     }, onConfirm: (date) {
                    //       print('confirm $date');
                    //     }, currentTime: DateTime.now());
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CupertinoPicker(
                              itemExtent: 40.0,
                              onSelectedItemChanged: (index) {},
                              diameterRatio: 360.0,
                              useMagnifier: true,
                              magnification: 1.0,
                              // looping: true,
                              backgroundColor: Colors.white,
                              offAxisFraction: 100.0,
                              children: [
                                Text('Item 1'),
                                Text('Item 2'),
                                Text('Item 3'),
                                Text('Item 4'),
                                Text('Item 5'),
                                Text('Item 6'),
                                Text('Item 7'),
                                Text('Item 8'),
                                Text('Item 9'),
                                Text('Item 10'),
                              ]);
                        });
                  },
                  child: Text(
                    'show time picker',
                    style: TextStyle(color: Colors.blue),
                  )),
              Container(
                height: 200,
                width: double.infinity,
                child: ListWheelScrollView(
                  physics: BouncingScrollPhysics(),
                  itemExtent: 30,
                  children: [
                    Container(
                      width: 200,
                      child: Center(
                        child: Text(
                          'English',
                          style: TextStyle(
                              color: (currentIndex == 0)
                                  ? Colors.black
                                  : Colors.grey),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: (currentIndex == 0)
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Container(
                        width: 200,
                        decoration: BoxDecoration(
                            color: (currentIndex == 1)
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            'French (standard)',
                            style: TextStyle(
                                color: (currentIndex == 1)
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                        )),
                    Container(
                        width: 200,
                        decoration: BoxDecoration(
                            color: (currentIndex == 2)
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            'French (canada)',
                            style: TextStyle(
                                color: (currentIndex == 2)
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                        )),
                  ],
                  onSelectedItemChanged: (val) {
                    print("value-->$val");
                    setState(() {
                      currentIndex = val;
                    });
                    print("value-->$val");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
