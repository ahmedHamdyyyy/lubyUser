import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/activity.dart';
import '../data/repository.dart';

part 'state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit(this._repo) : super(const ActivitiesState());
  final ActivitiesRespository _repo;

  void getActivities() async {
    if (isClosed) return;
    emit(state.copyWith(getAllActivitiesStatus: Status.loading));
    try {
      final activities = await _repo.getActivities();
      if (isClosed) return;
      emit(state.copyWith(getAllActivitiesStatus: Status.success, activities: activities));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(getAllActivitiesStatus: Status.error, msg: e.toString()));
    }
  }

  void getActivity(String id) async {
    if (isClosed) return;
    emit(state.copyWith(getActivityStatus: Status.loading));
    try {
      final activity = await _repo.getActivity(id);
      if (isClosed) return;
      emit(state.copyWith(getActivityStatus: Status.success, activity: activity));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(getActivityStatus: Status.error, msg: e.toString()));
    }
  }





}
