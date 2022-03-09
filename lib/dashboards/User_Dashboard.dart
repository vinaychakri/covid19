import 'package:flutter/material.dart';
import 'package:covid19/Auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'Admin_Dashboard.dart';
import 'ThankYou.dart';

class User_Dashboard extends StatefulWidget {
  User_Dashboard({this.auth,this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _User_DashboardState createState() => _User_DashboardState();
}
enum FormType{
  report_submission,
}


class _User_DashboardState extends State<User_Dashboard> {
  String qrCode ='UnKnown';
  var _health_condition_after_vaccine ='';
  var _casestate='';
  var pst='positive';
  var neg = 'negitive';
  bool _hasBeenPressed = false;
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.report_submission;
  bool reportValidate(){
    final form = formKey.currentState;
    FocusScope.of(context).unfocus();
    if(form.validate()){
      //form.save();
      return true;
    }else{
      return false;
    }
  }
  void _signOut()async{
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }catch(e) {
      print(e);

    }
  }
  Future<void> scanQRcode() async{
    setState(() {
      _hasBeenPressed = !_hasBeenPressed;
    });
   try{
     final qrCode = await FlutterBarcodeScanner.scanBarcode(
       '#ff6666',
       'cancel',
       true,
       ScanMode.QR,
     );
     if(!mounted) return;
     setState(() {
       if(qrCode.trim().contains('A')){
         this.qrCode = qrCode;
       }else if(qrCode.trim().contains('B')){
         this.qrCode = qrCode;
       }return  null;
     });
   }on PlatformException{
     qrCode = 'Failed to get barcode data.';
   }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0x66FF7F50),
                        Color(0x99E9E6E1),
                        Color(0x99E9E6E1),
                        Color(0x66FF7F50),
                      ]),
                ),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.green,
                  backgroundImage: AssetImage('assets/covid19.jpg'),
                ),
              ),
              SizedBox(height:50,),
              ListTile(
                leading: Icon(Icons.account_circle),
                trailing: Icon(Icons.login),
                dense: true,
                title: Text('Admin Dashboard',
                  style: TextStyle(fontSize: 15.5, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Admin_Dashboard()),
                  );
                },
              ),
              SizedBox(height:10,),
              ListTile(
                leading: Icon(Icons.work),
                trailing: Icon(Icons.exit_to_app),
                dense: true,
                title: Text('Sign out',
                  style: TextStyle(fontSize: 15.5, color: Colors.black),
                ),
                onTap: _signOut,
              ),
            ],
          ),
        ),
      appBar: AppBar(
        title: Text('Covid Vaccination'),
        backgroundColor: Colors.black12,
        actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.exit_to_app),
           onPressed: _signOut,
           ),
        ],
      ),
      body: Center(
        child:Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment .topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x66FF7F50),
                Color(0x99E9E6E1),
                Color(0x99E9E6E1),
                Color(0xffFF7F50),
              ]
            )
          ),
            child: Padding(padding: EdgeInsets.all(15.0),

                child: new Form(
                    key: formKey,
                    child: new SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          //SizedBox(height: 100,),
                          new Padding(
                            padding: EdgeInsets.all(15.0),
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.green,
                              backgroundImage: AssetImage('assets/covid19.jpg'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                          ),
                          Text('Scan Result $qrCode',
                            style: TextStyle(fontSize: 12.5, color: Colors.black54),
                          ),
                          Text('QRCode',
                            style: TextStyle(fontSize: 15.5, fontWeight:FontWeight.bold, color: Colors.black),
                          ),

                          SizedBox(height:10,),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black12)
                            ),
                            child: new Text('scan QRcode', style: new TextStyle(fontSize: 20.0),),
                            color: _hasBeenPressed ? Colors.black12 : Colors.brown,
                            textColor: Colors.white,
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            onPressed: scanQRcode,
                          ),
                          SizedBox(height:10,),
                          TextFormField(
                            key: ValueKey('vaccine type'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: new InputDecoration(icon: new Icon(Icons.youtube_searched_for,color: Colors.black54),
                              labelText: 'Vaccine is optional if your are scan the code',
                              hintText: 'vaccine type',
                              contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
                            ),
                          ),
                          SizedBox(height:10,),
                          TextFormField(
                            key: ValueKey('how much dose'),
                            decoration: new InputDecoration(icon: new Icon(Icons.add_chart,color: Colors.black54),
                              labelText: 'dose is optional if your are scan the code',
                              hintText: 'How much dose',
                              contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
                            ),
                          ),
                          SizedBox(height:10,),
                          TextFormField(
                            key: ValueKey('Health_condition'),
                            maxLines: 2,
                            decoration: new InputDecoration(icon: new Icon(Icons.add_circle_outlined,color: Colors.black54),
                              labelText: 'Enter your health condition after vaccine',
                              contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
                            ),
                            validator :(value)=>value.isEmpty ? 'please enter your health condition after vaccination':null,
                            onSaved:(value)=>_health_condition_after_vaccine=value,
                          ),
                          SizedBox(height:10,),
                          TextFormField(
                            key: ValueKey('Positive/Negative'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: new InputDecoration(icon: new Icon(Icons.airline_seat_recline_extra_rounded,color: Colors.black54),
                              labelText: 'Enter the result of test (+/-)',
                              contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
                            ),
                            onSaved:(value)=> _casestate=value,
                            validator: (value) {
                              if(value.trim().isEmpty){
                                return 'Please mention positive(+) or negative(-)';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height:10,),
                          new RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)
                            ),
                            child: new Text('.   submit report  .', style: new TextStyle(fontSize: 20.0),),
                            color: Colors.black12,
                            textColor: Colors.white,
                            elevation: 4.0,
                            splashColor: Colors.yellowAccent[200],
                            onPressed: () {
                            if(reportValidate()){
                            try{
                            if( _formType == FormType.report_submission){
                            return Navigator.push(context, MaterialPageRoute(builder: (context) => ThankYou()),);
                            }
                            }catch (e){
                            }
                            }
                            },

                          ),

                        ],
                      ),
                    )
                )
            )
        ),
      )
    );
  }
}
