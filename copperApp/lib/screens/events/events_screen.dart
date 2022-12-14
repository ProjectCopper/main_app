import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dating_app/screens/screens.dart';
import '/blocs/blocs.dart';
import '/models/models.dart';
import '/widgets/widgets.dart';
import '/models/event_model.dart';

class EventScreen extends StatelessWidget {
  static const String routeName = '/events';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => EventScreen(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'EVENTS'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Events',
                style: Theme.of(context).textTheme.headline4,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  /// itemCount: events.length,
                  itemBuilder: (context, index) 
                  {
                    return InkWell(
                      ///onTap: () {
                        ///Navigator.pushNamed(context, '/eventCard',
                            ///arguments: Events[index]);
                      ///},
                      child: Row(
                        children: [
                          events.small(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            height: 70,
                            width: 70,
                            url: events[index].eventId[0],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                events[index].eventLocation,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(height: 5),
                              Text(
                                events[index].dateTime
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 5),
                              Text(
                                events[index].info!
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}