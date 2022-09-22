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
}