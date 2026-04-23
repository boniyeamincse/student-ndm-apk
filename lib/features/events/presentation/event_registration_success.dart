import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/domain/member_models.dart';
import '../../shared/widgets/app_widgets.dart';

class EventRegistrationSuccessScreen extends StatelessWidget {
  final EventItem event;
  const EventRegistrationSuccessScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.check_circle_outline, color: Colors.white, size: 80),
              const SizedBox(height: 16),
              const Text(
                'Registration Successful',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const Text(
                'You are confirmed for the event',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 40),
              
              // Entry Pass Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'DIGITAL ENTRY PASS',
                        style: TextStyle(color: AppColors.textLow, fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 2),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        event.title,
                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: AppColors.primary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.location,
                        style: const TextStyle(color: AppColors.textMedium, fontSize: 12),
                      ),
                      const SizedBox(height: 32),
                      
                      // QR Code Placeholder
                      Container(
                        width: 200,
                        height: 200,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border, width: 2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.qr_code_2, size: 170, color: Colors.black87),
                      ),
                      
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _PassDetail(label: 'Gate', value: '04A'),
                          _PassDetail(label: 'Seat', value: 'Open'),
                          _PassDetail(label: 'ID', value: 'NDM-EVT-09'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.l),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white24,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _PassDetail extends StatelessWidget {
  final String label;
  final String value;
  const _PassDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textLow, fontSize: 10, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(color: AppColors.textHigh, fontSize: 14, fontWeight: FontWeight.w900)),
      ],
    );
  }
}
