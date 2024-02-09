import 'package:apiwork/MODELS/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryDetailsScreen extends StatefulWidget {

  //Initialized what we'll receive on this Screen//
  final Country country;
  const CountryDetailsScreen({super.key, required this.country});

  @override
  State<CountryDetailsScreen> createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Country Details', style: TextStyle(color:Colors.white,fontSize: 30),),centerTitle: true,backgroundColor: Colors.black,),
      body: Column(children: [
        SizedBox(width: double.infinity,
        height: 250,
        child: Hero(tag: widget.country.flag, child: SvgPicture.network(widget.country.flag, fit: BoxFit.cover,)),),
        Text(widget.country.name,style: const TextStyle(color:Colors.white,fontSize: 60),),
        Text(widget.country.iso2,style: const TextStyle(color:Colors.white,fontSize: 35),),
        Text(widget.country.iso3,style: const TextStyle(color:Colors.white,fontSize: 30),),
      ],),
    );
  }
}
