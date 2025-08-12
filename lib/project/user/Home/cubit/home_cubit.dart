import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/project/user/Home/data/home_repo.dart';

import '../../../../config/constants/constance.dart';
import '../../models/property.dart';
import '../../models/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(const HomeState());
  final HomeRespository repo;

  void fetchUser() async {
    emit(state.copyWith(userStatus: Status.loading));

    try {
      final user = await repo.fetchUser();

      emit(state.copyWith(userStatus: Status.success, user: user, msg: 'User fetched successfully'));
      if (kDebugMode) {
        print(state.user.toString());
      }
    } catch (e) {
      emit(state.copyWith(userStatus: Status.error, msg: e.toString()));
    }
  }

  /* void getUser() async {


    emit(state.copyWith(userStatus: Status.loading));
    try {
      final user = repo.getCachedUser();
   
      emit(state.copyWith(userStatus: 
        Status.success, user: user, msg: 'User fetched successfully'));
      print(state.user.toString());
    } catch (e) {
      
      emit(state.copyWith(userStatus: Status.error, msg: e.toString()));
    
    
    }
  }
  void setUser(UserModel user){
    emit(state.copyWith(user: user, userStatus: Status.initial, msg: ''));
  } */

  void getProperties() async {
    if (isClosed) return;
    emit(state.copyWith(propertiesStatus: Status.loading));
    try {
      final properties = await repo.getProperties();
      if (isClosed) return;
      emit(state.copyWith(propertiesStatus: Status.success, properties: properties));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(propertiesStatus: Status.error, msg: e.toString()));
    }
  }

  void getProperty(String id) async {
    if (isClosed) return;
    emit(state.copyWith(propertyStatus: Status.loading));
    try {
      final userProperty = await repo.getProperty(id);
      if (isClosed) return;
      emit(state.copyWith(propertyStatus: Status.success, property: userProperty));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(propertyStatus: Status.error, msg: e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void updateCurrentScreenIndex(int index) {
    emit(state.copyWith(currentScreenIndex: index));
  }
}
