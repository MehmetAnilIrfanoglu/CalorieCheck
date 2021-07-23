
class API {
  int offset;
  int number;
  int totalResults;
  List<Results> results;

  API({
    this.offset,
    this.number,
    this.totalResults,
    this.results,
  });

  factory API.fromJson(Map<String, dynamic> json) => API(
    offset: json["offset"],
    totalResults: json["totalResults"],
    number: json["number"],
    results: List<Results>.from(json["results"].map((x) => Results.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "offset": offset,
    "totalResults": totalResults,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "number": number,
  };
}

class Results {
  String title;
  int id;
  Nutrition nutrition;

  Results({

    this.title,
    this.id,
    this.nutrition,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(

    title: json["title"],
    id: json["id"],
    nutrition: Nutrition.fromJson(json["nutrition"]),

  );

  Map<String, dynamic> toJson() => {

    "title": title,
    "id": id,
    "nutrition": nutrition.toJson(),
  };
}


class Nutrition {
  List nutrients;

  Nutrition({
    this.nutrients,

  });

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
    nutrients: List.from(json["nutrients"].map((x) => Nutrients.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nutrients": List<dynamic>.from(nutrients.map((x) => x.toJson())),

  };
}
class Nutrients {
  double amount;

  Nutrients({
    this.amount,

  });

  factory Nutrients.fromJson(Map<String, dynamic> json) => Nutrients(
    amount: json["amount"],

  );

  Map<String, dynamic> toJson() => {
    "amount": amount,

  };
}
