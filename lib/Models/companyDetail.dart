class companyDetail {
  companyDetail({
    this.companyId = '',
    this.isShuttle = '',
    this.currencyId = '',
    this.company_name = '',
    this.company_email = '',
    this.company_phone = '',

    this.company_branch='',

  });

  late String companyId,currencyId,isShuttle,company_name,company_email,company_phone,company_branch;

  factory companyDetail.fromJson(Map<String, dynamic> responseData) {
    return companyDetail(

        companyId: responseData['companyId'],
        isShuttle: responseData['isShuttle'],
        currencyId: responseData['currencyId'],
        company_name: responseData['company_name'],
        company_email:responseData['company_email'],
        company_phone:responseData['company_phone'],
         company_branch:responseData['company_branch'],

    );
  }

}
