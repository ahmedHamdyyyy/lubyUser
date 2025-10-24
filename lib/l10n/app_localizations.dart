import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Luby'**
  String get appTitle;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @welcomeToOurApp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our App'**
  String get welcomeToOurApp;

  /// No description provided for @typeMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessageHint;

  /// No description provided for @contactTheHost.
  ///
  /// In en, this message translates to:
  /// **'Contact the host'**
  String get contactTheHost;

  /// No description provided for @youCanTalkToHost.
  ///
  /// In en, this message translates to:
  /// **'You can now talk to the host'**
  String get youCanTalkToHost;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @startConversation.
  ///
  /// In en, this message translates to:
  /// **'Start the conversation!'**
  String get startConversation;

  /// No description provided for @messageCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Message can\'t be empty'**
  String get messageCannotBeEmpty;

  /// No description provided for @yourConversations.
  ///
  /// In en, this message translates to:
  /// **'Your Conversations'**
  String get yourConversations;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @noConversationsYet.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get noConversationsYet;

  /// No description provided for @startByContactingSellers.
  ///
  /// In en, this message translates to:
  /// **'Start by contacting the sellers and the conversations will be displayed here'**
  String get startByContactingSellers;

  /// No description provided for @deleteConversationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete conversation'**
  String get deleteConversationTitle;

  /// No description provided for @deleteConversationBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this conversation? This cannot be undone.'**
  String get deleteConversationBody;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get commonApply;

  /// No description provided for @commonTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get commonTotal;

  /// No description provided for @summaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summaryTitle;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirmPayment;

  /// No description provided for @paymentMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethodTitle;

  /// No description provided for @debitCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Debit / Credit Card'**
  String get debitCreditCard;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @cardDetails.
  ///
  /// In en, this message translates to:
  /// **'Card details'**
  String get cardDetails;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @cardNumberHint.
  ///
  /// In en, this message translates to:
  /// **'0000 0000 0000 0000'**
  String get cardNumberHint;

  /// No description provided for @cardName.
  ///
  /// In en, this message translates to:
  /// **'Card Name'**
  String get cardName;

  /// No description provided for @cardholderName.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get cardholderName;

  /// No description provided for @expirationDate.
  ///
  /// In en, this message translates to:
  /// **'Expiration Date'**
  String get expirationDate;

  /// No description provided for @expirationHint.
  ///
  /// In en, this message translates to:
  /// **'MM/YY'**
  String get expirationHint;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @saveDataWhenPayLater.
  ///
  /// In en, this message translates to:
  /// **'Save data when paying later'**
  String get saveDataWhenPayLater;

  /// No description provided for @addLabel.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addLabel;

  /// No description provided for @cardDetailsAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Card details added successfully'**
  String get cardDetailsAddedSuccessfully;

  /// No description provided for @promoCodePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'MD1234'**
  String get promoCodePlaceholder;

  /// No description provided for @afterDiscount.
  ///
  /// In en, this message translates to:
  /// **'After Discount'**
  String get afterDiscount;

  /// No description provided for @youSavedAmount.
  ///
  /// In en, this message translates to:
  /// **'(You Saved {amount})'**
  String youSavedAmount(Object amount);

  /// No description provided for @reservationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation'**
  String get reservationsTitle;

  /// No description provided for @tabPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get tabPending;

  /// No description provided for @tabCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get tabCurrent;

  /// No description provided for @tabLast.
  ///
  /// In en, this message translates to:
  /// **'Last'**
  String get tabLast;

  /// No description provided for @propertiesSection.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get propertiesSection;

  /// No description provided for @activitiesSection.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activitiesSection;

  /// No description provided for @noPropertyReservations.
  ///
  /// In en, this message translates to:
  /// **'No Property Reservations'**
  String get noPropertyReservations;

  /// No description provided for @noCurrentPropertyReservations.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any current property reservations.'**
  String get noCurrentPropertyReservations;

  /// No description provided for @noActivityReservations.
  ///
  /// In en, this message translates to:
  /// **'No Activity Reservations'**
  String get noActivityReservations;

  /// No description provided for @noCurrentActivityReservations.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any current activity reservations.'**
  String get noCurrentActivityReservations;

  /// No description provided for @viewReservationDetails.
  ///
  /// In en, this message translates to:
  /// **'View Reservation Details'**
  String get viewReservationDetails;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'check in '**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'check out '**
  String get checkOut;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date '**
  String get dateLabel;

  /// No description provided for @unableToOpenGoogleMaps.
  ///
  /// In en, this message translates to:
  /// **'Unable to open Google Maps.'**
  String get unableToOpenGoogleMaps;

  /// No description provided for @locationNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Location not available'**
  String get locationNotAvailable;

  /// No description provided for @propertyLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Property Location'**
  String get propertyLocationLabel;

  /// No description provided for @noCoordinatesProvided.
  ///
  /// In en, this message translates to:
  /// **'No coordinates provided'**
  String get noCoordinatesProvided;

  /// No description provided for @noMappedLocationYet.
  ///
  /// In en, this message translates to:
  /// **'This property does not have a mapped location yet.'**
  String get noMappedLocationYet;

  /// No description provided for @openInGoogleMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Google Maps'**
  String get openInGoogleMaps;

  /// No description provided for @notificationAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationAppBarTitle;

  /// No description provided for @notificationsListAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsListAppBarTitle;

  /// No description provided for @yourNotifications.
  ///
  /// In en, this message translates to:
  /// **'Your Notifications'**
  String get yourNotifications;

  /// No description provided for @noNotificationsRightNow.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any notifications right now'**
  String get noNotificationsRightNow;

  /// No description provided for @notificationNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification Name'**
  String get notificationNameLabel;

  /// No description provided for @loginOrRegister.
  ///
  /// In en, this message translates to:
  /// **'Log in or register'**
  String get loginOrRegister;

  /// No description provided for @pleaseLoginToCompleteBooking.
  ///
  /// In en, this message translates to:
  /// **'Please log in or register first to\ncomplete the booking'**
  String get pleaseLoginToCompleteBooking;

  /// No description provided for @commonVat.
  ///
  /// In en, this message translates to:
  /// **'Vat'**
  String get commonVat;

  /// No description provided for @commonDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get commonDiscount;

  /// No description provided for @doneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneLabel;

  /// No description provided for @viewReservationSummary.
  ///
  /// In en, this message translates to:
  /// **'View reservation summary'**
  String get viewReservationSummary;

  /// No description provided for @confirmedReservationTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmed reservation'**
  String get confirmedReservationTitle;

  /// No description provided for @confirmedReservationNumber.
  ///
  /// In en, this message translates to:
  /// **'Confirmed reservation number {number}'**
  String confirmedReservationNumber(Object number);

  /// No description provided for @reservationNumber.
  ///
  /// In en, this message translates to:
  /// **'Reservation Number {number}'**
  String reservationNumber(Object number);

  /// No description provided for @freeCancellationBefore.
  ///
  /// In en, this message translates to:
  /// **'Free cancellation before {date}'**
  String freeCancellationBefore(Object date);

  /// No description provided for @hostedBy.
  ///
  /// In en, this message translates to:
  /// **'Hosted by'**
  String get hostedBy;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @paymentNotCompleted.
  ///
  /// In en, this message translates to:
  /// **'Payment not completed yet. Please complete the payment.'**
  String get paymentNotCompleted;

  /// No description provided for @canceledLabel.
  ///
  /// In en, this message translates to:
  /// **'Canceled...'**
  String get canceledLabel;

  /// No description provided for @reservedProperty.
  ///
  /// In en, this message translates to:
  /// **'Reserved Property'**
  String get reservedProperty;

  /// No description provided for @reservedActivity.
  ///
  /// In en, this message translates to:
  /// **'Reserved Activity'**
  String get reservedActivity;

  /// No description provided for @saveReservation.
  ///
  /// In en, this message translates to:
  /// **'Save Reservation'**
  String get saveReservation;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you'**
  String get thankYou;

  /// No description provided for @reservationCompleted.
  ///
  /// In en, this message translates to:
  /// **'Your reservation has been\nsuccessfully completed.'**
  String get reservationCompleted;

  /// No description provided for @paymentDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Loby disclaims responsibility for any financial\ntransfers outside the platform.\nIf there is a deposit or a balance, it is paid\nbefore you enter.'**
  String get paymentDisclaimer;

  /// No description provided for @uploadStudioPhotosOrVideo.
  ///
  /// In en, this message translates to:
  /// **'Upload studio photos or video'**
  String get uploadStudioPhotosOrVideo;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @commonOr.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get commonOr;

  /// No description provided for @guests.
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get guests;

  /// No description provided for @nights.
  ///
  /// In en, this message translates to:
  /// **'Nights'**
  String get nights;

  /// No description provided for @errorLabel.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorLabel;

  /// No description provided for @cardDetailsUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Card details updated successfully'**
  String get cardDetailsUpdatedSuccessfully;

  /// No description provided for @commonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon...'**
  String get comingSoon;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get somethingWentWrong;

  /// No description provided for @commonSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get commonSearch;

  /// No description provided for @rentalService.
  ///
  /// In en, this message translates to:
  /// **'Rental Service'**
  String get rentalService;

  /// No description provided for @touristActivities.
  ///
  /// In en, this message translates to:
  /// **'Tourist Activities'**
  String get touristActivities;

  /// No description provided for @noFavoritesFound.
  ///
  /// In en, this message translates to:
  /// **'No favorites found'**
  String get noFavoritesFound;

  /// No description provided for @selectOnlyJpgOrPng.
  ///
  /// In en, this message translates to:
  /// **'Please select only JPG or PNG images'**
  String get selectOnlyJpgOrPng;

  /// No description provided for @imageTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The image is too large. It must be less than 2 MB'**
  String get imageTooLarge;

  /// No description provided for @errorSelectingImage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while selecting the image'**
  String get errorSelectingImage;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmailTitle;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @sendVerificationEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Email'**
  String get sendVerificationEmail;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @responsiveExampleTitle.
  ///
  /// In en, this message translates to:
  /// **'Responsive Example'**
  String get responsiveExampleTitle;

  /// No description provided for @roomTypeSingle.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get roomTypeSingle;

  /// No description provided for @roomTypeDouble.
  ///
  /// In en, this message translates to:
  /// **'Double'**
  String get roomTypeDouble;

  /// No description provided for @roomTypeSuite.
  ///
  /// In en, this message translates to:
  /// **'Suite'**
  String get roomTypeSuite;

  /// No description provided for @roomTypeFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get roomTypeFamily;

  /// No description provided for @yourFavorites.
  ///
  /// In en, this message translates to:
  /// **'Your favorites'**
  String get yourFavorites;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the terms and conditions'**
  String get agreeToTerms;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get fillAllFields;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @accountInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Account info'**
  String get accountInfoTitle;

  /// No description provided for @pleaseCompleteInfo.
  ///
  /// In en, this message translates to:
  /// **'Please complete the following\ninformation'**
  String get pleaseCompleteInfo;

  /// No description provided for @agreeToTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Agree to the terms and conditions'**
  String get agreeToTermsAndConditions;

  /// No description provided for @saveLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveLabel;

  /// No description provided for @rateAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateAppTitle;

  /// No description provided for @inviteFriendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite Friends'**
  String get inviteFriendsTitle;

  /// No description provided for @addCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCardTitle;

  /// No description provided for @editCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Card'**
  String get editCardTitle;

  /// No description provided for @deleteCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Card'**
  String get deleteCardTitle;

  /// No description provided for @deleteCardConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure about deleting your card?'**
  String get deleteCardConfirmBody;

  /// No description provided for @saveCards.
  ///
  /// In en, this message translates to:
  /// **'Save Cards'**
  String get saveCards;

  /// No description provided for @bankCardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bank Cards'**
  String get bankCardsTitle;

  /// No description provided for @noCardsAddedYet.
  ///
  /// In en, this message translates to:
  /// **'You have not added any bank card yet'**
  String get noCardsAddedYet;

  /// No description provided for @useThisCardToPay.
  ///
  /// In en, this message translates to:
  /// **'Use this card to pay'**
  String get useThisCardToPay;

  /// No description provided for @addNewCard.
  ///
  /// In en, this message translates to:
  /// **'Add New Card'**
  String get addNewCard;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @areYouSureDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure about deleting your account?'**
  String get areYouSureDeleteAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signInInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password to sign in to your account.'**
  String get signInInstruction;

  /// No description provided for @searchLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Location (city, area, or property name)'**
  String get searchLocationHint;

  /// No description provided for @roomTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Room Type'**
  String get roomTypeLabel;

  /// No description provided for @includeBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Include breakfast'**
  String get includeBreakfast;

  /// No description provided for @petFriendly.
  ///
  /// In en, this message translates to:
  /// **'Pet friendly'**
  String get petFriendly;

  /// No description provided for @yourSearch.
  ///
  /// In en, this message translates to:
  /// **'Your Search'**
  String get yourSearch;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @searchProperties.
  ///
  /// In en, this message translates to:
  /// **'Search Properties'**
  String get searchProperties;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear Search'**
  String get clearSearch;

  /// No description provided for @pleaseEnterCheckInDate.
  ///
  /// In en, this message translates to:
  /// **'Please enter check-in date'**
  String get pleaseEnterCheckInDate;

  /// No description provided for @enterDateInDdMmYyyy.
  ///
  /// In en, this message translates to:
  /// **'Enter date in DD/MM/YYYY format'**
  String get enterDateInDdMmYyyy;

  /// No description provided for @invalidDateComponents.
  ///
  /// In en, this message translates to:
  /// **'Invalid date components'**
  String get invalidDateComponents;

  /// No description provided for @checkInDateMustBeInFuture.
  ///
  /// In en, this message translates to:
  /// **'Check-in date must be in the future'**
  String get checkInDateMustBeInFuture;

  /// No description provided for @dateMustBeWithinAvailability.
  ///
  /// In en, this message translates to:
  /// **'Date must be within property availability'**
  String get dateMustBeWithinAvailability;

  /// No description provided for @checkOutMustBeAfterCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check-out must be after check-in'**
  String get checkOutMustBeAfterCheckIn;

  /// No description provided for @guestsNoLabel.
  ///
  /// In en, this message translates to:
  /// **'Guests No.'**
  String get guestsNoLabel;

  /// No description provided for @invalidGuestNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid guest number'**
  String get invalidGuestNumber;

  /// No description provided for @guestCountHint.
  ///
  /// In en, this message translates to:
  /// **'1 Guests'**
  String get guestCountHint;

  /// No description provided for @serviceFees.
  ///
  /// In en, this message translates to:
  /// **'Service Fees'**
  String get serviceFees;

  /// No description provided for @notChargedYet.
  ///
  /// In en, this message translates to:
  /// **'You won\'t be charged yet'**
  String get notChargedYet;

  /// No description provided for @checkInBeforeCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Check-in date must be before check-out date'**
  String get checkInBeforeCheckOut;

  /// No description provided for @reserveLabel.
  ///
  /// In en, this message translates to:
  /// **'Reserve'**
  String get reserveLabel;

  /// No description provided for @pleaseEnterNumberOfGuests.
  ///
  /// In en, this message translates to:
  /// **'Please enter number of guests'**
  String get pleaseEnterNumberOfGuests;

  /// No description provided for @enterValidNumberOfGuests.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number of guests'**
  String get enterValidNumberOfGuests;

  /// No description provided for @maxGuestsIs.
  ///
  /// In en, this message translates to:
  /// **'Max guests is {max}'**
  String maxGuestsIs(Object max);

  /// No description provided for @viewLocationOnMap.
  ///
  /// In en, this message translates to:
  /// **'View Location on Map'**
  String get viewLocationOnMap;

  /// No description provided for @hotelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Hotels'**
  String get hotelsTitle;

  /// No description provided for @hotelsDescription.
  ///
  /// In en, this message translates to:
  /// **'Find the best hotels'**
  String get hotelsDescription;

  /// No description provided for @apartmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Apartments'**
  String get apartmentsTitle;

  /// No description provided for @apartmentsDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover amazing apartments'**
  String get apartmentsDescription;

  /// No description provided for @villasTitle.
  ///
  /// In en, this message translates to:
  /// **'Villas'**
  String get villasTitle;

  /// No description provided for @villasDescription.
  ///
  /// In en, this message translates to:
  /// **'Luxury villas for your vacation'**
  String get villasDescription;

  /// No description provided for @cabinsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cabins'**
  String get cabinsTitle;

  /// No description provided for @cabinsDescription.
  ///
  /// In en, this message translates to:
  /// **'Cozy cabins in nature'**
  String get cabinsDescription;

  /// No description provided for @searchForAccommodations.
  ///
  /// In en, this message translates to:
  /// **'Search for Accommodations'**
  String get searchForAccommodations;

  /// No description provided for @propertyTypeApartmentStudios.
  ///
  /// In en, this message translates to:
  /// **'Apartment - Studios'**
  String get propertyTypeApartmentStudios;

  /// No description provided for @propertyTypeCamps.
  ///
  /// In en, this message translates to:
  /// **'Camps'**
  String get propertyTypeCamps;

  /// No description provided for @propertyTypeVillas.
  ///
  /// In en, this message translates to:
  /// **'Villas'**
  String get propertyTypeVillas;

  /// No description provided for @pleaseEnterDate.
  ///
  /// In en, this message translates to:
  /// **'Please enter date'**
  String get pleaseEnterDate;

  /// No description provided for @invalidDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid date format'**
  String get invalidDateFormat;

  /// No description provided for @dateMustBeInFuture.
  ///
  /// In en, this message translates to:
  /// **'Date must be in the future'**
  String get dateMustBeInFuture;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get pleaseEnterNewPassword;

  /// No description provided for @invalidOtpCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 4-character code'**
  String get invalidOtpCode;

  /// No description provided for @resendComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Resend functionality coming soon'**
  String get resendComingSoon;

  /// No description provided for @mobileLoginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter your mobile number to create an account or log in.'**
  String get mobileLoginPrompt;

  /// No description provided for @requestWasCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled'**
  String get requestWasCancelled;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navMessages;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @sliderBookApartmentNow.
  ///
  /// In en, this message translates to:
  /// **'BOOK YOUR\nAPARTMENT NOW'**
  String get sliderBookApartmentNow;

  /// No description provided for @sliderFindDreamHome.
  ///
  /// In en, this message translates to:
  /// **'FIND YOUR DREAM HOME'**
  String get sliderFindDreamHome;

  /// No description provided for @sliderExperienceLuxury.
  ///
  /// In en, this message translates to:
  /// **'EXPERIENCE LUXURY LIVING'**
  String get sliderExperienceLuxury;

  /// No description provided for @noActivitiesFound.
  ///
  /// In en, this message translates to:
  /// **'No activities found'**
  String get noActivitiesFound;

  /// No description provided for @noPropertiesFound.
  ///
  /// In en, this message translates to:
  /// **'No properties found'**
  String get noPropertiesFound;

  /// No description provided for @perNightLabel.
  ///
  /// In en, this message translates to:
  /// **'Per Night'**
  String get perNightLabel;

  /// No description provided for @perPersonLabel.
  ///
  /// In en, this message translates to:
  /// **'Per Person'**
  String get perPersonLabel;

  /// No description provided for @fullDayExperience.
  ///
  /// In en, this message translates to:
  /// **'Full Day Experience'**
  String get fullDayExperience;

  /// No description provided for @touristActivity.
  ///
  /// In en, this message translates to:
  /// **'Tourist Activity'**
  String get touristActivity;

  /// No description provided for @fromSarPrice.
  ///
  /// In en, this message translates to:
  /// **'From {price} SAR'**
  String fromSarPrice(Object price);

  /// No description provided for @filterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterTitle;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// No description provided for @rateLabel.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rateLabel;

  /// No description provided for @propertyTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Property Type'**
  String get propertyTypeLabel;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityLabel;

  /// No description provided for @districtLabel.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get districtLabel;

  /// No description provided for @districtOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'District (optional)'**
  String get districtOptionalLabel;

  /// No description provided for @selectDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDateLabel;

  /// No description provided for @withPriceConnector.
  ///
  /// In en, this message translates to:
  /// **' with price '**
  String get withPriceConnector;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdated;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get profileUpdateFailed;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continueWithFacebook;

  /// No description provided for @continueWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue with E-mail'**
  String get continueWithEmail;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @signInWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get signInWelcomeBack;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @firstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameLabel;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signUpInstruction.
  ///
  /// In en, this message translates to:
  /// **'Create your account to continue using the app'**
  String get signUpInstruction;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordLabel;

  /// No description provided for @confirmNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPasswordLabel;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get readLess;

  /// No description provided for @categoryYacht.
  ///
  /// In en, this message translates to:
  /// **'Yacht'**
  String get categoryYacht;

  /// No description provided for @categoryCruise.
  ///
  /// In en, this message translates to:
  /// **'Cruise'**
  String get categoryCruise;

  /// No description provided for @priceHighToLow.
  ///
  /// In en, this message translates to:
  /// **'From high to low'**
  String get priceHighToLow;

  /// No description provided for @priceLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'From low to high'**
  String get priceLowToHigh;

  /// No description provided for @ratingHighToLow.
  ///
  /// In en, this message translates to:
  /// **'From high to low rated'**
  String get ratingHighToLow;

  /// No description provided for @ratingDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get ratingDefault;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @helloName.
  ///
  /// In en, this message translates to:
  /// **'Hello {name}'**
  String helloName(Object name);

  /// No description provided for @reservationCompletedShort.
  ///
  /// In en, this message translates to:
  /// **'Your studio reservation has been successfully completed!'**
  String get reservationCompletedShort;

  /// No description provided for @mostViewed.
  ///
  /// In en, this message translates to:
  /// **'Most Viewed'**
  String get mostViewed;

  /// No description provided for @priceTimesGuests.
  ///
  /// In en, this message translates to:
  /// **'{price} x {count} {count, plural, one {person} other {people}}'**
  String priceTimesGuests(num count, Object price);

  /// No description provided for @sarAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} SAR'**
  String sarAmount(Object amount);

  /// No description provided for @onboardingExploreSaudiTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Saudi Arabia'**
  String get onboardingExploreSaudiTitle;

  /// No description provided for @onboardingExploreSaudiDescription.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consecr adipiscing elit. Ut hendrerit triueasdwfa prm gravida felis, sociis in felis.'**
  String get onboardingExploreSaudiDescription;

  /// No description provided for @welcomeToLobyTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to LOBY'**
  String get welcomeToLobyTitle;

  /// No description provided for @welcomeToLobyDescription.
  ///
  /// In en, this message translates to:
  /// **'LLorem ipsum dolor sit amet, consecr adipiscing elit. Ut hendrerit triueasdwfa prm gravida felis, sociis in felis.'**
  String get welcomeToLobyDescription;

  /// No description provided for @letsStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Started'**
  String get letsStarted;

  /// No description provided for @selectYourLanguageEnglishTitle.
  ///
  /// In en, this message translates to:
  /// **'Select your Language'**
  String get selectYourLanguageEnglishTitle;

  /// No description provided for @selectYourLanguageArabicTitle.
  ///
  /// In en, this message translates to:
  /// **'اختر لغتك'**
  String get selectYourLanguageArabicTitle;

  /// No description provided for @contactUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsTitle;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get howCanWeHelp;

  /// No description provided for @messageInputHint.
  ///
  /// In en, this message translates to:
  /// **'You can add your message here'**
  String get messageInputHint;

  /// No description provided for @commonSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get commonSend;

  /// No description provided for @reviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviewsTitle;

  /// No description provided for @reviewsCount.
  ///
  /// In en, this message translates to:
  /// **'({count} Reviews)'**
  String reviewsCount(Object count);

  /// No description provided for @addReview.
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get addReview;

  /// No description provided for @editReview.
  ///
  /// In en, this message translates to:
  /// **'Edit Review'**
  String get editReview;

  /// No description provided for @chargingWallet.
  ///
  /// In en, this message translates to:
  /// **'Charging Wallet'**
  String get chargingWallet;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get availableBalance;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enterAmount;

  /// No description provided for @enterAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter amount you want to charge'**
  String get enterAmountHint;

  /// No description provided for @chooseTheCard.
  ///
  /// In en, this message translates to:
  /// **'Choose the card'**
  String get chooseTheCard;

  /// No description provided for @useThisCardToCharge.
  ///
  /// In en, this message translates to:
  /// **'Use this card to Charge'**
  String get useThisCardToCharge;

  /// No description provided for @cardNumberEndingWith.
  ///
  /// In en, this message translates to:
  /// **'Card number ending with {last4}'**
  String cardNumberEndingWith(Object last4);

  /// No description provided for @chargeLabel.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get chargeLabel;

  /// No description provided for @walletChargedTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet Charged'**
  String get walletChargedTitle;

  /// No description provided for @walletDepositMessage.
  ///
  /// In en, this message translates to:
  /// **'{amount} SAR were deposited into the wallet'**
  String walletDepositMessage(Object amount);

  /// No description provided for @sarCurrency.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get sarCurrency;

  /// No description provided for @whatThisPlaceOffers.
  ///
  /// In en, this message translates to:
  /// **'What this place offers'**
  String get whatThisPlaceOffers;

  /// No description provided for @showAllAmenities.
  ///
  /// In en, this message translates to:
  /// **'Show All Amenities'**
  String get showAllAmenities;

  /// No description provided for @entireRentalUnitIn.
  ///
  /// In en, this message translates to:
  /// **'Entire rental unit in {address}'**
  String entireRentalUnitIn(Object address);

  /// No description provided for @availableForRange.
  ///
  /// In en, this message translates to:
  /// **'Available for {nights} {nightsLabel} from {from} to {to}'**
  String availableForRange(
    Object from,
    Object nights,
    Object nightsLabel,
    Object to,
  );

  /// No description provided for @rateApartment.
  ///
  /// In en, this message translates to:
  /// **'Rate Apartment'**
  String get rateApartment;

  /// No description provided for @addComment.
  ///
  /// In en, this message translates to:
  /// **'Add Comment'**
  String get addComment;

  /// No description provided for @addYourCommentHere.
  ///
  /// In en, this message translates to:
  /// **'Add your comment here'**
  String get addYourCommentHere;

  /// No description provided for @reviewPostedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Review posted successfully'**
  String get reviewPostedSuccessfully;

  /// No description provided for @bedsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, one {Bed} other {Beds}}'**
  String bedsCount(num count);

  /// No description provided for @bathroomsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, one {Bathroom} other {Bathrooms}}'**
  String bathroomsCount(num count);

  /// No description provided for @yourBookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Your Booking Details'**
  String get yourBookingDetails;

  /// No description provided for @reservationStatusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get reservationStatusDraft;

  /// No description provided for @reservationStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get reservationStatusCompleted;

  /// No description provided for @reservationStatusCanceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get reservationStatusCanceled;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
