import 'package:shopping_app/models/shoplogin_model.dart';

import '../../models/changeFavorites_model/changeFavorites_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitialState extends ShopLayoutStates {}

class ShopLayoutChangeBottomState extends ShopLayoutStates {}

class ShopLayoutHomeLoadingState extends ShopLayoutStates {}

class ShopLayoutHomeSuccessState extends ShopLayoutStates {}

class ShopLayoutHomeErrorState extends ShopLayoutStates {
  final String error;

  ShopLayoutHomeErrorState(this.error);
}

class ShopLayoutCategoriesLoadingState extends ShopLayoutStates {}

class ShopLayoutCategoriesSuccessState extends ShopLayoutStates {}

class ShopLayoutCategoriesErrorState extends ShopLayoutStates {
  final String error;

  ShopLayoutCategoriesErrorState(this.error);
}

class ShopLayoutChangeFavoriteState extends ShopLayoutStates {}

class ShopLayoutSuccessChangeFavoriteState extends ShopLayoutStates {
  final ChangeFavoritesModel fModel;

  ShopLayoutSuccessChangeFavoriteState(this.fModel);
}

class ShopLayoutErrorChangeFavoriteState extends ShopLayoutStates {
  final String error;

  ShopLayoutErrorChangeFavoriteState(this.error);
}

class ShopGetFavoritesSuccessState extends ShopLayoutStates {}

class ShopGetFavoritesErrorState extends ShopLayoutStates {
  final String error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopGetFavoritesLoadingState extends ShopLayoutStates {}

class ShopGetProfileLoadingState extends ShopLayoutStates {}

class ShopGetProfileSuccessState extends ShopLayoutStates {}
class ShopGetProfileErrorState extends ShopLayoutStates {

  final String error;
  ShopGetProfileErrorState(this.error);
}

class UpdateLoadingState extends ShopLayoutStates{}
class UpdateSuccessState extends ShopLayoutStates{
  final ShopLogInModel updateModel;

  UpdateSuccessState(this.updateModel);
}
class UpdateErrorState extends ShopLayoutStates{
  final String error;
  UpdateErrorState(this.error);
}

class SearchLoadingState extends ShopLayoutStates{}
class SearchSuccessState extends ShopLayoutStates{
 // final ShopLogInModel updateModel;

 // UpdateSuccessState(this.updateModel);
}
class SearchErrorState extends ShopLayoutStates{
  final String error;
  SearchErrorState(this.error);
}