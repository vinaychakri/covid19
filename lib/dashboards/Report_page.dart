import 'dart:async';
import 'package:flutter/material.dart';
import 'package:covid19/covid_data.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
class Report_page extends StatefulWidget {
  @override
  _Report_pageState createState() => _Report_pageState();
}
class _Report_pageState extends State<Report_page> {
  Future<List<Welcome>> featchItems(BuildContext context) async{
    final jsonstring = await DefaultAssetBundle.of(context).loadString('assets/covid_data.json');
    return welcomeFromJson(jsonstring);
  }
  SearchBar searchBar;
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Vaccine Report'),
        backgroundColor: Colors.black12,
        actions: [searchBar.getSearchAction(context)]
    );
  }
  _Report_pageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
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
        child: Card(
          color: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: FutureBuilder(
            future: featchItems(context),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount:snapshot.data.length,
                  shrinkWrap : true,
                  itemBuilder: (BuildContext context, int index){
                    Welcome welcome= snapshot.data[index];
                    return Card(
                      elevation: 10,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('name:${welcome.type}',
                            style:  TextStyle(fontSize: 20),
                          ),
                          Text('Group type:${welcome.vaccineGroup}',
                            style:  TextStyle(fontSize: 20),
                          ),
                          Text('Quantity of Dose : ${welcome.singleDose}',
                            style:  TextStyle(fontSize: 20),
                          ),
                          Text('vaccine efficacy ${welcome.efficacyRate} in Group ${welcome.vaccineGroup} of Dose ${welcome.singleDose}',
                            style:  TextStyle(fontSize: 20),
                          ),Text('Number of volunteers:${welcome.volunteer.toString()}',
                            style:  TextStyle(fontSize: 20),
                          ),
                          Text('Number of positive cases:${welcome.confirmPositive.toString()}',
                            style:  TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return CircularProgressIndicator();
            },
          ),

        ),
      ),
    );
  }
}
