import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({required this.height, required this.weight});

  final int height;
  final int weight;
  double? _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi!.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi == null) {
      return 'No BMI calculated';
    }

    if (_bmi! >= 25) {
      return 'Overweight';
    } else if (_bmi! >= 18.5) {
      return 'Normal weight';
    } else {
      return 'Underweight';
    }
  }
  String getInterperataion(){
    if (_bmi == null) {
      return 'No BMI calculated';
    }

    if (_bmi! >= 25) {
      return 'You have a higher than normal Body Weight.Try to Exercise more';
    } else if (_bmi! >= 18.5) {
      return 'You have Normal Body Weight.Good Job';
    }

    else {
      return 'You have a lower than normal Body Weight.Eat More';
    }
  }

}
