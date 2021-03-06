import 'package:flutter/material.dart';
import 'package:flutter_restaurant/helper/menu_type.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/utill/routes.dart';
import 'package:flutter_restaurant/view/base/mars_menu_bar.dart' as m;

class MenuBar extends StatelessWidget {
  final bool isLeft;
  MenuBar(this.isLeft);
  List<m.MenuItem> getCartMenu(BuildContext context) {
    return [
      m.MenuItem(
        menuType: MenuType.menu,
        onTap: () => Navigator.pushNamed(context, Routes.getDashboardRoute('menu')),
      ),
      m.MenuItem(
        menuType: MenuType.cart,
        icon: Icons.shopping_cart,
        onTap: () => Navigator.pushNamed(context, Routes.getDashboardRoute('cart')),
      ),
    ];
  }
  List<m.MenuItem> getMenus(BuildContext context) {
    return [
      m.MenuItem(
        menuType: MenuType.text,
        title: getTranslated('home', context),
        onTap: () => Navigator.pushNamed(context, Routes.getDashboardRoute('home')),
      ),

      // MenuItem(
      //   menuType: MenuType.text,
      //   title: 'Categories',
      //   onTap: () => {
      //
      //   }
      //   //children:[for(var i = 0; i < Provider.of<CategoryProvider>(context, listen: false).categoryList.length; i++) MenuItem(menuType: MenuType.text, title: Provider.of<CategoryProvider>(context, listen: false).categoryList[i].name)]
      // ),
      m.MenuItem(
        menuType: MenuType.text,
        title: 'Favourite',
        onTap: () => Navigator.pushNamed(context, Routes.getDashboardRoute('favourite')),
      ),
      // MenuItem(
      //   menuType: MenuType.search
      // ),
      

    ];
    // return [
    //   MenuItem(
    //     title: getTranslated('home', context),
    //     icon: Icons.home_filled,
    //     onTap: () => Navigator.pushNamed(context, Routes.getDashboardRoute('home')),
    //   ),
    //   MenuItem(
    //     title: getTranslated('set_menu', context),
    //     icon: Icons.fastfood_outlined,
    //     onTap: () => Navigator.pushNamed(context, Routes.getSetMenuRoute()),
    //   ),
    //   MenuItem(
    //     title: getTranslated('necessary_links', context),
    //     icon: Icons.settings,
    //     children: [
    //       MenuItem(
    //         title: getTranslated('privacy_policy', context),
    //         onTap: () => Navigator.pushNamed(context, Routes.getPolicyRoute()),
    //       ),
    //       MenuItem(
    //         title: getTranslated('terms_and_condition', context),
    //         onTap: () => Navigator.pushNamed(context, Routes.getTermsRoute()),
    //       ),
    //       MenuItem(
    //         title: getTranslated('about_us', context),
    //         onTap: () => Navigator.pushNamed(context, Routes.getAboutUsRoute()),
    //       ),
    //
    //     ],
    //   ),
    //   MenuItem(
    //     title: getTranslated('favourite', context),
    //     icon: Icons.favorite_border,
    //     onTap: () => Navigator.pushNamed(context, Routes.getDashboardRoute('favourite')),
    //   ),
    //
    //   MenuItem(
    //     title: getTranslated('menu', context),
    //     icon: Icons.menu,
    //     onTap: () => Navigator.pushNamed(context, Routes.getDashboardRoute('menu')),
    //   ),
    //
    //   _isLoggedIn ?  MenuItem(
    //     title: getTranslated('profile', context),
    //     icon: Icons.person,
    //     onTap: () =>  Navigator.pushNamed(context, Routes.getProfileRoute()),
    //   ):  MenuItem(
    //     title: getTranslated('login', context),
    //     icon: Icons.lock,
    //     onTap: () => Navigator.pushNamed(context, Routes.getLoginRoute()),
    //   ),
    //   MenuItem(
    //     menuType: MenuType.cart,
    //     title: '',
    //     icon: Icons.shopping_cart,
    //     onTap: () => Navigator.pushNamed(context, Routes.getDashboardRoute('cart')),
    //   ),
    //
    // ];
  }

  @override
  Widget build(BuildContext context) {

    return Container(
    //   //color: Colors.white,
    // width: 800,
      child: m.PlutoMenuBar(
        backgroundColor: Theme.of(context).cardColor,
        gradient: false,
        goBackButtonText: 'Back',
        textStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
        moreIconColor: Theme.of(context).textTheme.bodyText1.color,
        menuIconColor: Theme.of(context).textTheme.bodyText1.color,
        menus: isLeft ?  getMenus(context) : getCartMenu(context),

      ),
    );
  }
}