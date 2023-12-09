import 'package:chat_mingle/provider/shared_pref_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.snap});
  final QueryDocumentSnapshot<Map<String, dynamic>> snap;

  @override
  Widget build(BuildContext context) {
    late BoxDecoration boxDecoration;
    late AlignmentGeometry align;

    return Consumer<SharedPrefNotifier>(builder: (context, sharePrefNotifier, _) {
      if (sharePrefNotifier.currentUser['user_name'] == snap['send_by']) {
        boxDecoration = BoxDecoration(
          color:
              Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(31, 102, 102, 102) : Colors.grey.shade300,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
            bottomRight: Radius.circular(0),
            bottomLeft: Radius.circular(14),
          ),
        );
        align = Alignment.centerRight;
      } else {
        boxDecoration = const BoxDecoration(
          color: Color.fromARGB(255, 235, 221, 239),
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 221, 203, 242), Color.fromARGB(255, 207, 214, 243)],
            begin: Alignment.topLeft,
            end: AlignmentDirectional.bottomEnd,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
            bottomRight: Radius.circular(14),
            bottomLeft: Radius.circular(0),
          ),
        );
        align = Alignment.centerLeft;
      }

      return Container(
        alignment: align,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: boxDecoration,
              child: Text(
                snap['message'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                snap['formated_time'],
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                      fontSize: 8,
                    ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
