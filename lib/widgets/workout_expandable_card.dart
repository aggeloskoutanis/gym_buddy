import 'package:flutter/material.dart';

class WorkoutExpandableCard extends StatefulWidget {

  final workout;

  const WorkoutExpandableCard({required this.workout, Key? key}) : super(key: key);

  @override
  _WorkoutExpandableCardState createState() => _WorkoutExpandableCardState();
}

class _WorkoutExpandableCardState extends State<WorkoutExpandableCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.only(
            top: 20.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text('Not expanded'),
          children: <Widget>[
            Text('Expandable 1'),
            Text('Expandable 2'),
            Text('Expandable 3'),
          ],
        ),
      ),
    );
  }
}
