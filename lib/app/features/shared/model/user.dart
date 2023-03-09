import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User extends Equatable {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final String name;

  const User({required this.name, required this.userId});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(userId: json["id"], name: json["name"]);

  @override
  List<Object?> get props => [userId, name];
}

@HiveType(typeId: 4)
class Users {
  @HiveField(0)
  List<User> users;

  Users({required this.users});

  factory Users.fromJson(List<dynamic> data) =>
      Users(users: List<User>.from(data.map((e) => User.fromJson(e))));

  @override
  String toString() => users.toString();
}
