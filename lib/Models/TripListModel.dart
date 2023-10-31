

import 'FaresModel.dart';

class TripListModel {
  TripListModel(
      {this.bus_id = '',
        this.trip_code = '',
        this.trip_type = '',
        this.company_name = '',
        this.company_logo='',
        this.route_id = '',
        this.route_name = '',
        this.departure_time = '',
        this.total_journey_time = '',
        this.arrival_time='',
        this.bus_type='',
        this.amenities='',
        this.avg_rating='',
        this.rating_count='',
        this.highWayDirectRoute='',
        this.fares = const [],
        this.ticket_amount=0,

        this.available_seat_count=0});

  late String bus_id,
      trip_code,
      trip_type,
      company_name,
      route_id,
      route_name,
      departure_time,
      company_logo,
      amenities,
      bus_type,
      avg_rating,
      rating_count,
      highWayDirectRoute='',
      total_journey_time;
  late String arrival_time;
  late List<FareModel> fares;
  int available_seat_count,ticket_amount;

  factory TripListModel.fromJson(Map<String, dynamic> responseData) {
    Iterable far = responseData['defaultTripPriceList'];
    print("Has company logo "+responseData.containsKey('company_logo').toString());
    return TripListModel(
      bus_id: responseData['bus_id'],
      trip_code: responseData['trip_code'],
      trip_type: responseData['highWayDirectRoute'],
      company_name: responseData['company_name'],
      route_id:responseData.containsKey('route_id')? responseData['route_id']:'',
      arrival_time: responseData['arrival_time'],
      route_name: responseData['trip_code'],
      company_logo: responseData['company_logo'],
      amenities: responseData['amenities'] ?? '',
      departure_time: responseData['departure_time'],
      total_journey_time: responseData['total_journey_time'],
      avg_rating: responseData['avg_rating'],
      bus_type:responseData['bus_type'] ,
      highWayDirectRoute: responseData['highWayDirectRoute'],
      rating_count: responseData['rating_count'],
      fares: far.map((e) => FareModel.fromJson(e)).toList(),
      available_seat_count: responseData['available_seat_count'],
    );
  }

  @override
  String toString() {
    return 'TripListModel{bus_id: $bus_id, trip_code: $trip_code, trip_type: $trip_type, company_name: $company_name, route_id: $route_id, route_name: $route_name, departure_time: $departure_time, total_journey_time: $total_journey_time, ticket_amount: $ticket_amount, arrival_time: $arrival_time, fares: $fares}';
  }
}

