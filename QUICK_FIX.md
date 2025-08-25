# حل سريع لمشكلة الأذونات

## 🚨 **المشكلة:**
```
خطأ في الأذونات: تأكد من تسجيل الدخول : Exception
```

## ⚡ **الحل السريع (5 دقائق):**

### **الخطوة 1: فتح Firebase Console**
1. اذهب إلى: https://console.firebase.google.com/
2. اختر مشروعك: `gymahmed-cd701`

### **الخطوة 2: تطبيق قواعد مؤقتة**
1. اذهب إلى **Firestore Database** في القائمة اليسرى
2. انقر على **"Rules"** في الأعلى
3. **احذف** كل القواعد الموجودة
4. **اكتب** هذه القواعد:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

5. انقر على **"Publish"**

### **الخطوة 3: اختبار التطبيق**
1. شغل التطبيق
2. افتح أي منتج
3. انقر على أيقونة الدردشة
4. جرب إرسال رسالة

## ✅ **بعد التطبيق:**
- ✅ **الأذونات تعمل** بشكل صحيح
- ✅ **نظام الدردشة** يعمل بدون أخطاء
- ✅ **يمكنك إرسال واستقبال** الرسائل

## ⚠️ **تحذير مهم:**
هذه القواعد مؤقتة للتطوير فقط! لا تستخدمها في الإنتاج.

## 🔒 **قواعد الإنتاج الآمنة (لاحقاً):**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /chats/{chatId} {
      allow read, write: if request.auth != null;
      match /messages/{messageId} {
        allow read, write: if request.auth != null;
      }
    }
  }
}
```

## 📞 **إذا لم تعمل:**
1. تأكد من أن القواعد تم نشرها
2. انتظر دقيقة واحدة
3. أعد تشغيل التطبيق
4. تحقق من اتصال الإنترنت

النظام سيعمل فوراً بعد تطبيق القواعد المؤقتة! 🚀 