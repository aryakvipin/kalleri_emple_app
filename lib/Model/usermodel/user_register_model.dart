import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String role;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.createdAt,
  });

  /// Convert a Firestore document snapshot into a UserModel
  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      uid:       docId,
      name:      map['name']      ?? '',
      email:     map['email']     ?? '',
      phone:     map['phone']     ?? '',
      role:      map['role']      ?? 'users',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// Map UserModel to Firestore data
  Map<String, dynamic> toMap() {
    return {
      'uid':       uid,
      'name':      name,
      'email':     email,
      'phone':     phone,
      'role':      role,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }
}
