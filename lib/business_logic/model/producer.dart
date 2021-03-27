class Producers {
  final int id;
  final String name;
  final String genre;
  final String about;
  final String photo;
  final String location;
  final List<dynamic> prices;

  Producers({
    this.about,
    this.genre,
    this.id,
    this.photo,
    this.location,
    this.name,
    this.prices,
  });

  Producers.fromJson(Map<String, dynamic> map)
      : id = map[ProducersMap.id],
        name = map[ProducersMap.name],
        genre = map[ProducersMap.genre],
        photo = map[ProducersMap.photo],
        location = map[ProducersMap.location],
        prices = [
          {'session': 'Reharsal', 'price': '500'},
          {'session': 'Live', 'price': '1000'},
          {'session': 'Live streaming', 'price': '1500'},
          {'session': 'Recording', 'price': '2000'},
        ],
        about = map[ProducersMap.about];
}

class ProducersMap {
  static const id = 'id';
  static const name = 'name';
  static const genre = 'genre';
  static const location = 'location';
  static const about = 'about';
  static const prices = 'price_list';
  static const photo = 'photo';
}
