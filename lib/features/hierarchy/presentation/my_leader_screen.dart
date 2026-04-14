import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/providers/member_providers.dart';
import '../../shared/widgets/app_widgets.dart';

class MyLeaderScreen extends ConsumerWidget {
  const MyLeaderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderAsync = ref.watch(leaderProvider);

    return Scaffold(
      appBar: const PrimaryAppBar(title: 'My Leader'),
      body: AppScaffoldPadding(
        child: leaderAsync.when(
          data: (leader) {
            if (leader == null) {
              return const AppEmptyState(
                title: 'No Leader Assigned',
                subtitle: 'Your reporting leader is not assigned yet.',
              );
            }
            return ContentCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AvatarWidget(imageUrl: leader.photoUrl, fallback: leader.name),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(leader.name,
                                style: Theme.of(context).textTheme.titleMedium),
                            Text(leader.position),
                            Text(leader.committee),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LabeledValueRow(label: 'Relation', value: leader.relationType),
                  LabeledValueRow(label: 'Phone', value: leader.phone ?? 'Not shared'),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => AppErrorState(message: e.toString()),
        ),
      ),
    );
  }
}
