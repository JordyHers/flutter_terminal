class JokeModel {
  String? category;
  String? type;
  String? joke;
  int? id;
  bool? safe;
  String? lang;

  JokeModel(
      {this.category, this.type, this.joke, this.id, this.safe, this.lang});

  JokeModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    joke = json['joke'];
    id = json['id'];
    safe = json['safe'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['type'] = this.type;
    data['joke'] = this.joke;
    data['id'] = this.id;
    data['safe'] = this.safe;
    data['lang'] = this.lang;
    return data;
  }
}