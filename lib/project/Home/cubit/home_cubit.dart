import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/project/Home/data/home_repo.dart';

import '../../../../config/constants/constance.dart';
import '../../models/notification.dart';
import '../../models/property.dart';
import '../../models/review.dart';
import '../../models/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(const HomeState());
  final HomeRespository repo;
  bool _hasNextPage = false;
  bool _hasNextNotificationsPage = false;

  void fetchUser() async {
    emit(state.copyWith(getUserStatus: Status.loading));
    try {
      final user = await repo.fetchUser();
      emit(state.copyWith(getUserStatus: Status.success, user: user, msg: 'User fetched successfully'));
    } catch (e) {
      emit(state.copyWith(getUserStatus: Status.error, msg: e.toString()));
    }
  }

  void getProperties({bool fetchNext = false, Map<String, dynamic>? filters}) async {
    if (fetchNext && !_hasNextPage || state.propertiesStatus == Status.loading) return;
    emit(state.copyWith(propertiesStatus: Status.loading));
    try {
      final propertiesData = await repo.getProperties(fetchNext, filters);
      _hasNextPage = propertiesData.hasNextPage;
      emit(
        state.copyWith(
          propertiesStatus: Status.success,
          properties: fetchNext ? [...state.properties, ...propertiesData.properties] : propertiesData.properties,
        ),
      );
    } catch (e) {
      emit(state.copyWith(propertiesStatus: Status.error, msg: e.toString()));
    }
  }

  void getProperty(String id) async {
    emit(state.copyWith(propertyStatus: Status.loading));
    try {
      final userProperty = await repo.getProperty(id);
      emit(state.copyWith(propertyStatus: Status.success, property: userProperty));

      if (kDebugMode) {
        print(userProperty.toString());
      }
    } catch (e) {
      emit(state.copyWith(propertyStatus: Status.error, msg: e.toString()));
      if (kDebugMode) print(e.toString());
    }
  }

  void toggleFavorite(String id) {
    final updatedProperties =
        state.properties.map((property) {
          if (property.id == id) {
            return property.copyWith(isFavorite: !property.isFavorite);
          }
          return property;
        }).toList();
    emit(state.copyWith(properties: updatedProperties));
    if (state.property.id == id) {
      emit(state.copyWith(property: state.property.copyWith(isFavorite: !state.property.isFavorite)));
    }
  }

  void updateCurrentScreenIndex(int index) {
    emit(state.copyWith(currentScreenIndex: index));
  }

  void getReviewes(String itemId, ReviewType type) async {
    emit(state.copyWith(reviewesStatus: Status.loading));
    try {
      final reviews = await repo.getReviewes(itemId, type);
      emit(state.copyWith(reviewesStatus: Status.success, reviews: reviews));
    } catch (e) {
      emit(state.copyWith(reviewesStatus: Status.error, msg: e.toString()));
    }
  }

  void addReview(ReviewModel review, bool isProperty) async {
    emit(state.copyWith(reviewStatus: Status.loading));
    try {
      final newReview = await repo.addReview(review);
      emit(
        state.copyWith(
          reviewStatus: Status.success,
          reviews: [...state.reviews, newReview],
          msg: 'Review added successfully',
        ),
      );
    } catch (e) {
      emit(state.copyWith(reviewStatus: Status.error, msg: e.toString()));
    }
  }

  void updatePropertyReview(ReviewModel review) {
    emit(
      state.copyWith(
        property: state.property.copyWith(
          review: review,
          totalRate:
              ((state.property.totalRate * state.property.reviewsCount) + review.rating) / (state.property.reviewsCount + 1),
          reviewsCount: state.property.reviewsCount + 1,
        ),
      ),
    );
  }

  void updateReview(String id, String comment, int rating) async {
    emit(state.copyWith(reviewStatus: Status.loading));
    try {
      await repo.updateReview(id, comment, rating);
      emit(
        state.copyWith(
          reviewStatus: Status.success,
          reviews: [...state.reviews.map((r) => r.id == id ? r.copyWith(comment: comment, rating: rating) : r)],
          msg: 'Review updated successfully',
        ),
      );
    } catch (e) {
      emit(state.copyWith(reviewStatus: Status.error, msg: e.toString()));
    }
  }

  void deleteReview(String id) async {
    emit(state.copyWith(reviewStatus: Status.loading));
    try {
      await repo.deleteReview(id);
      emit(
        state.copyWith(
          reviewStatus: Status.success,
          reviews: state.reviews.where((r) => r.id != id).toList(),
          msg: 'Review deleted successfully',
        ),
      );
    } catch (e) {
      emit(state.copyWith(reviewStatus: Status.error, msg: e.toString()));
    }
  }

  void initReviewStatus() => emit(state.copyWith(reviewStatus: Status.initial));

  void updateUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String imagePath,
  }) async {
    emit(state.copyWith(updateUserStatus: Status.loading));
    try {
      final user = await repo.updateUser(firstName: firstName, lastName: lastName, phone: phone, imagePath: imagePath);
      emit(state.copyWith(updateUserStatus: Status.success, user: user));
    } catch (e) {
      emit(state.copyWith(updateUserStatus: Status.error, msg: e.toString()));
    }
  }

  void loadNotifications({bool fetchNext = false}) async {
    if (fetchNext && !_hasNextNotificationsPage || state.loadNotificationsStatus == Status.loading) return;
    emit(state.copyWith(loadNotificationsStatus: Status.loading));
    try {
      final notifications = await repo.fetchNotifications(fetchNext);
      _hasNextNotificationsPage = notifications.hasNextPage;
      emit(state.copyWith(loadNotificationsStatus: Status.success, notifications: notifications.notifications));
    } catch (e) {
      emit(state.copyWith(loadNotificationsStatus: Status.error, msg: e.toString()));
    } finally {
      emit(state.copyWith(loadNotificationsStatus: Status.initial));
    }
  }

  void readNotification(String id) async {
    emit(state.copyWith(readNotificationStatus: Status.loading));
    try {
      await repo.readNotification(id);
      emit(
        state.copyWith(
          readNotificationStatus: Status.success,
          notifications: [
            ...state.notifications.map((notification) {
              if (notification.id == id) {
                return notification.copyWith(isRead: true);
              }
              return notification;
            }),
          ],
        ),
      );
    } catch (e) {
      emit(state.copyWith(readNotificationStatus: Status.error, msg: e.toString()));
    } finally {
      emit(state.copyWith(readNotificationStatus: Status.initial));
    }
  }

  void initNotifications() => emit(state.copyWith(notifications: []));
}
