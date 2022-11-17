import 'package:covid_tracker/Services/utilities/servicesStates.dart';
import 'package:covid_tracker/View/countryDetails.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    statesServices StateServices= statesServices();
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search with country name",
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: StateServices.countriesListApi(),
                      builder:(context, AsyncSnapshot<List<dynamic>> snapshot){
                        if(snapshot.hasData){
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                String name= snapshot.data![index]['country'];
                                if(searchController.text.isEmpty){
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesDetail(name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        critical: snapshot.data![index]['critical'],
                                        active: snapshot.data![index]['active'],
                                        tests: snapshot.data![index]['tests'])));
                                  },
                                  child: ListTile(
                                          title: Text(snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"])),
                                        ),
                                      )
                                    ],
                                  );
                                }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                                 return Column(
                                   children: [
                                     InkWell(
                                       onTap:(){
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesDetail(name: snapshot.data![index]['country'],
                                             image: snapshot.data![index]['countryInfo']['flag'],
                                             totalCases: snapshot.data![index]['cases'],
                                             totalDeaths: snapshot.data![index]['deaths'],
                                             todayRecovered: snapshot.data![index]['todayRecovered'],
                                             totalRecovered: snapshot.data![index]['recovered'],
                                             critical: snapshot.data![index]['critical'],
                                             active: snapshot.data![index]['active'],
                                             tests: snapshot.data![index]['tests'])));
                                 },
                                       child: ListTile(
                                         title: Text(snapshot.data![index]['country']),
                                         subtitle: Text(snapshot.data![index]['cases'].toString()),
                                         leading: Image(
                                             height: 50,
                                             width: 50,
                                             image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"])),
                                       ),
                                     )
                                   ],
                                 );
                                }else{
                                 return Container();
                                }
                              });
                        }else{
                          return  ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context,index){
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade600,
                                  highlightColor: Colors.grey.shade100,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Container(height: 10, width: 80, color: Colors.white,),
                                        subtitle: Container(height: 10, width: 80, color: Colors.white,),
                                        leading: Container(height: 50, width: 50, color: Colors.white,),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      })
              )
            ],
          )),
    );
  }
}
