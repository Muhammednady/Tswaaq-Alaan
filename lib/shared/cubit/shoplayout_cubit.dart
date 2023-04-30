import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/categories_model/categories_model.dart';
import 'package:shopping_app/models/changeFavorites_model/changeFavorites_model.dart';
import 'package:shopping_app/models/getFavorites_model/getFavorites_model.dart';
import 'package:shopping_app/models/search_model/search_model.dart';
import 'package:shopping_app/models/shoplayout_model/shoplayout_model.dart';
import 'package:shopping_app/models/shoplogin_model.dart';
import 'package:shopping_app/modules/categories/categories.dart';
import 'package:shopping_app/modules/favourites/favourites.dart';
import 'package:shopping_app/modules/homepage/homepage.dart';
import 'package:shopping_app/modules/settings/settings.dart';
import 'package:shopping_app/shared/consonents.dart';
import 'package:shopping_app/shared/network/remote.dart';
import 'package:shopping_app/shared/states/login_states.dart';
import 'package:shopping_app/shared/states/shoplayout_states.dart';
import '../components/components.dart';
import '../network/end_points.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialState());

  HomeModel? homeModel;
  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> titles = ['Home Page', 'Categories', 'Favourites', 'Settings'];
  List<Widget> screens = [HomePage(), Categories(), Favorites(), Settings()];

  Map<int, bool> favorites = {};

  void changeBottomItem(int index) {
    currentIndex = index;
    emit(ShopLayoutChangeBottomState());
  }

  void getUserData(String? token) {
    emit(ShopLayoutHomeLoadingState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      print('============ value.data =============');
      print(value.data);
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites!.addAll({element.id!: element.inFavorites!});
      });

      emit(ShopLayoutHomeSuccessState());
    }).catchError((error) {
      emit(ShopLayoutHomeErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(ShopLayoutCategoriesLoadingState());

    DioHelper.getCategories(url: CATEGORIES).then((value) {
      print('===================categories============');
      print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopLayoutCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopLayoutCategoriesErrorState(error.toString()));
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopLayoutChangeFavoriteState());

    DioHelper.postData(
        url: FAVORITES,
        token: userToken,
        data: {'product_id': productId}).then((value) {
      var fModel = ChangeFavoritesModel.fromJson(value.data);

      if (!fModel.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites(userToken!);
      }

      emit(ShopLayoutSuccessChangeFavoriteState(fModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopLayoutErrorChangeFavoriteState(error.toString()));
    });
  }

  //GetFavoritesModel? getFavoritesModel;
  Map<String, dynamic> getFavoritesModel = {};

  void getFavorites(String? token) {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      // getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      print('==================value===============');
      print(value.data);

      getFavoritesModel = value.data;
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      print('================* ERROR *=================');
      print(error.toString());
      emit(ShopGetFavoritesErrorState(error.toString()));
    });
  }

  ShopLogInModel? profileModel;

  void getProfile(String? token) {
    emit(ShopGetProfileLoadingState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = ShopLogInModel.FromJson(value.data);
      emit(ShopGetProfileSuccessState());
    }).catchError((error) {
      emit(ShopGetProfileErrorState(error.toString()));
    });
  }
ShopLogInModel? updateProfileModel;
  void updateProfile(
      {required String name, required String email, required String phone}) {
    emit(UpdateLoadingState());
    DioHelper.updateProfile(url: UPDATE_PROFILE, token: userToken, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value){
        updateProfileModel = ShopLogInModel.FromJson(value.data);
       emit(UpdateSuccessState(updateProfileModel!));
    }).catchError((error){
       emit(UpdateErrorState(error.toString()));
    });
  }

   SearchModel? searchModel;

  void searchProducts(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH_PRODUCT, token: userToken,data: {'text':text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState(error.toString()));
    });
  }
}
