# حل مشكلة أذونات Firestore

## 🚨 **المشكلة:**
```
Error: [cloud_firestore/permission-denied] The caller does not have permission to execute the specified operation.
```

## ✅ **الحل:**

### **1. إعداد قواعد Firestore:**

#### **أولاً: انتقل إلى Firebase Console**
1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
2. اختر مشروعك `gymahmed-cd701`
3. اذهب إلى **Firestore Database** في القائمة اليسرى
4. انقر على **Rules** في الأعلى

#### **ثانياً: استبدل القواعد الحالية:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow access to chat rooms and messages
    match /chats/{chatId} {
      // Allow read/write if user is authenticated
      allow read, write: if request.auth != null;
      
      // Allow access to messages in chat room
      match /messages/{messageId} {
        allow read, write: if request.auth != null;
      }
    }
    
    // Allow access to user profiles
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow access to properties
    match /properties/{propertyId} {
      allow read: if true; // Anyone can read properties
      allow write: if request.auth != null; // Only authenticated users can write
    }
    
    // Allow access to activities
    match /activities/{activityId} {
      allow read: if true; // Anyone can read activities
      allow write: if request.auth != null; // Only authenticated users can write
    }
  }
}
```

#### **ثالثاً: انقر على "Publish"**

### **2. قواعد أكثر أماناً (اختياري):**

إذا كنت تريد قواعد أكثر أماناً:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow access to chat rooms and messages
    match /chats/{chatId} {
      // Allow read/write if user is a participant
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.participants;
      
      // Allow access to messages in chat room
      match /messages/{messageId} {
        allow read, write: if request.auth != null && 
          request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.participants;
      }
    }
    
    // Allow access to user profiles
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow access to properties
    match /properties/{propertyId} {
      allow read: if true; // Anyone can read properties
      allow write: if request.auth != null; // Only authenticated users can write
    }
    
    // Allow access to activities
    match /activities/{activityId} {
      allow read: if true; // Anyone can read activities
      allow write: if request.auth != null; // Only authenticated users can write
    }
  }
}
```

### **3. اختبار القواعد:**

#### **أولاً: تأكد من أن القواعد تم نشرها:**
- يجب أن ترى رسالة "Rules published successfully"

#### **ثانياً: اختبر التطبيق:**
1. شغل التطبيق
2. تأكد من تسجيل الدخول
3. افتح أي منتج
4. انقر على أيقونة الدردشة
5. جرب إرسال رسالة

### **4. إذا استمرت المشكلة:**

#### **أولاً: تحقق من تسجيل الدخول:**
```dart
// في ChatScreen
final homeCubit = getIt<HomeCubit>();
print('User ID: ${homeCubit.state.user.id}');
print('User authenticated: ${homeCubit.state.user.id.isNotEmpty}');
```

#### **ثانياً: تحقق من Firebase:**
1. تأكد من أن Firebase تم تهيئته بشكل صحيح
2. تأكد من أن `google-services.json` موجود
3. تأكد من أن `firebase_options.dart` صحيح

#### **ثالثاً: قواعد مؤقتة للتطوير:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true; // WARNING: Only for development!
    }
  }
}
```

**⚠️ تحذير:** لا تستخدم القواعد المؤقتة في الإنتاج!

### **5. قواعد الإنتاج الآمنة:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Chat rules
    match /chats/{chatId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.participants;
      
      match /messages/{messageId} {
        allow read, write: if request.auth != null && 
          request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.participants;
      }
    }
    
    // User rules
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Public read, authenticated write
    match /properties/{propertyId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    
    match /activities/{activityId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

## 🎯 **بعد تطبيق الحل:**

1. ✅ **الأذونات تعمل** بشكل صحيح
2. ✅ **نظام الدردشة** يعمل بدون أخطاء
3. ✅ **المستخدمون المسجلون** يمكنهم الدردشة
4. ✅ **الأمان محفوظ** مع قواعد مناسبة

## 📞 **إذا احتجت مساعدة:**

1. تحقق من أن القواعد تم نشرها
2. تأكد من تسجيل دخول المستخدم
3. تحقق من سجلات Firebase Console
4. اختبر مع قواعد مؤقتة للتطوير

النظام سيعمل بشكل مثالي بعد تطبيق هذه القواعد! 🚀 