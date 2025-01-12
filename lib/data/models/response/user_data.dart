class UserData {
  final String name;
  final String email;
  final num amount;

  const UserData({
    required this.name,
    required this.email,
    required this.amount
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json["name"],
      email: json["email"],
      amount: json["amount"],
    );
  }
}