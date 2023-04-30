import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/categories_model/categories_model.dart';
import 'package:shopping_app/shared/cubit/shoplayout_cubit.dart';
import 'package:shopping_app/shared/states/shoplayout_states.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ShopLayoutCubit>(context);
        return cubit.categoriesModel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: cubit.categoriesModel!.data!.data!.length,
                itemBuilder: (context, index) =>
                    buildListItem(cubit.categoriesModel!.data!.data![index]),
                separatorBuilder: (context, index) =>const Divider(
                  height: 5.0,
                ),
              );
      },
    );
  }
}

Widget buildListItem(DataCModel dataModel) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.network(
            dataModel.image!,
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            '${dataModel.name}',
            style: TextStyle(color: Colors.black),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 30.0,
          )
        ],
      ),
    );
