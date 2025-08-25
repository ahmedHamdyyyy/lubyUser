part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int currentScreenIndex;
  final Status getUserStatus, updateUserStatus;
  final UserModel user;
  final Status propertyStatus;
  final PropertyModel property;
  final List<PropertyModel> properties;
  final Status propertiesStatus;
  final Status signoutStatus;
  final String msg;
  final List<ReviewModel> reviews;
  final Status reviewStatus;
  final Status reviewesStatus;

  const HomeState({
    this.currentScreenIndex = 0,
    this.propertiesStatus = Status.initial,
    this.getUserStatus = Status.initial,
    this.signoutStatus = Status.initial,
    this.user = UserModel.initial,
    this.properties = const [],
    this.propertyStatus = Status.initial,
    this.property = PropertyModel.initial,
    this.msg = '',
    this.reviews = const [],
    this.reviewesStatus = Status.initial,
    this.reviewStatus = Status.initial,
    this.updateUserStatus = Status.initial,
  });

  HomeState copyWith({
    int? currentScreenIndex,
    Status? propertiesStatus,
    Status? getUserStatus,
    UserModel? user,
    Status? propertyStatus,
    PropertyModel? property,
    Status? signoutStatus,
    String? msg,
    List<PropertyModel>? properties,
    List<ReviewModel>? reviews,
    Status? reviewesStatus,
    Status? reviewStatus,
    Status? updateUserStatus,
  }) => HomeState(
    currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,
    getUserStatus: getUserStatus ?? this.getUserStatus,
    user: user ?? this.user,
    propertyStatus: propertyStatus ?? this.propertyStatus,
    property: property ?? this.property,
    propertiesStatus: propertiesStatus ?? this.propertiesStatus,
    signoutStatus: signoutStatus ?? this.signoutStatus,
    msg: msg ?? this.msg,
    properties: properties ?? this.properties,
    reviews: reviews ?? this.reviews,
    reviewesStatus: reviewesStatus ?? this.reviewesStatus,
    reviewStatus: reviewStatus ?? this.reviewStatus,
  );

  @override
  List<Object?> get props => [
    currentScreenIndex,
    getUserStatus,
    user,
    propertyStatus,
    property,
    msg,
    properties,
    propertiesStatus,
    signoutStatus,
    reviews,
    reviewesStatus,
    reviewStatus,
    updateUserStatus,
  ];
}
