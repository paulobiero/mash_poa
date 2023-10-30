import 'package:mash/Models/FaresModel.dart';
import 'package:mash/Models/SeatItem.dart';

class BookingPassengerModel {
  String country;

  String idNumber;

  String gendar;



  BookingPassengerModel({
    this.first_name = '',
    this.last_name = '',
    this.phone = '',
    this.ticket_price = '',
    this.age='',
    this.country='',
    this.idNumber='',
    this.gendar='',
    required this.fareModel,
    required this.seatItem


  });

  late String first_name,last_name,phone,ticket_price,age;
  late SeatItem seatItem;
  late FareModel fareModel;

  factory BookingPassengerModel.fromJson(Map<String, dynamic> responseData) {
    return BookingPassengerModel(
      first_name: responseData['first_name'],
      last_name: responseData['last_name'],
      phone: responseData['phone'],
      ticket_price: responseData['ticket_price'],
      fareModel: FareModel(),
      seatItem: SeatItem(left: '',top: '',seat_color: '',seat_height: '',seat_width: '',seat_id: '',seat_name: '',seat_type: '',seat_type_id: '',selection_status: false)


    );
  }


  @override
  String toString() {
    return 'BookingPassengerModel{country: $country, idNumber: $idNumber, gendar: $gendar, first_name: $first_name, last_name: $last_name, phone: $phone, ticket_price: $ticket_price, age: $age, seatItem: $seatItem, fareModel: $fareModel}';
  }

  Map<String,dynamic> toJson(){
    return  {
      "seat_id":seatItem.seat_id,
      "seat_name":seatItem.seat_name,
      "seat_type":seatItem.seat_type,
      "ticketPrice":fareModel.amount.toString(),
      "flatTicketPrice":fareModel.amount.toString(),
      "currency":fareModel.currencyCode.toString(),
      "flat_sale":0,
      "name":first_name+" "+last_name,
      "gender":gendar,
      "age":age,
      "mobileId":"254",
      "mobile":phone,
      "nationality":country,
      "id_no":idNumber
    }
    ;
}
}