import 'package:flutter/material.dart';
import '../providers/muscle_group.dart';
import '../screens/group_details_screen.dart';

class GroupItem extends StatefulWidget {
  const GroupItem({required this.muscleGroup, Key? key}) : super(key: key);

  final MuscleGroup muscleGroup;

  @override
  State<GroupItem> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(GroupDetailScreen.routeName,
            arguments: widget.muscleGroup.id);
      },
      child: Hero(
        tag: widget.muscleGroup.id,
        child: Card(
          elevation: 2,
          shadowColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Row(children: [
                Flexible(child: Center(child: Text(widget.muscleGroup.name)))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
