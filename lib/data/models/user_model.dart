import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  User({
    required this.id,
    required this.name,
    required this.contact,
    required this.email,
    required this.token,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String contact;

  @HiveField(3)
  String email;

  @HiveField(4)
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        name: json["full_name"],
        contact: json["phone"] ?? "",
        email: json["email"] ?? "",
        token: json["token"] ?? '',
      );
}
