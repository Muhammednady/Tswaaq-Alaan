import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/shoplayout_model/shoplayout_model.dart';
import 'package:shopping_app/shared/cubit/shoplayout_cubit.dart';
import 'package:shopping_app/shared/states/shoplayout_states.dart';

import '../../models/getFavorites_model/getFavorites_model.dart';
import '../../shared/styles/colors.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);

        return state is ShopGetFavoritesLoadingState ||
                cubit.getFavoritesModel.isEmpty ||
                cubit.getFavoritesModel['data'] == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: cubit.getFavoritesModel!['data']['data'].length,
                itemBuilder: (context, index) => buildFavoriteItem(
                    cubit.getFavoritesModel!['data']['data'][index]['product'],
                    context),
              );
      },
    );
  }
}

buildFavoriteItem(Map productModel, context) => Card(
      child: Container(
        height: 100.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  productModel['image'],
                  // fit: BoxFit.cover,
                  height: 100.0,
                  width: 100.0,
                ),
                if (productModel['discount'] != 0)
                  Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 8.0),
                        ),
                      )),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${productModel['name']}',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${productModel['price'].round()}',
                        style: TextStyle(color: activeColor, fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (productModel['discount'] != 0)
                        Text(
                          '${productModel['old_price'].round()}',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopLayoutCubit.get(context)
                                .changeFavorites(productModel['id']);
                          },
                          icon: CircleAvatar(
                              radius: 14.0,
                              backgroundColor: ShopLayoutCubit.get(context)
                                      .favorites[productModel['id']]!
                                  ? activeColor
                                  : Colors.grey,
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              )))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
