import 'package:mash/Models/BookingPassengerModel.dart';
import 'package:mash/Models/LocationItemModel.dart';
import 'package:mash/Models/SelectedSeatModel.dart';
import 'package:mash/Models/TripListModel.dart';

class AppUrl {
  static const String liveBaseURL = "http://api.ma3app.com/";
  static const String devBaseURL = "http://bossapi.99synergy.com/";
  static const String companyToken = "54M91C72-2CF4-4591-A6E9-02A60UPBAE4C";
  static const String defaultToken = "4F5D3QC5-C94A-CFD5-87C1-4E2903311DF0";
  static const String baseURL = liveBaseURL;
  static Uri login = Uri.parse(baseURL + "appApi/AppUser/LoginUsers");
  static String getVehicleList = baseURL + "agent/staff/getVehicleList";
  static String forgetPassword = baseURL + "appApi/AppUser/ForgotPassword";
  static String otp = baseURL + "AppUser/GenerateOTP";
  static String getDriverList = baseURL + "agent/staff/StaffList";
  static String getRouteList = baseURL + "agent/conductor/getRouteList";
  static String getAllCities = baseURL + "appApi/common/getCity";
  static String startTrip = baseURL + "agent/conductor/StartTrip";
  static String getUserDetails = baseURL + "agent/conductor/GetDetail";
  static String bookTicket = baseURL + "agent/conductor/bookTicket";
  static String getPassengerManifest =
      baseURL + "agent/conductor/getPassengerList";
  static String createAccountString = baseURL + "appApi/AppUser/RegisterUsers";
  static String updateProfile = '${baseURL}appApi/appUser/UpdateProfile';
  static String bookingHistory = '${baseURL}appApi/seatBookings/GetBookedSeats';
  static String changeForgotPassword =
      '${baseURL}globalApi/AppUser/ChangeForgotPassword';
  static Uri createAccount =
      Uri.parse(baseURL + "globalApi/AppUser/GenerateOTP");
  static String verifyOTPString =
      baseURL + "appApi/AppUser/UserOTPVerification";
  static String getTripList = baseURL + "appApi/booking/filterBuses";
  static String sampleSeatJson =
      '{"priceList":{"normal":[{"currencyType":"KES","currencyId":"1","price":"1500.00","tax":0}]},"data":[{"left":"38","top":"10","seat_id":"13865","seat_width":"37","seat_height":"36","seat_name":"Driver","seat_type":"driver","seat_type_id":"","seat_color":"#006DB5","selection_status":true},{"left":"104","top":"252","seat_id":"13866","seat_width":"37","seat_height":"36","seat_name":"Staff","seat_type":"staff","seat_type_id":0,"seat_color":"#006DB5","selection_status":false},{"left":"0","top":"252","seat_id":"13867","seat_width":"100","seat_height":"36","seat_name":"Door","seat_type":"door","seat_type_id":"","seat_color":"#006DB5","selection_status":true},{"left":"149","top":"252","seat_id":"13868","seat_width":"37","seat_height":"36","seat_name":"A3","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"196","top":"252","seat_id":"13869","seat_width":"37","seat_height":"36","seat_name":"A5","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"250","top":"252","seat_id":"13870","seat_width":"37","seat_height":"36","seat_name":"A7","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"297","top":"252","seat_id":"13871","seat_width":"37","seat_height":"36","seat_name":"A9","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"347","top":"252","seat_id":"13872","seat_width":"37","seat_height":"36","seat_name":"A11","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"399","top":"252","seat_id":"13873","seat_width":"37","seat_height":"36","seat_name":"A13","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"454","top":"252","seat_id":"13874","seat_width":"37","seat_height":"36","seat_name":"A15","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"502","top":"252","seat_id":"13875","seat_width":"37","seat_height":"36","seat_name":"A17","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"551","top":"252","seat_id":"13876","seat_width":"37","seat_height":"36","seat_name":"A19","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"606","top":"252","seat_id":"13877","seat_width":"37","seat_height":"36","seat_name":"A21","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"656","top":"252","seat_id":"13878","seat_width":"37","seat_height":"36","seat_name":"A23","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"110","top":"9","seat_id":"13879","seat_width":"37","seat_height":"36","seat_name":"B2","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"155","top":"9","seat_id":"13880","seat_width":"37","seat_height":"36","seat_name":"B4","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"201","top":"9","seat_id":"13881","seat_width":"37","seat_height":"36","seat_name":"B6","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"252","top":"9","seat_id":"13882","seat_width":"37","seat_height":"36","seat_name":"B8","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"301","top":"9","seat_id":"13883","seat_width":"37","seat_height":"36","seat_name":"B10","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"347","top":"8","seat_id":"13884","seat_width":"37","seat_height":"36","seat_name":"B12","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"397","top":"8","seat_id":"13885","seat_width":"37","seat_height":"36","seat_name":"B14","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"450","top":"9","seat_id":"13886","seat_width":"37","seat_height":"36","seat_name":"B16","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"503","top":"9","seat_id":"13887","seat_width":"37","seat_height":"36","seat_name":"B18","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"555","top":"9","seat_id":"13888","seat_width":"37","seat_height":"36","seat_name":"B20","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"606","top":"10","seat_id":"13889","seat_width":"37","seat_height":"36","seat_name":"B22","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"656","top":"8","seat_id":"13890","seat_width":"37","seat_height":"36","seat_name":"B24","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"656","top":"125","seat_id":"13891","seat_width":"37","seat_height":"36","seat_name":"25","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"612","top":"125","seat_id":"13892","seat_width":"37","seat_height":"36","seat_name":"A22","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"556","top":"126","seat_id":"13893","seat_width":"37","seat_height":"36","seat_name":"A20","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"508","top":"127","seat_id":"13894","seat_width":"37","seat_height":"36","seat_name":"A18","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"455","top":"127","seat_id":"13895","seat_width":"37","seat_height":"36","seat_name":"A16","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"407","top":"129","seat_id":"13896","seat_width":"37","seat_height":"36","seat_name":"A14","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"351","top":"129","seat_id":"13897","seat_width":"37","seat_height":"36","seat_name":"A12","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"303","top":"130","seat_id":"13898","seat_width":"37","seat_height":"36","seat_name":"A10","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"253","top":"131","seat_id":"13899","seat_width":"37","seat_height":"36","seat_name":"A8","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false},{"left":"199","top":"129","seat_id":"13900","seat_width":"37","seat_height":"36","seat_name":"A6","seat_type":"normal","seat_type_id":"13014","seat_color":"blue","selection_status":false}],"seatsBooked":2,"isSuccess":true}';

  static String samplePrices =
      '{"data":[{"bus_id":"6941","route_id":"967","bus_title":"TRANSLINE CLASSIC","bus_type":"33 - SEATER COVID","amenities":null,"departure_time":"07:30 AM","arrival_time":"06:00 PM","available_seat_count":33,"total_journey_time":"06:26","avg_rating":"0.0","rating_count":"0","multi_seat":false,"defaultTripPriceList":[{"currencyCode":"KES","amount":"1500.00","seatType":"normal"}],"flatPriceList":[],"highWayDirectRoute":"Direct","trip_code":"NRB - SIAYA","ticket_amount":"1500.00","sort_time":1665030600,"message":"","isPromotional":false,"seatSelectionLimit":"0","delayedDate":1665090000,"delayedFlag":0,"delayedMsg":""}],"available_buses_count":1,"isSuccess":true}';

  static String getTripSeatsPrice =
      baseURL + "appApi/booking/getTripSeatsPrice";

  static String getBoardingDroppingPoints =
      baseURL + "appApi/booking/getBoardingDroppingPoints";

  static String getPaymentMethods = baseURL + "appApi/booking/paymentMethod";

  static Uri ticketBooking = Uri.parse(baseURL + "appApi/booking/save");
  static Uri initiatePayment =
      Uri.parse(baseURL + "appApi/paymentGateway/init");
  static String resetPassword = '${baseURL}appApi/AppUser/ForgotPassword';
  static List<BookingPassengerModel> bookingsReturn = [];
  static TripListModel tripListModelReturn = TripListModel();
  static LocationItemModel pickLocationReturn = LocationItemModel();
  static LocationItemModel dropLocationReturn = LocationItemModel();
  static List<SelectedSeatModel> passengersReturn = [];
  static LocationItemModel pickLocation = LocationItemModel();
  static LocationItemModel dropLocation = LocationItemModel();
  static TripListModel tripListModel = TripListModel();
  static List<SelectedSeatModel> passengers = [];
  static List<BookingPassengerModel> bookings = [];
  static String email = "";
  static String getWalletData = baseURL + "appApi/UserWallet/getWalletData";
  static String addAmount = baseURL + "appApi/userWallet/addAmount";
  static String redeemVoucher = baseURL + "appApi/UserWallet/RedeemVoucher";
  static String checkAddAmountRequest =
      baseURL + "appApi/userWallet/CheckAddAmountRequest";
  static String getWalletHistory =
      baseURL + "appApi/UserWallet/getWalletHistory";
  static String changePassword = '${baseURL}appApi/AppUser/ChangePassword';
  static Uri reInitiatePayment =
      Uri.parse(baseURL + "appApi/paymentGateway/reInit");

  static String resendOTP = '${baseURL}appApi/AppUser/ReSendOTP';
}
