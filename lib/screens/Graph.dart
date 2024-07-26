import 'package:flutter/material.dart';


class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Graphs',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
          centerTitle: true,
          bottom: TabBar(
            labelStyle:TextStyle(fontSize: 17,color: Colors.white) ,

            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Expense Graph',),
              Tab(text: 'Add Money Graph'),
            ],
          ),
        ),
        body: TabBarView(
          children: [

          ],
        ),
      ),
    );
  }
}
