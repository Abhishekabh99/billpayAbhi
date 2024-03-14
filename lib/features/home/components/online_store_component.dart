import 'package:flutter/material.dart';

class OnlineStoreComponent extends StatefulWidget {
  const OnlineStoreComponent({super.key});

  @override
  State<OnlineStoreComponent> createState() => _OnlineStoreComponentState();
}

class _OnlineStoreComponentState extends State<OnlineStoreComponent> {
  bool isOnlineStore = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Online Store",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: isOnlineStore,
                onChanged: (value) {
                  if (context.mounted) {
                    setState(() {
                      isOnlineStore = value;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            SizedBox(
              width: 220,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                value: "Order Notification",
                items: [
                  "Order Notification",
                  "All Notification",
                ]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {},
              ),
            ),
          ],
        )
      ],
    );
  }
}
