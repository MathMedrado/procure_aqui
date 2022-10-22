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