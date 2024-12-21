class UserAuthenticateRequestData {
  final String email;
  final String password;

  UserAuthenticateRequestData({
    required this.email, required this.password
});

  Map<String, dynamic> userRequestToJson() => {
    "email": email,
    "password": password
  };
}