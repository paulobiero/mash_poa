class LocationItemModel {
  LocationItemModel({
    this.id = '0',
    this.name = '',

  });

  late String id,name;


  factory LocationItemModel.fromJson(Map<String, dynamic> responseData) {
    return LocationItemModel(

      id: responseData['id'],
      name: responseData['name'],

    );
  }
}