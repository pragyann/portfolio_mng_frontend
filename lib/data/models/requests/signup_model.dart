class SignupModel {
  String fullName;
  String email;
  String phone;
  String password;
  SignupModel({
    required this.fullName,
    required this.password,
    required this.phone,
    required this.email,
  });

  Map<String, String> toJson() {
    return {
      'email': email,
      'password': password,
      'full_name': fullName,
      'phone': phone,
    };
  }
}
