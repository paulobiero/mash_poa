import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Models/companyDetail.dart';
import '../Models/userInfo.dart';
import '../Utils/Constants.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart' as dioo;

class AuthenticationServices {
  ///Save the user Object @UserInfo
  Future<bool> saveUser(UserInfo user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.id);
    prefs.setString("name", user.name);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phone);
    prefs.setString("api_token", user.api_access_token);
    prefs.setString("country_code", user.country_code);
    prefs.setString("last_name", user.last_name);
    prefs.setString("gender", user.gender);
    prefs.setString("currencyId", user.currencyId);

    prefs.setString("age", user.age);

    return prefs.commit();
  }

  Future<Map<String, dynamic>> resendOTP(String phonme) async {
    dioo.Response response;
    var returnValue = {
      "status": false,
      "verificationKey": "",
      "message": "An error occurred during operation"
    };
    var dio = dioo.Dio();
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }
    final Map<String, dynamic> loginData = {

      "device_number": deviceID,
      "gcm_token": "",
      "phone": phonme,

      "token": AppUrl.companyToken
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = AppUrl.defaultToken;
    dio.options.headers["source"] = 'web';
    print("the number is $loginData");

    response = await dio.post(AppUrl.resendOTP, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      // final jsonData = json.decode(response.data.toString());
      if (response.data['isSuccess']) {
        returnValue = {"status": true, "message": "OTP sent to 254$phonme"};
      }

      //return list.where((element) => Fund.fromJson(element).isActive == true).toList();

    } else if (response.statusCode == 401) {}
    return returnValue;
  }

  Future<bool> saveUser2(UserInfo user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("name", user.name);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phone);
    prefs.setString("api_token", user.api_access_token);
    prefs.setString("last_name", user.last_name);
    prefs.setString("gender", user.gender);

    return prefs.commit();
  }

  ///Logout the user
  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("userId");
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("country_code");
    prefs.remove("last_name");
    prefs.remove("api_token");
    prefs.remove("gender");
    prefs.remove("currencyId");
    prefs.remove("age");

    return prefs.commit();
  }

  ///Get the user Object @UserInfo
  Future<UserInfo> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("userId");
    String? name = prefs.getString("name");
    String? email = prefs.getString("email");
    String? phone = prefs.getString("phone");
    String? country_code = prefs.getString("country_code");
    String? last_name = prefs.getString("last_name");
    String? apiAccessToken = prefs.getString("api_token");

    String? gender = prefs.getString("gender");
    String? currencyId = prefs.getString("currencyId");
    String? age = prefs.getString("age");
    String? idNumber =
    prefs.containsKey("id_number") ? prefs.getString("id_number") : "";

    return UserInfo(
        id: id!,
        age: age!,
        name: name!,
        email: email!,
        phone: phone!,
        country_code: country_code!,
        last_name: last_name!,
        api_access_token: apiAccessToken!,
        gender: gender!,
        currencyId: currencyId!,
        id_number: idNumber!);
  }

  Future<void> saveEmailAndId(String id, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("id_number", id);
    prefs.commit();
  }

  ///Save the Company Details Object @companyDetail
  Future<bool> saveCompanyDetails(companyDetail user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("companyId", user.companyId);
    prefs.setString("isShuttle", user.isShuttle);
    prefs.setString("currencyId", user.currencyId);
    prefs.setString("company_name", user.company_name);
    prefs.setString("company_email", user.company_email);
    prefs.setString("company_phone", user.company_phone);
    prefs.setString("company_branch", user.company_branch);

    return prefs.commit();
  }

  ///Get the Company Details Object @companyDetail
  Future<companyDetail> getCompanyDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("companyId");
    String? isShuttle = prefs.getString("isShuttle");
    String? currencyId = prefs.getString("currencyId");
    String? companyName = prefs.getString("company_name");
    String? companyEmail = prefs.getString("company_email");
    String? companyPhone = prefs.getString("company_phone");
    String? companyBranch = prefs.getString("company_branch");

    return companyDetail(
      companyId: id!,
      isShuttle: isShuttle!,
      currencyId: currencyId!,
      company_name: companyName!,
      company_email: companyEmail!,
      company_phone: companyPhone!,
      company_branch: companyBranch!,
    );
  }

  ///Check if a user is signed in
  Future<bool> IsSignedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("the id is ${prefs.getString("api_token")}");
    return prefs.containsKey("userId");
  }

  ///The api for login into the app,it accepts two parameters Email/username and password
  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      "username": email,
      "password": password,
      "gcm_token": "",
      "country_code": "254",
      "token": AppUrl.companyToken
    };

    print("started processing with payload ${loginData}");
    Response response = await post(
      AppUrl.login,
      body: json.encode(loginData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': AppUrl.defaultToken
      },
    );
    print(response.body.toString());

    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData['isSuccess']) {
          var userData = responseData['data'];

          UserInfo authUser = UserInfo.fromJson(userData);
          saveUser(authUser);
          result = {'status': true, 'message': responseData['message']};
        } else {
          Map<String, dynamic> response = responseData['errors'];
          result = {
            'status': false,
            'message': response.containsKey("email")
                ? response["email"][0]
                : "Invalid login credentials",
            'isNotVerified': responseData.containsKey('accountVerified')
          };
        }
      } else {
        result = {
          'status': false,
          'message': responseData['errors']['error'],
          'isNotVerified': responseData.containsKey('accountVerified')
        };
      }
    } on Exception {
      result = {'status': false, 'message': "Login error"};
    }
    return result;
  }

  static DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();

  ///The api for login into the app,it accepts two parameters Email/username and password
  Future<Map<String, dynamic>> CreateAccount(String phone) async {
    var result;
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }
    final Map<String, dynamic> loginData = {
      "phone": phone,
      "country_code": "254",
      "device_number": deviceID,
      "sourcetype": "web"
    };
    print("the payload is $loginData");
    Response response = await post(
      AppUrl.createAccount,
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body.toString());
    print("started processing with payload ${loginData}");

    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {} else {
        result = {'status': false, 'message': "Error"};
      }
    } on Exception {
      result = {'status': false, 'message': "Login error"};
    }
    return result;
  }

  Future<Map<String, dynamic>> createNewAccount(String phonme) async {
    dioo.Response response;
    var returnValue = {
      "status": false,
      "verificationKey": "",
      "message": "An error occurred during operation"
    };
    var dio = dioo.Dio();
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }
    final Map<String, dynamic> loginData = {
      "phone": phonme,
      "country_code": "254",
      "device_number": deviceID,
      "sourcetype": "web"
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = AppUrl.defaultToken;
    dio.options.headers["source"] = 'web';
    print("the number is $phonme");
    response = await dio.post(AppUrl.createAccountString, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      //    final jsonData = json.decode(response.data.toString());
      if (response.data['isSuccess']) {
        returnValue = {
          "status": true,
          "verificationKey": response.data['verification_key']
        };
      } else {
        returnValue = {"status": false, "message": response.data['message']};
      }
      //return list.where((element) => Fund.fromJson(element).isActive == true).toList();

    } else if (response.statusCode == 401) {}
    return returnValue;
  }

  Future<Map<String, dynamic>> verifyOTP(String phonme, String code,
      int key) async {
    dioo.Response response;
    var returnValue = {"status": false, "verificationKey": ""};
    var dio = dioo.Dio();
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }
    final Map<String, dynamic> loginData = {
      "otp_number": int.parse(code),
      "device_number": deviceID,
      "gcm_token": "",
      "phone": phonme,
      "verification_key": key,
      "country_code": "254",
      "sourcetype": "web",
      "token": AppUrl.companyToken
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = AppUrl.defaultToken;
    dio.options.headers["source"] = 'web';
    print("the number is $loginData");

    response = await dio.post(AppUrl.verifyOTPString, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      // final jsonData = json.decode(response.data.toString());
      if (response.data['isSuccess']) {
        AuthenticationServices()
            .saveUser(UserInfo.fromJson(response.data['data']));
        returnValue = {"status": true, "message": "Welcome to Transline"};
      }

      //return list.where((element) => Fund.fromJson(element).isActive == true).toList();

    } else if (response.statusCode == 401) {}
    return returnValue;
  }

  Future<Map<String, dynamic>> verifyOTP2(String phonme, String code) async {
    dioo.Response response;
    var returnValue = {"status": false, "verificationKey": ""};
    var dio = dioo.Dio();
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }
    final Map<String, dynamic> loginData = {
      "otp_number": int.parse(code),
      "device_number": deviceID,
      "gcm_token": "",
      "phone": phonme,
      "country_code": "254",
      "sourcetype": "web",
      "token": AppUrl.companyToken
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = AppUrl.defaultToken;
    dio.options.headers["source"] = 'web';
    print("the number is $loginData");

    response = await dio.post(AppUrl.verifyOTPString, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
     //  final jsonData = json.decode(response.data.toString());
      if (response.data['isSuccess']) {
        UserInfo userInfo=UserInfo.fromJson(response.data['data']);
        saveUser(userInfo);
        returnValue = {"status": true, "message": "Welcome to Transline"};
      }

      //return list.where((element) => Fund.fromJson(element).isActive == true).toList();

    } else if (response.statusCode == 401) {}
    return returnValue;
  }

  Future<Map<String, dynamic>> createUserProfile(String firstName,
      String lastName,
      String phone,
      String email,
      String date,
      String gender,
      String password,
      int verificationKey) async {
    dioo.Response response;
    var returnValue = {
      "status": false,
      "message": "Invalid request,make sure to use unique email and phone"
    };
    var dio = dioo.Dio();
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }
    final Map<String, dynamic> loginData = {
      "name": firstName,
      "last_name": lastName,
      "gender": gender,
      "date_of_birth": date,
      "email": email,
      "phone": phone,
      "password": password,
      "country_code": "254",
      "device_number": deviceID,
      "verification_key": verificationKey,
      "gcm_token": "",
      "sourcetype": "web"
    };
    final Map<String, dynamic> data = {
      "name": '$firstName $lastName',
      "gender": gender,
      "date_of_birth": date,
      "email": "",
      "phone": phone,
      "password": password,
      "country_code": "254",
      "device_number": deviceID,
      "token": AppUrl.companyToken
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = AppUrl.defaultToken;
    dio.options.headers["source"] = 'web';
    print("the number is $loginData");
    response = await dio.post(AppUrl.createAccountString, data: data);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      //    final jsonData = json.decode(response.data.toString());
      if (response.data['isSuccess']) {
        returnValue = {
          "status": true,
          "message": "Account created successfully"
        };
      }
      //return list.where((element) => Fund.fromJson(element).isActive == true).toList();

    } else if (response.statusCode == 401) {}
    return returnValue;
  }

  Future<Map<String, dynamic>> resetPassword(String confirm_password,
      String password, String phone) async {
    dioo.Response response;
    var dio = dioo.Dio();
    UserInfo userInfo = await AuthenticationServices().getUser();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = userInfo.api_access_token;
    dio.options.headers["source"] = 'web';
    var returnValue = {
      "status": false,
      "message": "An error occurred during operation"
    };
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }
    final Map<String, dynamic> loginData = {
      "phone": phone,
      "newPassword": password,
      "confirmPassword": confirm_password,
      "country_code": "254",
      "token": AppUrl.companyToken,
      "device_number": deviceID,
      "sourcetype": "app"
    };
    response = await dio.post(AppUrl.resetPassword, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      //    final jsonData = json.decode(response.data.toString());
      if (response.data['isSuccess']) {}
      //return list.where((element) => Fund.fromJson(element).isActive == true).toList();

    } else if (response.statusCode == 401) {}
    return returnValue;
  }

  Future<Map<String, dynamic>> changePassword(String phone,
      String password, String oldPassword) async {
    dioo.Response response;
    var dio = dioo.Dio();
    UserInfo userInfo = await AuthenticationServices().getUser();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = AppUrl.defaultToken;
    dio.options.headers["source"] = 'web';
    var returnValue = {
      "status": false,
      "message": "An error occurred during operation"
    };
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }

    final Map<String, dynamic> resetData = {
      "phone": phone,
      "newPassword": password,
      "confirmPassword":oldPassword,
      "token": AppUrl.companyToken
    };
    print("The payload is ${resetData}");
    response = await dio.post(AppUrl.changePassword, data: resetData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      //    final jsonData = json.decode(response.data.toString());
      returnValue = response.data;
      //return list.where((element) => Fund.fromJson(element).isActive == true).toList();

    } else if (response.statusCode == 401) {}
    return returnValue;
  }

  Future<Map<String, dynamic>> forgetPassword(String phonme) async {
    dioo.Response response;
    var returnValue = {
      "status": false,
      "verificationKey": "",
      "message": "An error occurred during operation"
    };
    var dio = dioo.Dio();
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }
    final Map<String, dynamic> loginData = {
      "phone": phonme,
      "country_code": "254",
      "device_number": deviceID,
      "sourcetype": "web",
      "token": AppUrl.companyToken
    };

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = AppUrl.defaultToken;
    dio.options.headers["source"] = 'web';
    print("the number is $phonme");
    response = await dio.post(AppUrl.forgetPassword, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      //    final jsonData = json.decode(response.data.toString());
      if (response.data['isSuccess']) {
        returnValue = {
          "status": true,
          "verificationKey": response.data['verification_key']
        };
      } else {
        returnValue = {"status": false, "message": response.data['message']};
      }
      //return list.where((element) => Fund.fromJson(element).isActive == true).toList();

    } else if (response.statusCode == 401) {}
    return returnValue;
  }

  Future<Map<String, dynamic>> updateUser(String first, String last,
      String email, String phone, String id, Future<UserInfo> userInfo) async {
    dioo.Response response;
    var returnValue = {
      "status": false,
      "verificationKey": "",
      "message": "An error occurred during operation"
    };
    var dio = dioo.Dio();
    UserInfo user = await userInfo;
    var deviceID = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceID = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceID = data.identifierForVendor;
      }
      print("your uuid $deviceID");
    } on PlatformException {
      print('Failed to get platform version');
    }
    final Map<String, dynamic> loginData = {
      "email": email,
      "phone": phone,
      "identity_number": id,
      "name": first + " " + last,
      "last_name": last,
      "sourcetype": 'mini-app',
      "country_code": "254",
      "gender": user.gender,
      "age": user.age,
      "token": AppUrl.companyToken
    };

    print('$loginData');
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = user.api_access_token;
    dio.options.headers["source"] = 'web';

    response = await dio.post(AppUrl.updateProfile, data: loginData);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      //    final jsonData = json.decode(response.data.toString());
      if (response.data['isSuccess']) {
        UserInfo savedinf = UserInfo.fromJson(response.data['data']);
        saveUser2(savedinf);
        returnValue = {
          "status": true,
          "message": "Updated profile successfully"
        };
      } else {
        returnValue = {"status": false, "message": response.data['message']};
      }
      //return list.where((element) => Fund.fromJson(element).isActive == true).toList();

    } else if (response.statusCode == 401) {}
    return returnValue;
  }
}
