import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:openwhatsappchat/DB/db_helper.dart';
import 'package:openwhatsappchat/Models/MobileNumberModel.dart';
import 'package:openwhatsappchat/main.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';


class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with WidgetsBindingObserver  {

  final dbHelper = DatabaseHelper.instance;

  List<MobileNumberModel>? mobileNumberModel = [];
  int count = 0;

  getData(){
    Future<List<MobileNumberModel>> noteListFuture = dbHelper.getMobileNumberList();
    noteListFuture.then((dataList) {
      setState(() {
        this.mobileNumberModel = dataList;
        this.count = dataList.length;
      });
    });
  }

  Future<void> deleteData(int id) async {

    final res = await dbHelper.deleteData(id);
    print(res.toString());
    setState(() {

    });
  }

  @override
  void initState() {
    getData();
    WidgetsBinding.instance?.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {

    if (mobileNumberModel == null) {
      mobileNumberModel = <MobileNumberModel>[];
      getData();
    }

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
    GlobalKey<LiquidPullToRefreshState>();

    int refreshNum = 10;
    Stream<int> counterStream =
    Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);

    ScrollController? _scrollController;


    Future<void> _handleRefresh() {
      final Completer<void> completer = Completer<void>();
      Timer(const Duration(seconds: 3), () {
        completer.complete();
      });
      setState(() {
        refreshNum = Random().nextInt(100);
      });
      return completer.future.then<void>((_) {
        ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
          SnackBar(
            content: const Text('Refresh complete'),
            action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState!.show();
              },
            ),
          ),
        );
      });
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg22.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: LiquidPullToRefresh(
          key: _refreshIndicatorKey,
          color: Colors.deepPurple,
          backgroundColor: Colors.white,
          onRefresh: _handleRefresh,
          showChildOpacityTransition: false,
          child: StreamBuilder<int>(
            stream: counterStream,
            builder: (context, snapshot) {
              return  ListView(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(40),
                      child:  Align(
                        alignment: Alignment.center,
                        child: Text('History', style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                        ),),
                      )
                  ),
                  SizedBox(height: 10,),
                  for (var i = 0; i < mobileNumberModel!.length; i++)
                    InkWell(
                      onTap: (){
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage( title: 'Click To Chat',mobileNumber: mobileNumberModel![i].mobile_number, countryCode: mobileNumberModel![i].country_code,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 6,bottom: 6),
                        child: Container(
                          height: 60,
                          child: Card(
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20.0),),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 10,),
                                      Text(
                                        mobileNumberModel![i].mobile_number,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight:
                                            FontWeight
                                                .w600),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        child: FaIcon(
                                          FontAwesomeIcons.copy,
                                          size: 18,
                                          color: Colors.deepPurple,
                                        ),
                                        onPressed: () {
                                          print("Rishabh");
                                          Clipboard.setData(ClipboardData(text: mobileNumberModel![i].mobile_number))
                                              .then((value) {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied Success"),
                                            ));
                                          });
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty
                                                .all(Colors
                                                .white),
                                            elevation: MaterialStatePropertyAll(0),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            200))))),
                                      ),
                                      SizedBox(width: 10,),
                                      ElevatedButton(
                                        child: FaIcon(
                                          FontAwesomeIcons.trash,
                                          size: 18,
                                          color: Colors.deepPurple,
                                        ),
                                        onPressed: () async {
                                          print("Ravi");
                                          QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.confirm,
                                              text: 'Do you want to delete',
                                              confirmBtnText: 'Yes',
                                              cancelBtnText: 'No',
                                              confirmBtnColor: Colors.green,
                                              onConfirmBtnTap: () async{
                                                await deleteData(mobileNumberModel![i].id);
                                                getData();
                                                setState(() {});
                                                Navigator.pop(context);
                                              }
                                          );
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty
                                                .all(Colors
                                                .white),
                                            elevation: MaterialStatePropertyAll(0),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            200))))),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 40,)
                ],
              );
            },
          ),
        ),

      ),
    );


  }
}
