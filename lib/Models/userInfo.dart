class UserInfo {
  UserInfo({
    this.id = '',
    this.age = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.country_code = '',
    this.last_name='',
    this.api_access_token='',
    this.gender='',
    this.currencyId='',
    this.id_number=''

  });

 late String id,name,age,email,phone,api_access_token,country_code,currencyId,gender,last_name,id_number;
  factory UserInfo.fromJson(Map<String, dynamic> responseData) {
    return UserInfo(

        id: responseData.containsKey('userId')?responseData['userId']:'',
        name:responseData.containsKey('name')? responseData['name']:'',
        email: responseData.containsKey('email')?responseData['email']:'',
        phone:responseData.containsKey('phone')? responseData['phone']:'',
        country_code: responseData.containsKey('country_code')? responseData['country_code']:'',
        last_name:responseData.containsKey('last_name')? responseData['last_name']:'',
        api_access_token:responseData.containsKey('api_token')? responseData['api_token']:'',
        gender:responseData.containsKey('gender')? responseData['gender']:'',
        currencyId:responseData.containsKey('currencyId')? responseData['currencyId']:'',
        age:responseData.containsKey('age')? responseData['age']:'',

    );
  }

  @override
  String toString() {
    return 'UserInfo{id: $id, name: $name, age: $age, email: $email, phone: $phone, api_access_token: $api_access_token, country_code: $country_code, currencyId: $currencyId, gender: $gender, last_name: $last_name}';
  }
}
