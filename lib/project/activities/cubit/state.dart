part of 'cubit.dart';

class ActivitiesState extends Equatable {
  final String msg;
  final Status getActivityStatus;
  final Status getAllActivitiesStatus;
  final List<CustomActivityModel> activities;
  final ActivityModel activity;

  const ActivitiesState({
    this.msg = '',
    this.getActivityStatus = Status.initial,
    this.getAllActivitiesStatus = Status.initial,
    this.activities = const [],
    this.activity = ActivityModel.non,
  });

  ActivitiesState copyWith({
    String? msg,
    Status? getActivityStatus,
    Status? getAllActivitiesStatus,
    List<CustomActivityModel>? activities,
    ActivityModel? activity,
  }) {
    return ActivitiesState(
      msg: msg ?? this.msg,

      getActivityStatus: getActivityStatus ?? this.getActivityStatus,
      activities: activities ?? this.activities,
      activity: activity ?? this.activity,
      getAllActivitiesStatus: getAllActivitiesStatus ?? this.getAllActivitiesStatus,
    );
  }

  @override
  List<Object> get props => [msg, getActivityStatus, activities, activity, getAllActivitiesStatus];
}
