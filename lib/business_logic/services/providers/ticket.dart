import 'package:dio/dio.dart';
import 'package:edge_rythm/business_logic/model/myticket.dart';
import 'package:edge_rythm/business_logic/model/ticket.dart';
import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:edge_rythm/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

BaseOptions options = new BaseOptions(
  baseUrl: dotenv.env['BASE_URL'],
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = new Dio(options);

class TicketProvider with ChangeNotifier {
  List<Ticket> utickets = [];
  List<Ticket> ptickets = [];
  Map<String, dynamic> tickets = {
    TMap.title: '',
    TMap.price: '',
    TMap.howMany: 1,
    TMap.ticket: null,
  };

  get price {
    return tickets;
  }

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(UserMap.token);
  }

  Future<void> upcomingEvents(BuildContext context) async {
    utickets.clear();
    try {
      var response = await dio.get('/ticket/');
      var res = (response.data) as List<dynamic>;
      res.forEach((element) {
        var model = Ticket.fromJson(element);
        utickets.add(model);
      });
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        timeOut(context);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> popularEvents(BuildContext context) async {
    ptickets.clear();
    try {
      var response = await dio.get('/ticket/popular');
      var res = (response.data) as List<dynamic>;
      res.forEach((element) {
        var model = Ticket.fromJson(element);
        ptickets.add(model);
      });
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        timeOut(context);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future setPrice(key, value) async {
    tickets.update(key, (_) => value);
    notifyListeners();
  }

  Future<void> newTicket(id, booking, BuildContext context) async {
    myTickets.clear();
    getToken().then((token) async {
      try {
        var response = await dio.post('/tickets/add',
            data: {
              MyTicketMap.ticket_id: '$id',
              MyTicketMap.ticket_type: tickets[TMap.title],
              MyTicketMap.booking_id: '$booking',
              MyTicketMap.how_many: '${tickets[TMap.howMany]}',
            },
            options: Options(headers: {'Authorization': '$token'}));

        var data = (response.data);
        myTickets.add(MyTicket.fromJson(data));
        notifyListeners();
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          timeOut(context);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }
    });
  }

  List<MyTicket> myTickets = [];
  Future<void> fetchMyTickets(BuildContext context) async {
    myTickets.clear();
    getToken().then((token) async {
      try {
        var response = await dio.get(
          '/tickets/all',
          options: Options(headers: {'Authorization': '$token'}),
        );

        var data = (response.data) as List<dynamic>;
        data.forEach((element) {
          myTickets.add(MyTicket.fromJson(element));
        });

        notifyListeners();
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          timeOut(context);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }
    });
  }

  Future<void> deleteTicket(var id, BuildContext context) async {
    getToken().then((token) async {
      try {
        await dio.delete(
          '/tickets/$id',
          options: Options(headers: {'Authorization': '$token'}),
        );
        myTickets.removeWhere((element) => element.id == id);
        notifyListeners();
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          timeOut(context);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }
    });
  }
}

class TMap {
  static const title = 'title';
  static const price = 'price';
  static const howMany = 'how_many';
  static const ticket = 'ticket';
}
