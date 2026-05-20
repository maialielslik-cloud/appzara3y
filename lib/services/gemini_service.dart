import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  // المفتاح الجديد الخاص بك تم وضعه وتفعيله بنجاح
  static const String _apiKey = 'AIzaSyDnhLouBgbmzEfwI3dj3zxOd3iuDaxdLYs';

  // تنظيف المفتاح من أي مسافات زائدة لضمان استقرار الاتصال
  static String get _cleanApiKey => _apiKey.trim();

  // التحقق من أن الحقل ليس فارغاً فقط
  static bool get _isKeyValid => _cleanApiKey.isNotEmpty && 
                                 _cleanApiKey != 'YOUR_GEMINI_API_KEY_HERE';

  static GenerativeModel _getModel(String modelName) {
    return GenerativeModel(
      model: modelName,
      apiKey: _cleanApiKey,
      // إضافة إعدادات الأمان لضمان تدفق المعلومات الزراعية التقنية دون حظر
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
      ],
    );
  }

  // Helper for generating content with fallback
  static Future<GenerateContentResponse> _generateWithFallback(List<Content> content) async {
    const timeoutDuration = Duration(seconds: 60); // زيادة المهلة لـ 60 ثانية للإجابات الطويلة
    try {
      // المحاولة الأولى: الموديل الأحدث (Gemini 2.5)
      final model = _getModel('gemini-2.5-flash');
      return await model.generateContent(content).timeout(timeoutDuration);
    } catch (e) {
      String err = e.toString().toLowerCase();
      // إذا كان الخطأ متعلق بالموديل نفسه، نجرب الموديل الاحترافي (Pro)
      if (err.contains('model') || err.contains('not found') || err.contains('404')) {
        try {
          final fallbackModel = _getModel('gemini-1.5-flash');
          return await fallbackModel.generateContent(content).timeout(timeoutDuration);
        } catch (e2) {
          rethrow; 
        }
      }
      rethrow; 
    }
  }

  // General Agricultural Chatbot
  static Future<String> getResponse(String query) async {
    if (!_isKeyValid) {
      return 'عذراً، يرجى إضافة مفتاح API Key الخاص بك في ملف gemini_service.dart لتفعيل الذكاء الاصطناعي.';
    }

    try {
      final content = [
        Content.text(
          'أنت خبير زراعي متميز. قدم نصيحة زراعية مفصلة وعملية للسؤال التالي باللغة العربية، مع التركيز على الخطوات والحلول: $query',
        ),
      ];
      final response = await _generateWithFallback(content);
      return response.text ?? 'لم أستطع الحصول على رد من الذكاء الاصطناعي حالياً.';
    } catch (e) {
      String errText = e.toString();
      if (errText.contains('TimeoutException')) {
        return 'عذراً، معالجة هذا السؤال التقني استغرقت وقتاً طويلاً. يرجى المحاولة مرة أخرى أو توضيح سؤالك.';
      }
      if (errText.contains('API_KEY_INVALID')) {
        return 'خطأ تقني: مفتاح API غير صحيح أو غير مفعل في Google AI Studio.';
      } else if (errText.contains('SocketException') || errText.contains('connection')) {
        return 'خطأ في الاتصال: يرجى التأكد من الإنترنت أو استخدام VPN إذا كانت الخدمة محجوبة.';
      } else if (errText.contains('403')) {
        return 'خطأ تقني (403): الوصول مرفوض. تأكد من تفعيل Gemini API في منطقتك.';
      } else if (errText.contains('model')) {
        return 'خطأ في الموديل: تم تحديث الخدمة لـ Gemini 2.5 ولكن حسابك يحتاج تفعيل الموديل ($errText).';
      }
      return 'مشكلة في الخدمة: $errText';
    }
  }

  // Plant Disease Diagnosis (Multimodal)
  static Future<DiagnosisResult> diagnosePlant(File image) async {
    if (!_isKeyValid) {
      return DiagnosisResult(
        name: 'يرجى وضع مفتاح API حقيقي',
        description: 'المفتاح الحالي غير فعال أو لم يتم إدخاله بشكل صحيح.',
        treatment: 'اذهب إلى ملف gemini_service.dart وادخل مفتاحك الخاص.',
        recommendedProductId: '3',
      );
    }

    try {
      final bytes = await image.readAsBytes();
      final content = [
        Content.multi([
          TextPart(
            '''حلل هذه الصورة لنبات مصاب. أعطني النتائج باللغة العربية في الصيغة التالية بدقة وبدون مقدمات:
1. اسم المرض (السطر الأول)
2. وصف للمشكلة (السطر الثاني)
3. التوصية بالعلاج وكيفية استخدامه (السطر الثالث)''',
          ),
          DataPart('image/jpeg', bytes),
        ]),
      ];

      final response = await _generateWithFallback(content);
      final text = response.text ?? '';

      final lines = text.split('\n').where((l) => l.trim().isNotEmpty).toList();

      String name = lines.isNotEmpty
          ? lines[0].replaceFirst(RegExp(r'^\d+\.\s*'), '').trim()
          : 'غير معروف';
      String description = lines.length > 1
          ? lines[1].replaceFirst(RegExp(r'^\d+\.\s*'), '').trim()
          : 'لا يوجد وصف متاح';
      String treatment = lines.length > 2
          ? lines[2].replaceFirst(RegExp(r'^\d+\.\s*'), '').trim()
          : 'لا توجد توصية محددة';

      // Advanced keyword matching for store products
      String recommendedProductId = '3'; // Default to Fungicide if unclear
      if (treatment.contains('سماد') || description.contains('تسميد')) {
        recommendedProductId = '2';
      }
      if (treatment.contains('بذور') || description.contains('بيدر')) {
        recommendedProductId = '1';
      }
      if (treatment.contains('رشاش') || treatment.contains('ري')) {
        recommendedProductId = '4';
      }

      return DiagnosisResult(
        name: name,
        description: description,
        treatment: treatment,
        recommendedProductId: recommendedProductId,
      );
    } catch (e) {
      return DiagnosisResult(
        name: 'فشل في التشخيص',
        description: 'خطأ تقني في الموديل: $e',
        treatment: 'تأكد من جودة الصورة ومن صلاحية مفتاح الـ API وتفعيله.',
        recommendedProductId: '3',
      );
    }
  }
}

class DiagnosisResult {
  final String name;
  final String description;
  final String treatment;
  final String recommendedProductId;

  DiagnosisResult({
    required this.name,
    required this.description,
    required this.treatment,
    required this.recommendedProductId,
  });
}
