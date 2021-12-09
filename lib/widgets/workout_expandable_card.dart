import 'package:flutter/material.dart';
import '../providers/exercise.dart';
import '../providers/workouts.dart';

class WorkoutExpandableCard extends StatefulWidget {
  final Exercise exercise;

  const WorkoutExpandableCard({required this.exercise, Key? key})
      : super(key: key);

  @override
  _WorkoutExpandableCardState createState() => _WorkoutExpandableCardState();
}

class _WorkoutExpandableCardState extends State<WorkoutExpandableCard> {
  var list = List<double>.generate(100, (i) => (i + 1) * 0.25);
  late int _index = 0;
  List<String> weights = [];
  List<ListTile> repetitions = [];

  @override
  Widget build(BuildContext context) {
    for (var element in list) {
      weights.add(element.toString());
    }
    final exerciseName = widget.exercise.name;
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          leading: Container(
            decoration: BoxDecoration(
              // color: Colors.grey,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListWheelScrollView(
              onSelectedItemChanged: (index) {
                setState(() {
                  _index = index;
                });
              },
              squeeze: 2,
              clipBehavior: Clip.hardEdge,
              itemExtent: 20,
              magnification: 1.5,
              useMagnifier: true,
              physics: const FixedExtentScrollPhysics(),
              children: <Text>[...weights.map((value) => Text(value))],
            ),
            width: 60,
            height: 40,
          ),
          title: Text(exerciseName,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed')),
          trailing: IconButton(
            icon: const Icon(Icons.fitness_center),
            onPressed: () {
              int orderNr = (repetitions.length + 1);
              Text title = Text(
                "\u2022\t\t" + weights[_index] + " Kg",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15, fontFamily: 'RobotoCondensed'),
              );

              setState(() {
                ListTile listTileToAdd = ListTile(
                  title: title,
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        repetitions
                            .removeWhere((element) => element.title == title);

                        orderNr--;
                      });
                    },
                  ),
                );

                repetitions.add(listTileToAdd);
              });
            },
          ),
          children: <Widget>[...repetitions],
        ),
      ),
    );
  }
}
