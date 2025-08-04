part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Status userStatus;
  final UserModel user;
  final Status propertyStatus;
  final PropertyModel property;
  final List<PropertyModel> properties;
  final Status propertiesStatus;
  final Status signoutStatus;
  final String msg;

  const HomeState({
    this.propertiesStatus = Status.initial,
    this.userStatus = Status.initial,
    this.signoutStatus = Status.initial,
    this.user = UserModel.initial,
    this.properties = const [],
    this.propertyStatus = Status.initial,
    this.property = PropertyModel.non,
    this.msg = '',
  });

  HomeState copyWith({
    Status? propertiesStatus,
    Status? userStatus,
    UserModel? user,
    Status? propertyStatus,
    PropertyModel? property,
    Status? signoutStatus,
    String? msg,
    List<PropertyModel>? properties,
  }) => HomeState(
    userStatus: userStatus ?? this.userStatus,
    user: user ?? this.user,
    propertyStatus: propertyStatus ?? this.propertyStatus,
    property: property ?? this.property,
    propertiesStatus: propertiesStatus ?? this.propertiesStatus,
    signoutStatus: signoutStatus ?? this.signoutStatus,
    msg: msg ?? this.msg,
    properties: properties ?? this.properties,
  );

  @override
  List<Object?> get props => [userStatus, user, propertyStatus, property, msg, properties, propertiesStatus, signoutStatus];
}
