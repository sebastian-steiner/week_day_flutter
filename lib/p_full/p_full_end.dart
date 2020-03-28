import 'package:flutter/material.dart';
import 'package:week_day_flutter/logic/statistics.dart';
import 'package:week_day_flutter/widgets/named_navigator_button.dart';
import 'package:week_day_flutter/widgets/navigator_pop_button.dart';

class PFullEnd extends StatelessWidget {
  final Statistics stats;

  PFullEnd({@required this.stats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Practice years"),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("Congrats!!", style: Theme.of(context).textTheme.headline1,),
                Text(
                  "Average time:",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  "${avgTime()}s",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  "Mistakes:",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  "${stats.errors}",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Spacer(),
                NavigatorPopButton(
                  text: 'Again',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String avgTime() {
    int sum = stats.times
        .map((d) => d.inMilliseconds)
        .fold(0, (previousValue, element) => previousValue + element);
    return (sum / stats.times.length / 1000).toStringAsFixed(3);
  }
}
