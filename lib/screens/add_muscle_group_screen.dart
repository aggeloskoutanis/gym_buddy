import 'package:flutter/material.dart';

import 'package:gym_buddy/widgets/multiple_search.dart';

class AddMuscleGroupScreen extends StatefulWidget {
  static const routeName = '/add-muscle-group';

  const AddMuscleGroupScreen({Key? key}) : super(key: key);

  @override
  _AddMuscleGroupScreenState createState() => _AddMuscleGroupScreenState();
}

class _AddMuscleGroupScreenState extends State<AddMuscleGroupScreen> {
  final _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(

        onTap: () {

          FocusManager.instance.primaryFocus?.unfocus();

        },
        child: Column(
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

                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                            ),
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


                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  child: const Icon(Icons.save, color: Colors.white,),
                  onPressed: () {



                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
