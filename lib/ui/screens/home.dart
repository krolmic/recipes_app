import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 2.0,
            bottom: TabBar(
              labelColor: Theme.of(context).indicatorColor,
              tabs: [
                Tab(icon: Icon(Icons.restaurant, size: 20.0)),
                Tab(icon: Icon(Icons.local_drink, size: 20.0)),
                Tab(icon: Icon(Icons.favorite, size: 20.0)),
                Tab(icon: Icon(Icons.settings, size: 20.0)),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: TabBarView(
            children: [
              Center(child: Icon(Icons.restaurant, size: 20.0)),
              Center(child: Icon(Icons.restaurant, size: 20.0)),
              Center(child: Icon(Icons.restaurant, size: 20.0)),
              Center(child: Icon(Icons.restaurant, size: 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}
