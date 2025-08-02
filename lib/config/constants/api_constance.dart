class ApiConstance {
  static const baseUrl = "https://Luby-rafiks-projects-827f7443.vercel.app/api/v1/";

  static const signin = "auth/signin";
  static const signup = "auth/signup";
  static const logout = "auth/logout";
  static const refreshToken = "auth/refresh-token";

  static const userProfile = "users/me";
  static getProperty(String id) => "properties/$id";
  static getActivity(String id) => "getActivity/$id";
  static updateProperty(String id) => "properties/$id";
  static const createProperty = "properties";
  static const getActivities = "activities";
}
