import 'dart:convert';
import 'package:mash/Models/BookingPassengerModel.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Models/TripListModel.dart';
import 'package:mash/Models/UserWalletHistoryItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Models/companyDetail.dart';
import '../Models/userInfo.dart';
import '../Utils/Constants.dart';
import 'package:dio/dio.dart' as dioo;
import 'AuthenticationServices.dart';

class PaymentApiServices {
  BuildContext context;

  PaymentApiServices(this.context);

  Future<Map<String, dynamic>> ticketBooking(
      List<BookingPassengerModel> passengerModel,
      TripListModel tripListModel,
      LocationItemModel from,
      LocationItemModel to,
      LocationItemModel pickup,
      LocationItemModel dropOff,
      String date,
      String email, bool selected, int paymentRequired) async {
    var result = {"status": false, "message": ""};

    int total = 0;
    passengerModel.forEach((element) {
      total += double.parse(element.fareModel.amount).toInt();
    });
    final loginData2 = {
      "ticketDetail": {
        "onwardticket": {
          "booking_date": date,
          "pickup_id": from.id,
          "return_id": to.id,
          "source_city": from.name,
          "dest_city": to.name,
          "bus_title": tripListModel.route_name,
          "currency": tripListModel.fares[0].currencyCode,
          "departure_time": tripListModel.departure_time,
          "boardingPointId": pickup.id,
          "droppingPointId": dropOff.id,
          "boardingPointname": pickup.name,
          "droppingPointname": dropOff.name,
          "bus_id": tripListModel.bus_id,
          "currencyId": 1,
          "ticket_cnt": passengerModel.length,
          "bs_number_of_seats": tripListModel.available_seat_count,
          "available_Seats": tripListModel.available_seat_count,
          "sub_total": total,
          "tax": "0.00",
          "total": total,
          "is_luggage": false,
          "c_address": "",
          "c_city": "",
          "c_state": "",
          "c_zip": "",
          "c_country": "",
          "isWalletApply": selected,
          "isPayThroughWallet": selected,
          "paymentMethod": "mpesa",
          "passenger": passengerModel.map((e) => e.toJson()).toList(),
          "route_id": tripListModel.route_id,
          "isPromotional": false,
          "promotionalTripMsg": "",
          "seatSelectionLimit": "0",
          "c_email": email,
          "selectedSeat":
              passengerModel.map((e) => e.seatItem.seat_id).toList(),
          "bookedThrough": "app",
          "token": AppUrl.companyToken
        },
        "returnticket": {},
        "bookedThrough": "web"
      },
      "token": AppUrl.companyToken
    };

    AuthenticationServices().saveEmailAndId(passengerModel[0].idNumber, email);

    final Map<String, dynamic> loginData = {
      "booking_date": date,
      "pickup_id": from.id,
      "return_id": to.id,
      "source_city": from.name,
      "dest_city": to.name,
      "bus_title": tripListModel.route_name,
      "currency": tripListModel.fares[0].currencyCode,
      "departure_time": tripListModel.departure_time,
      "boardingPointId": pickup.id,
      "droppingPointId": dropOff.id,
      "boardingPointname": pickup.name,
      "droppingPointname": dropOff.name,
      "bus_id": tripListModel.bus_id,
      "currencyId": 1,
      "ticket_cnt": passengerModel.length,
      "bs_number_of_seats": tripListModel.available_seat_count,
      "available_Seats": tripListModel.available_seat_count,
      "sub_total": total,
      "tax": "0.00",
      "total": total,
      "is_luggage": false,
      "c_address": "",
      "c_city": "",
      "c_state": "",
      "c_zip": "",
      "c_country": "",
      "isWalletApply": false,
      "isPayThroughWallet": false,
      "paymentMethod": "mpesa",
      "passenger": passengerModel.map((e) => e.toJson()).toList(),
      "route_id": tripListModel.route_id,
      "isPromotional": false,
      "promotionalTripMsg": "",
      "seatSelectionLimit": "0",
      "c_email": email,
      "selectedSeat": passengerModel.map((e) => e.seatItem.seat_id).toList(),
      "bookedThrough": "app",
      "token": AppUrl.companyToken
    };
    bool isSignedIn = await AuthenticationServices().IsSignedIn();
    late String token;
    if (isSignedIn) {
      UserInfo userInfo = await AuthenticationServices().getUser();
      token = userInfo.api_access_token;
    } else {
      token = AppUrl.defaultToken;
    }
    print("started processing with payload ${loginData2}");
    Response response = await post(
      AppUrl.ticketBooking,
      body: json.encode(loginData2),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );
    print(response.body.toString());

    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData['isSuccess']) {
          result = {
            'status': true,
            'message': responseData['message'],
            "booking_reference": responseData['booking_reference'],
            "phone": '254${passengerModel[0].phone}',
            "total": total
          };
        } else {
          result = {
            'status': false,
            'message': 'Some of the selected seats have already been booked'
          };
        }
      } else {
        result = {
          'status': false,
          'message': 'Some of the selected seats have already been booked'
        };
      }
    } on Exception {
      result = {'status': false, 'message': "Login error"};
    }
    return result;
  }

  Future<Map<String, dynamic>> ticketBookingRound(
      List<BookingPassengerModel> passengerModel,
      List<BookingPassengerModel> passengerModelReturn,
      TripListModel tripListModel,
      TripListModel tripListModelReturn,
      LocationItemModel from,
      LocationItemModel to,
      LocationItemModel pickup,
      LocationItemModel dropOff,
      LocationItemModel pickupReturn,
      LocationItemModel dropOffReturn,
      String date,
      String dateReturn,
      String email, bool selected) async {
    var result = {"status": false, "message": "errro"};

    int total = 0, totalReturn = 0;
    passengerModel.forEach((element) {
      total += double.parse(element.fareModel.amount).toInt();
    });

    passengerModelReturn.forEach((element) {
      total += double.parse(element.fareModel.amount).toInt();
    });
    final loginData2 = {
      "ticketDetail": {
        "onwardticket": {
          "booking_date": date,
          "pickup_id": from.id,
          "return_id": to.id,
          "source_city": from.name,
          "dest_city": to.name,
          "bus_title": tripListModel.route_name,
          "currency": tripListModel.fares[0].currencyCode,
          "departure_time": tripListModel.departure_time,
          "boardingPointId": pickup.id,
          "droppingPointId": dropOff.id,
          "boardingPointname": pickup.name,
          "droppingPointname": dropOff.name,
          "bus_id": tripListModel.bus_id,
          "currencyId": 1,
          "ticket_cnt": passengerModel.length,
          "bs_number_of_seats": tripListModel.available_seat_count,
          "available_Seats": tripListModel.available_seat_count,
          "sub_total": total,
          "tax": "0.00",
          "total": total,
          "is_luggage": false,
          "c_address": "",
          "c_city": "",
          "c_state": "",
          "c_zip": "",
          "c_country": "",
          "isWalletApply": selected,
          "isPayThroughWallet": selected,
          "paymentMethod": "mpesa",
          "passenger": passengerModel.map((e) => e.toJson()).toList(),
          "route_id": tripListModel.route_id,
          "isPromotional": false,
          "promotionalTripMsg": "",
          "seatSelectionLimit": "0",
          "c_email": email,
          "selectedSeat":
              passengerModel.map((e) => e.seatItem.seat_id).toList(),
          "bookedThrough": "app",
          "token": AppUrl.companyToken
        },
        "returnticket": {
          "booking_date": dateReturn,
          "pickup_id": to.id,
          "return_id": from.id,
          "source_city": to.name,
          "dest_city": from.name,
          "bus_title": tripListModelReturn.route_name,
          "currency": tripListModelReturn.fares[0].currencyCode,
          "departure_time": tripListModelReturn.departure_time,
          "boardingPointId": pickupReturn.id,
          "droppingPointId": dropOffReturn.id,
          "boardingPointname": pickupReturn.name,
          "droppingPointname": dropOffReturn.name,
          "bus_id": tripListModelReturn.bus_id,
          "currencyId": 1,
          "ticket_cnt": passengerModelReturn.length,
          "bs_number_of_seats": tripListModelReturn.available_seat_count,
          "available_Seats": tripListModelReturn.available_seat_count,
          "sub_total": totalReturn,
          "tax": "0.00",
          "total": totalReturn,
          "is_luggage": false,
          "c_address": "",
          "c_city": "",
          "c_state": "",
          "c_zip": "",
          "c_country": "",
          "isWalletApply": false,
          "isPayThroughWallet": false,
          "paymentMethod": "mpesa",
          "passenger": passengerModelReturn.map((e) => e.toJson()).toList(),
          "route_id": tripListModelReturn.route_id,
          "isPromotional": false,
          "promotionalTripMsg": "",
          "seatSelectionLimit": "0",
          "c_email": email,
          "selectedSeat":
              passengerModelReturn.map((e) => e.seatItem.seat_id).toList(),
          "bookedThrough": "app",
          "token": AppUrl.companyToken
        },
        "bookedThrough": "web"
      },
      "token": AppUrl.companyToken
    };

    AuthenticationServices().saveEmailAndId(passengerModel[0].idNumber, email);
    final Map<String, dynamic> loginData = {
      "booking_date": date,
      "pickup_id": from.id,
      "return_id": to.id,
      "source_city": from.name,
      "dest_city": to.name,
      "bus_title": tripListModel.route_name,
      "currency": tripListModel.fares[0].currencyCode,
      "departure_time": tripListModel.departure_time,
      "boardingPointId": pickup.id,
      "droppingPointId": dropOff.id,
      "boardingPointname": pickup.name,
      "droppingPointname": dropOff.name,
      "bus_id": tripListModel.bus_id,
      "currencyId": 1,
      "ticket_cnt": passengerModel.length,
      "bs_number_of_seats": tripListModel.available_seat_count,
      "available_Seats": tripListModel.available_seat_count,
      "sub_total": total,
      "tax": "0.00",
      "total": total,
      "is_luggage": false,
      "c_address": "",
      "c_city": "",
      "c_state": "",
      "c_zip": "",
      "c_country": "",
      "isWalletApply": false,
      "isPayThroughWallet": false,
      "paymentMethod": "mpesa",
      "passenger": passengerModel.map((e) => e.toJson()).toList(),
      "route_id": tripListModel.route_id,
      "isPromotional": false,
      "promotionalTripMsg": "",
      "seatSelectionLimit": "0",
      "c_email": email,
      "selectedSeat": passengerModel.map((e) => e.seatItem.seat_id).toList(),
      "bookedThrough": "app",
      "token": AppUrl.companyToken
    };
    bool isSignedIn = await AuthenticationServices().IsSignedIn();
    late String token;
    if (isSignedIn) {
      UserInfo userInfo = await AuthenticationServices().getUser();
      token = userInfo.api_access_token;
    } else {
      token = AppUrl.defaultToken;
    }
    print("started processing with payload ${loginData2}");
    Response response = await post(
      AppUrl.ticketBooking,
      body: json.encode(loginData2),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );
    print(response.body.toString());

    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData.containsKey('isSuccess')) {
          result = {
            'status': true,
            'message': responseData['message'],
            "booking_reference": responseData['booking_reference'],
            "phone": '254${passengerModel[0].phone}',
            "total": total
          };
        } else {
          result = {
            'status': false,
            'message': 'Some of the selected seats have already been booked'
          };
        }
      } else {
        result = {
          'status': false,
          'message': 'Some of the selected seats have already been booked'
        };
      }
    } on Exception {
      result = {'status': false, 'message': "Login error"};
    }
    return result;
  }

  Future<void> initiatePayment(
      String bookingRef, int amount, String phone, bool selected) async {
    var finalData = {
      "bookingRef": bookingRef,
      "queryoption": amount,
      "queryvalue": phone,
      "requestType": "ticket",
      "isWalletApply": selected,
      "additionalInfo": {
        "onward": {"sponsorTrip": false, "discountId": 0},
        "return": {"sponsorTrip": false, "discountId": 0}
      },
      "token": AppUrl.companyToken
    };
    print("the data is ${finalData}");
    bool isSignedIn = await AuthenticationServices().IsSignedIn();
    late String token;
    if (isSignedIn) {
      UserInfo userInfo = await AuthenticationServices().getUser();
      token = userInfo.api_access_token;
    } else {
      token = AppUrl.defaultToken;
    }
    Response response = await post(
      AppUrl.initiatePayment,
      body: json.encode(finalData),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );
    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        print("the data is ${response.body}");
      } else {}
    } on Exception {}
  }

  Future<List<dynamic>> getWalletData() async {
    dioo.Response response;
    var dio = dioo.Dio();

    List<dynamic> returnData = [];
    UserInfo userInfo = await AuthenticationServices().getUser();
    final Map<String, dynamic> loginData = {
      "userId": userInfo.id,
      "currencyId": "1",
      "token": AppUrl.companyToken
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = userInfo.api_access_token;
    dio.options.headers["source"] = 'web';

    try {
      response = await dio.post(AppUrl.getWalletData, data: loginData);
      print(response.statusCode);
      print(loginData);
      print(response.data);
      if (response.statusCode == 200) {
        //  Iterable keys= response.data['data'];
        if(response.data['isSuccess'])
          {
            returnData = response.data['data'];
          }
        else{
            returnData=[{'amount':'0.00'}];
        }
        // returnData=keys.map((e) => LocationItemModel(name: e['city_name'],id: e['id'])).toList();


      } else if (response.statusCode == 401) {
        // AuthenticationServices().removeUser().then((value) => {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute<void>(
        //       builder: (BuildContext context) => LoginPage(title: '',),
        //
        //     ),
        //
        //   )
        // });
      }
    } catch (ex) {
      print(ex.toString());
      // AuthenticationServices().removeUser().then((value) => {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute<void>(
      //       builder: (BuildContext context) => LoginPage(title: '',),
      //
      //     ),
      //
      //   )
      // });
    }
    return returnData;
  }

  Future<List<UserWalletHistoryItem>> getWalletHistory() async {
    dioo.Response response;
    var dio = dioo.Dio();

    List<UserWalletHistoryItem> returnData = [];
    UserInfo userInfo = await AuthenticationServices().getUser();
    final Map<String, dynamic> loginData = {
      "userId": userInfo.id,
      "currencyId": 1,
      "sourcetype": "web",
      "perPage": 100,
      "page": 1,
      "token": AppUrl.companyToken
    };
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = userInfo.api_access_token;
    dio.options.headers["source"] = 'web';

    try {
      response = await dio.post(AppUrl.getWalletHistory, data: loginData);
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['isSuccess']) {
          Iterable keys = response.data['data'];
          for(Map<String,dynamic>data in keys)
            {
              for(Map<String,dynamic>item in data['data'])
                {

                  item['name']=data['name'];
                  returnData.add(UserWalletHistoryItem.fromJson(item));
                }

            }


        }
        else{
          returnData=[];
        }
      } else if (response.statusCode == 401) {
        // AuthenticationServices().removeUser().then((value) => {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute<void>(
        //       builder: (BuildContext context) => LoginPage(title: '',),
        //
        //     ),
        //
        //   )
        // });
      }
    } catch (ex) {
      print(ex.toString());
      // AuthenticationServices().removeUser().then((value) => {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute<void>(
      //       builder: (BuildContext context) => LoginPage(title: '',),
      //
      //     ),
      //
      //   )
      // });
    }
    return returnData;
  }

  Future<Map<String, dynamic>> addAmount(String amount) async {
    dioo.Response response;
    var dio = dioo.Dio();

    Map<String, dynamic> returnData = {
      "isSuccess": false,
      "msg": "Payment notification sending failed. Please check phone number"
    };
    UserInfo userInfo = await AuthenticationServices().getUser();
    final Map<String, dynamic> loginData = {
      "amount": amount,
      "currencyId": 1,
      "sourcetype": "web",
      "token": AppUrl.companyToken
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = userInfo.api_access_token;
    dio.options.headers["source"] = 'web';
    print("the payload is $loginData");

    try {
      response = await dio.post(AppUrl.addAmount, data: loginData);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        //  Iterable keys= response.data['data'];

        // returnData=keys.map((e) => LocationItemModel(name: e['city_name'],id: e['id'])).toList();

        returnData = response.data;
      } else if (response.statusCode == 401) {
        // AuthenticationServices().removeUser().then((value) => {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute<void>(
        //       builder: (BuildContext context) => LoginPage(title: '',),
        //
        //     ),
        //
        //   )
        // });
      }
    } catch (ex) {
      print(ex.toString());
      // AuthenticationServices().removeUser().then((value) => {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute<void>(
      //       builder: (BuildContext context) => LoginPage(title: '',),
      //
      //     ),
      //
      //   )
      // });
    }
    return returnData;
  }

  Future<Map<String, dynamic>> RedeemVoucher(String amount) async {
    dioo.Response response;
    var dio = dioo.Dio();

    Map<String, dynamic> returnData = {
      "isSuccess": false,
      "message": {"message": "Not a valid voucher"}
    };
    UserInfo userInfo = await AuthenticationServices().getUser();
    final Map<String, dynamic> loginData = {
      "voucherCode": amount,
      "sourcetype": "web",
      "token": AppUrl.companyToken
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = userInfo.api_access_token;
    dio.options.headers["source"] = 'web';
    print("the payload is $loginData");

    try {
      response = await dio.post(AppUrl.redeemVoucher, data: loginData);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        //  Iterable keys= response.data['data'];

        // returnData=keys.map((e) => LocationItemModel(name: e['city_name'],id: e['id'])).toList();

        returnData = response.data;
      } else if (response.statusCode == 401) {
        // AuthenticationServices().removeUser().then((value) => {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute<void>(
        //       builder: (BuildContext context) => LoginPage(title: '',),
        //
        //     ),
        //
        //   )
        // });
      }
    } catch (ex) {
      print(ex.toString());
      // AuthenticationServices().removeUser().then((value) => {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute<void>(
      //       builder: (BuildContext context) => LoginPage(title: '',),
      //
      //     ),
      //
      //   )
      // });
    }
    return returnData;
  }

  Future<Map<String, dynamic>> CheckAddAmountRequest(String amount) async {
    dioo.Response response;
    var dio = dioo.Dio();

    Map<String, dynamic> returnData = {
      "isSuccess": false,
      "msg": "No transaction found. Please try sending new payment request",
      "paymentData": []
    };
    UserInfo userInfo = await AuthenticationServices().getUser();
    final Map<String, dynamic> loginData = {
      "ref_number": amount,
      "token": AppUrl.companyToken
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = userInfo.api_access_token;
    dio.options.headers["source"] = 'web';
    print("the payload is $loginData");

    try {
      response = await dio.post(AppUrl.checkAddAmountRequest, data: loginData);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        //  Iterable keys= response.data['data'];

        // returnData=keys.map((e) => LocationItemModel(name: e['city_name'],id: e['id'])).toList();

        returnData = response.data;
      } else if (response.statusCode == 401) {
        // AuthenticationServices().removeUser().then((value) => {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute<void>(
        //       builder: (BuildContext context) => LoginPage(title: '',),
        //
        //     ),
        //
        //   )
        // });
      }
    } catch (ex) {
      print(ex.toString());
      // AuthenticationServices().removeUser().then((value) => {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute<void>(
      //       builder: (BuildContext context) => LoginPage(title: '',),
      //
      //     ),
      //
      //   )
      // });
    }
    return returnData;
  }
  Future<void> ReInitiatePayment(
      String bookingRef, int amount, String phone, bool selected) async {
    var finalData = {
      "bookingRef": bookingRef,
      "queryoption": amount,
      "queryvalue": phone,
      "requestType": "ticket",
      "token": AppUrl.companyToken
    };
    print("the data is ${finalData}");
    bool isSignedIn = await AuthenticationServices().IsSignedIn();
    late String token;
    if (isSignedIn) {
      UserInfo userInfo = await AuthenticationServices().getUser();
      token = userInfo.api_access_token;
    } else {
      token = AppUrl.defaultToken;
    }
    Response response = await post(
      AppUrl.reInitiatePayment,
      body: json.encode(finalData),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );
    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        print("the data is ${response.body}");
      } else {}
    } on Exception {}
  }
}
