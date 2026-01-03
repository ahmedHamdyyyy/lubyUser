import 'package:dio/dio.dart';

enum Status { initial, loading, success, error }

class AppConst {
  // static double serviceFees(double price) =>
  //     (price * 4 / 100) % 0.01 == 0 ? (price * 4 / 100) : ((price * 4 / 100).ceilToDouble());
  //variables
  static const id = '_id';
  static const email = 'email';
  static const name = 'name';
  static const phone = 'phone';
  static const dateOfBirth = 'birthDate';
  static const gender = 'gender';
  // Identity
  static const identityType = 'identityType'; // 'citizen' | 'resident' | 'visitor'
  static const nationalIdNumber = 'nationalId';
  static const residenceNumber = 'referenceNumber';
  static const passportNumber = 'passportNumber';
  static const password = 'password';
  static const passwordConfirmation = 'password_confirmation';
  static const theme = 'theme';
  static const reviewsCount = 'reviewsCount';
  static const lang = 'lang';
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const property = 'Property';
  static const role = 'role';
  static const otp = 'otp';
  static const accessToken = 'accessToken';
  static const refreshToken = 'refreshToken';
  static const userId = "_id";
  static const vendorId = 'vendorId';
  static const vendorName = 'vendorName';
  static const endDate = 'endDate';
  static const startDate = 'startDate';
  static const vendorImageUrl = 'vendorImageUrl';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
  static const address = 'address';
  static const city = 'city';
  static const type = 'type';
  static const date = 'date';
  static const available = 'available';
  static const profilePicture = 'profilePicture';
  static const user = 'user';
  static const guestNumber = 'guestNumber';
  static const bedrooms = 'bedrooms';
  static const bathrooms = 'bathrooms';
  static const beds = 'beds';
  static const isFavorite = 'isFavourite';
  static const details = 'details';
  static const tags = 'tags';
  static const pricePerNight = 'pricePerNight';
  static const availableDates = 'availableDates';
  static const maxDays = 'maxDays';
  static const ownershipContract = 'ownershipContract';
  static const facilityLicense = 'facilityLicense';
  static const medias = 'medias';
  static const images = 'images';
  static const reviewId = 'reviewId';
  static const comment = 'comment';
  static const rate = 'rate';

  //screens
  static const splashScreen = '/';
  static const signInScreen = '/signInScreen';
  static const signUpScreen = '/signUpScreen';
  static const adminScreen = '/adminHomeScreen';
  static const userScreen = '/userHomeScreen';
  static const addProductScreen = '/AddProductScreen';
  static const detailsScreen = '/detailsScreen';
  static const cutomerScreen = '/customerHomeScreen';

  // cache
  static const String tokenKey = 'auth_token';
  static const String isLoggedInKey = 'is_logged_in';
  // onboarding
  static const String viewOnboarding = 'view_onboarding';

  static const daysOfWeek = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

  // Deep link base used by backend to craft return links back into the app
  // Examples backend can build:
  //   lubyuser://open/reservation/<id>
  //   lubyuser://open/activity/<id>
  //   lubyuser://open/property/<id>
  // Using custom scheme deep links (not Firebase Dynamic Links)
  static const String deepLinkBase = 'lubyuser://open/';
  static String normalizeError(Object e) {
    String? message;

    // 1️⃣ Handle DioException explicitly
    if (e is DioException) {
      // a) Direct Dio message (e.g. DioException(Error: ...))
      if (e.message != null && e.message!.isNotEmpty) {
        message = e.message;
      }

      // b) Response data
      final data = e.response?.data;
      if (data != null) {
        if (data is String && data.isNotEmpty) {
          message = data;
        } else if (data is Map<String, dynamic>) {
          // Common backend keys
          for (final key in ['message', 'error', 'detail', 'details', 'msg']) {
            if (data[key] != null && data[key].toString().isNotEmpty) {
              message = data[key].toString();
              break;
            }

            // Nested data { data: { message: ... } }
            if (data['data'] is Map && data['data'][key] != null && data['data'][key].toString().isNotEmpty) {
              message = data['data'][key].toString();
              break;
            }
          }
        }
      }
    }

    // 2️⃣ Handle normal Exception
    if (message == null && e is Exception) {
      message = e.toString();
    }

    // 3️⃣ Final fallback
    message ??= e.toString();

    // 🔥 Clean technical prefixes
    message =
        message
            .replaceFirst(RegExp(r'^DioException[:\(]*', caseSensitive: false), '')
            .replaceFirst(RegExp(r'^Exception[:\(]*', caseSensitive: false), '')
            .replaceFirst(RegExp(r'^Error[: ]*', caseSensitive: false), '')
            .replaceAll(')', '')
            .trim();

    // 🧠 Friendly defaults
    if (message.isEmpty || message.toLowerCase() == 'null') {
      return 'Something went wrong. Please try again.';
    }

    return message;
  }
}
// sha1   A3:F0:AA:05:78:C3:9A:43:7E:4B:39:55:03:AC:5D:24:FB:52:C0:EE