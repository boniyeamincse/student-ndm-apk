import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/providers/member_providers.dart';
import '../../shared/widgets/app_widgets.dart';

class MySubordinatesScreen extends ConsumerWidget {
  const MySubordinatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subsAsync = ref.watch(subordinatesProvider);

    return Scaffold(
      appBar: const PrimaryAppBar(title: 'My Subordinates'),
      body: AppScaffoldPadding(
        child: subsAsync.when(
          data: (subs) {
            if (subs.isEmpty) {
              return const AppEmptyState(
                title: 'No Subordinates',
                subtitle: 'You do not have subordinate members assigned yet.',
              );
            }
            return ListView.separated(
              itemCount: subs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = subs[index];
                return ContentCard(
                  child: Row(
                    children: [
                      AvatarWidget(imageUrl: item.photoUrl, fallback: item.name),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: Theme.of(context).textTheme.titleSmall),
                            Text(item.position),
                            Text(item.committee),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => AppErrorState(message: e.toString()),
        ),
      ),
    );
  }
}
