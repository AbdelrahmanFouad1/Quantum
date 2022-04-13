class LoginModel {
  final int uId;
  final String email;
  final String name;
  final String token;


  LoginModel({
    required this.uId,
    required this.email,
    required this.name,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      uId:  json['id'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
