class UserData {
  final String name;
  final String email;

  const UserData({
    required this.name,
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json["main"]["temp"],
      email: json["weather"][0]["icon"],
    );
  }
}