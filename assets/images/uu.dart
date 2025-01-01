import 'package:flutter/material.dart';

void main() {
  runApp(OnlineQuizApp());
}

class OnlineQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Quiz',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatelessWidget {
  final List<String> topics = ['Science', 'History', 'Mathematics', 'General Knowledge'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Online Quiz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Online Quiz', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Select a Topic to Begin', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: topics.map((topic) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizPage(topic: topic)),
                    );
                  },
                  child: Text(topic),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String topic;

  QuizPage({required this.topic});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final Map<String, List<Map<String, Object>>> quizData = {
    'Science': [
      {'question': 'What planet is known as the Red Planet?', 'answers': ['Earth', 'Mars', 'Jupiter'], 'correct': 'Mars'},
      {'question': 'What is the chemical symbol for water?', 'answers': ['H2O', 'O2', 'CO2'], 'correct': 'H2O'},
    ],
    'History': [
      {'question': 'Who was the first President of the USA?', 'answers': ['Abraham Lincoln', 'George Washington', 'Thomas Jefferson'], 'correct': 'George Washington'},
    ],
    // Add other topics similarly...
  };

  int currentQuestionIndex = 0;
  int score = 0;

  void checkAnswer(String answer) {
    if (answer == quizData[widget.topic]![currentQuestionIndex]['correct']) {
      score++;
    }
    if (currentQuestionIndex < quizData[widget.topic]!.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Completed!'),
        content: Text('Your score is $score/${quizData[widget.topic]!.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionData = quizData[widget.topic]![currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('${widget.topic} Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questionData['question'] as String,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...((questionData['answers'] as List<String>).map((answer) {
              return ElevatedButton(
                onPressed: () => checkAnswer(answer),
                child: Text(answer),
              );
            })).toList(),
          ],
        ),
      ),
    );
  }
}