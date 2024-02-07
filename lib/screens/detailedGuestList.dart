import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Guest.dart';
import 'package:wedding_planner/style/Theme.dart';


class DetailedList extends StatelessWidget {
  const DetailedList({super.key});

  TableRow _buildGuestDetails(Guest guest) {
    return TableRow(children: [
      Container(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          guest.name,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      Container(
        child: Center(
            child: Text(
          guest.womenNumber.toString(),
          style: const TextStyle(fontSize: 20),
        )),
      ),
      Container(
        child: Center(
            child: Text(
          guest.menNumber.toString(),
          style: const TextStyle(fontSize: 20),
        )),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Guest mperson = Guest("lala", 'Family');
    mperson.menNumber = 4;
    mperson.womenNumber = 55;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
          child: Column(
            children: [
              Table(border: TableBorder.all(width: 2), children: const [
                 TableRow(
                    children: [
                      Align(alignment: Alignment.centerRight,child: Text("total  ")),
                      Center(child: Text("55")),
                      Center(child: Text("77")),
                    ]),
              ]),
              const SizedBox(height: 10,),
              Table(
                border: TableBorder.all(width: 2, color: Colors.brown),
                children: [
                 TableRow(
                      children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Guest Name",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: gold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Men N°",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: gold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      child:  Text(
                        "Women N°",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: gold),
                      ),
                    ),
                  ]),

                  const TableRow(children: [
                    Text("Guest"),
                    Text("5"),
                    Text("6"),
                  ]),
                  const TableRow(children: [
                    Text("someone"),
                    Text("9"),
                    Text("6"),
                  ]),
                  _buildGuestDetails(mperson),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
