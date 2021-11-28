import 'package:flutter/material.dart';
import 'package:gym_buddy/helpers/style_helpers.dart';
import 'package:gym_buddy/providers/muscle_group.dart';
import 'package:provider/provider.dart';
import '../providers/muscle_groups.dart';

class GroupDetailScreen extends StatefulWidget {
  static const routeName = '/muscle-group-details';

  const GroupDetailScreen({Key? key}) : super(key: key);

  @override
  _GroupDetailScreenState createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final groupId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedGroup =
        Provider.of<MuscleGroups>(context, listen: false).findById(groupId);
    List<Widget> cards = getExercises(loadedGroup, context);


    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 20,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Hero(
            tag: loadedGroup.id,
            child: Center(
              child: Text(loadedGroup.name),
            ),
          ),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Column(children: [
              MediaQuery.removePadding(
                removeTop: true,
                  context: context,
                  child: StyleHelpers.frameContainer(
                      ListView(shrinkWrap: true, children: [...cards]),
                    300, context
                  ),
              ),
            ])),
      ]))
    ]));
  }


  List<Card> getExercises(MuscleGroup loadedGroup, context) {
    List<Card> cards = [];

    for (var element in loadedGroup.exercises) {
      cards.add(Card(
        elevation: 2,
        shadowColor: Theme.of(context).primaryColor,
        child: Center(heightFactor: 3,
          child: Text(
            element.name,
          ),
        ),
      ));
    }

    return cards;
  }
}
