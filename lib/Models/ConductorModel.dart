class ConductorModel{

  late String designation;
  late String name;
  late String email;
  late String phone;
  late String duplicate_ticket_print;
  late bool is_snap_shot_captured;
  late String id;
  late String vehicle_reg_no;
  late String vehicle_type;


  ConductorModel({
      required this.designation,
      required this.name,
      required this.email,
    required this.phone,
    required this.duplicate_ticket_print,
    required this.is_snap_shot_captured,
    required this.id,
    required  this.vehicle_reg_no,
    required  this.vehicle_type});

  factory ConductorModel.fromJson(Map<String, dynamic> responseData) {
    return ConductorModel(

        designation: responseData['designation'],
        name: responseData['name'],
        email: responseData['email'],
        phone: responseData['phone'],
        duplicate_ticket_print:responseData.containsKey('duplicate_ticket_print')?responseData['duplicate_ticket_print']:"",
        is_snap_shot_captured:responseData['is_snap_shot_captured'],
        id:responseData['id'],
        vehicle_reg_no:responseData['vehicle_reg_no'],
        vehicle_type:responseData.containsKey('vehicle_type')?responseData['vehicle_type']:"",


    );
  }

}