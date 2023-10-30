class currencyDetail {
  currencyDetail({
    this.id = '',
    this.code = '',

  });

  late String id,code;

  factory currencyDetail.fromJson(Map<String, dynamic> responseData) {
    return currencyDetail(

      id: responseData['id'],
      code: responseData['code'],

    );
  }

}