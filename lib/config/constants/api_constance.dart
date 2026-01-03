class ApiConstance {
  // static const baseUrl = "https://Luby-rafiks-projects-827f7443.vercel.app/api/v1/";
  static const baseUrl = "https://dashboard.lubyksa.com/api/v1/";

  static const initiateSignin = "auth/signin";
  static const verifySignin = "auth/signin/verify";
  static const initiateSignup = "auth/signup/initiate";
  static const signup = "auth/signup";
  static const verifyUserData = "auth/signup/validate";
  static const logout = "auth/logout";
  static const refreshToken = "auth/refresh-token";
  static const resetpassword = "auth/reset-password";
  static const confirmOtpSignUp = "auth/signup/verify";
  static const confirmOtpResetPassword = "auth/confirm-otp-reset-password";
  static const forgetPasswordReset = "auth/forget-password/reset";
  static const updateFcmToken = "auth/update-fcm-token";

  static const userProfile = "users/me";
  static getProperty(String id) => "properties/$id";
  static getActivity(String id) => "activities/$id";
  static updateProperty(String id) => "properties/$id";
  static const createProperty = "properties";
  static const getActivities = "activities";

  static const getFavorites = 'favourites/me';
  static const addFavorites = 'favourites/add';
  static const removeFavorites = 'favourites/remove';

  static deleteReview(String id) => "reviews/$id";
  static updateReview(String id) => "reviews/$id";
  static const reviews = "reviews";
  static addReview(String itemId) => "reviews/$itemId";

  static const notifications = "notifications";
  static String readNotification(String id) => "notifications/$id";
}
