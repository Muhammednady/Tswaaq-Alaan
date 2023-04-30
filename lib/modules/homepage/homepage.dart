import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/categories_model/categories_model.dart';
import 'package:shopping_app/models/shoplayout_model/shoplayout_model.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/shoplayout_cubit.dart';
import '../../shared/states/shoplayout_states.dart';
import '../../shared/styles/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {
            if(state is ShopLayoutSuccessChangeFavoriteState){
              if(!state.fModel.status!){
                showToast(state.fModel.message!,ToastStates.ERROR);
              }
            }

        },
        builder: (context, state) {
          var cubit = BlocProvider.of<ShopLayoutCubit>(context);

          return cubit.homeModel == null || cubit.categoriesModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : HomeBuilder(cubit.homeModel!, cubit.categoriesModel!, context);
        });
  }
}
////////////////////////////////////////*//////////////////////////////////////////////////
Widget HomeBuilder(
        HomeModel homeModel, CategoriesModel categoriesModel, context) =>
    Container(
      color: Colors.grey[300],
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel.data!.banners
                  .map<Image>((e) => Image.network(
                        e.image!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250.0,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayInterval: Duration(seconds: 3),
                  reverse: false,
                  scrollPhysics: const BouncingScrollPhysics(),
                  viewportFraction: 1.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 25.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriesModel.data!.data.length,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 5.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'New Products',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 25.0),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.68,
              crossAxisCount: 2,
              children: List.generate(
                  homeModel.data!.products.length,
                  (int index) =>
                      buildGridItem(homeModel.data!.products[index],context)),
            )
          ],
        ),
      ),
    );
Widget buildCategoryItem(DataCModel dataModel) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image.network(
          dataModel.image!,
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
            color: Colors.black.withOpacity(0.8),
            width: 100.0,
            child: Text(
              '${dataModel.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            )),
      ],
    );
/////////////////////////////////////////////////////////////////////////
Widget buildGridItem( ProductsModel productsModel,context) =>
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image.network(
                productsModel.image!,
                // fit: BoxFit.cover,
                height: 200.0,
              ),
              if (productsModel.discount != 0)
                Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                            color: Colors.white, fontSize: 8.0),
                      ),
                    )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${productsModel.name}',
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      '${productsModel.price.round()}',
                      style:
                          TextStyle(color: activeColor, fontSize: 12.0),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (productsModel.discount != 0)
                      Text(
                        '${productsModel.oldPrice.round()}',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopLayoutCubit.get(context).changeFavorites(productsModel.id!);
                        
                        },
                        icon: CircleAvatar(
                          radius: 14.0,
                          backgroundColor: ShopLayoutCubit.get(context).favorites[productsModel.id!]!? activeColor : Colors.grey,
                            child: Icon(Icons.favorite_border,color: Colors.white,)))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
