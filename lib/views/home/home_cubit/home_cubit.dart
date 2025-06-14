import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/views/home/home_cubit/home_states.dart';
import 'package:shopify/views/home/home_views/favourites_screen.dart';
import '../../../models/categories_model.dart';
import '../home_views/cart_screen.dart';
import '../home_views/layout_screen.dart';
import '../home_views/profile_screen.dart';

class HomeShopCubit extends Cubit<HomeShopStates> {
  HomeShopCubit() : super(HomeShopInitialState());

  static HomeShopCubit get(BuildContext context) =>
      BlocProvider.of<HomeShopCubit>(context);

  int currentIndex = 0;
  int selectedCategoryIndex = 0;

  final List<Widget> bottomScreens = [
    const LayoutScreen(),
    const FavouriteScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  final List<Categoryy> categoriesSection = [
    Categoryy(name: 'All', icon: Icons.all_inclusive, id: 'all'),
    Categoryy(name: 'Electronics', icon: Icons.electrical_services, id: 'electronics',),
    Categoryy(name: 'Fashion', icon: Icons.checkroom, id: 'fashion'),
    Categoryy(name: 'Home', icon: Icons.home, id: 'home'),
    Categoryy(name: 'Beauty', icon: Icons.spa, id: 'beauty'),
    Categoryy(name: 'Sports', icon: Icons.sports, id: 'sports'),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomeShopSuccessState('Index changed to $index'));
  }

  void resetIndex() {
    currentIndex = 0;
    emit(HomeShopSuccessState('Index reset to 0'));
  }

  void changeBottomNav(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      emit(ShopChangeBottomNavState());
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    emit(ShopCategoryChangedState(index));
  }
}
