import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../store/product_details_screen.dart';
import '../../models/product.dart';
import '../../services/gemini_service.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  bool _isAnalyzing = false;
  bool _showResult = false;
  File? _image;
  DiagnosisResult? _result;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _showResult = false;
      });
    }
  }

  void _onAnalyze() async {
    if (_image == null) return;
    
    setState(() {
      _isAnalyzing = true;
      _showResult = false;
    });

    try {
      final result = await GeminiService.diagnosePlant(_image!);
      if (mounted) {
        setState(() {
          _result = result;
          _isAnalyzing = false;
          _showResult = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ في التشخيص: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('تشخيص الأمراض'),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(12),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                border: Border.all(color: AppColors.primary.withAlpha(51), width: 2),
              ),
              child: Column(
                children: [
                  if (_image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover),
                    )
                  else
                    const Icon(Icons.camera_alt_rounded, size: 80, color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(
                    _image != null ? 'تم اختيار الصورة' : 'التقط صورة للنبات المصاب',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'تأكد من وجود إضاءة جيدة ووضوح للأجزاء المصابة',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.camera),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('كاميرا'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(120, 45),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library),
                        label: const Text('المعرض'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(120, 45),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            if (!_isAnalyzing && !_showResult)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _image == null ? null : _onAnalyze,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    side: const BorderSide(color: AppColors.primary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                  child: const Text(
                    'بدء التحليل الفوري', 
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                ),
              ),
            if (_isAnalyzing)
              Column(
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 16),
                  const Text('جاري تحليل الصورة بالذكاء الاصطناعي...', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            if (_showResult && _result != null)
              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  side: BorderSide(color: Colors.red.withAlpha(76)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'النتيجة المحتملة: ${_result!.name}',
                              style: const TextStyle(
                                color: Color(0xFFB71C1C),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      const Text(
                        'وصف المشكلة:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _result!.description,
                        style: const TextStyle(fontSize: 15, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'التوصية بالعلاج:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _result!.treatment,
                        style: const TextStyle(fontSize: 15, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final treatment = dummyProducts.firstWhere(
                              (p) => p.id == _result!.recommendedProductId,
                              orElse: () => dummyProducts[2], // Default to Fungicide
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(product: treatment),
                              ),
                            );
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text('شراء العلاج من المتجر'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade800,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
