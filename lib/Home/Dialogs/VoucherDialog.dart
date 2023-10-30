
import 'package:mash/Services/PaymentApiServices.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Widgets/home_drawer.dart';

class VoucherDialog extends StatefulWidget {

   const VoucherDialog({Key? key,required this.onVoucherSuccess});
  _VoucherDialog createState() => _VoucherDialog();
  final Function()onVoucherSuccess;
}
class _VoucherDialog extends State<VoucherDialog>
{

  bool isLoading=true;
  final myController3 = TextEditingController();

 late ProgressDialog pr;
  @override
  void initState() {

    super.initState();
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);
    pr.style(message: 'Processing...');
  }

  String bullet = "\u2022 ";
  String amount="";
  String regNo="";
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     return Scaffold(

      appBar: AppBar(title: const Text("Top up",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,elevation: 0,  iconTheme: IconThemeData(color: Colors.black)),

      body: SingleChildScrollView(
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(child: Text("Load wallet using voucher",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),padding: EdgeInsets.all(20),),
              Padding(padding: const EdgeInsets.only(top: 10,right: 20,left: 20),child: Text("$bullet Enter the voucher number",style:TextStyle(fontFamily: 'Montserrat',fontSize: 15)),),
               Padding(padding: const EdgeInsets.only(top: 10,right: 20,left: 20),child: Text("$bullet Click on continue",style:const TextStyle(fontFamily: 'Montserrat',fontSize: 15)),),
              Padding(padding: const EdgeInsets.only(top: 10,right: 20,left: 20),child: Text("$bullet Refresh the wallet page",style:TextStyle(fontFamily: 'Montserrat',fontSize: 15)),),

              Form(
                  key: _formKey,
                  child:  Container(
                    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[

                        Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Enter voucher number',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child:
                            Container(
                                padding: EdgeInsets.only(
                                top: 2.0, bottom: 2, left: 20),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.white70),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)),
                              color: Colors.grey.shade300),
                                  child:
                                  TextFormField(
                                      autofocus: false,
                                      obscureText: false,
                                     onSaved: (s){
                                        setState(() {
                                          amount=s!;
                                        });
                                     },
                                      keyboardType: TextInputType.text,
                                      validator: (value) => value!.isEmpty ? "Enter code" : null,
                                      textInputAction: TextInputAction.done,

                                      decoration:
                                      const InputDecoration(

                                          border: InputBorder.none,
                                          icon: Icon(Icons.attach_money),
                                          hintText: "Enter voucher code",
                                          hintStyle: TextStyle(
                                              color: Colors.black))




                                  )),
                                ),
                              ],
                            )),

                      ],

                    ),
                  )),
              GestureDetector(
                child:  Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [
                            Colors.yellow.shade700,
                            Colors.yellow.shade700,
                          ]
                      )
                  ),
                  child: const Center(
                    child: Text("Continue", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
                onTap: () async {
                  final form = _formKey.currentState;

                  if (form!.validate()) {
                    form.save();
                    print("the form valid");
                    pr.show();
                    PaymentApiServices(context).RedeemVoucher(amount).then((value) =>
                    {
                      pr.hide(),
                      if(value['isSuccess'])
                        {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("Successfully redeemed voucher"),

                    )),
                          widget.onVoucherSuccess(),
                    Navigator.pop(context)
                        }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text("Not a valid voucher"),

                        )),Navigator.pop(context)
                      }


                    });
                  }
                  else{
                    print("the form not valid");
                  }

                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}