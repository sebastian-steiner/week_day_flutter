import 'dart:math';

import 'package:flutter/material.dart';
import 'package:week_day_flutter/logic/date.dart';
import 'package:week_day_flutter/logic/stat_saver.dart';
import 'package:week_day_flutter/logic/statistics.dart';
import 'package:week_day_flutter/widgets/answer_button.dart';

import 'p_day_month_end.dart';

class PDayMonth extends StatefulWidget {
  final int count;
  final bool byMonthNames;

  PDayMonth({Key key, @required this.count, @required this.byMonthNames}) : super(key: key);

  @override
  _PDayMonthState createState() => _PDayMonthState();
}

class _PDayMonthState extends State<PDayMonth> {
  List<Date> remainingCodes;
  Stopwatch watch;
  Random rng;

  Statistics stats;

  List<Date> setupCodes() {
    List<Date> remaining = new List();
    for (int i = 0; i < widget.count; i++) {
      remaining.add(createDate());
    }
    return remaining;
  }

  Date createDate() {
    int month = rng.nextInt(12);
    int day = rng.nextInt(Date.maxDayFromDate(month)) + 1;
    return new Date(
        month: month,
        day: day
    );
  }

  @override
  void initState() {
    super.initState();
    rng = new Random();
    stats = new Statistics();
    remainingCodes = setupCodes();
    remainingCodes.shuffle();
    watch = Stopwatch();
  }

  @override
  Widget build(BuildContext context) {
    if (!watch.isRunning) {
      watch.start();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice Day-Months"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Date:",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                remainingCodes.last.formatDayMonth(widget.byMonthNames),
                style: Theme.of(context).textTheme.headline1,
              ),
              AnswerButton(
                answer: answer,
                val: 0,
              ),
              AnswerButton(
                answer: answer,
                val: 1,
              ),
              AnswerButton(
                answer: answer,
                val: 2,
              ),
              AnswerButton(
                answer: answer,
                val: 3,
              ),
              AnswerButton(
                answer: answer,
                val: 4,
              ),
              AnswerButton(
                answer: answer,
                val: 5,
              ),
              AnswerButton(
                answer: answer,
                val: 6,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void answer(int val) async {
    int curr = (Date.monthCodes[remainingCodes.last.month] + remainingCodes.last.day) % 7;
    if (curr == val) {
      if (remainingCodes.length == 1) {
        stats.options.addAll({
          "count": widget.count.toString(),
          "byMonthNames": widget.byMonthNames.toString()
        });
        await new StatSaver().saveStats('pdaymonth', stats);
      }

      setState(() {
        // time
        watch.stop();
        stats.times.add(watch.elapsed);
        watch.reset();

        remainingCodes.removeLast();
        if (remainingCodes.isEmpty) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => PDayMonthEnd(stats: stats)));
        }
      });
    } else {
      setState(() {
        stats.errors++;
      });
    }
  }
}
