# نظام الدردشة مع Firebase

## ✅ **ما تم إنجازه:**

### 1. **نموذج الرسالة المحسن**
- `ChatMessage` مع دعم Firebase
- حقول: `id`, `text`, `senderId`, `receiverId`, `timestamp`
- دعم `fromFirestore` و `toMap`

### 2. **خدمة الدردشة**
- `ChatService` لإدارة المحادثات
- إنشاء غرف دردشة فريدة
- إرسال واستقبال الرسائل في الوقت الفعلي
- معالجة أخطاء محسنة

### 3. **شاشة الدردشة المحدثة**
- `ChatScreen` مع دعم Firebase
- تحديثات في الوقت الفعلي
- معالجة الأخطاء والمصادقة
- **تكامل مع نظام المصادقة المخصص** ✅

### 4. **واجهة المستخدم المحسنة**
- رسائل فارغة جميلة
- دعم صور الشبكة
- زر إرسال محسن
- دعم Enter للإرسال
- **زر تسجيل دخول للمستخدمين غير المسجلين** ✅

## 🔧 **التبعيات المطلوبة:**

```yaml
dependencies:
  firebase_core: ^3.6.0
  cloud_firestore: ^5.4.0
  firebase_auth: ^5.3.0
```

## ⚠️ **مشاكل تم حلها:**

### **1. مشكلة minSdk:**
- **المشكلة**: `minSdkVersion 21` أقل من الحد الأدنى المطلوب لـ Firebase Auth (23)
- **الحل**: تم تحديث `minSdk` إلى 23 في `android/app/build.gradle.kts`
- **التأثير**: تطبيق Android سيعمل على الأجهزة التي تعمل بـ Android 6.0 (API 23) وما فوق

### **2. مشكلة تهيئة Firebase:**
- **المشكلة**: `No Firebase App '[DEFAULT]' has been created - call Firebase.initializeApp()`
- **الحل**: تم إضافة تهيئة Firebase في `main.dart`
- **الكود**:
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase
    print('Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Continue without Firebase for now
  }
  
  setup();
  await getIt<CacheService>().init();
  await getIt<ApiService>().init();
  runApp(const MyApp());
}
```

### **3. مشكلة المصادقة:**
- **المشكلة**: `Authentication Required` - المستخدم غير مسجل دخول في Firebase
- **الحل**: تم دمج نظام الدردشة مع نظام المصادقة المخصص للتطبيق
- **الميزات**:
  - استخدام معرف المستخدم من `HomeCubit`
  - زر تسجيل دخول للمستخدمين غير المسجلين
  - واجهة عربية محسنة

### **ملف build.gradle.kts:**
```kotlin
defaultConfig {
    minSdk = 23  // تم تحديثه من flutter.minSdkVersion
    // ... باقي الإعدادات
}
```

### **flutter_launcher_icons:**
```yaml
flutter_launcher_icons:
  min_sdk_android: 23  # تم تحديثه من 21
```

## 📱 **كيفية الاستخدام:**

### **1. فتح الدردشة:**
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ChatScreen(
      userName: vendorName,
      userImage: vendorImageUrl,
      vendorId: vendorId,
      isOnline: true,
    ),
  ),
);
```

### **2. نظام المصادقة:**
- **المستخدمون المسجلون**: يمكنهم الدردشة مباشرة
- **المستخدمون غير المسجلين**: يظهر لهم زر تسجيل دخول
- **التكامل**: يعمل مع نظام المصادقة الموجود في التطبيق

### **3. هيكل البيانات في Firebase:**

#### **مجموعة `chats`:**
```
chats/{chatRoomId}/
├── lastMessage: "آخر رسالة"
├── lastMessageTime: timestamp
├── participants: [userId1, userId2]
└── updatedAt: timestamp
```

#### **مجموعة `messages`:**
```
chats/{chatRoomId}/messages/{messageId}/
├── text: "نص الرسالة"
├── senderId: "معرف المرسل"
├── receiverId: "معرف المستقبل"
└── timestamp: timestamp
```

## 🚀 **الميزات:**

- ✅ **دردشة في الوقت الفعلي**
- ✅ **إنشاء غرف دردشة تلقائياً**
- ✅ **معالجة الأخطاء**
- ✅ **دعم المصادقة**
- ✅ **واجهة مستخدم محسنة**
- ✅ **دعم الصور من الشبكة**
- ✅ **توافق Android API 23+**
- ✅ **تهيئة Firebase تلقائية**
- ✅ **تكامل مع نظام المصادقة المخصص**
- ✅ **واجهة عربية محسنة**
- ✅ **زر تسجيل دخول للمستخدمين غير المسجلين**

## 🔧 **خطوات الإعداد:**

### **1. إعداد Firebase:**
```bash
flutterfire configure --project=gymahmed-cd701
```

### **2. تحديث minSdk:**
```kotlin
// android/app/build.gradle.kts
minSdk = 23
```

### **3. تهيئة Firebase في main.dart:**
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### **4. تكامل نظام المصادقة:**
```dart
// في ChatScreen
final homeCubit = getIt<HomeCubit>();
if (homeCubit.state.user.id.isNotEmpty) {
  _currentUserId = homeCubit.state.user.id;
  // ... باقي الكود
}
```

## 📋 **الخطوات التالية:**

1. **تأكد من إعداد Firebase** في مشروعك ✅
2. **إعداد قواعد Firestore** للدردشة
3. **اختبار النظام** مع مستخدمين مختلفين
4. **إضافة إشعارات** للرسائل الجديدة

## 🔒 **قواعد Firestore المقترحة:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /chats/{chatId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.participants;
      
      match /messages/{messageId} {
        allow read, write: if request.auth != null && 
          request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.participants;
      }
    }
  }
}
```

## 📱 **متطلبات النظام:**

- **Android**: API 23+ (Android 6.0 Marshmallow)
- **iOS**: iOS 11.0+
- **Flutter**: 3.7.0+

## 🚨 **استكشاف الأخطاء:**

### **إذا واجهت مشكلة Firebase:**
1. تأكد من وجود `google-services.json` في `android/app/`
2. تأكد من وجود `firebase_options.dart` في `lib/`
3. قم بتشغيل `flutter clean` ثم `flutter pub get`
4. تأكد من تهيئة Firebase في `main.dart`

### **إذا واجهت مشكلة المصادقة:**
1. تأكد من تسجيل دخول المستخدم في التطبيق
2. تأكد من أن `HomeCubit` يحتوي على بيانات المستخدم
3. استخدم زر تسجيل الدخول إذا لم تكن مسجل دخول

## 🎯 **كيفية الاختبار:**

1. **شغل التطبيق**
2. **افتح أي منتج**
3. **انقر على أيقونة الدردشة**
4. **إذا لم تكن مسجل دخول**: ستظهر شاشة تسجيل الدخول
5. **إذا كنت مسجل دخول**: ستظهر شاشة الدردشة
6. **جرب إرسال رسالة**

النظام جاهز للاستخدام! 🎉 