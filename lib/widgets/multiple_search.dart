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
  @override
  Widget build(BuildContext context) {

    String _selectedExercise;

    return Column(
      children: [ TextField(
        decoration:
        InputDecoration(
            labelText: 'Search text', icon: const Icon(Icons.search)),
        onChanged: (_) {
            

        },
        keyboardType: TextInputType.name,

      ),
        FutureBuilder(
            future: Provider.of<Exercises>(context, listen: false)
                .fetchAndSetExercises(),
            builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator(),)
                : Consumer<Exercises>(
                child: Center(child: Text('Got no exercises yet'),),
                builder: (context, exercises, ch) =>
                exercises.items.isEmpty
                    ? ch as Widget
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: exercises.items.length,
                  itemBuilder: (ctx, i) =>
                      ListTile(
                          title: Text(exercises.items[i].name),
                          subtitle: Text(exercises.items[i].desc),
                          onTap: () {



                          },

                      ),
                )
            )
        )
      ],
    );
  }
}
