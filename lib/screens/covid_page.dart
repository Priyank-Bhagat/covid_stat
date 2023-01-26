import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/bloc/covid_bloc.dart';



/*
class CovidPage extends StatefulWidget {
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  final CovidBloc _newsBloc = CovidBloc();

  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('COVID-19 List')),
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<CovidBloc, CovidState>(
          listener: (context, state) {
            if (state is CovidError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidInitial) {
                return _buildLoading();
              } else if (state is CovidLoading) {
                return _buildLoading();
              } else if (state is CovidLoaded) {
                return _buildCard(context, state.covidModel);
              } else if (state is CovidError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CovidModel model) {
    return ListView.builder(
      itemCount: model.countries!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Country: ${model.countries![index].country}"),
                  Text(
                      "Total Confirmed: ${model.countries![index].totalConfirmed}"),
                  Text("Total Deaths: ${model.countries![index].totalDeaths}"),
                  Text(
                      "Total Recovered: ${model.countries![index].totalRecovered}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
*/


class CovidPage extends StatefulWidget {
  const CovidPage({Key? key}) : super(key: key);

  @override
  State<CovidPage> createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  final CovidBloc _newsBloc = CovidBloc();


  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    super.initState();
  }

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Covid-19 Data')),
      body: Container(
        child: BlocProvider(
          create: (_) => _newsBloc,
          child: BlocConsumer<CovidBloc, CovidState>(
            listener: (context, state) {
              if (state is CovidError){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)));
              }
            },
            builder: (context, state) {
              if (state is CovidLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              else if (state is CovidLoaded){
                return ListView.builder(
                  itemCount: state.covidModel.countries!.length,
                    itemBuilder: (context, index) {
                      return  Container(
                        padding: EdgeInsets.all(deviceHeight(context)*0.01),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.only(bottom: deviceHeight(context)*0.025),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: deviceHeight(context)*0.05,
                                  backgroundImage: NetworkImage('https://countryflagsapi.com/png/${state.covidModel.countries![index].country}'),
                                ),
                                SizedBox(height: deviceHeight(context)*0.015,),
                                Text("Country: ${state.covidModel.countries![index].country}",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: deviceHeight(context)*0.005,),
                                Text("Total Confirmed: ${state.covidModel.countries![index].totalConfirmed}",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: deviceHeight(context)*0.005,),
                                Text("Total Deaths: ${state.covidModel.countries![index].totalDeaths}",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: deviceHeight(context)*0.005,),
                                Text("Total Recovered: ${state.covidModel.countries![index].totalRecovered}",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
              }
              return Text('nothing');
            },
          ),
        ),
      ),
    );
  }
}