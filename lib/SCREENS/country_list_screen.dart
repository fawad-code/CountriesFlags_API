import 'dart:convert';
import 'package:apiwork/SCREENS/country_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../MODELS/country.dart';
import 'package:http/http.dart' as http;

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late Future<List<Country>> _countriesFuture;
  late List<Country> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _countriesFuture = getAllCountries();
  }

  Future<List<Country>> getAllCountries() async {
    String url = 'https://countriesnow.space/api/v0.1/countries/flag/images';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      var jsonList = jsonResponse['data'];

      List<Country> countries = [];

      for (var countryMap in jsonList) {
        Country country = Country.fromMap(countryMap);
        countries.add(country);
      }
      _filteredCountries = countries;
      return countries;
    }
    return <Country>[];
  }

  void _searchCountry(String query) {
    setState(() {
      _filteredCountries = _filteredCountries.where((country) {
        return country.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade200,
        title: const Text(
          'Countries List',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              cursorColor: Colors.deepPurple,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Search',
                hintText: 'Search for a country',
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: _searchCountry,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Country>>(
              future: _countriesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(child: Text('Something Went Wrong'));
                  } else {
                    return ListView.builder(
                      itemCount: _filteredCountries.length,
                      itemBuilder: (context, index) {
                        Country country = _filteredCountries[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return CountryDetailsScreen(country: country);
                              },
                            ));
                          },
                          child: Container(
                            color: Colors.green.shade50,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 100,
                                  child: Hero(
                                    tag: country.flag,
                                    child: SvgPicture.network(
                                      country.flag,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 125,
                                  child: Text(
                                    country.name,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
