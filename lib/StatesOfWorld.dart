import 'package:covid_tracker/Model/worldStatesModel.dart';
import 'package:covid_tracker/Services/utilities/servicesStates.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'View/countriesList.dart';
class StatesOfWorld extends StatefulWidget {
  const StatesOfWorld({Key? key}) : super(key: key);

  @override
  State<StatesOfWorld> createState() => _StatesOfWorldState();
}

class _StatesOfWorldState extends State<StatesOfWorld> with TickerProviderStateMixin {
  statesServices StatesServices= statesServices();
  late final AnimationController controller= AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this)..repeat();
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  final colorList =<Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                FutureBuilder(
                  future: StatesServices.fetchWorldStatesRecords(),
                    builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        PieChart(
                          dataMap:{
                            "Total": double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered.toString()),
                            "Deaths": double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width/3.2,
                          // chartLegendSpacing: 70,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          chartType: ChartType.ring,
                          animationDuration: Duration(milliseconds: 1200),
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ReusableRow(title: "Active Cases", value: snapshot.data!.active.toString()),
                                ReusableRow(title: "Today's Cases", value: snapshot.data!.todayCases.toString()),
                                ReusableRow(title: "Today's Death", value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
                      },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text('Track Country',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  else{
                    {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          //size: 50,
                          controller: controller,
                        ),
                      );
                    }
                  }
                }),

              ],
            ),
          ),
        ));
  }
}

class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
        ],
      ),
    );
  }
}
