import 'package:flutter/material.dart';
import 'package:week_day_flutter/logic/date.dart';
import 'package:week_day_flutter/widgets/answer_button.dart';

import 'p_year_end.dart';

class PYear extends StatefulWidget {
  final int repetitions;
  final int min;
  final int max;

  PYear({Key key, @required this.repetitions, @required this.min, @required this.max}) : super(key: key);

  @override
  _PYearState createState() => _PYearState();
}

class _PYearState extends State<PYear> {
  List<int> remainingCodes;
  Stopwatch watch;

  // stats
  List<Duration> times;
  int errors;

  List<int> setupCodes() {
    List<int> remaining = new List();
    for (int i = widget.min; i <= widget.max; i++) {
      remaining.addAll(List.filled(widget.repetitions, i));
    }
    return remaining;
  }

  @override
  void initState() {
    super.initState();
    times = new List();
    remainingCodes = setupCodes();
    remainingCodes.shuffle();
    errors = 0;
    watch = Stopwatch();
  }

  @override
  Widget build(BuildContext context) {
    if (!watch.isRunning) {
      watch.start();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice Years"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Year:",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                remainingCodes.last.toString(),
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
    int curr = Date.yearCode(remainingCodes.last);
    if (curr == val) {
      setState(() {
        // time
        watch.stop();
        times.add(watch.elapsed);
        watch.reset();

        remainingCodes.removeLast();
        if (remainingCodes.isEmpty) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => PYearEnd(times: times, errors: errors)));
        }
      });
    } else {
      setState(() {
        errors++;
      });
    }
  }
}
