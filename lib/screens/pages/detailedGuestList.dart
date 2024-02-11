import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Guest.dart';
import 'package:wedding_planner/classes/Helpers.dart';
import 'package:wedding_planner/style/Theme.dart';


class DetailedList extends StatefulWidget {
  const DetailedList({super.key});

  @override
  State<DetailedList> createState() => _DetailedListState();
}

class _DetailedListState extends State<DetailedList> {
  List<Guest> FamilyList = [], FriendsList = [], NeighborsList = [], OthersList = [] ;


  initLists() async{
    FamilyList = await getFamilyGuest();
    FriendsList = await getFriendsGuest();
    NeighborsList = await getNeighborsGuest();
  }
  @override
  void initState() {
    super.initState();
    initLists();
  }

  getFamilyGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Family').get();
    FamilyList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    return snapshot;
  }

  getNeighborsGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Neighbors').get();
    NeighborsList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    return snapshot;
  }
  getFriendsGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Friends').get();
    FriendsList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    return snapshot;
  }

  getOthersGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Others').get();
    OthersList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    initLists();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
        child: Column(
          children: [
            Table(border: TableBorder.all(width: 2, color: Colors.black38),
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
            Table(
              border: TableBorder.all(width: 2, color: Colors.black38),
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
              ],

            ),
            Expanded(
              flex : 1,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                     Table(
                       children: [
                         TableRow(
                           children: const [
                            Center(child: Text("Family", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),)
                           ],
                           decoration: BoxDecoration(
                             color: maize,
                           )
                         )
                       ],
                     ),
                      FutureBuilder(
                        future: getFamilyGuest(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData){
                            if(snapshot.connectionState == ConnectionState.done){
                              return Table(
                                  border: TableBorder.all(width: 2, color: Colors.black38),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FlexColumnWidth(45),
                                    1: FlexColumnWidth(27),
                                    2: FlexColumnWidth(28)
                                  },
                                  children: FamilyList.map((e) {
                                    return _buildGuestDetails(e);
                                  }).toList()
                              );
                            }
                          }
                          else if(snapshot.hasError){
                            print(snapshot.error.toString());
                          }
                          else {
                            return const CircularProgressIndicator();
                          }
                          return const SizedBox();
                        },

                      ),
                      Table(
                        children: [
                          TableRow(
                              children: const [
                                Center(child: Text("Friends", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),)
                              ],
                              decoration: BoxDecoration(
                                color: maize,
                              )
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: getFriendsGuest(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData){
                            if(snapshot.connectionState == ConnectionState.done){
                              return Table(
                                  border: TableBorder.all(width: 2, color: Colors.black38),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FlexColumnWidth(45),
                                    1: FlexColumnWidth(27),
                                    2: FlexColumnWidth(28)
                                  },
                                  children: FriendsList.map((e) {
                                    return _buildGuestDetails(e);
                                  }).toList()
                              );
                            }
                          }
                          else if(snapshot.hasError){
                            print(snapshot.error.toString());
                          }
                          else {
                            return const CircularProgressIndicator();
                          }
                          return const SizedBox();
                        },

                      ),
                      Table(
                        children: [
                          TableRow(
                              children: const [
                                Center(child: Text("Neighbors", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),)
                              ],
                              decoration: BoxDecoration(
                                color: maize,
                              )
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: getNeighborsGuest(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData){
                            if(snapshot.connectionState == ConnectionState.done){
                              return Table(
                                  border: TableBorder.all(width: 2, color: Colors.black38),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FlexColumnWidth(45),
                                    1: FlexColumnWidth(27),
                                    2: FlexColumnWidth(28)
                                  },
                                  children: NeighborsList.map((e) {
                                    return _buildGuestDetails(e);
                                  }).toList()
                              );
                            }
                          }
                          else if(snapshot.hasError){
                            print(snapshot.error.toString());
                          }
                          else {
                            return const CircularProgressIndicator();
                          }
                          return const SizedBox();
                        },

                      ),
                      Table(
                        children: [
                          TableRow(
                              children: const [
                                Center(child: Text("Others", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),)
                              ],
                              decoration: BoxDecoration(
                                color: maize,
                              )
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: getOthersGuest(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData){
                            if(snapshot.connectionState == ConnectionState.done){
                              return Table(
                                  border: TableBorder.all(width: 2, color: Colors.black38),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FlexColumnWidth(45),
                                    1: FlexColumnWidth(27),
                                    2: FlexColumnWidth(28)
                                  },
                                  children: OthersList.map((e) {
                                    return _buildGuestDetails(e);
                                  }).toList()
                              );
                            }
                          }
                          else if(snapshot.hasError){
                            print(snapshot.error.toString());
                          }
                          else {
                            return const CircularProgressIndicator();
                          }
                          return const SizedBox();
                        },

                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
  TableRow _buildGuestDetails(Guest guest) {

    return TableRow(
        children: [
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
                      guest.menNumber.toString(),
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
              Container(
                child: Center(
                    child: Text(
                      guest.womenNumber.toString(),
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            ]);


  }
}

