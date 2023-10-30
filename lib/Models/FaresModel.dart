
class FareModel {
  FareModel({
    this.seatType = '',
    this.currencyCode = '',
    this.amount = '',

  });

  late String seatType,seatForeignId,currencyId,currencyCode,amount,id;
  late int tax;
  factory FareModel.fromJson(Map<String, dynamic> responseData) {
    return FareModel(

        seatType: responseData['seatType'],

        currencyCode: responseData['currencyCode'],

      amount:responseData['amount'],

    );
  }

}