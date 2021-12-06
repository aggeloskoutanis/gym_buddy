import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 20,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        child: Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width / 2 - 20) * 0.4,
              height: MediaQuery.of(context).size.height * 0.2,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Tue', style: TextStyle(color: Colors.black, fontFamily: 'RobotoCondensed-Bold', fontSize: 20),),
                    Text('23', style: TextStyle(color: Colors.black, fontFamily: 'RobotoCondensed-Bold', fontSize: 20)),
                    Text('12 days ago',  style: TextStyle(color: Colors.black87, fontFamily: 'RobotoCondensed', fontSize: 10))
                  ]
              ),
            ),
            Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(6),
                width: (MediaQuery.of(context).size.width / 2 - 20) * 0.43,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: const [
                  Text('Group 1', style: TextStyle(color: Colors.black, fontFamily: 'RobotoCondensed', fontSize: 15),),
                  Text('Group 2', style: TextStyle(color: Colors.black, fontFamily: 'RobotoCondensed', fontSize: 15),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
