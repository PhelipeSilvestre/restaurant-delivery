import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String token;
  final String? phone;
  final String? photoUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.phone,
    this.photoUrl,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, photoUrl];
}
