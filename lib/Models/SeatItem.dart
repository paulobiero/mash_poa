class SeatItem {
  late String left,
      top,
      seat_id,
      seat_width,
      seat_height,
      seat_name,
      seat_type,

      seat_color;
    late bool  selection_status;
    late dynamic seat_type_id;

  SeatItem(
      {required this.left,
      required this.top,
      required this.seat_id,
      required this.seat_width,
      required this.seat_height,
      required this.seat_name,
      required this.seat_type,
      required this.seat_type_id,
      required this.seat_color,
      required this.selection_status});

  factory SeatItem.fromJson(Map<String, dynamic> responseData) {
    return SeatItem(
      left: responseData['left'],
      top: responseData['top'],
      seat_id: responseData['seat_id'],
      seat_width: responseData['seat_width'],
      seat_height: responseData['seat_height'],
      seat_name: responseData['seat_name'],
      seat_type: responseData['seat_type'],
      seat_type_id: responseData['seat_type_id'],
      seat_color: responseData['seat_color'],
      selection_status: responseData['selection_status'],
    );
  }
}
