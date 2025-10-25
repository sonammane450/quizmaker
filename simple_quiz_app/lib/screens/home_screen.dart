// import the material package

import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/question_model.dart'; // our question model
import '../widgets/question_widget.dart'; // the question widget
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/result_box.dart';
import '../models/db_connect.dart';

// create the HomeScreen widget
// I'm taking the Stateful widget because it's going to be our parent widget and all the functions and variables will be in this widget so we will need to change state of our widget.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.userName = ''}) : super(key: key);
  
  final String userName;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // create an object for Dbconnect
  var db = DBconnect();
  late Future _questions;
  String userName = '';

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    userName = widget.userName;
    super.initState();
  }

  // create an index to loop through _questions
  int index = 0;
  // create a score variable
  int score = 0;
  // create a boolean value to check if the user has clicked
  bool isPressed = false;
  // create a function to display the next question
  bool isAlreadySelected = false;
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      // this is the block where the questions end.
      showDialog(
          context: context,
          barrierDismissible:
              false, // this will disable the dissmis function on clicking outside of box
          builder: (ctx) => ResultBox(
                result: score, // total points the user got
                questionLength: questionLength, // out of how many questions
                onPressed: startOver,
                userName: userName,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++; // when the index will change to 1. rebuild the app.
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select any option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  // create a function for changing color
  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  // create a function to start over
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // use the FutureBuilder Widget
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF667EEA),
                      Color(0xFF764BA2),
                      Color(0xFFF093FB),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Modern App Bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // App Title
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: const Icon(
                                    Icons.quiz,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                const Text(
                                  'Quiz Master',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            // Score Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    '$score',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Main Content
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: backgroundLight,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20.0),
                              
                              // Question Widget
                              QuestionWidget(
                                indexAction: index,
                                question: extractedData[index].title,
                                totalQuestions: extractedData.length,
                              ),
                              
                              const SizedBox(height: 20.0),
                              
                              // Options
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  itemCount: extractedData[index].options.length,
                                  itemBuilder: (context, i) {
                                    return OptionCard(
                                      option: extractedData[index].options.keys.toList()[i],
                                      color: isPressed
                                          ? extractedData[index]
                                                      .options
                                                      .values
                                                      .toList()[i] ==
                                                  true
                                              ? correct
                                              : incorrect
                                          : neutral,
                                      onTap: () => checkAnswerAndUpdate(
                                          extractedData[index].options.values.toList()[i]),
                                    );
                                  },
                                ),
                              ),
                              
                              const SizedBox(height: 20.0),
                              
                              // Next Button
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: NextButton(
                                  onTap: () => nextQuestion(extractedData.length),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF667EEA),
                    Color(0xFF764BA2),
                    Color(0xFFF093FB),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Loading Animation
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        gradient: primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 20.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 3.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    
                    // Loading Text
                    const Text(
                      'Loading Questions...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Preparing your quiz experience',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}

// import this file to our main.dart file
