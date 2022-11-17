import 'package:covid_tracker/StatesOfWorld.dart';
import 'package:flutter/material.dart';

class CountriesDetail extends StatefulWidget {
  String name ;
  String image;
  int critical,active,totalRecovered,totalDeaths,totalCases,tests,todayRecovered;
   CountriesDetail({
     required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.todayRecovered,
     required this.totalRecovered,
     required this.critical,
     required this.active,
     required this.tests,
});

  @override
  State<CountriesDetail> createState() => _CountriesDetailState();
}

class _CountriesDetailState extends State<CountriesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.067),
                child: Card(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                    ReusableRow(title: "Cases", value: widget.totalCases.toString()),
                    ReusableRow(title: "Recovered", value: widget.totalRecovered.toString()),
                    ReusableRow(title: "Deaths", value: widget.totalDeaths.toString()),
                    ReusableRow(title: "Active", value: widget.active.toString()),
                    ReusableRow(title: "Critical", value: widget.critical.toString()),
                    ReusableRow(title: "Tests", value: widget.tests.toString()),
                  ],
                ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
