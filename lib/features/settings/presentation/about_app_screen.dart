import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../shared/widgets/app_widgets.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  String _version = '-';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = '${info.version}+${info.buildNumber}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(title: 'About App'),
      body: AppScaffoldPadding(
        child: ContentCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Student Movement - NDM',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text('Official member application for profile, notices, news, and hierarchy access.'),
              const SizedBox(height: 16),
              LabeledValueRow(label: 'Version', value: _version),
              const LabeledValueRow(label: 'Support', value: 'support@ndm.org'),
              const LabeledValueRow(label: 'Website', value: 'www.ndm.org'),
            ],
          ),
        ),
      ),
    );
  }
}
