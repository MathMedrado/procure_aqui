class Supermarket{
  int id;
  String nameSupermarket;
  String city;
  String street;
  String district;
  String complement;

  Supermarket({
    required this.id,
    required this.nameSupermarket,
    required this.city,
    required this.street,
    required this.district,
    required this.complement
  });

  int get getId{
    return id;
  }

  String get getNameSupermarket{
    return nameSupermarket;
  }

  String get getCity{
    return city;
  }

  String get getStreet{
    return street;
  }

  String? get getDistrict{
    return district;
  }

  String get getComplement{
    return complement;
  }

  factory Supermarket.fromJson(Map json){
    return Supermarket(
      id: json['id'], 
      nameSupermarket: json['nameSupermarket'], 
      city: json['city'], 
      street: json['street'], 
      district: json['district'], 
      complement: json['complement']
    );
  }

  Map toJson(){
    return{
      'id' : id,
      'nameSupermarket' : nameSupermarket,
      'city' : city,
      'street' : street,
      'district' : district,
      'complement' : complement
    };
  }

}