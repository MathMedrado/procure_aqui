import 'package:flutter/foundation.dart';

class Product{
  int id;
  String nameProduct;
  int barCode;
  int categoryId;
  String imageUrl;
  DateTime creationDate;
  bool isVisible;
  double actualPrice;

  Product({
    required this.id,
    required this.nameProduct,
    required this.barCode,
    required this.categoryId,
    required this.imageUrl,
    required this.creationDate,
    required this.isVisible,
    required this.actualPrice
  });

  factory Product.fromJson(Map json){
    return Product(
      id: json['id'], 
      nameProduct: json['nameProduct'],
      barCode: json['barCode'], 
      categoryId: json['categoryId'], 
      imageUrl: json['imageUrl'], 
      creationDate: json['creationDate'],
      isVisible: json['isVisible'], 
      actualPrice:json['actualPrice']
    );
  }

  Map toJson(){
    return {
      'id' : id,
      'nameProduct' : nameProduct,
      'barCode' : barCode,
      'categoryId' : categoryId,
      'imageUrl': imageUrl,
      'creationDate' : creationDate,
      'isVisible' : isVisible,
      'actualPrice' : actualPrice

    };
  }


  int get getId{
    return id;
  }

  String get getNameProduct{
    return nameProduct;
  }

  int get getBarCode{
    return id;
  }  
  
  int get getCategoryId{
    return id;
  }

  String get getImageUrl{
    return imageUrl;
  }

  DateTime get getCreationDate{
    return creationDate;
  }

  bool get getIsVisible{
    return isVisible;
  }

  double get getActualPrice{
    return actualPrice;
  }




}