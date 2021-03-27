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
          {
            'title': 'Rehearsal session',
            'sessions': [
              {
                'session': 'Half session(3hrs)',
                'price': '10000',
              },
              {
                'session': 'Full session(6hrs)',
                'price': '25000',
              },
            ],
          },
          {
            'title': 'Live recording session',
            'sessions': [
              {
                'session': '6hours full session',
                'price': '50000',
              },
              {
                'session': '3hours half session',
                'price': '25000',
              },
              {
                'session': 'Mixing & mastering',
                'price': '50000',
              },
            ],
          },
          {
            'title': 'Digital recording session',
            'sessions': [
              {
                'session': '6hours full session',
                'price': '30000',
              },
              {
                'session': '3hours half session',
                'price': '15000',
              },
              {
                'session': 'Mixing & mastering',
                'price': '30000',
              },
            ],
          },
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
