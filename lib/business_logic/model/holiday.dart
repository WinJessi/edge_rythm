class Holiday {
  final String name;
  final String date;
  final String weekDay;

  Holiday({
    this.name,
    this.date,
    this.weekDay,
  });

  Holiday.fromJson(Map<String, dynamic> map)
      : name = map[HolidayMap.name],
        date = map[HolidayMap.date],
        weekDay = map[HolidayMap.week];
}

class HolidayMap {
  static const name = 'name';
  static const date = 'date';
  static const week = 'week_day';
}
