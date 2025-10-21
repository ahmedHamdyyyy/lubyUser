part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int currentScreenIndex;
  final Status getUserStatus, updateUserStatus;
  final UserModel user;
  final Status propertyStatus,
      propertiesStatus,
      signoutStatus,
      reviewStatus,
      reviewesStatus,
      loadNotificationsStatus,
      readNotificationStatus;
  final PropertyModel property;
  final List<CustomPropertyModel> properties;
  final String msg;
  final List<ReviewModel> reviews;
  final List<NotificationModel> notifications;

  const HomeState({
    this.currentScreenIndex = 0,
    this.propertiesStatus = Status.initial,
    this.getUserStatus = Status.initial,
    this.readNotificationStatus = Status.initial,
    this.signoutStatus = Status.initial,
    this.loadNotificationsStatus = Status.initial,
    this.user = UserModel.initial,
    this.properties = const [],
    this.propertyStatus = Status.initial,
    this.property = PropertyModel.initial,
    this.msg = '',
    this.reviews = const [],
    this.reviewesStatus = Status.initial,
    this.reviewStatus = Status.initial,
    this.updateUserStatus = Status.initial,
    this.notifications = const [],
  });

  HomeState copyWith({
    int? currentScreenIndex,
    Status? propertiesStatus,
    Status? getUserStatus,
    UserModel? user,
    Status? propertyStatus,
    Status? readNotificationStatus,
    PropertyModel? property,
    Status? signoutStatus,
    String? msg,
    List<CustomPropertyModel>? properties,
    List<ReviewModel>? reviews,
    Status? reviewesStatus,
    Status? loadNotificationsStatus,
    Status? reviewStatus,
    Status? updateUserStatus,
    List<NotificationModel>? notifications,
  }) => HomeState(
    currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,
    getUserStatus: getUserStatus ?? this.getUserStatus,
    user: user ?? this.user,
    propertyStatus: propertyStatus ?? this.propertyStatus,
    property: property ?? this.property,
    propertiesStatus: propertiesStatus ?? this.propertiesStatus,
    signoutStatus: signoutStatus ?? this.signoutStatus,
    msg: msg ?? this.msg,
    readNotificationStatus: readNotificationStatus ?? this.readNotificationStatus,
    properties: properties ?? this.properties,
    reviews: reviews ?? this.reviews,
    reviewesStatus: reviewesStatus ?? this.reviewesStatus,
    reviewStatus: reviewStatus ?? this.reviewStatus,
    loadNotificationsStatus: loadNotificationsStatus ?? this.loadNotificationsStatus,
    updateUserStatus: updateUserStatus ?? this.updateUserStatus,
    notifications: notifications ?? this.notifications,
  );

  @override
  List<Object?> get props => [
    currentScreenIndex,
    getUserStatus,
    user,
    propertyStatus,
    property,
    msg,
    readNotificationStatus,
    properties,
    propertiesStatus,
    signoutStatus,
    reviews,
    reviewesStatus,
    reviewStatus,
    loadNotificationsStatus,
    updateUserStatus,
    notifications,
  ];
}
