import 'dart:convert';

import 'package:mash/AuthenticationPages/AuthLandingPage.dart';
import 'package:mash/Models/FaresModel.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Models/SeatItem.dart';
import 'package:mash/Models/TicketModel.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../AuthenticationPages/Login/Login.dart';
import '../Models/TripListModel.dart';
import '../Models/userInfo.dart';
import '../Utils/Constants.dart';

class GetListData {
  BuildContext context;

  GetListData(this.context);

  Future<List<LocationItemModel>> getAllCities(
      int cityId, String cityType) async {
    Response response;
    var dio = Dio();

    List<LocationItemModel> returnData = [];
    bool isSignedIn = await AuthenticationServices().IsSignedIn();
    late String token;
    if (isSignedIn) {
      UserInfo userInfo = await AuthenticationServices().getUser();
      token = userInfo.api_access_token;
    } else {
      token = AppUrl.defaultToken;
    }

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = token;
    dio.options.headers["AppType"] = 'townservice';
    var parameters = {
      "city_id": cityId,
      "city_type": cityType,
      "token": AppUrl.companyToken
    };
    print("token is ${token}");
    try {
      response = await dio.post(AppUrl.getAllCities, data: parameters);
      print(response.data.toString());
      if (response.statusCode == 200) {
        Iterable keys = response.data['data'];

        returnData = keys
            .map((e) => LocationItemModel(name: e['city_name'], id: e['id']))
            .toList();
      } else if (response.statusCode == 401) {
        AuthenticationServices().removeUser().then((value) => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AuthLandingPage(
                    title: 'Auth',
                  ),
                ),
              )
            });
      }
    } catch (ex) {
      print(ex);
      AuthenticationServices().removeUser().then((value) => {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
              const AuthLandingPage(title: ''),
            ),(route) => false
        )
          });
    }

    return returnData;
  }

  Future<List<SeatItem>> getTripSeats(
      String listModel, String from, String to, String date) async {
    List<SeatItem> returnData = [];

    final Map<String, dynamic> loginData = {
      "source_city_id": from,
      "destination_city_id": to,
      "travel_date": date,
      "bus_id": listModel,
      "delayedFlag": 0,
      "delayedDate": 1663102800,
      "token": AppUrl.companyToken
    };
    print("The payload is $loginData");
    Response response;
    var dio = Dio();
    UserInfo userInfo = await AuthenticationServices().getUser();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = userInfo.api_access_token;
    dio.options.headers["source"] = 'web';
    response = await dio.post(AppUrl.getTripSeatsPrice, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['isSuccess']) {
        Iterable keys = response.data['data'];

        returnData = keys.map((e) => SeatItem.fromJson(e)).toList();
      }
    } else if (response.statusCode == 401) {
      AuthenticationServices().removeUser().then((value) => {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
              const AuthLandingPage(title: ''),
            ),(route) => false
        )
          });
    }

    return returnData;
  }

  Future<List<FareModel>> getSamplePrices() async {
    List<FareModel> returnData = [];

    final body = json.decode(AppUrl.samplePrices);

    Iterable keys = body['data'][0]['defaultTripPriceList'];

    returnData = keys.map((e) => FareModel.fromJson(e)).toList();

    return returnData;
  }

  Future<List<TripListModel>> getTripList(
      String sourceId, String destinationId, String travelDate) async {
    Response response;
    var dio = Dio();

    List<TripListModel> returnData = [];
    UserInfo userInfo = await AuthenticationServices().getUser();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = userInfo.api_access_token;
    dio.options.headers["source"] = 'web';

    final Map<String, dynamic> loginData = {
      "source_city_id": sourceId,
      "destination_city_id": destinationId,
      "travel_date": travelDate,
      "avg_rating": null,
      "departure_time": null,
      "fare": null,
      "seat_type": "",
      "travels": "",
      "boarding_points": [],
      "dropping_points": [],
      "bus_with_amenities": [],
      "high_rating": true,
      "bus_with_live_tracking": false,
      "cabs": false,
      "hot_deals": false,
      "on_time": false,
      "bus_type": [],
      "time_range": [],
      "record_type": "data",
      "currencyId": "1",
      "token": AppUrl.companyToken
    };
    print("the payload is $loginData");

    response = await dio.post(AppUrl.getTripList, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['isSuccess']) {
        Iterable keys = response.data['data'];

        returnData = keys.map((e) => TripListModel.fromJson(e)).toList();
      }
    } else if (response.statusCode == 401) {
      AuthenticationServices().removeUser().then((value) => {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
              const AuthLandingPage(title: ''),
            ),(route) => false
        )
          });
    }

    return returnData;
  }

  Future<void> getBoardingDroppingPoints(
      String from,
      String to,
      String date,
      String trip,
      Function(List<LocationItemModel>, List<LocationItemModel>)
          onLocationsFetched) async {
    List<LocationItemModel> returnData = [];
    List<LocationItemModel> returnData2 = [];
    final Map<String, dynamic> loginData = {
      "source": from,
      "destination": to,
      "trip": trip,
      "booking_date": trip,
      "delayedFlag": 0,
      "delayedDate": 1663102800,
      "token": AppUrl.companyToken
    };
    print("The payload is $loginData");
    Response response;
    var dio = Dio();
    UserInfo userInfo = await AuthenticationServices().getUser();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = userInfo.api_access_token;
    dio.options.headers["source"] = 'web';
    response =
        await dio.post(AppUrl.getBoardingDroppingPoints, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['isSuccess']) {
        Iterable keys = response.data['boarding'];
        Iterable keys2 = response.data['dropping'];
        returnData = keys.map((e) => LocationItemModel.fromJson(e)).toList();
        returnData2 = keys2.map((e) => LocationItemModel.fromJson(e)).toList();
        onLocationsFetched(returnData, returnData2);
      }
    } else if (response.statusCode == 401) {
      AuthenticationServices().removeUser().then((value) => {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
              const AuthLandingPage(title: ''),
            ),(route) => false
        )
          });
    }
  }

  Future<List<String>> getPaymentMethods() async {
    Response response;
    var dio = Dio();

    List<String> returnData = [];
    bool isSignedIn = await AuthenticationServices().IsSignedIn();
    late String token;
    if (isSignedIn) {
      UserInfo userInfo = await AuthenticationServices().getUser();
      token = userInfo.api_access_token;
    } else {
      token = AppUrl.defaultToken;
    }

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = token;
    dio.options.headers["AppType"] = 'townservice';
    var parameters = {"token": AppUrl.companyToken};
    print("token is ${token}");
    try {
      response = await dio.post(AppUrl.getPaymentMethods, data: parameters);
      print(response.data.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> keys = response.data;
        Iterable methods = keys.keys;
        methods.forEach((element) {
          if (keys[element] == true) {
            returnData.add(element);
          }
        });
      } else if (response.statusCode == 401) {
        AuthenticationServices().removeUser().then((value) => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AuthLandingPage(
                    title: 'Auth',
                  ),
                ),
              )
            });
      }
    } catch (ex) {
      print(ex);
      AuthenticationServices().removeUser().then((value) => {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
              const AuthLandingPage(title: ''),
            ),(route) => false
        )
          });
    }

    return returnData;
  }
  Future<List<TicketModel>> getRecentTickets(String status) async {
    Response response;
    var dio = Dio();

    List<TicketModel> returnData = [];

      UserInfo userInfo = await AuthenticationServices().getUser();

      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = userInfo.api_access_token;
      dio.options.headers["source"] = 'web';

      final Map<String, dynamic> loginData =
      {
        "tripType": status,
        "sourcetype": "App",
        "token": AppUrl.companyToken
      };
      print("the payload is $loginData");

      try {
        response = await dio.post(AppUrl.bookingHistory, data: loginData);
        print(response.statusCode);
        print(response.data);
        if (response.statusCode == 200) {
          if (response.data['isSuccess']) {
            Iterable keys = response.data['data'];

            returnData = keys.map((e) => TicketModel.fromJson(e)).toList();
          }
        } else if (response.statusCode == 401) {
          AuthenticationServices().removeUser().then((value) =>
          {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                  const AuthLandingPage(title: ''),
                ),(route) => false
            )
          });
        }
      }
      catch (ex) {
        print(ex);
        AuthenticationServices().removeUser().then((value) =>
        {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                const AuthLandingPage(title: ''),
              ),(route) => false
          )
        });
      }

    return returnData;
  }
}
