import 'dart:math';

import 'package:flutter/material.dart';
import 'package:week_day_flutter/logic/date.dart';
import 'package:week_day_flutter/widgets/answer_button.dart';

import 'p_full_end.dart';

class PFull extends StatefulWidget {
  final int count;
  final int minYear;
  final int maxYear;
  final int minCentury;
  final int maxCentury;
  final bool byMonthNames;

  PFull(
      {Key key,
      @required this.count,
      @required this.minYear,
      @required this.maxYear,
      @required this.minCentury,
      @required this.maxCentury,
      @required this.byMonthNames})
      : super(key: key);

  @override
  _PFullState createState() => _PFullState();
}

class _PFullState extends State<PFull> {
  List<Date> remainingCodes;
  Stopwatch watch;
  Random rng;

  // stats
  List<Duration> times;
  int errors;

  List<Date> setupCodes() {
    List<Date> remaining = new List();
    for (int i = 0; i < widget.count; i++) {
      remaining.add(createDate());
    }
    return remaining;
  }

  Date createDate() {
    Date date = new Date()
        .withYear(rng.nextInt(widget.maxCentury - widget.minCentury + 1) + widget.minCentury
        + rng.nextInt(widget.maxYear - widget.minYear + 1) + widget.minYear)
        .withMonth(rng.nextInt(12));
    return date.withDay(rng.nextInt(Date.maxDayFromDate(date.month, year: date.year) - 1) + 1);
  }

  @override
  void initState() {
    super.initState();
    rng = new Random();
    watch = Stopwatch();
    times = new List();
    errors = 0;
    remainingCodes = setupCodes();
    remainingCodes.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (!watch.isRunning) {
      watch.start();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice Full dates"),
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
                remainingCodes.last.formatDate(widget.byMonthNames),
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

  void answer(int val) {
    int curr = remainingCodes.last.weekDay();
    if (curr == val) {
      setState(() {
        // time
        watch.stop();
        times.add(watch.elapsed);
        watch.reset();

        remainingCodes.removeLast();
        if (remainingCodes.isEmpty) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => PFullEnd(times: times, errors: errors)));
        }
      });
    } else {
      setState(() {
        errors++;
      });
    }
  }
}
