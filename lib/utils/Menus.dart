import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wedding_planner/style/Theme.dart';
import 'package:wedding_planner/utils/Dialogs.dart';

Widget sideMenu(String route, argu ,String collection){
  return PopupMenuButton(
    itemBuilder: (context)=> <PopupMenuEntry>[
      PopupMenuItem(
          child: TextButton(
              onPressed: (){
                Navigator.pop(context);//close the popup menu
                Navigator.pushNamed(
                    context,
                    route,
                    arguments: argu
                );
              },
              child: const Text('Edit'))),
      PopupMenuItem(
          child: TextButton(
              onPressed: (){confirmDelete(context, argu,  collection);            },
              child: const Text('Delete'))),
    ],
  );
}

Widget inviteMenu(){
  return PopupMenuButton(
    child: Row(
      children: [
        Text('Send an invitation', style: TextStyle(color: gold, fontSize: 20),),
        const SizedBox(width: 4,),
        Icon(Icons.email, color: gold,),
        const SizedBox(width: 10,),
      ],
    ),

    //choose picture
    itemBuilder: (context)=> <PopupMenuEntry>[

      PopupMenuItem(
          child: TextButton(
              onPressed: (){Navigator.pop(context); shareInvite(context, 'invite/invitation_ar.png');},
              child: const Text('Arabic Invitation'))),
      PopupMenuItem(
          child: TextButton(
              onPressed: (){Navigator.pop(context); shareInvite(context, 'invite/invitation_fr.png');},
              child: const Text('French invitation'))),
    ],

  );
}


void shareInvite(BuildContext context, String file) async {
  final box = context.findRenderObject() as RenderBox?;
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final data = await rootBundle.load('assets/$file');
  final buffer = data.buffer;
  final shareResult = await Share.shareXFiles(
    [
      XFile.fromData(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        name: file,
        mimeType: 'image/png',
      ),
    ],
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );

  scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
}

SnackBar getResultSnackBar(ShareResult result) {
  return SnackBar(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        //Text("Share result: ${result.status}"),
        if (result.status == ShareResultStatus.success)
          const Text("Invitation is shared!")
        else
          const Text("Failed to share")
      ],
    ),
  );
}