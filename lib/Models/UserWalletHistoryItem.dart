class UserWalletHistoryItem {
  UserWalletHistoryItem({
    this.date = '',
    this.amount = '',
    this.amountStatus = '',
    this.comments = '',
    this.time = '',
    this.currencyId = '1',

  });

  late String date,amount,amountStatus,comments,time,currencyId;

  factory UserWalletHistoryItem.fromJson(Map<String, dynamic> responseData) {
    return UserWalletHistoryItem(

      date: responseData['name'],
      amount: responseData['amount'],
      currencyId: responseData['currencyId'],
      amountStatus: responseData['amountStatus'],
      comments:responseData['comments'],
      time:responseData['time'],

    );
  }
}