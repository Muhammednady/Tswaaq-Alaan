import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/search_screen/search_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/cubit/shoplayout_cubit.dart';
import 'package:shopping_app/shared/states/shoplayout_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if(state is ShopLayoutHomeErrorState){
          print('===================Error================');
          print('${state.error}');
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<ShopLayoutCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('${cubit.titles[cubit.currentIndex]}'),
            actions: [
              IconButton(onPressed: (){
               navigateToAndSave(SearchSCreen(), context);
            }, icon: Icon(Icons.search,size: 30.0,))
            ],
           // elevation: 5.0,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomItem(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view_outlined), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outlined), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]),
        );
      },
    );
  }
}
