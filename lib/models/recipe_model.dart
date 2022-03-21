class RecipeResponse {
  late String q;
  late int from;
  late int to;
  late bool more;
  late int count;
  late List<Hits> hits;

  RecipeResponse({required this.q, required this.from, required this.to, required this.more, required this.count, required this.hits});

  RecipeResponse.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    from = json['from'];
    to = json['to'];
    more = json['more'];
    count = json['count'];
    if (json['hits'] != null) {
      hits = <Hits>[];
      json['hits'].forEach((v) {
        hits.add(new Hits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hits != null) {
      data['hits'] = this.hits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hits {
  late Recipe recipe;

  Hits({required this.recipe});

  Hits.fromJson(Map<String, dynamic> json) {
    recipe = Recipe.fromJson(json['recipe']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recipe != null) {
      data['recipe'] = this.recipe.toJson();
    }
    return data;
  }
}

class Recipe {
  String? uri;
  late String label;
  late String image;
  late String source;
  late String url;
  String? shareAs;
  // int? yield;
  List<String>? dietLabels;
  List<String>? healthLabels;
  List<String>? cautions;
  List<String>? ingredientLines;
  // List<Ingredients>? ingredients;
  // double? calories;
  // double? totalWeight;
  // int? totalTime;
  List<String>? cuisineType;
  List<String>? mealType;
  List<String>? dishType;

  Recipe(
      {this.uri,
        required this.label,
        required this.image,
        required this.source,
        required this.url,
        this.shareAs,
        // this.yield,
        this.dietLabels,
        this.healthLabels,
        this.cautions,
        this.ingredientLines,
        // this.ingredients,
        // this.calories,
        // this.totalWeight,
        // this.totalTime,
        this.cuisineType,
        this.mealType,
        this.dishType});

  Recipe.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    label = json['label'];
    image = json['image'];
    source = json['source'];
    url = json['url'];
    shareAs = json['shareAs'];
    // yield = json['yield'];
    dietLabels = json['dietLabels'].cast<String>();
    healthLabels = json['healthLabels'].cast<String>();
    cautions = json['cautions'].cast<String>();
    ingredientLines = json['ingredientLines'].cast<String>();
    // if (json['ingredients'] != null) {
    //   ingredients = <Ingredients>[];
    //   json['ingredients'].forEach((v) {
    //     ingredients!.add(new Ingredients.fromJson(v));
    //   });
    // }
    // calories = json['calories'];
    // totalWeight = json['totalWeight'];
    // totalTime = json['totalTime'];
    cuisineType = json['cuisineType'].cast<String>();
    mealType = json['mealType'].cast<String>();
    dishType = json['dishType'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this.uri;
    data['label'] = this.label;
    data['image'] = this.image;
    data['source'] = this.source;
    data['url'] = this.url;
    data['shareAs'] = this.shareAs;
    // data['yield'] = this.yield;
    data['dietLabels'] = this.dietLabels;
    data['healthLabels'] = this.healthLabels;
    data['cautions'] = this.cautions;
    data['ingredientLines'] = this.ingredientLines;
    // if (this.ingredients != null) {
    //   data['ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    // }
    // data['calories'] = this.calories;
    // data['totalWeight'] = this.totalWeight;
    // data['totalTime'] = this.totalTime;
    data['cuisineType'] = this.cuisineType;
    data['mealType'] = this.mealType;
    data['dishType'] = this.dishType;
    return data;
  }
}

// class Ingredients {
//   String? text;
//   double? quantity;
//   String? measure;
//   String? food;
//   double? weight;
//   String? foodCategory;
//   String? foodId;
//   String? image;
//
//   Ingredients(
//       {this.text,
//         this.quantity,
//         this.measure,
//         this.food,
//         this.weight,
//         this.foodCategory,
//         this.foodId,
//         this.image});
//
//   Ingredients.fromJson(Map<String, dynamic> json) {
//     text = json['text'];
//     quantity = json['quantity'];
//     measure = json['measure'];
//     food = json['food'];
//     weight = json['weight'];
//     foodCategory = json['foodCategory'];
//     foodId = json['foodId'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['text'] = this.text;
//     data['quantity'] = this.quantity;
//     data['measure'] = this.measure;
//     data['food'] = this.food;
//     data['weight'] = this.weight;
//     data['foodCategory'] = this.foodCategory;
//     data['foodId'] = this.foodId;
//     data['image'] = this.image;
//     return data;
//   }
// }