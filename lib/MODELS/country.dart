class Country
{
  late String name;
  late String flag;
  late String iso2;
  late String iso3;

  //Constructor
  Country({
    required this.name,
    required this.flag,
    required this.iso2,
    required this.iso3,
});

  //Helper function Map to Object
  
  Country.fromMap( Map<String, dynamic> map){
    name = map['name'];
    flag = map['flag'];
    iso2 = map['iso2'];
    iso3 = map['iso3'];
  }

}
