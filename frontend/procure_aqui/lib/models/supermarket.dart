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