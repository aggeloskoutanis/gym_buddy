import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:gym_buddy/widgets/multiple_search.dart';
import '../providers/exercises.dart';
import 'package:provider/provider.dart';

class AddMuscleGroupScreen extends StatefulWidget {
  static const routeName = '/add-muscle-group';

  const AddMuscleGroupScreen({Key? key}) : super(key: key);

  @override
  _AddMuscleGroupScreenState createState() => _AddMuscleGroupScreenState();
}

class _AddMuscleGroupScreenState extends State<AddMuscleGroupScreen> {
  final _groupNameController = TextEditingController();

  final GlobalKey<FormState> _abcKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                          labelText: 'Group name',
                          border: OutlineInputBorder()),
                      controller: _groupNameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MultipleSearch(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Add new group'),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
