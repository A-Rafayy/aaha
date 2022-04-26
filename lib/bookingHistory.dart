import 'package:flutter/material.dart';
import './bookingHistoryHistory.dart';
import './bookingHistoryScheduled.dart';


class bookingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle : true,
            backgroundColor: Colors.transparent.withOpacity(0.5) ,
            title: Text('Bookings', textAlign: TextAlign.center,),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.history), text: "History"),
                Tab(icon: Icon(Icons.watch_later_outlined), text: "Scheduled")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              History(),
              Scheduled(),
            ],
          ),
        ),
      ),
    );
  }
}