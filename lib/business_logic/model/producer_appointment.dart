import 'dart:convert';

import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:html_character_entities/html_character_entities.dart';

class ProducerAppointment {
  final int id;
  final UserModel userModel;
  final Map<String, dynamic> info;
  final String fulfilled;

  ProducerAppointment({
    this.id,
    this.fulfilled,
    this.info,
    this.userModel,
  });

  ProducerAppointment.fromJson(Map<String, dynamic> map)
      : id = map[ProducerAppointmentMap.id],
        userModel = UserModel.fromJsonLocally({
          UserMap.name: map[UserMap.name],
          UserMap.email: map[UserMap.email],
          UserMap.phone: map[UserMap.phone],
          UserMap.role: map[UserMap.role],
        }),
        info = json.decode(
          HtmlCharacterEntities.decode(map[ProducerAppointmentMap.info]),
        ),
        fulfilled = map[ProducerAppointmentMap.fulfil];

  // Map<String, dynamic> toJson() => {
  //       AppointmentMap.id: id,
  //       AppointmentMap.producer: producer,
  //       AppointmentMap.info: json.encode(info),
  //       AppointmentMap.fulfil: fulfilled,
  //     };
}

class ProducerAppointmentMap {
  static const id = 'id';
  static const producer = 'producer_id';
  static const info = 'appoinment_info';
  static const fulfil = 'fulfilled';
  static const created = 'created_at';
}
