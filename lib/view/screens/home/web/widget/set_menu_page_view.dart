import 'package:flutter/material.dart';
import 'package:flutter_restaurant/provider/set_menu_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../data/model/response/cart_model.dart';
import '../../../../../helper/date_converter.dart';
import '../../../../../helper/price_converter.dart';
import '../../../../../localization/language_constrants.dart';
import '../../../../../provider/splash_provider.dart';
import '../../../../../provider/theme_provider.dart';
import '../../../../../utill/color_resources.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../../utill/images.dart';
import '../../../../../utill/styles.dart';
import '../../../../base/custom_snackbar.dart';
import '../../../../base/on_hover.dart';
import '../../../../base/rating_bar.dart';
import '../../widget/cart_bottom_sheet.dart';
import 'CartBottomSheetWeb.dart';

class SetMenuPageView extends StatelessWidget {
  final SetMenuProvider setMenuProvider;
  final PageController pageController;
  const SetMenuPageView({Key key, @required this.setMenuProvider, @required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _totalPage = (setMenuProvider.setMenuList.length / 4).ceil();

    return Container(
      child: PageView.builder(
        controller: pageController,
        itemCount: _totalPage,
        onPageChanged: (index) {
          setMenuProvider.updateSetMenuCurrentIndex(index, _totalPage);
        },
        itemBuilder: (context, index) {
          int _initialLength = 4;
          int currentIndex = 4 * index;
          double _startingPrice;
          double _endingPrice;
          if(setMenuProvider.setMenuList[index].choiceOptions.length != 0) {
            List<double> _priceList = [];
            setMenuProvider.setMenuList[index].variations.forEach((variation) => _priceList.add(variation.price));
            _priceList.sort((a, b) => a.compareTo(b));
            _startingPrice = _priceList[0];
            if(_priceList[0] < _priceList[_priceList.length-1]) {
              _endingPrice = _priceList[_priceList.length-1];
            }
          }else {
            _startingPrice = setMenuProvider.setMenuList[index].price;
          }

          double _discount = setMenuProvider.setMenuList[index].price - PriceConverter.convertWithDiscount(context,
              setMenuProvider.setMenuList[index].price, setMenuProvider.setMenuList[index].discount, setMenuProvider.setMenuList[index].discountType);

          bool _isAvailable = DateConverter.isAvailable(setMenuProvider.setMenuList[index].availableTimeStarts, setMenuProvider.setMenuList[index].availableTimeEnds, context);

          // ignore: unnecessary_statements
          (index + 1 == _totalPage) ? _initialLength = setMenuProvider.setMenuList.length - (index * 4)  : 4;
          return ListView.builder(
              itemCount: _initialLength, scrollDirection: Axis.horizontal, physics: NeverScrollableScrollPhysics(), shrinkWrap: true,
              itemBuilder: (context, item) {
                int _currentIndex = item  + currentIndex;
                String _name = '';
                setMenuProvider.setMenuList[_currentIndex].name.length > 20 ? _name = setMenuProvider.setMenuList[_currentIndex].name.substring(0, 20)+' ...' : _name = setMenuProvider.setMenuList[_currentIndex].name;
                return OnHover(
                    builder: (isHover) {
                      return InkWell(
                        onTap: () {
                          showDialog(context: context, builder: (con) => Dialog(
                            child: CartBottomSheetWeb(
                              product: setMenuProvider.setMenuList[_currentIndex], fromSetMenu: true,
                              callback: (CartModel cartModel) {
                                showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                              },
                            ),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
                          child: Container(
                            height: 360,
                            width: 280,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                  color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
                                  blurRadius: 5, spreadRadius: 1,
                                )]
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: Images.placeholder_rectangle, height: 225.0, width: 368, fit: BoxFit.cover,
                                          image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${setMenuProvider.setMenuList[_currentIndex].image}',
                                          imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_rectangle, height: 225.0, width: 368, fit: BoxFit.cover),
                                        ),
                                      ),
                                      _isAvailable ? SizedBox() : Positioned(
                                        top: 0, left: 0, bottom: 0, right: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                            color: Colors.black.withOpacity(0.6),
                                          ),
                                          child: Text(getTranslated('not_available_now', context), textAlign: TextAlign.center, style: rubikRegular.copyWith(
                                            color: Colors.white, fontSize: Dimensions.FONT_SIZE_SMALL,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Text(_name, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.getCartTitleColor(context)), maxLines: 2, overflow: TextOverflow.ellipsis),
                                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                        RatingBar(rating: setMenuProvider.setMenuList[_currentIndex].rating.length > 0 ? double.parse(setMenuProvider.setMenuList[_currentIndex].rating[0].average) : 0.0, size: Dimensions.PADDING_SIZE_DEFAULT),
                                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            _discount > 0 ? Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                              child: Text(
                                                  '${PriceConverter.convertPrice(context, _startingPrice, asFixed: 1)}'
                                                      '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, asFixed: 1)}' : ''}',
                                                  style: TextStyle(decoration: TextDecoration.lineThrough)
                                              ),
                                            ) : SizedBox(),
                                            Text(
                                              '${PriceConverter.convertPrice(context, _startingPrice, discount: setMenuProvider.setMenuList[index].discount,
                                                  discountType: setMenuProvider.setMenuList[index].discountType, asFixed: 1)}''${_endingPrice!= null
                                                  ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: setMenuProvider.setMenuList[index].discount,
                                                  discountType: setMenuProvider.setMenuList[index].discountType, asFixed: 1)}' : ''}',
                                              style: rubikBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.APPBAR_HEADER_COL0R),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                        ElevatedButton(
                                            style : ElevatedButton.styleFrom(primary: ColorResources.APPBAR_HEADER_COL0R),
                                            onPressed: (){
                                              showDialog(context: context, builder: (con) => Dialog(
                                                child: CartBottomSheet(
                                                  product: setMenuProvider.setMenuList[index], fromSetMenu: true,
                                                  callback: (CartModel cartModel) {
                                                    showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                                                  },
                                                ),
                                              ));
                                            }, child: Padding(
                                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                            Text(getTranslated('quick_view', context),style: robotoRegular), SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                          ]),
                                        ))
                                      ]),
                                    ),
                                  ),

                                ]),
                          ),
                        ),
                      );
                    }
                );
              }
          );
        },
      ),
    );
  }
}
