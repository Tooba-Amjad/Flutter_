import 'quiz.dart';

enum QuizType {
  multipleChoice,
  trueFalse,
}

class QuizBrain {
  int _questionIndex = 0;

  // Variable to hold the quiz type
  QuizType _quizType;

  // Map of course names to their respective question banks
  final Map<String, List<Quiz>> _questionBanks = {
    'Web Development': [
      Quiz(
        questionText: 'What does HTML stand for?',
        answer: 'HyperText Markup Language',
        options: ['HyperText Markup Language', 'HyperText Markup', 'HyperText Language'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
      Quiz(
        questionText: 'Which language is used for styling web pages?',
        answer: 'CSS',
        options: ['HTML', 'CSS', 'JavaScript'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
    ],
    'React': [
      Quiz(
        questionText: 'What is React primarily used for?',
        answer: 'Building user interfaces',
        options: ['Building user interfaces', 'Server-side scripting', 'Database management'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
      Quiz(
        questionText: 'What is JSX?',
        answer: 'A syntax extension for JavaScript',
        options: ['A CSS framework', 'A syntax extension for JavaScript', 'A JavaScript library'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
    ],
    'Mobile App Development': [
      Quiz(
        questionText: 'Which framework is used for building mobile applications with Dart?',
        answer: 'Flutter',
        options: ['Flutter', 'React Native', 'Ionic'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
      Quiz(
        questionText: 'What is the main programming language used for Android development?',
        answer: 'Java',
        options: ['Java', 'Kotlin', 'Dart'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
    ],
    'Machine Learning': [
      Quiz(
        questionText: 'What is the primary programming language used in Machine Learning?',
        answer: 'Python',
        options: ['Python', 'Java', 'C++'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
      Quiz(
        questionText: 'What is a common library used for Machine Learning in Python?',
        answer: 'Scikit-learn',
        options: ['NumPy', 'Scikit-learn', 'Pandas'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
    ],
    'AI': [
      Quiz(
        questionText: 'What does AI stand for?',
        answer: 'Artificial Intelligence',
        options: ['Artificial Intelligence', 'Automated Integration', 'Artificial Interference'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
      Quiz(
        questionText: 'Which of the following is a subfield of AI?',
        answer: 'Machine Learning',
        options: ['Machine Learning', 'Web Development', 'Data Analysis'],
        questionType: QuestionType.multipleChoice, // Specify the question type
      ),
    ],
  };

  String courseName;

  // Constructor to initialize the course name and quiz type
  QuizBrain(this.courseName, this._quizType) {
    _questionIndex = 0; // Reset index for each new course
  }

  List<Quiz> get _currentQuestionBank {
    return _questionBanks[courseName] ?? [];
  }

  String getQuestion() {
    return _currentQuestionBank[_questionIndex].questionText;
  }

  dynamic getAnswer() {
    return _currentQuestionBank[_questionIndex].answer;
  }

  List<String>? getOptions() {
    return _currentQuestionBank[_questionIndex].options;
  }

  bool isMultipleChoice() {
    return _quizType == QuizType.multipleChoice &&
        _currentQuestionBank[_questionIndex].questionType == QuestionType.multipleChoice; // Check question type
  }

  bool isTrueFalse() {
    return _quizType == QuizType.trueFalse &&
        _currentQuestionBank[_questionIndex].questionType == QuestionType.trueFalse; // Check question type
  }

  void nextQuestion() {
    if (_questionIndex < _currentQuestionBank.length - 1) {
      _questionIndex++;
    }
  }

  bool isQuizFinished() {
    return _questionIndex >= _currentQuestionBank.length - 1;
  }

  void reset() {
    _questionIndex = 0;
  }

  int getQuestionCount() {
    return _currentQuestionBank.length;
  }

  int getCurrentQuestionNumber() {
    return _questionIndex + 1;
  }

  double getQuizProgress() {
    return (_questionIndex + 1) / _currentQuestionBank.length;
  }
}
