import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:openwhatsappchat/DB/db_helper.dart';
import 'package:openwhatsappchat/Models/MobileNumberModel.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  var mobileNumber;
  var countryCode;

  Home(String this.mobileNumber,String this.countryCode, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final dbHelper = DatabaseHelper.instance;

  var countryCode = "IN";
  var mobileNo;
  var messageText = TextEditingController();

  bool _validate = false;


  Future<void> insertData(String countryCode,String mobileNo,String date) async {

    MobileNumberModel mobileNumberModel = MobileNumberModel(countryCode, mobileNo, date);

    final id = await dbHelper.insertData(mobileNumberModel);
    print(id.toString());
  }

  @override
  void initState() {
    mobileNo = widget.mobileNumber;
    countryCode = widget.countryCode;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/imgcropped2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(40),
                child:  Align(
                  alignment: Alignment.center,
                  child: Text('Chit Chat', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                  ),),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
              child:  IntlPhoneField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Mobile Number",
                ),
                initialCountryCode: countryCode,
                initialValue: mobileNo,

                onChanged: (phone) {
                  print(phone.completeNumber);
                  mobileNo = phone.number;
                  countryCode = phone.countryISOCode;
                  print(phone.countryISOCode);
                },
                onCountryChanged: (country) {
                  print('Country changed to: ' + country.dialCode);
                  countryCode = country.code;
                  print(country.code);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              child: TextField(
                controller: messageText,
                maxLines: 8,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Message (Optional)",
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.whatsapp,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: 3,),
                      Text(
                        " Send ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16),
                      )
                    ],
                  ),
                  onPressed: () async{
                    if(mobileNo.toString().isNotEmpty){
                      print("Rishabh");
                      print(countryCode);
                      print(mobileNo);

                      DateTime now = new DateTime.now();
                      print(now.toString());

                      var chk = await dbHelper.checkMobileNumber(mobileNo);

                      if(chk == true){
                        print("Mobile Number Already Inserted");
                      }else{
                        await insertData(countryCode,mobileNo,now.toString());
                      }

                      var whatsappUrl =
                          "whatsapp://send?phone=${mobileNo.toString()}" +
                              "&text=${Uri.encodeComponent(messageText.text)}";
                      try {
                        launch(whatsappUrl);
                      } catch (e) {
                      }
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(200))))),
                ),
              ),
            ),
            SizedBox(height: 60,)
          ],
        ),

      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(right: 30,bottom: 80),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //
      //     },
      //     backgroundColor: Colors.white,
      //     child: const Icon(Icons.ads_click, color: Colors.green,),
      //   ),
      // ),
    );


  }
}
