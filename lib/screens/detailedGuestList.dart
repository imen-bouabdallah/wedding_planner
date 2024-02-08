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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
        child: Column(
          children: [
            Table(border: TableBorder.all(width: 2, color: Colors.brown),
             columnWidths: const <int, TableColumnWidth>{
               0: FlexColumnWidth(45),
               1: FlexColumnWidth(27),
               2: FlexColumnWidth(28)
             },
             children:  [
               TableRow(
                  children: [
                    Align(alignment: Alignment.centerRight,child: Text("Total  ", style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: gold),
                    )),
                    const Center(child: Text("55", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                    )),
                    const Center(child: Text("77", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                    )),
                  ]),
            ]),
            const SizedBox(height: 10,),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(width: 2, color: Colors.brown),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(45),
                    1: FlexColumnWidth(27),
                    2: FlexColumnWidth(28)
                  },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
