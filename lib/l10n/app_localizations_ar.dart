// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'لوبي';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonDelete => 'حذف';

  @override
  String get language => 'اللغة';

  @override
  String get welcomeToOurApp => 'مرحبًا بك في تطبيقنا';

  @override
  String get typeMessageHint => 'اكتب رسالة...';

  @override
  String get contactTheHost => 'التواصل مع المضيف';

  @override
  String get youCanTalkToHost => 'يمكنك الآن التحدث مع المضيف';

  @override
  String get noMessagesYet => 'لا توجد رسائل حتى الآن';

  @override
  String get startConversation => 'ابدأ المحادثة!';

  @override
  String get messageCannotBeEmpty => 'لا يمكن أن تكون الرسالة فارغة';

  @override
  String get yourConversations => 'محادثاتك';

  @override
  String get searchHint => 'ابحث...';

  @override
  String get noConversationsYet => 'لا توجد محادثات حتى الآن';

  @override
  String get startByContactingSellers =>
      'ابدأ بالتواصل مع البائعين وستظهر المحادثات هنا';

  @override
  String get deleteConversationTitle => 'حذف المحادثة';

  @override
  String get deleteConversationBody =>
      'هل أنت متأكد أنك تريد حذف هذه المحادثة؟ هذا الإجراء لا يمكن التراجع عنه.';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonApply => 'تطبيق';

  @override
  String get commonTotal => 'الإجمالي';

  @override
  String get summaryTitle => 'الملخص';

  @override
  String get confirmPayment => 'تأكيد الدفع';

  @override
  String get paymentMethodTitle => 'طريقة الدفع';

  @override
  String get debitCreditCard => 'بطاقة خصم / ائتمان';

  @override
  String get wallet => 'المحفظة';

  @override
  String get cardDetails => 'تفاصيل البطاقة';

  @override
  String get cardNumber => 'رقم البطاقة';

  @override
  String get cardNumberHint => '0000 0000 0000 0000';

  @override
  String get cardName => 'اسم البطاقة';

  @override
  String get cardholderName => 'اسم صاحب البطاقة';

  @override
  String get expirationDate => 'تاريخ الانتهاء';

  @override
  String get expirationHint => 'MM/YY';

  @override
  String get cvv => 'CVV';

  @override
  String get saveDataWhenPayLater => 'حفظ البيانات عند الدفع لاحقًا';

  @override
  String get addLabel => 'إضافة';

  @override
  String get cardDetailsAddedSuccessfully => 'تمت إضافة تفاصيل البطاقة بنجاح';

  @override
  String get promoCodePlaceholder => 'MD1234';

  @override
  String get afterDiscount => 'بعد الخصم';

  @override
  String youSavedAmount(Object amount) {
    return '(لقد وفرت $amount)';
  }

  @override
  String get reservationsTitle => 'الحجوزات';

  @override
  String get tabPending => 'قيد الانتظار';

  @override
  String get tabCurrent => 'الحالية';

  @override
  String get tabLast => 'السابقة';

  @override
  String get propertiesSection => 'العقارات';

  @override
  String get activitiesSection => 'الأنشطة';

  @override
  String get noPropertyReservations => 'لا توجد حجوزات عقارات';

  @override
  String get noCurrentPropertyReservations =>
      'لا توجد لديك حجوزات عقارات حالية.';

  @override
  String get noActivityReservations => 'لا توجد حجوزات أنشطة';

  @override
  String get noCurrentActivityReservations =>
      'لا توجد لديك حجوزات أنشطة حالية.';

  @override
  String get viewReservationDetails => 'عرض تفاصيل الحجز';

  @override
  String get checkIn => 'تسجيل الوصول ';

  @override
  String get checkOut => 'تسجيل المغادرة ';

  @override
  String get dateLabel => 'التاريخ ';

  @override
  String get unableToOpenGoogleMaps => 'تعذر فتح خرائط جوجل.';

  @override
  String get locationNotAvailable => 'الموقع غير متاح';

  @override
  String get propertyLocationLabel => 'موقع العقار';

  @override
  String get noCoordinatesProvided => 'لا توجد إحداثيات';

  @override
  String get noMappedLocationYet =>
      'لا يحتوي هذا العقار على موقع محدد حتى الآن.';

  @override
  String get openInGoogleMaps => 'افتح في خرائط جوجل';

  @override
  String get notificationAppBarTitle => 'الإشعار';

  @override
  String get notificationsListAppBarTitle => 'الإشعارات';

  @override
  String get yourNotifications => 'إشعاراتك';

  @override
  String get noNotificationsRightNow => 'ليس لديك أي إشعارات الآن';

  @override
  String get notificationNameLabel => 'اسم الإشعار';

  @override
  String get loginOrRegister => 'تسجيل الدخول أو التسجيل';

  @override
  String get pleaseLoginToCompleteBooking =>
      'يرجى تسجيل الدخول أو التسجيل أولًا\nلإكمال الحجز';

  @override
  String get commonVat => 'ضريبة القيمة المضافة';

  @override
  String get commonDiscount => 'الخصم';

  @override
  String get doneLabel => 'تم';

  @override
  String get viewReservationSummary => 'عرض ملخص الحجز';

  @override
  String get confirmedReservationTitle => 'تأكيد الحجز';

  @override
  String confirmedReservationNumber(Object number) {
    return 'رقم الحجز المؤكد $number';
  }

  @override
  String reservationNumber(Object number) {
    return 'رقم الحجز $number';
  }

  @override
  String freeCancellationBefore(Object date) {
    return 'إلغاء مجاني قبل $date';
  }

  @override
  String get hostedBy => 'يستضيفه';

  @override
  String get payNow => 'ادفع الآن';

  @override
  String get paymentNotCompleted =>
      'لم يكتمل الدفع بعد. يرجى إتمام عملية الدفع.';

  @override
  String get canceledLabel => 'ملغي...';

  @override
  String get reservedProperty => 'عقار محجوز';

  @override
  String get reservedActivity => 'نشاط محجوز';

  @override
  String get saveReservation => 'حفظ الحجز';

  @override
  String get thankYou => 'شكرًا لك';

  @override
  String get reservationCompleted => 'تم إكمال حجزك\nبنجاح.';

  @override
  String get paymentDisclaimer =>
      'تخلي لُبي مسؤوليتها عن أي تحويلات مالية\nخارج المنصة.\nفي حال وجود عربون أو رصيد يتم دفعه\nقبل الدخول.';

  @override
  String get uploadStudioPhotosOrVideo => 'قم بتحميل صور أو فيديو الاستوديو';

  @override
  String get noReviewsYet => 'لا توجد مراجعات حتى الآن';

  @override
  String get commonOr => 'أو';

  @override
  String get guests => 'ضيوف';

  @override
  String get nights => 'ليالٍ';

  @override
  String get errorLabel => 'خطأ';

  @override
  String get cardDetailsUpdatedSuccessfully => 'تم تحديث تفاصيل البطاقة بنجاح';

  @override
  String get commonYes => 'نعم';

  @override
  String get commonNo => 'لا';

  @override
  String get comingSoon => 'قريبًا...';

  @override
  String get somethingWentWrong => 'حدث خطأ ما!';

  @override
  String get commonSearch => 'بحث';

  @override
  String get rentalService => 'خدمة الإيجار';

  @override
  String get touristActivities => 'الأنشطة السياحية';

  @override
  String get noFavoritesFound => 'لا توجد مفضلات';

  @override
  String get selectOnlyJpgOrPng => 'يرجى اختيار صورة بصيغة JPG أو PNG فقط';

  @override
  String get imageTooLarge =>
      'حجم الصورة كبير جدًا. يجب أن يكون أقل من 2 ميجابايت';

  @override
  String get errorSelectingImage => 'حدث خطأ أثناء اختيار الصورة';

  @override
  String get orContinueWith => 'أو المتابعة باستخدام';

  @override
  String get skip => 'تخطي';

  @override
  String get verifyEmailTitle => 'التحقق من البريد الإلكتروني';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get sendVerificationEmail => 'إرسال رسالة التحقق';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get dismiss => 'إغلاق';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get responsiveExampleTitle => 'مثال الاستجابة';

  @override
  String get roomTypeSingle => 'مفرد';

  @override
  String get roomTypeDouble => 'مزدوج';

  @override
  String get roomTypeSuite => 'جناح';

  @override
  String get roomTypeFamily => 'عائلي';

  @override
  String get yourFavorites => 'مفضلاتك';

  @override
  String get agreeToTerms => 'يرجى الموافقة على الشروط والأحكام';

  @override
  String get fillAllFields => 'يرجى ملء جميع الحقول';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get accountInfoTitle => 'معلومات الحساب';

  @override
  String get pleaseCompleteInfo => 'يرجى إكمال المعلومات التالية';

  @override
  String get agreeToTermsAndConditions => 'الموافقة على الشروط والأحكام';

  @override
  String get saveLabel => 'حفظ';

  @override
  String get rateAppTitle => 'قيّم التطبيق';

  @override
  String get inviteFriendsTitle => 'ادعُ الأصدقاء';

  @override
  String get addCardTitle => 'إضافة بطاقة';

  @override
  String get editCardTitle => 'تعديل البطاقة';

  @override
  String get deleteCardTitle => 'حذف البطاقة';

  @override
  String get deleteCardConfirmBody => 'هل أنت متأكد من حذف بطاقتك؟';

  @override
  String get saveCards => 'حفظ البطاقات';

  @override
  String get bankCardsTitle => 'بطاقات البنك';

  @override
  String get noCardsAddedYet => 'لم تقم بإضافة أي بطاقة بنك بعد';

  @override
  String get useThisCardToPay => 'استخدم هذه البطاقة للدفع';

  @override
  String get addNewCard => 'إضافة بطاقة جديدة';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get areYouSureDeleteAccount => 'هل أنت متأكد من حذف حسابك؟';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get signInInstruction =>
      'الرجاء إدخال البريد الإلكتروني وكلمة المرور لتسجيل الدخول إلى حسابك.';

  @override
  String get searchLocationHint => 'الموقع (مدينة، منطقة، أو اسم العقار)';

  @override
  String get roomTypeLabel => 'نوع الغرفة';

  @override
  String get includeBreakfast => 'تشمل الإفطار';

  @override
  String get petFriendly => 'صديقة للحيوانات الأليفة';

  @override
  String get yourSearch => 'بحثك';

  @override
  String get locationLabel => 'الموقع';

  @override
  String get searchProperties => 'بحث عن عقارات';

  @override
  String get clearSearch => 'مسح البحث';

  @override
  String get pleaseEnterCheckInDate => 'يرجى إدخال تاريخ تسجيل الوصول';

  @override
  String get enterDateInDdMmYyyy => 'أدخل التاريخ بصيغة يوم/شهر/سنة';

  @override
  String get invalidDateComponents => 'مكونات التاريخ غير صحيحة';

  @override
  String get checkInDateMustBeInFuture =>
      'يجب أن يكون تاريخ تسجيل الوصول في المستقبل';

  @override
  String get dateMustBeWithinAvailability =>
      'يجب أن يكون التاريخ ضمن فترة توفر العقار';

  @override
  String get checkOutMustBeAfterCheckIn =>
      'يجب أن يكون تسجيل المغادرة بعد تسجيل الوصول';

  @override
  String get guestsNoLabel => 'عدد الضيوف';

  @override
  String get invalidGuestNumber => 'عدد الضيوف غير صالح';

  @override
  String get guestCountHint => '1 ضيف';

  @override
  String get serviceFees => 'رسوم الخدمة';

  @override
  String get notChargedYet => 'لن يتم تحصيل رسوم الآن';

  @override
  String get checkInBeforeCheckOut =>
      'يجب أن يكون تاريخ تسجيل الوصول قبل تاريخ المغادرة';

  @override
  String get reserveLabel => 'احجز';

  @override
  String get pleaseEnterNumberOfGuests => 'يرجى إدخال عدد الضيوف';

  @override
  String get enterValidNumberOfGuests => 'أدخل عددًا صالحًا من الضيوف';

  @override
  String maxGuestsIs(Object max) {
    return 'أقصى عدد للضيوف هو $max';
  }

  @override
  String get viewLocationOnMap => 'عرض الموقع على الخريطة';

  @override
  String get hotelsTitle => 'فنادق';

  @override
  String get hotelsDescription => 'اعثر على أفضل الفنادق';

  @override
  String get apartmentsTitle => 'شقق';

  @override
  String get apartmentsDescription => 'اكتشف شققًا رائعة';

  @override
  String get villasTitle => 'فلل';

  @override
  String get villasDescription => 'فلل فاخرة لعطلتك';

  @override
  String get cabinsTitle => 'أكواخ';

  @override
  String get cabinsDescription => 'أكواخ دافئة في الطبيعة';

  @override
  String get searchForAccommodations => 'ابحث عن أماكن الإقامة';

  @override
  String get propertyTypeApartmentStudios => 'شقة - استوديوهات';

  @override
  String get propertyTypeCamps => 'مخيمات';

  @override
  String get propertyTypeVillas => 'فلل';

  @override
  String get pleaseEnterDate => 'يرجى إدخال التاريخ';

  @override
  String get invalidDateFormat => 'صيغة التاريخ غير صحيحة';

  @override
  String get dateMustBeInFuture => 'يجب أن يكون التاريخ في المستقبل';

  @override
  String get pleaseEnterValidEmail => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get pleaseEnterNewPassword => 'يرجى إدخال كلمة مرور جديدة';

  @override
  String get invalidOtpCode => 'يرجى إدخال رمز صالح مكوّن من 4 أحرف';

  @override
  String get resendComingSoon => 'ميزة إعادة الإرسال قادمة قريبًا';

  @override
  String get mobileLoginPrompt =>
      'يرجى إدخال رقم هاتفك لإنشاء حساب أو تسجيل الدخول.';

  @override
  String get requestWasCancelled => 'تم إلغاء الطلب';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navFavorites => 'المفضلة';

  @override
  String get navBookings => 'الحجوزات';

  @override
  String get navMessages => 'الرسائل';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get sliderBookApartmentNow => 'احجز شقتك\nالآن';

  @override
  String get sliderFindDreamHome => 'اعثر على منزل أحلامك';

  @override
  String get sliderExperienceLuxury => 'اختبر حياة الرفاهية';

  @override
  String get noActivitiesFound => 'لا توجد أنشطة';

  @override
  String get noPropertiesFound => 'لا توجد عقارات';

  @override
  String get perNightLabel => 'في الليلة';

  @override
  String get perPersonLabel => 'للفرد';

  @override
  String get fullDayExperience => 'تجربة طوال اليوم';

  @override
  String get touristActivity => 'نشاط سياحي';

  @override
  String fromSarPrice(Object price) {
    return 'ابتداءً من $price ريال';
  }

  @override
  String get filterTitle => 'تصفية';

  @override
  String get priceLabel => 'السعر';

  @override
  String get rateLabel => 'التقييم';

  @override
  String get propertyTypeLabel => 'نوع العقار';

  @override
  String get cityLabel => 'المدينة';

  @override
  String get districtLabel => 'الحي';

  @override
  String get districtOptionalLabel => 'الحي (اختياري)';

  @override
  String get selectDateLabel => 'اختر التاريخ';

  @override
  String get withPriceConnector => ' بسعر ';

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get profileUpdateFailed => 'فشل تحديث الملف الشخصي';

  @override
  String get continueAsGuest => 'المتابعة كزائر';

  @override
  String get continueWithGoogle => 'المتابعة باستخدام جوجل';

  @override
  String get continueWithFacebook => 'المتابعة باستخدام فيسبوك';

  @override
  String get continueWithEmail => 'المتابعة باستخدام البريد الإلكتروني';

  @override
  String get commonContinue => 'متابعة';

  @override
  String get signInWelcomeBack => 'مرحبًا بعودتك!';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور';

  @override
  String get firstNameLabel => 'الاسم الأول';

  @override
  String get lastNameLabel => 'اسم العائلة';

  @override
  String get phoneNumberLabel => 'رقم الهاتف';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get signUpInstruction => 'أنشئ حسابك للمتابعة في استخدام التطبيق';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get newPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPasswordLabel => 'تأكيد كلمة المرور الجديدة';

  @override
  String get readMore => 'قراءة المزيد';

  @override
  String get readLess => 'قراءة أقل';

  @override
  String get categoryYacht => 'يخت';

  @override
  String get categoryCruise => 'رحلة بحرية';

  @override
  String get priceHighToLow => 'من الأعلى إلى الأقل';

  @override
  String get priceLowToHigh => 'من الأقل إلى الأعلى';

  @override
  String get ratingHighToLow => 'من الأعلى تقييماً إلى الأقل';

  @override
  String get ratingDefault => 'افتراضي';

  @override
  String get hello => 'مرحبًا';

  @override
  String helloName(Object name) {
    return 'مرحبًا $name';
  }

  @override
  String get reservationCompletedShort => 'تم إكمال حجز الاستوديو بنجاح!';

  @override
  String get mostViewed => 'الأكثر مشاهدة';

  @override
  String priceTimesGuests(num count, Object price) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'أشخاص',
      one: 'شخص',
    );
    return '$price × $count $_temp0';
  }

  @override
  String sarAmount(Object amount) {
    return '$amount ريال';
  }

  @override
  String get onboardingExploreSaudiTitle => 'استكشف السعودية';

  @override
  String get onboardingExploreSaudiDescription =>
      'هذا نص افتراضي لشرح موجز عن التطبيق. يمكن تعديله لاحقًا ليتضمن وصفًا مناسبًا.';

  @override
  String get welcomeToLobyTitle => 'مرحبًا بك في لُوبي';

  @override
  String get welcomeToLobyDescription =>
      'هذا نص ترحيبي تجريبي. يمكن استبداله لاحقًا بوصف حقيقي للتطبيق.';

  @override
  String get letsStarted => 'لنبدأ';

  @override
  String get selectYourLanguageEnglishTitle => 'اختر لغتك';

  @override
  String get selectYourLanguageArabicTitle => 'اختر لغتك';
}
