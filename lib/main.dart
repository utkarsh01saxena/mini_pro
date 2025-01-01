import 'package:flutter/material.dart';

void main() {
  runApp(OnlineQuizApp());
}

class OnlineQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MystiqueMind',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuizHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF98FF98), // Mint green color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/quiz.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'MystiqueMind',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizHomePage extends StatelessWidget {
  final List<String> topics = ['Science', 'History', 'Mathematics', 'General Knowledge'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MystiqueMind',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Color(0xFF1B4B5A), // Petroleum color
          ),
        ),
        backgroundColor: Color(0xFFD4B69A),
      ),
      backgroundColor: Color(0xFFD4B69A), // Whiskey color for background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Quizzy App', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
      {'question': 'What is the largest organ in the human body?', 'answers': ['Heart', 'Brain', 'Skin'], 'correct': 'Skin'},
      {'question': 'What force keeps planets in orbit?', 'answers': ['Gravity', 'Magnetism', 'Friction'], 'correct': 'Gravity'},
      {'question': 'Which gas do plants absorb from the atmosphere?', 'answers': ['Oxygen', 'Carbon Dioxide', 'Nitrogen'], 'correct': 'Carbon Dioxide'},
    ],
    'History': [
      {'question': 'Who was the first President of the USA?', 'answers': ['Abraham Lincoln', 'George Washington', 'Thomas Jefferson'], 'correct': 'George Washington'},
      {'question': 'In which year did World War II end?', 'answers': ['1945', '1944', '1946'], 'correct': '1945'},
      {'question': 'Who was the first Emperor of Rome?', 'answers': ['Julius Caesar', 'Augustus', 'Nero'], 'correct': 'Augustus'},
      {'question': 'Which civilization built the pyramids?', 'answers': ['Romans', 'Greeks', 'Egyptians'], 'correct': 'Egyptians'},
    ],
    'Mathematics': [
      {'question': 'What is the value of Pi (rounded to 2 decimals)?', 'answers': ['3.14', '3.16', '3.12'], 'correct': '3.14'},
      {'question': 'What is the square root of 144?', 'answers': ['12', '14', '10'], 'correct': '12'},
      {'question': 'What is 7 x 8?', 'answers': ['54', '56', '58'], 'correct': '56'},
      {'question': 'How many sides does a hexagon have?', 'answers': ['5', '6', '7'], 'correct': '6'},
    ],
    'General Knowledge': [
      {'question': 'What is the capital of Japan?', 'answers': ['Seoul', 'Beijing', 'Tokyo'], 'correct': 'Tokyo'},
      {'question': 'Which is the largest ocean on Earth?', 'answers': ['Atlantic', 'Pacific', 'Indian'], 'correct': 'Pacific'},
      {'question': 'Who painted the Mona Lisa?', 'answers': ['Van Gogh', 'Da Vinci', 'Picasso'], 'correct': 'Da Vinci'},
      {'question': 'What is the currency of the UK?', 'answers': ['Euro', 'Dollar', 'Pound'], 'correct': 'Pound'},
    ],
  };
  int currentQuestionIndex = 0;
  int score = 0;
  void checkAnswer(String answer) {
    bool isCorrect = answer == quizData[widget.topic]![currentQuestionIndex]['correct'];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(
          isCorrect ? 'Correct! (+1 point)' : 'Wrong! (+0 points)',
          style: TextStyle(
            color: isCorrect ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isCorrect
                ? 'Great job! Keep going!'
                : 'The correct answer was: ${quizData[widget.topic]![currentQuestionIndex]['correct']}'
            ),
            SizedBox(height: 10),
            Text(
              'Current score: ${isCorrect ? score + 1 : score}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (isCorrect) score++;
              if (currentQuestionIndex < quizData[widget.topic]!.length - 1) {
                setState(() {
                  currentQuestionIndex++;
                });
              } else {
                _showResult();
              }
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
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
    // Add null check to prevent error when topic doesn't exist
    if (!quizData.containsKey(widget.topic) || quizData[widget.topic]!.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('${widget.topic} Quiz')),
        body: Center(
          child: Text('No questions available for this topic'),
        ),
      );
    }

    final questionData = quizData[widget.topic]![currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.topic} Quiz'),
        backgroundColor: Color(0xFFD4B69A),
      ),
      backgroundColor: Color(0xFFD4B69A),
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