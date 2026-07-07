import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  final String firstName;
  final String lastName;
  final String age;

  Profile copyWith({String? firstName, String? lastName, String? age}) {
    return Profile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, age];
}
