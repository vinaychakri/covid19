import 'package:flutter/material.dart';
class ThankYou extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final icon = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 70.0,
          backgroundColor: Colors.redAccent,
          backgroundImage: AssetImage('assets/covid19.jpg'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(' COVID 19\nVaccination',
        style: TextStyle(fontSize: 24.0, color: Colors.black54),
      ),
    );

    final info = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'The NHS is currently offering the COVID-19 vaccine to people most at risk from coronavirus.'
        'In England, the vaccine is being offered in some hospitals and pharmacies, at hundreds of local'
            ' vaccination centres run by GPs and at larger vaccination centres. More centres are opening all the time.\n'
            'Its being given to:\n'
              '* people aged 80 and over\n'
              '* people who live or work in care homes\n'
              '* health and social care workers at high risk\n'
        'The vaccine will be offered more widely as soon as possible.\n\n\n'
        'Thank you using our service'
        ,
        style: TextStyle(fontSize: 15.5, color: Colors.black54),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0x66FF7F50),
              Color(0x99E9E6E1),
              Color(0x99E9E6E1),
              Color(0xffFF7F50),
            ]),
      ),
      child: Column(
        children: <Widget>[icon, welcome, info],
      ),
    );
    return Scaffold(
        body: body
    );
  }
}
