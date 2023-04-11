class Results {
  String? question;
  String? correct_answer;
  String? total_time;
  List<dynamic> incorrect_answer;

  Results({this.question, this.correct_answer, required this.incorrect_answer,required this.total_time});

  Results.fromJson(Map<String, dynamic> mapOfJson)
      : question = mapOfJson["question"],
        correct_answer = mapOfJson["correct_answer"],
        incorrect_answer = mapOfJson["incorrect_answer"],
        total_time = mapOfJson["total_time"];
}
