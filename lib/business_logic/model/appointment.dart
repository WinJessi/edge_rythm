import 'dart:convert';

import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:html_character_entities/html_character_entities.dart';

class Appointment {
  final int id;
  final Producers producer;
  final Map<String, dynamic> info;
  final String fulfilled;
  // final DateTime created;

  Appointment({
    this.id,
    this.fulfilled,
    this.info,
    this.producer,
    // this.created,
  });

  Appointment.fromJson(Map<String, dynamic> map)
      : id = map[AppointmentMap.id],
        producer = Producers.fromJson({
          ProducersMap.name: map[ProducersMap.name],
          ProducersMap.id: map[ProducersMap.id],
          ProducersMap.genre: map[ProducersMap.genre],
          ProducersMap.about: map[ProducersMap.about],
          ProducersMap.photo: map[ProducersMap.photo],
          ProducersMap.location: map[ProducersMap.location],
          ProducersMap.prices: map[ProducersMap.prices],
        }),
        info = json.decode(
          HtmlCharacterEntities.decode(map[AppointmentMap.info]),
        ),
        // created = DateTime.parse(map[AppointmentMap.created]),
        fulfilled = map[AppointmentMap.fulfil];

  // Map<String, dynamic> toJson() => {
  //       AppointmentMap.id: id,
  //       AppointmentMap.producer: producer,
  //       AppointmentMap.info: json.encode(info),
  //       AppointmentMap.fulfil: fulfilled,
  //     };
}

class AppointmentMap {
  static const id = 'id';
  static const producer = 'producer_id';
  static const info = 'appoinment_info';
  static const fulfil = 'fulfilled';
  static const created = 'created_at';
}
