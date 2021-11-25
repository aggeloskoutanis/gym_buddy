import 'package:flutter/material.dart';
import 'package:gym_buddy/models/exercise.dart';
import 'package:provider/provider.dart';
import '../providers/exercises.dart';
import '../models/exercise.dart';

class MultipleSearch extends StatefulWidget {
  const MultipleSearch({Key? key}) : super(key: key);

  @override
  _MultipleSearchState createState() => _MultipleSearchState();
}

class _MultipleSearchState extends State<MultipleSearch> {
  final _selectedExerciseController = TextEditingController();

  ScrollController? _scrollController;
  var _onChangeValue;
  bool _isExerciseFound = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _selectedExerciseController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _onChangeValue = '';
    // Start listening to changes.
    _selectedExerciseController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print('Second text field: ${_selectedExerciseController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _selectedExerciseController,
          decoration: const InputDecoration(
              labelText: 'Search text', icon: Icon(Icons.search)),
          onChanged: (value) {
            setState(() {
              _onChangeValue = value;
            });
            // setState(() {
            //   _loadedExercises = Provider.of<Exercises>(context, listen: false).filterOutExercises('exercises', value);
            // });
          },
          keyboardType: TextInputType.name,
        ),
        StreamBuilder(
          initialData: Provider.of<Exercises>(context, listen: false)
              .fetchAndSetExercises(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Exercises>(
                  child: const Center(
                    child: Text('Got no exercises yet'),
                  ),
                  builder: (context, exercises, ch) => exercises.items.isEmpty
                      ? ch as Widget
                      : _buildListOfExercises(exercises.items)),
        )
      ],
    );
  }

  Widget _buildListOfExercises(table) {
    List<Exercise> tempTable = table;

    print('before : ' + tempTable.toString());
    tempTable.removeWhere((element) => !element.name.contains(_onChangeValue));
    print('after' + tempTable.toString());

    if (tempTable.isEmpty) {
      _isExerciseFound = false;

      return frameContainer( Row(
        children: [
          Container(
            child: Text(
              'No exercise found!',
            ),
            margin: EdgeInsets.all(20),
          ),
          Expanded(
              child: Container(
            width: 60,
          )),
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.deepPurple,
            onPressed: () {
              setState(() {
                Provider.of<Exercises>(context, listen: false)
                    .insertNewExercise(_onChangeValue);
              });

              const SnackBar snackBar =
                  SnackBar(content: Text('New exercise has been added!'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ), 100);
    } else {
      _isExerciseFound = true;

      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
          frameContainer(
             ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: tempTable.length,
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text(tempTable[i].name),
                    subtitle: Text(tempTable[i].desc),
                    onTap: () {
                      _selectedExerciseController.text = tempTable[i].name;
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
            300

            ),
          ],
        ),
      );
    }
  }

  Widget frameContainer(Widget child, double height) {


    return Container(
        decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    height: height,
    width: 400,
    child:child
    );
  }
}
