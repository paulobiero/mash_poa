import 'package:mash/Home/Dialogs/TopUpDialog.dart';
import 'package:mash/Home/Dialogs/VoucherDialog.dart';
import 'package:mash/Models/UserWalletHistoryItem.dart';
import 'package:mash/Services/PaymentApiServices.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWalletLanding extends StatefulWidget {
  const MyWalletLanding({Key? key}) : super(key: key);


  @override
  _MyWalletLanding createState() => _MyWalletLanding();
}
class _MyWalletLanding extends State<MyWalletLanding> {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    PaymentApiServices apiServices=PaymentApiServices(context);
    apiServices.getWalletData().then((value) => {
      apiServices.getWalletHistory().then((value2) => {
        setState(() {
          isLoading=false;

          try{
            amount=value[0]["amount"];
          }catch(r){
            amount=0;
          }
          history=value2;
          print("The number is ${history.length}");
        })
      })

    });
  }
  bool isLoading=true;
  dynamic amount=0;
  List<UserWalletHistoryItem>history=[];
  @override
  Widget build(BuildContext context) {
    // var mainProvider = MainProvider();
    Size size = MediaQuery.of(context).size;
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600
    );
    final TextStyle ticketLargeText=Theme.of(context).textTheme.headline2!.copyWith(
      color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,
    );
    return Scaffold(
        appBar:AppBar(
          title: const Text("",style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,


        ),

        body:isLoading?Column(
          children: const [
            LinearProgressIndicator()
          ],
        ):CustomScrollView(
            slivers: <Widget>[
              SliverList(delegate: SliverChildListDelegate([
                Padding(padding: EdgeInsets.only(left: 20,top: 20)
                  ,child:  Text(
                    "My Wallet",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.rubik(textStyle: headline4),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 20,top: 10),child:   Text(
                  "Manage your wallet here",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey),
                  textAlign: TextAlign.left,
                ),),

                SizedBox(height: 20,),
                Center(
                  child: Container(

                    width: size.width *.95,

                    child: Card(
                      color: Colors.green.shade700,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(height: 30,),
                          Text("Your wallet balance",style:Theme.of(context).textTheme.headline6?.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text("Ksh $amount",style:ticketLargeText)
                          ,

                          SizedBox(height: 30,),
                          Container(
                            height: 35,
                            width: size.width *.4,
                            child:TextButton(
                              onPressed: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) => const TopUpDialog(),
                                      fullscreenDialog: true

                                  ),
                                );
                              },

                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        side: BorderSide(color: Colors.white)
                                    )
                                ),
                              ),
                              child: const Text("Top up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Container(
                            height: 35,
                            margin: EdgeInsets.only(top: 20),
                            width: size.width *.4,
                            child:TextButton(
                              onPressed: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>  VoucherDialog(onVoucherSuccess: (){
                                        setState(() {
                                          isLoading=true;
                                        });
                                        PaymentApiServices apiServices=PaymentApiServices(context);
                                        apiServices.getWalletData().then((value) => {
                                          apiServices.getWalletHistory().then((value2) => {
                                            setState(() {
                                              isLoading=false;
                                              amount=value[0]["amount"];
                                              history=value2;
                                            })
                                          })

                                        });
                                      },),
                                      fullscreenDialog: true

                                  ),
                                );
                              },

                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        side: BorderSide(color: Colors.white)
                                    )
                                ),
                              ),
                              child: const Text("Redeem Voucher",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            ),
                          ),
                          const SizedBox(height: 30,),
                        ],
                      ),
                    ),

                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20,top: 30),
                      child:  Expanded(
                        child: Text("Wallet history",style:Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20,top: 30,right: 20),
                      child:  Text("View All",style:Theme.of(context).textTheme.headline5?.copyWith(
                          color:  Colors.green.shade700,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold)),
                    )
                  ],),
                SizedBox(height: 30.0),
                history.isEmpty?Center(
                  child: Padding(padding: EdgeInsets.only(left: 20,top: 10),child:   Text(
                    "No recent history",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),),
                ):SizedBox()
              ])),
              SliverList(delegate: SliverChildListDelegate(history.map((e) => getNotifications(e)).toList())),
            ])
    );
  }

  Widget getNotifications(UserWalletHistoryItem item){
    return ListTile(
      title: Text(item.date,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
      dense: true,
      selected: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      subtitle:
      RichText(
          overflow: TextOverflow.clip,
          text: TextSpan(
              children:  <TextSpan>[
                TextSpan(text: "${item.comments} of amount ${item.amount} at" , style: TextStyle(color: Colors.black,fontSize: 12),),
                TextSpan(text: " ${item.time}" , style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),)

              ]
          )
      ),

      leading:
      TextDrawable(
        text: item.amountStatus,
        textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        isTappable: true,
        onTap: (val) {

        },
        boxShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
      ),trailing: item.amountStatus=="debited"?Icon(Icons.arrow_upward,color: Colors.red,):Icon(Icons.arrow_downward,color: Colors.green,),
      onTap: (){

      },
    );
  }

}
