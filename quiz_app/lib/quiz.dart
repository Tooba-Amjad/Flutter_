enum QuestionType {
  multipleChoice,
  trueFalse,
}

class Quiz {
  String questionText;
  String answer; // Correct answer as a String
  List<String> options;
  QuestionType questionType; // To specify the type of the question

  Quiz({
    required this.questionText,
    required this.answer,
    required this.options,
    required this.questionType, // New parameter for question type
  });
}
