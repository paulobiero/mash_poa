class PassengerItemModel{


  String pickup='';
  String return_string='';
  String first_name='';
  String last_name='';
  String phone='';
  String total='';
  String sub_total='';
  String payable_amount='';
  String uuid='';
  String booking_reference='';
  String booking_date='';
  String currency_code='';

  PassengerItemModel({
      required this.pickup,
      required this.return_string,
      required this.first_name,
      required this.last_name,
      required this.phone,
      required this.total,
      required this.sub_total,
      required this.payable_amount,
      required this.uuid,
      required this.booking_reference,
      required this.booking_date,
      required this.currency_code});

  factory PassengerItemModel.fromJson(Map<String, dynamic> responseData) {
    return PassengerItemModel(

      pickup: responseData['pickup'],
      return_string: responseData['return'],
      first_name: responseData['first_name'],
      last_name: responseData['last_name'],
      phone:responseData.containsKey('phone')?responseData['phone']:"",
      total:responseData['total'],
      sub_total:responseData['sub_total'],
      payable_amount:responseData['payable_amount'],
      uuid:responseData.containsKey('uuid')?responseData['uuid']:"",
      booking_reference: responseData['booking_reference'],
      booking_date: responseData['booking_date'],
      currency_code: responseData['currency_code'],


    );
  }

}