import 'package:flutter/material.dart';
import '../widgets/workout.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const String routeName = 'welcome-screen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(

            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(5),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width - 20,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'My workouts',
                style:
                TextStyle(color: Colors.black, fontFamily: 'RobotoCondensed'),
              ),
              Expanded(child: Container(

              ),),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return WorkoutCard();
                  },),
              )
            ]),
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.33,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 96,
                          fontFamily: 'RobotoCondensed-Bold',
                        ),
                      ),
                      Text('days since your last workout',
                          style: TextStyle(fontFamily: 'RobotoCondensed')),
                    ])),
          ),

        ],
      ),
    );
  }
}
