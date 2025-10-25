import 'package:http/http.dart' as http;
import './question_model.dart';
import 'dart:convert';

class DBconnect {
  // Use sample questions instead of Firebase to avoid API issues
  Future<List<Question>> fetchQuestions() async {
    // Return sample questions directly to avoid API type issues
    return [
      Question(
        id: '1',
        title: 'What is 2 + 2?',
        options: {'3': false, '4': true, '5': false, '6': false},
      ),
      Question(
        id: '2',
        title: 'What is the capital of France?',
        options: {'London': false, 'Paris': true, 'Berlin': false, 'Madrid': false},
      ),
      Question(
        id: '3',
        title: 'Which planet is closest to the Sun?',
        options: {'Venus': false, 'Mercury': true, 'Earth': false, 'Mars': false},
      ),
      Question(
        id: '4',
        title: 'What is the largest mammal?',
        options: {'Elephant': false, 'Blue Whale': true, 'Giraffe': false, 'Hippo': false},
      ),
      Question(
        id: '5',
        title: 'Which programming language is Flutter based on?',
        options: {'Java': false, 'Dart': true, 'Python': false, 'JavaScript': false},
      ),
      Question(
        id: '6',
        title: 'What is the speed of light?',
        options: {'300,000 km/s': true, '150,000 km/s': false, '600,000 km/s': false, '450,000 km/s': false},
      ),
      Question(
        id: '7',
        title: 'Which country has the most population?',
        options: {'India': false, 'China': true, 'USA': false, 'Brazil': false},
      ),
      Question(
        id: '8',
        title: 'What is the chemical symbol for Gold?',
        options: {'Go': false, 'Au': true, 'Gd': false, 'Ag': false},
      ),
      Question(
        id: '9',
        title: 'Which ocean is the largest?',
        options: {'Atlantic': false, 'Pacific': true, 'Indian': false, 'Arctic': false},
      ),
      Question(
        id: '10',
        title: 'What year did World War II end?',
        options: {'1944': false, '1945': true, '1946': false, '1943': false},
      ),
    ];
  }
}
