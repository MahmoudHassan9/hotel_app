class UserDM {
  static const String collectionName = 'users';

  String? email;
  String? uid;
  String? name;
  String? phoneNumber;
  bool? isAdmin;

  UserDM({
    required this.email,
    required this.uid,
    required this.name,
    required this.phoneNumber,
    this.isAdmin = false,
  });

  UserDM.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
    };
  }
}
