class MetalPrices {
  Prices? prices;
  String? currentTime;

  MetalPrices({this.prices, this.currentTime});

  MetalPrices.fromJson(Map<String, dynamic> json) {
    prices = json['prices'] != null ? Prices.fromJson(json['prices']) : null;
    currentTime = json['current_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (prices != null) {
      data['prices'] = prices!.toJson();
    }
    data['current_time'] = currentTime;
    return data;
  }
}

class Prices {
  Ounce? ounce;
  Ounce? gram;
  Ounce? hundredGram;
  Ounce? thousandGram;

  Prices({this.ounce, this.gram, this.hundredGram, this.thousandGram});

  Prices.fromJson(Map<String, dynamic> json) {
    ounce = json['ounce'] != null ? Ounce.fromJson(json['ounce']) : null;
    gram = json['gram'] != null ? Ounce.fromJson(json['gram']) : null;
    hundredGram = json['hundred_gram'] != null
        ? Ounce.fromJson(json['hundred_gram'])
        : null;
    thousandGram = json['thousand_gram'] != null
        ? Ounce.fromJson(json['thousand_gram'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ounce != null) {
      data['ounce'] = ounce!.toJson();
    }
    if (gram != null) {
      data['gram'] = gram!.toJson();
    }
    if (hundredGram != null) {
      data['hundred_gram'] = hundredGram!.toJson();
    }
    if (thousandGram != null) {
      data['thousand_gram'] = thousandGram!.toJson();
    }
    return data;
  }
}

class Ounce {
  double? silver;
  double? gold;
  double? platinum;

  Ounce({this.silver, this.gold, this.platinum});

  Ounce.fromJson(Map<String, dynamic> json) {
    silver = json['silver'];
    gold = json['gold'];
    platinum = json['platinum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['silver'] = silver;
    data['gold'] = gold;
    data['platinum'] = platinum;
    return data;
  }
}
