import 'package:get_it/get_it.dart';
import 'package:luby2/project/Home/data/home_data.dart';
import 'package:luby2/project/Home/data/home_repo.dart';
import 'package:luby2/project/activities/cubit/cubit.dart';
import 'package:luby2/project/activities/data/data.dart';
import 'package:luby2/project/activities/data/repository.dart';
import 'package:luby2/project/auth/cubit/auth_cubit.dart';
import 'package:luby2/project/auth/data/auth_data.dart';

import 'core/localization/localization_cubit.dart';
import 'core/services/api_services.dart';
import 'core/services/cach_services.dart';
import 'project/Home/cubit/home_cubit.dart';
import 'project/auth/data/auth_repo.dart';
import 'project/favorites/cubit/cubit.dart';
import 'project/favorites/data/data.dart';
import 'project/favorites/data/repository.dart';
import 'project/reservation/cubit/cubit.dart';
import 'project/reservation/data/data.dart';
import 'project/reservation/data/repository.dart';

final getIt = GetIt.instance;

void setup() {
  // services
  getIt.registerSingleton<CacheService>(CacheService());
  getIt.registerSingleton<ApiService>(ApiService(getIt<CacheService>()));

  // Home feature dependencies
  getIt.registerSingleton<AuthCubit>(AuthCubit(AuthRepo(AuthData(getIt<ApiService>(), getIt<CacheService>()))));
  getIt.registerSingleton<HomeCubit>(HomeCubit(HomeRespository(HomeData(getIt<ApiService>(), getIt<CacheService>()))));
  getIt.registerSingleton<ActivitiesCubit>(ActivitiesCubit(ActivitiesRespository(ActivitiesData(getIt<ApiService>()))));
  getIt.registerSingleton<FavoritesCubit>(FavoritesCubit(FavoritesRepository(FavoritesData(getIt<ApiService>()))));
  getIt.registerSingleton<ReservationsCubit>(
    ReservationsCubit(ReservationsRepository(ReservationsData(getIt<ApiService>()))),
  );
  getIt.registerSingleton<LocalizationCubit>(LocalizationCubit());
}
