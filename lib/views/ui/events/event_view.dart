import 'package:edge_rythm/business_logic/model/ticket.dart';
import 'package:edge_rythm/business_logic/services/providers/ticket.dart';
import 'package:edge_rythm/views/ui/events/payment.dart';
import 'package:edge_rythm/views/ui/events/ticket.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/gradient_button.dart';

class EventViewScreen extends StatefulWidget {
  static const route = '/eventviewscreen';
  const EventViewScreen({Key key}) : super(key: key);

  @override
  _EventViewScreenState createState() => _EventViewScreenState();
}

class _EventViewScreenState extends State<EventViewScreen> {
  var _isLoading = false;

  paymentSuccessful(BuildContext context, id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<TicketProvider>(context, listen: false)
          .newTicket(id, generateBookingID(), context);
      Navigator.of(context)
          .pushReplacementNamed(TicketScreen.route, arguments: true);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      throw error;
    }
    setState(() {
      _isLoading = false;
    });
  }

  String generateBookingID() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  Widget build(BuildContext context) {
    var ticket = ModalRoute.of(context).settings.arguments as Ticket;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                child: Stack(
                  children: [
                    Hero(
                      tag: '#${ticket.id}',
                      child: FancyShimmerImage(
                        imageUrl: ticket.showBanner,
                        boxFit: BoxFit.cover,
                        width: double.infinity,
                        height: double.maxFinite,
                        shimmerBackColor: Color.fromRGBO(219, 165, 20, 1),
                        shimmerBaseColor: Color.fromRGBO(183, 134, 40, 1),
                      ),
                    ),
                    Container(color: Colors.black26),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  ticket.showTitle,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer),
                        SizedBox(width: 15),
                        Text(
                          ticket.showTime,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 15),
                        Text(
                          ticket.showDate,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_pin),
                        SizedBox(width: 15),
                        Text(
                          ticket.showAddress,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Details',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 15),
                    Text(
                      ticket.showDetail,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              PriceList(prices: ticket.priceList),
              SizedBox(height: 5),
              Tickets(ticket: ticket),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GradientRaisedButton(
                  child: Text(
                    'Proceed to payment',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(PaymentScreen.route)
                      .then((value) {
                    if (value) paymentSuccessful(context, ticket.id);
                  }),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
          if (_isLoading)
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Card(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.maxFinite,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Tickets extends StatefulWidget {
  const Tickets({
    Key key,
    this.ticket,
  }) : super(key: key);

  final Ticket ticket;

  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  var _tickets = 1;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<TicketProvider>(context, listen: false)
            .setPrice(TMap.ticket, widget.ticket));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tmap = Provider.of<TicketProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Number of tickets',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                height: 50,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {
                        setState(() {
                          _tickets += 1;
                        });
                        tmap.setPrice(TMap.howMany, _tickets);
                      },
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '$_tickets',
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: _tickets < 2
                          ? null
                          : () {
                              setState(() {
                                _tickets -= 1;
                              });
                              tmap.setPrice(TMap.howMany, _tickets);
                            },
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PriceList extends StatefulWidget {
  const PriceList({
    Key key,
    this.prices,
  }) : super(key: key);

  final List<dynamic> prices;

  @override
  _PriceListState createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  var _current = 0;
  @override
  void initState() {
    super.initState();
    setDefaultCost();
  }

  setDefaultCost() async {
    var tmap = Provider.of<TicketProvider>(context, listen: false);
    await tmap.setPrice(TMap.title, widget.prices.first[TMap.title]);
    tmap.setPrice(TMap.price, widget.prices.first[TMap.price]);
  }

  @override
  Widget build(BuildContext context) {
    var tmap = Provider.of<TicketProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Select price',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 15),
          Card(
            child: ExpansionTile(
              title: Text('Select from price list'),
              initiallyExpanded: true,
              children: [
                for (var i = 0; i < widget.prices.length; i++)
                  ListTile(
                    onTap: () {
                      tmap.setPrice(TMap.title, widget.prices[i][TMap.title]);
                      tmap.setPrice(TMap.price, widget.prices[i][TMap.price]);
                      setState(() {
                        _current = i;
                      });
                    },
                    tileColor: _current == i
                        ? Colors.blue.withOpacity(.3)
                        : Colors.transparent,
                    title: Text(
                        '${widget.prices[i][TMap.title]} ${widget.prices[i][TMap.price]}'),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
