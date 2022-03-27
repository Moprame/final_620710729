
class Game{
  final String image_url;
  final int answer;
  final List choice_list;

  Game({
    required this.image_url,
    required this.answer,
    required this.choice_list,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      image_url:  json["image_url"],
      answer:   json["answer"],
      choice_list:   (json['choice_list'] as List).map((choice) => choice).toList() ,
    );
  }
}