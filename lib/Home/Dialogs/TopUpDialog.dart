
import 'package:mash/Services/PaymentApiServices.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Widgets/home_drawer.dart';

class TopUpDialog extends StatefulWidget {

   const TopUpDialog({Key? key});
  _TopUpDialog createState() => _TopUpDialog();
}
class _TopUpDialog extends State<TopUpDialog>
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
  final _formKey = GlobalKey<FormState>();
  String regNo="";

  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final SimpleDialog dialog2 =   SimpleDialog(
      title: const Text('Confirm payment'),
      children: [
        Padding(padding: EdgeInsets.only(right: 10,left: 10)
          ,child: Form(
              key:_formKey2 ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 20),child: TextFormField(
                    onSaved:  (String){
                      setState(() {
                        regNo=String!;
                      });
                    },
                    validator: (value) => value!.isEmpty ? "Enter transaction code" : null,
                    decoration: InputDecoration(

                      labelText: 'Enter Transaction code',

                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.directions_bus,
                      ),
                    ),
                  ),),
                  GestureDetector(
                    child:  Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Colors.deepOrange.shade700,
                                Colors.deepOrange.shade700,
                              ]
                          )
                      ),
                      child: const Center(
                        child: Text("Confirm", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    onTap: () async {
                      final form = _formKey2.currentState;
                      if (form!.validate()) {
                        form.save();
                        print("the reg is ::$regNo");
                        Navigator.pop(context);
                        pr.show();
                        Map<String,dynamic> trip=await PaymentApiServices(context).CheckAddAmountRequest(regNo);
                        pr.hide();

                        if(trip['isSuccess']){
                          Navigator.pop(context);
                          const snackBar=  SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("Payment received successfully"),
                            duration: Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }else{
                          const snackBar=  SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("No transaction found. Please try sending new payment request"),
                            duration: Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                      }

                    },
                  )
                ],
              )),
        )
      ],
    );

    return Scaffold(

      appBar: AppBar(title: const Text("Top up",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,elevation: 0,  iconTheme: IconThemeData(color: Colors.black)),

      body: SingleChildScrollView(
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(child: Text("Tips load your wallet",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),padding: EdgeInsets.all(20),),
              Padding(padding: const EdgeInsets.only(top: 10,right: 20,left: 20),child: Text("$bullet Click on initiate new payment",style:TextStyle(fontFamily: 'Montserrat',fontSize: 15)),),
              Padding(padding: const EdgeInsets.only(top: 10,right: 20,left: 20),child: Text("$bullet Enter the amount you want to top up",style:TextStyle(fontFamily: 'Montserrat',fontSize: 15)),),
              Padding(padding: const EdgeInsets.only(top: 10,right: 20,left: 20),child: Text("$bullet Click on continue",style:const TextStyle(fontFamily: 'Montserrat',fontSize: 15)),),
              Padding(padding: const EdgeInsets.only(top: 10,right: 20,left: 20),child: Text("$bullet Enter your mpesa pin and refresh the wallet",style:TextStyle(fontFamily: 'Montserrat',fontSize: 15)),),
              GestureDetector(
                child:  Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 20,right: 20,top: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white,
                          ]
                      )
                  ),
                  child:
                     Text("Confirm payment", style: TextStyle(color: Colors.yellow.shade700, fontWeight: FontWeight.bold,fontSize: 18),),

                ),
                onTap: () async {
                  showDialog<void>(context: context, builder: (context) => dialog2);


                },
              ),
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
                                      'Enter mpesa amount here',
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
                                      keyboardType: TextInputType.number,
                                      validator: (value) => value!.isEmpty ? "Enter amount" : null,
                                      textInputAction: TextInputAction.done,

                                      decoration:
                                      const InputDecoration(

                                          border: InputBorder.none,
                                          icon: Icon(Icons.attach_money),
                                          hintText: "Enter amount",
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
                    PaymentApiServices(context).addAmount(amount).then((value) =>
                    {
                      pr.hide(),
                      if(value['isSuccess'])
                        {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("${value['msg']}"),

                    )),
                    Navigator.pop(context)
                        }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text("${value['msg']}"),

                        ))
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
