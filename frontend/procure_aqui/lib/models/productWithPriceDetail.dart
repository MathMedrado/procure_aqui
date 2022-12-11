import 'package:flutter/foundation.dart';
import 'package:procure_aqui/models/supermarket.dart';

class ProductWithPrice{
  int id;
  String nameProduct;
  int barCode;
  String category;
  String imageUrl;
  DateTime creationDate;
  bool isVisible;
  double actualPrice;
  double avaragePrice;
  double minimunPrice;
  Supermarket supermarket;

  ProductWithPrice({
    required this.id,
    required this.nameProduct,
    required this.barCode,
    required this.category,
    required this.imageUrl,
    required this.creationDate,
    required this.isVisible,
    required this.actualPrice,
    required this.avaragePrice,
    required this.minimunPrice,
    required this.supermarket
  });

  //
  // factory Product.fromJson(Map json){
  //   return Product(
  //     id: json['id'],
  //     nameProduct: json['nameProduct'],
  //     barCode: json['barCode'],
  //     categoryId: json['categoryId'],
  //     imageUrl: json['imageUrl'],
  //     creationDate: json['creationDate'],
  //     isVisible: json['isVisible'],
  //     actualPrice:json['actualPrice']
  //   );
  // }

  Map toJson(){
    return {
      'id' : id,
      'nameProduct' : nameProduct,
      'barCode' : barCode,
      'category' : category,
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
    return barCode;
  }  
  
  String get getCategory{
    return category;
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

  double get getAveragePrice{
    return avaragePrice;
  }

  double get getMinimunPrice{
    return minimunPrice;
  }


}