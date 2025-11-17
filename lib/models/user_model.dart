class UserModel {
  final String message;
  final int customerId;

  UserModel({required this.message,required this.customerId});

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      message: json['message'],
      customerId: json['userId'],
    );
  }
}

