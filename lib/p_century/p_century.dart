import 'package:flutter/material.dart';
import 'package:week_day_flutter/logic/date.dart';
import 'package:week_day_flutter/logic/stat_saver.dart';
import 'package:week_day_flutter/logic/statistics.dart';
import 'package:week_day_flutter/widgets/answer_button.dart';

import 'p_century_end.dart';

class PCentury extends StatefulWidget {
  final int repetitions;
  final int min;
  final int max;

  PCentury({Key key, @required this.repetitions, @required this.min, @required this.max}) : super(key: key);

  @override
  _PCenturyState createState() => _PCenturyState();
}

class _PCenturyState extends State<PCentury> {
  List<int> remainingCodes;
  Stopwatch watch;

  Statistics stats;

  List<int> setupCodes() {
    List<int> remaining = new List();
    for (int i = widget.min; i <= widget.max; i += 100) {
      remaining.addAll(List.filled(widget.repetitions, i));
    }
    return remaining;
  }

  @override
  void initState() {
    super.initState();
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
        title: Text("Practice Centuries"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Century:",
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

  void answer(int val) async {
    int curr = Date.centuryCode(remainingCodes.last ~/ 100);
    if (curr == val) {
      if (remainingCodes.length == 1) {
        await new StatSaver().saveStats('pcentury', stats);
      }

      setState(() {
        // time
        watch.stop();
        stats.times.add(watch.elapsed);
        watch.reset();

        remainingCodes.removeLast();
        if (remainingCodes.isEmpty) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => PCenturyEnd(stats: stats)));
        }
      });
    } else {
      setState(() {
        stats.errors++;
      });
    }
  }
}
