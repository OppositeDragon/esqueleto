
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? phone,
    String? website,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      website: map['website'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, username: $username, email: $email, phone: $phone, website: $website)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.username == username &&
      other.email == email &&
      other.phone == phone &&
      other.website == website;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      website.hashCode;
  }
}
