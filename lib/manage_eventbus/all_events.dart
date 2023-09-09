class AllProductsDetailsEvent {
  bool isNotify;
  Map<String, dynamic> mapData = {};

  AllProductsDetailsEvent(this.isNotify, this.mapData);
}

class RedeemPointEvent {
  bool isNotify;

  RedeemPointEvent(this.isNotify);
}
