import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/crop.dart';
import 'package:animate_do/animate_do.dart';

class CropDetailsScreen extends StatelessWidget {
  final Crop crop;

  const CropDetailsScreen({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    crop.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primary.withAlpha(40),
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 80, color: AppColors.primary),
                      ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black54, Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                crop.name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'عن المحصول',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.primary,
                              ),
                            ),
                            const Divider(),
                            Text(crop.description, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailSection(
                    context,
                    'موعد الزراعة',
                    crop.plantingTime,
                    Icons.calendar_today_rounded,
                    Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailSection(
                    context,
                    'نظام الري',
                    crop.irrigation,
                    Icons.water_drop_rounded,
                    Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailSection(
                    context,
                    'التسميد',
                    crop.fertilization,
                    Icons.grass_rounded,
                    Colors.green,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailSection(
                    context,
                    'أشهر الأمراض',
                    crop.diseases,
                    Icons.bug_report_rounded,
                    Colors.red,
                  ),
                  const SizedBox(height: 100), // Space for bottom
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('أضف إلى مزرعتي'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildDetailSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return FadeInUp(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withAlpha((0.1 * 255).toInt()),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(content, style: const TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
