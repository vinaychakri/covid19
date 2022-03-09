import 'package:flutter/material.dart';
import 'Report_page.dart';
class Admin_Dashboard extends StatefulWidget {
  @override
  _Admin_DashboardState createState() => _Admin_DashboardState();
}
enum FormType{
  login,
}


class _Admin_DashboardState extends State<Admin_Dashboard> {
  var _email = '';
  var _password = '';
  var adminEmail = 'admin';
  var adminPassword = 'admin';
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  bool validateandsave(){
    final form = formKey.currentState;
    FocusScope.of(context).unfocus();
    if(form.validate()){
      formKey.currentState.reset();
      //form.save();
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin login'),
          backgroundColor: Colors.black12,
        ),
        body: Container(
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
          child: Padding(padding: const EdgeInsets.all(15.0),
              child: new Form(
                  key: formKey,
                  child: new SingleChildScrollView(child: Column(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.all(15.0),
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.green,
                            backgroundImage: AssetImage('assets/covid19.jpg'),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          key: ValueKey('email'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(icon: new Icon(Icons.email),
                            labelText: 'Please Enter your Mail',
                            contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
                          ),
                          onSaved:(value)=> _email=value,
                          validator: (value) {
                            if(value.trim().isEmpty){
                              return 'Email can not be empty';
                            }
                            if(!value.trim().contains(adminEmail)){
                              return 'enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          key: ValueKey('Password'),
                          obscureText: true,
                          decoration: new InputDecoration(icon: new Icon(Icons.lock),
                            labelText: 'please enter your password',
                            contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
                          ),
                          onSaved:(value)=> _password=value,
                          validator: (value) {
                            if(value.trim().isEmpty){
                              return 'password can not be empty';
                            }
                            if(!value.trim().contains(adminPassword)){
                              return 'enter a valid password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        if(_formType == FormType.login)
                          new RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: new Text('.   Admin login   .', style: new TextStyle(fontSize: 20.0),),
                          color: Colors.black12,
                          textColor: Colors.white,
                          elevation: 4.0,
                          splashColor: Colors.blueGrey,
                          onPressed: () {
                            if(validateandsave()){
                              try{
                                if( _formType == FormType.login){
                                  return Navigator.push(context, MaterialPageRoute(builder: (context) => Report_page()),);
                                }
                              }catch (e){
                              }
                            }
                          },

                        ),

                      ]
                  )
                  )
              )
          ),
        )
    );
  }
}
