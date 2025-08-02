import 'package:get_it/get_it.dart';
import 'package:luby2/project/user/Home/data/home_data.dart';
import 'package:luby2/project/user/Home/data/home_repo.dart';
import 'package:luby2/project/user/auth/cubit/auth_cubit.dart';
import 'package:luby2/project/user/auth/data/auth_data.dart';
import 'package:luby2/project/user/activities/cubit/cubit.dart';
import 'package:luby2/project/user/activities/data/data.dart';
import 'package:luby2/project/user/activities/data/repository.dart';

import 'core/services/api_services.dart';
import 'core/services/cach_services.dart';
import 'project/user/Home/cubit/home_cubit.dart';
import 'project/user/auth/data/auth_repo.dart';


final getIt = GetIt.instance;

void setup() {
  // services
  getIt.registerSingleton<CacheService>(CacheService());
  getIt.registerSingleton<ApiService>(ApiService(getIt<CacheService>()));

  // Home feature dependencies
  getIt.registerSingleton<AuthCubit>(AuthCubit(AuthRepo(AuthData(getIt<ApiService>(), getIt<CacheService>()))));
  getIt.registerSingleton<HomeCubit>(HomeCubit(HomeRespository(HomeData(getIt<ApiService>()))));
  getIt.registerSingleton<ActivitiesCubit>(ActivitiesCubit(ActivitiesRespository(ActivitiesData(getIt<ApiService>()))));

}
