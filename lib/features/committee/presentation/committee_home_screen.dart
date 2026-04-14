import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommitteeHomeScreen extends ConsumerWidget {
  const CommitteeHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Committee')),
      body: const Center(
        child: Text('Committee Assignments Placeholder'),
      ),
    );
  }
}
