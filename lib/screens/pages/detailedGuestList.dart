import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Guest.dart';
import 'package:wedding_planner/utils/DBHelpers.dart';
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
    FamilyList.sort((a, b) {
      return a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase());
    });
    return snapshot;
  }

  getNeighborsGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Neighbors').get();
    NeighborsList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    NeighborsList.sort((a, b) {
      return a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase());
    });
    return snapshot;
  }
  getFriendsGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Friends').get();
    FriendsList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    FriendsList.sort((a, b) {
      return a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase());
    });
    return snapshot;
  }

  getFriendsKaisGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Friends Kais').get();
    FriendsList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    FriendsList.sort((a, b) {
      return a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase());
    });
    return snapshot;
  }

  getFriendsAhmedGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Friends Ahmed').get();
    FriendsList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    FriendsList.sort((a, b) {
      return a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase());
    });
    return snapshot;
  }

  getFriendsAmineGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Friends Amine').get();
    FriendsList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    FriendsList.sort((a, b) {
      return a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase());
    });
    return snapshot;
  }

  getFriendsImenGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Friends Imen').get();
    FriendsList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    FriendsList.sort((a, b) {
      return a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase());
    });
    return snapshot;
  }

  getFriendsKhaledGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Friends Khaled').get();
    FriendsList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    FriendsList.sort((a, b) {
      return a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase());
    });
    return snapshot;
  }

  getOthersGuest() async{
    final snapshot = await db_guest.where('type', isEqualTo: 'Others').get();
    OthersList = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
    OthersList.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
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
            FutureBuilder(
              future: getAllGuest(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.done) {

                    num men = 0, women = 0, total = 0;
                    for(var guest in snapshot.data){
                      men = men + guest.menNumber;
                      women += guest.womenNumber;

                    }
                    total = men + women;
                    return Table(
                        border: TableBorder.all(width: 2, color: Colors.black38),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(45),
                          1: FlexColumnWidth(27),
                          2: FlexColumnWidth(28)
                        },
                        children: [
                          TableRow(
                              children: [

                                Align(alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        Text("Total  ", style:
                                        TextStyle(fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: gold),
                                        ),
                                        Text("$total", style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20,),
                                        )
                                      ],
                                    )
                                ),
                                 Center(child: Text("$men", style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20,),
                                )),
                                Center(child: Text("$women", style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20,),
                                )),
                              ]),
                        ]);
                  }
                }
                else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                else {
                  return const CircularProgressIndicator();
                }
                return const SizedBox();
              },
            ),
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
                            return Text(snapshot.error.toString());
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
                                Center(child: Text("Friends Kais", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),)
                              ],
                              decoration: BoxDecoration(
                                color: maize,
                              )
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: getFriendsKaisGuest(),
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
                            return Text(snapshot.error.toString());
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
                                Center(child: Text("Friends Ahmed", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),)
                              ],
                              decoration: BoxDecoration(
                                color: maize,
                              )
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: getFriendsAhmedGuest(),
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
                            return Text(snapshot.error.toString());
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
                                Center(child: Text("Friends Amine", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),)
                              ],
                              decoration: BoxDecoration(
                                color: maize,
                              )
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: getFriendsAmineGuest(),
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
                            return Text(snapshot.error.toString());
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
                                Center(child: Text("Friends Imen", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),)
                              ],
                              decoration: BoxDecoration(
                                color: maize,
                              )
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: getFriendsImenGuest(),
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
                            return Text(snapshot.error.toString());
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
                                Center(child: Text("Friends Khaled", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),)
                              ],
                              decoration: BoxDecoration(
                                color: maize,
                              )
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: getFriendsKhaledGuest(),
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
                            return Text(snapshot.error.toString());
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
                            return Text(snapshot.error.toString());
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
                            return Text(snapshot.error.toString());
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

