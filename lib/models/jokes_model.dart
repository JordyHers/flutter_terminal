class ResultModel {
  bool? error;
  int? amount;
  List<Jokes>? jokes;

  ResultModel({this.error, this.amount, this.jokes});

  ResultModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    amount = json['amount'];
    if (json['jokes'] != null) {
      jokes = <Jokes>[];
      json['jokes'].forEach((v) {
        jokes!.add(new Jokes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['amount'] = this.amount;
    if (this.jokes != null) {
      data['jokes'] = this.jokes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jokes {
  String? category;
  String? type;
  String? setup;
  String? delivery;
  Flags? flags;
  int? id;
  bool? safe;
  String? lang;
  String? joke;

  Jokes(
      {this.category,
        this.type,
        this.setup,
        this.delivery,
        this.flags,
        this.id,
        this.safe,
        this.lang,
        this.joke});

  Jokes.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    setup = json['setup'];
    delivery = json['delivery'];
    flags = json['flags'] != null ? new Flags.fromJson(json['flags']) : null;
    id = json['id'];
    safe = json['safe'];
    lang = json['lang'];
    joke = json['joke'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['type'] = this.type;
    data['setup'] = this.setup;
    data['delivery'] = this.delivery;
    if (this.flags != null) {
      data['flags'] = this.flags!.toJson();
    }
    data['id'] = this.id;
    data['safe'] = this.safe;
    data['lang'] = this.lang;
    data['joke'] = this.joke;
    return data;
  }
  @override
  String toString() {
    return "category : $category \n setup: $setup  \n delivery: $delivery";
  }
}

class Flags {
  bool? nsfw;
  bool? religious;
  bool? political;
  bool? racist;
  bool? sexist;
  bool? explicit;

  Flags(
      {this.nsfw,
        this.religious,
        this.political,
        this.racist,
        this.sexist,
        this.explicit});

  Flags.fromJson(Map<String, dynamic> json) {
    nsfw = json['nsfw'];
    religious = json['religious'];
    political = json['political'];
    racist = json['racist'];
    sexist = json['sexist'];
    explicit = json['explicit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nsfw'] = this.nsfw;
    data['religious'] = this.religious;
    data['political'] = this.political;
    data['racist'] = this.racist;
    data['sexist'] = this.sexist;
    data['explicit'] = this.explicit;
    return data;
  }
}