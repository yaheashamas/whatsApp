import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;
  final bool invite;

  const UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
    this.invite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
      'invite': invite,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      uid: map['uid'],
      profilePic: map['profilePic'],
      isOnline: map['isOnline'],
      phoneNumber: map['phoneNumber'],
      groupId: List<String>.from(map['groupId']),
      invite: map['invite'] ?? false,
    );
  }
  
  @override
  // TODO: implement props
  List<Object> get props {
    return [
      name,
      uid,
      profilePic,
      isOnline,
      phoneNumber,
      groupId,
      invite,
    ];
  }

  UserModel copyWith({
    String? name,
    String? uid,
    String? profilePic,
    bool? isOnline,
    String? phoneNumber,
    List<String>? groupId,
    bool? invite,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      isOnline: isOnline ?? this.isOnline,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      groupId: groupId ?? this.groupId,
      invite: invite ?? this.invite,
    );
  }
}
