import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // String get phone => null;
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
