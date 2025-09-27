
import 'package:get/get.dart';

class ReviewModel{



  ReviewModel({
    required this.name,
    required this.rating,
    required this.review,
  });

  final String name;
  final int rating;
  String review;
  DateTime date = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Rating': rating,
      'Review': review,
      'Date': date.toIso8601String(),

    };
  }

}