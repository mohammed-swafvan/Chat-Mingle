import 'package:chat_mingle/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (context, notifier, _) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextField(
            onChanged: (value) {
              notifier.runFilter(value);
            },
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              border: InputBorder.none,
              hintText: 'Search User',
              hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    });
  }
}
