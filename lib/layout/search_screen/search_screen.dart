import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/shop_layout/shop_layout.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/cubit/shoplayout_cubit.dart';
import 'package:shopping_app/shared/states/shoplayout_states.dart';

import '../../models/search_model/search_model.dart';
import '../../shared/styles/colors.dart';

class SearchSCreen extends StatelessWidget {
  SearchSCreen({super.key});

  var seachcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Search products'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DefaultTextFormField(
                    label: 'search',
                    type: TextInputType.text,
                    controll: seachcontroller,
                    prefix: Icons.search,
                    onSubmit: (value) {
                      cubit.searchProducts(value);
                    },
                    validate: (text) {
                      if (text!.isEmpty) {}
                    }),
                SizedBox(
                  height: 10.0,
                ),
                state is SearchLoadingState
                    ? Center(
                        child: LinearProgressIndicator(),
                      )
                    : cubit.searchModel == null
                        ? Container()
                        : Expanded(
                            child: ListView.builder(
                            itemCount:
                                cubit.searchModel!.data!.searchProducts.length,
                            itemBuilder: (context, index) => buildSearchItem(
                                cubit.searchModel!.data!.searchProducts[index],
                                context),
                          ))
              ],
            ),
          ),
        );
      },
    );
  }

  buildSearchItem(SearchProductModel searchproduct, context,{bool Old_Price = false}) => Card(
        child: Container(
          height: 100.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image.network(
                    searchproduct.image!,
                    // fit: BoxFit.cover,
                    height: 100.0,
                    width: 100.0,
                  ),
                  if (searchproduct.discount != 0 && Old_Price)
                    Container(
                        color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'DISCOUNT',
                            style:
                                TextStyle(color: Colors.white, fontSize: 8.0),
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
                        '${searchproduct.name}',
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${searchproduct.price.round()}',
                          style: TextStyle(color: activeColor, fontSize: 12.0),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (searchproduct.discount != 0 && Old_Price)
                          Text(
                            '${searchproduct.oldPrice}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                               ShopLayoutCubit.get(context)
                              .changeFavorites(searchproduct.id!);
                            },
                            icon: CircleAvatar(
                                radius: 14.0,
                                backgroundColor: ShopLayoutCubit.get(context).favorites[searchproduct.id!]!
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
}
