class CreateTransactionRequestData {
  final String amount;

  CreateTransactionRequestData({
    required this.amount
});

  Map<String, dynamic> transactionToJson() => {
    "amount": amount
  };
}