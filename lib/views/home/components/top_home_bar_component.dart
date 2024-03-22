import 'package:billpe/views/notification/notification_router.dart';
import 'package:billpe/global/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class TopHomeBarComponent extends StatelessWidget {
  const TopHomeBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu,
              size: 28,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: () async {
                  HapticFeedback.selectionClick();
                  Prefs.clear();
                },
                child: const Icon(Icons.settings_outlined)),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                HapticFeedback.selectionClick();
                context.push(NotificationPath.notification);
              },
              child: const Icon(Icons.notifications_outlined),
            ),
          ],
        )
      ],
    );
  }
}
