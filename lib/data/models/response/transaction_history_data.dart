class TransactionHistoryData {
  final dynamic temp;
  final dynamic icon;

  TransactionHistoryData( {
    this.temp,
    this.icon,
  });

  factory TransactionHistoryData.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryData(
      temp: json["main"]["temp"],
      icon: json["weather"][0]["icon"],
    );
  }
}