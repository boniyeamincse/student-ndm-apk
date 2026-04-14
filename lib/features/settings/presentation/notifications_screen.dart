import 'package:flutter/material.dart';

import '../../shared/widgets/app_widgets.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimaryAppBar(title: 'Notifications'),
      body: AppScaffoldPadding(
        child: AppEmptyState(
          title: 'No Notifications Yet',
          subtitle: 'Push notifications will be enabled in a future release.',
          icon: Icons.notifications_none,
        ),
      ),
    );
  }
}
