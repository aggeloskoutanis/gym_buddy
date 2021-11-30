import 'package:flutter/material.dart';
import '../providers/muscle_group.dart';
import '../screens/group_details_screen.dart';

class GroupItem extends StatefulWidget {
  const GroupItem({required this.muscleGroup, required this.index, this.isWorkoutSelection = false, required this.getSelectedGroupId, Key? key}) : super(key: key);

  final Function (String) getSelectedGroupId;
  final bool isWorkoutSelection;
  final MuscleGroup muscleGroup;
  final int index;

  @override
  State<GroupItem> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {

  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        widget.isWorkoutSelection ?
        Navigator.of(context).pushNamed(GroupDetailScreen.routeName,
            arguments: widget.muscleGroup.id)
        :
            setState((){
              _isSelected = !_isSelected;
              widget.getSelectedGroupId(widget.muscleGroup.id);
            });
      },
      child: Hero(
        tag: widget.muscleGroup.id,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: _isSelected ? Theme.of(context).colorScheme.secondary : Colors.white70,
                width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          shadowColor: Theme.of(context).colorScheme.secondary,
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
