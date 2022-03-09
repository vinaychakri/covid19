import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:covid19/Auth.dart';
class LoginPage extends StatefulWidget {
  LoginPage({this.auth,this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}
enum FormType{
  login,
  register,
}
class Gender{
  int id;
  String gender;
  Gender(this.id,this.gender);
  static List<Gender> getGender(){
    return <Gender>[
      Gender(1, 'Male'),
      Gender(2, 'Female'),
      Gender(3, 'other'),
    ];
  }
}
class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = new GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _repassword = '';
  var _fullName = '';
  var _age = '';
  var _address ='';
  var _health_condition ='';
  FormType _formType = FormType.login;

  List<Gender> _gender = Gender.getGender();
  List<DropdownMenuItem<Gender>> _dropdownMenuItems;
  Gender _selectGender;


  bool validateandsave(){
    final form = formKey.currentState;
    FocusScope.of(context).unfocus();
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }
  void validateandsubmit()async{
    if(validateandsave()){
      try {
        if( _formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('signed in:${userId}');
        }else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('registered in:${userId}');
        }
       widget.onSignedIn();
      }
      catch (e){
        print('error $e');
      }
    }
  }
  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }
  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType=FormType.login;
    });
  }
  onChangeDropDownItem(Gender selectGender){
    setState(() {
      _selectGender = selectGender;
    });
  }
  @override
  void initState(){
    _dropdownMenuItems = buildDropdownMenuItems(_gender);
    _selectGender = _dropdownMenuItems[0].value;
    super.initState();
  }
  List<DropdownMenuItem<Gender>> buildDropdownMenuItems(List genders) {
    List<DropdownMenuItem<Gender>> items = List();
    for(Gender gen in genders){
      items.add(
        DropdownMenuItem(
          value: gen,
            child: Text(gen.gender)
        ),
      );
    }
    return items;
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Covid Vaccination'),
          backgroundColor: Colors.black12,
        ),
        body: new Container(
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
                      Color(0x66FF7F50),
                    ]
                )
            ),
            child: Padding(padding: EdgeInsets.all(15.0),

                child: new Form(
                    key: formKey,
                    child: new SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                            children: buildInputs() + buildSubmitButtons(),
                    )
                    )
                )
            )
        )
    );
  }
  List<Widget> buildInputs(){
    return[
      if(_formType == FormType.login)
        new Padding(
        padding: EdgeInsets.all(15.0),
        child: CircleAvatar(
          radius: 60.0,
          backgroundColor: Colors.green,
          backgroundImage: AssetImage('assets/covid19.jpg'),
        ),
      ),
      SizedBox(height: 5,),
      if(_formType == FormType.register)
        TextFormField(
          key: ValueKey('Full Name'),
          decoration: new InputDecoration(icon: new Icon(Icons.account_circle,color: Colors.black54),
            labelText: 'Enter the Full Name',
            contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
          ),
          onSaved:(value)=> _fullName=value,
          validator:(value)=>value.trim().isEmpty ? 'Full Name cannot be empty':null,
        ),
      SizedBox(height: 6,),
      TextFormField(
        key: ValueKey('email'),
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(icon: new Icon(Icons.email,color: Colors.black54,),
          labelText: 'Please Enter your Mail',
          contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
        ),
        onSaved:(value)=> _email=value,
        validator: (value) {
          if(value.trim().isEmpty){
            return 'Email can not be empty';
          }
          if(!value.trim().contains('@')){
            return 'enter a valid email';
          }
          return null;
        },
      ),
      SizedBox(height: 6,),
      TextFormField(
        key: ValueKey('Password'),
        obscureText: true,
        decoration: new InputDecoration(icon: new Icon(Icons.lock,color: Colors.black54),
          labelText: 'please enter your password',
          contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
        ),
        onSaved:(value)=> _password=value,
        validator: (value) {
          _password= value;
          if(value.trim().isEmpty){
            return 'password can not be empty';
          }
          if(value.trim().length<=6){
            return 'password should contain at 7 characters';
          }
          return null;
        },
      ),
      SizedBox(height: 6,),
      if(_formType == FormType.register)
      TextFormField(
        key: ValueKey('Re-enter Password'),
        obscureText: true,
        decoration: new InputDecoration(icon: new Icon(Icons.lock,color: Colors.black54),
          labelText: 'please re-enter your password',
          contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
        ),
        onSaved:(value)=> _repassword=value,
        validator: (value) {
          if(value.trim().isEmpty){
            return 'Re-Enter password cannot be empty';
          }
          if(_password !=value){
            return 'password should match';
          }
          return null;
        },
      ),
      SizedBox(height: 6,),
      if(_formType == FormType.register)
        TextFormField(
          key: ValueKey('enter your age'),
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(icon: new Icon(Icons.accessibility_new,color: Colors.black54),
            labelText: 'please enter your age',
            contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
          ),
          onSaved:(value)=> _age =value,
          validator: (value) {
            if(value.trim().isEmpty){
              return 'please enter your age';
            }
            if(int.parse(value)<=17){
              return "your are under 18 year old, you can't register";
            }
            return null;
          },
        ),
      SizedBox(height: 6,),
      if(_formType == FormType.register)
        DropdownButtonFormField(
          decoration: new InputDecoration(icon: new Icon(Icons.add_circle_outlined,color: Colors.black54),
            labelText: 'Select your gender',
            contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
          ),
          value: _selectGender,
          items: _dropdownMenuItems,
          onChanged: onChangeDropDownItem,
        ),

      SizedBox(height: 6,),
      if(_formType == FormType.register)
        TextFormField(
          key: ValueKey('Address'),
          maxLines: 3,
          decoration: new InputDecoration(icon: new Icon(Icons.message,color: Colors.black54),
            labelText: 'Enter your address',
            contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
          ),
          validator :(value)=>value.isEmpty ? 'please enter your address':null,
          onSaved:(value)=>_address=value,
        ),
      SizedBox(height: 6,),
      if(_formType == FormType.register)
        TextFormField(
          key: ValueKey('Health_condition'),
          maxLines: 2,
          decoration: new InputDecoration(icon: new Icon(Icons.add_circle_outlined,color: Colors.black54),
            labelText: 'Enter your health condition',
            contentPadding: EdgeInsets.fromLTRB(23.0, 13.0, 23.0, 13.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(23.0)),
          ),
          validator :(value)=>value.isEmpty ? 'please enter your health condition':null,
          onSaved:(value)=>_health_condition=value,
        ),

    ];
  }
  List<Widget> buildSubmitButtons(){
    if(_formType == FormType.login) {
      return [
        new RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
          ),
          child: new Text('.    login    .', style: new TextStyle(fontSize: 20.0),),
          color: Colors.black12,
          textColor: Colors.white,
          elevation: 10.0,
          //splashColor: Colors.blueGrey,
          splashColor: Colors.yellowAccent[200],
          onPressed: validateandsubmit,
        ),
        new MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          child: new Text('create an account', style: new TextStyle(fontSize: 20.0),),
          onPressed: moveToRegister,

        ),
      ];
    }else{
      return [
        new RaisedButton(
          child: new Text('Create an account', style: new TextStyle(fontSize: 20.0),),
          color: Colors.black12,
          textColor: Colors.white,
          elevation: 10.0,
          //splashColor: Colors.blueGrey,
          splashColor: Colors.yellowAccent[200],
          onPressed: validateandsubmit,
        ),
        new FlatButton(
          child: new Text('Have an account? login', style: new TextStyle(fontSize: 20.0),),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
