import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/activity.dart';
import '../../models/review.dart';
import '../data/repository.dart';

part 'state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit(this._repo) : super(const ActivitiesState());
  final ActivitiesRespository _repo;
  bool _hasNextPage = false;

  void getActivities({bool fetchNext = false, Map<String, dynamic>? filters}) async {
    if (fetchNext && !_hasNextPage) return;
    emit(state.copyWith(getAllActivitiesStatus: Status.loading));
    try {
      final activitiesData = await _repo.getActivities(fetchNext, filters);
      _hasNextPage = activitiesData.hasNextPage;
      emit(
        state.copyWith(
          getAllActivitiesStatus: Status.success,
          activities: fetchNext ? [...state.activities, ...activitiesData.activities] : activitiesData.activities,
        ),
      );
    } catch (e) {
      emit(state.copyWith(getAllActivitiesStatus: Status.error, msg: e.toString()));
    }
  }

  void getActivity(String id) async {
    emit(state.copyWith(getActivityStatus: Status.loading));
    try {
      final activity = await _repo.getActivity(id);
      emit(state.copyWith(getActivityStatus: Status.success, activity: activity));
    } catch (e) {
      emit(state.copyWith(getActivityStatus: Status.error, msg: e.toString()));
    }
  }

  void toggleFavorite(String id) {
    final updatedActivities =
        state.activities.map((activity) {
          if (activity.id == id) return activity.copyWith(isFavorite: !activity.isFavorite);
          return activity;
        }).toList();
    emit(state.copyWith(activities: updatedActivities));
    if (state.activity.id == id) {
      emit(state.copyWith(activity: state.activity.copyWith(isFavorite: !state.activity.isFavorite)));
    }
  }

  void setActivityReview(ReviewModel review) {
    emit(state.copyWith(activity: state.activity.copyWith(review: review)));
  }
}
