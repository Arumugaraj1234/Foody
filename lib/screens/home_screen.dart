import 'package:flutter/material.dart';
import 'package:foody/models/dish_data.dart';
import 'package:foody/models/network_response.dart';
import 'package:foody/support_files/api_services.dart';
import 'package:foody/widgets/dish_details_widget.dart';
import 'package:provider/provider.dart';
import 'package:foody/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  void getDishsesDetails() async {
    NetworkResponse response = await ApiService.shared.getAppInitDetails();
    if (response.responseCode == 1) {
      List<CategoryModel> categories = response.responseData;
      print('Raj: $categories');
      Provider.of<DishData>(context, listen: false).setCategories(categories);

      setState(() {
        allTabs = setTabs(
            Provider.of<DishData>(context, listen: false).getCategories);
        //allTabsView =setTabBarView(Provider.of<DishData>(context).getCategories);
        tabsCount =
            Provider.of<DishData>(context, listen: false).getCategories.length;
        _controller = TabController(length: tabsCount, vsync: this);
      });
//      setState(() {
//        allTabs = setTabs(categories);
//        allTabsView = setTabBarView(categories);
//        tabsCount = categories.length;
//      });
    }
    //print('Response: ${response.responseData.toString()}');
  }

  List<Widget> setTabs(List<CategoryModel> cat) {
    List<CategoryModel> categories = cat;
    List<Widget> resultWidget = [];
    for (var category in categories) {
      Widget tab = Tab(
        text: category.categoryName,
      );
      resultWidget.add(tab);
    }
    return resultWidget;
  }

  Widget setCartCount() {
    return Consumer<DishData>(builder: (context, dishData, child) {
      return Text(
        Provider.of<DishData>(context, listen: false)
            .selectedItemsCount
            .toString(),
        style: new TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      );
    });
  }

  Widget setTabBarView() {
    Widget result = Consumer<DishData>(builder: (context, dishData, child) {
      List<CategoryModel> categories = dishData.getCategories;
      List<Widget> resultWidget = [];
      for (var category in categories) {
        Widget temp = Container(
          child: ListView(
            children: List.generate(category.dishes.length, (index) {
              return DishDetailsWidget(
                dishDetail: category.dishes[index],
                onPlusTapped: () {
                  Provider.of<DishData>(context, listen: false).addItem(
                      categoryIndex: _controller.index, dishIndex: index);
                },
                onMinusTapped: () {
                  if (category.dishes[index].addedCount > 0) {
                    Provider.of<DishData>(context, listen: false).removeItem(
                        categoryIndex: _controller.index, dishIndex: index);
                  }
                },
              );
            }),
          ),
        );
        resultWidget.add(temp);
      }
      return TabBarView(
        controller: _controller,
        children: resultWidget,
      );
    });
    return result;
  }

  List<Widget> allTabs = [];
  List<Widget> allTabsView = [];
  int tabsCount = 0;

  @override
  void initState() {
    super.initState();
    getDishsesDetails();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabsCount,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
              actions: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      children: <Widget>[
                        new Icon(
                          Icons.shopping_cart,
                          color: Colors.grey,
                          size: 30.0,
                        ),
                        new Positioned(
                          right: 0,
                          child: new Container(
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: setCartCount(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              bottom: TabBar(
                tabs: allTabs,
                indicatorColor: Colors.red,
                labelColor: Colors.red,
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
              )),
          body: setTabBarView(),
        ));
  }
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar({@required this.tabBar, @required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}
/*
DecoratedTabBar(
tabBar: TabBar(
tabs: [
Tab(
icon: Icon(
Icons.school,
color: Colors.black,
),
text: 'Hi djdbd fdhfbdsaf dsfbdsfdsfdbfdsn',
),
Tab(
icon: Icon(
Icons.home,
color: Colors.black,
),
),
Tab(
icon: Icon(
Icons.local_hospital,
color: Colors.black,
),
),
],
indicatorColor: Colors.red,
labelColor: Colors.black,
),
decoration: BoxDecoration(
border: Border(
bottom: BorderSide(
color: Colors.white,
width: 2.0,
),
),
),
),*/

/*
new Container(
child: ListView(
children: <Widget>[
Container(
decoration: BoxDecoration(
border: Border(
bottom: BorderSide(color: Colors.grey, width: 1),
),
),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Container(
child: Align(
alignment: Alignment.topLeft,
child: Image.asset('images/veg_icon.png'),
),
),
SizedBox(
width: 10.0,
),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Text(
'Spinach Salad',
style: TextStyle(
color: Colors.black87,
fontWeight: FontWeight.bold,
fontSize: 18.0),
),
SizedBox(
height: 5.0,
),
Row(
children: <Widget>[
Expanded(
child: Align(
alignment: Alignment.centerLeft,
child: Text(
'INR 7.95',
style: TextStyle(
color: Colors.black87,
fontWeight: FontWeight.bold,
fontSize: 18.0),
),
)),
Expanded(
child: Align(
alignment: Alignment.centerRight,
child: Text(
'15 Calories',
style: TextStyle(
color: Colors.black87,
fontWeight: FontWeight.bold,
fontSize: 18.0),
),
))
],
),
SizedBox(
height: 10.0,
),
Text(
'Fresh spinach, mushrooms, and hard-boiled egg served with warm bacon vinaigrette',
style: TextStyle(
color: Colors.black54,
fontWeight: FontWeight.normal,
fontSize: 16.0),
),
SizedBox(
height: 10.0,
),
Container(
width: 150.0,
height: 50.0,
decoration: BoxDecoration(
color: Colors.green,
borderRadius: BorderRadius.all(
Radius.circular(25.0),
),
),
child: Row(
children: <Widget>[
Expanded(
child: IconButton(
icon: Icon(
Icons.remove,
color: Colors.white,
),
onPressed: () {}),
),
Expanded(
child: Center(
child: Text(
'0',
style: TextStyle(
color: Colors.white,
fontSize: 20.0),
),
),
),
Expanded(
child: IconButton(
icon: Icon(
Icons.add,
color: Colors.white,
),
onPressed: () {}),
)
],
),
),
Visibility(
visible: true,
child: MaterialButton(
onPressed: () {},
child: Text(
'Customizations Available',
style: TextStyle(
color: Colors.red, fontSize: 16.0),
),
),
)
],
),
),
SizedBox(
width: 10.0,
),
Align(
alignment: Alignment.topCenter,
child: Container(
height: 100.0,
width: 70.0,
foregroundDecoration: BoxDecoration(
image: DecorationImage(
image: NetworkImage(
'http://restaurants.unicomerp.net//images/Restaurant/1010000001/Item/Items/100000001.jpg'),
fit: BoxFit.fill),
),
alignment: Alignment.center,
),
),
],
),
),
),
Container(
decoration: BoxDecoration(
border: Border(
bottom: BorderSide(color: Colors.grey, width: 1),
),
),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Container(
child: Align(
alignment: Alignment.topLeft,
child: Image.asset('images/nonveg_icon.png'),
),
),
SizedBox(
width: 10.0,
),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Text(
'Traditional New England Seafood Chowder',
style: TextStyle(
color: Colors.black87,
fontWeight: FontWeight.bold,
fontSize: 18.0),
),
SizedBox(
height: 5.0,
),
Row(
children: <Widget>[
Expanded(
child: Align(
alignment: Alignment.centerLeft,
child: Text(
'INR 12.00',
style: TextStyle(
color: Colors.black87,
fontWeight: FontWeight.bold,
fontSize: 18.0),
),
)),
Expanded(
child: Align(
alignment: Alignment.centerRight,
child: Text(
'30 Calories',
style: TextStyle(
color: Colors.black87,
fontWeight: FontWeight.bold,
fontSize: 18.0),
),
))
],
),
SizedBox(
height: 10.0,
),
Text(
'with clams, scallops, and shrimp,',
style: TextStyle(
color: Colors.black54,
fontWeight: FontWeight.normal,
fontSize: 16.0),
),
SizedBox(
height: 10.0,
),
Container(
width: 150.0,
height: 50.0,
decoration: BoxDecoration(
color: Colors.green,
borderRadius: BorderRadius.all(
Radius.circular(25.0),
),
),
child: Row(
children: <Widget>[
Expanded(
child: IconButton(
icon: Icon(
Icons.remove,
color: Colors.white,
),
onPressed: () {}),
),
Expanded(
child: Center(
child: Text(
'0',
style: TextStyle(
color: Colors.white,
fontSize: 20.0),
),
),
),
Expanded(
child: IconButton(
icon: Icon(
Icons.add,
color: Colors.white,
),
onPressed: () {}),
)
],
),
),
Visibility(
visible: false,
child: MaterialButton(
onPressed: () {},
child: Text(
'Customizations Available',
style: TextStyle(
color: Colors.red, fontSize: 16.0),
),
),
)
],
),
),
SizedBox(
width: 10.0,
),
Align(
alignment: Alignment.topCenter,
child: Container(
height: 100.0,
width: 70.0,
foregroundDecoration: BoxDecoration(
image: DecorationImage(
image: NetworkImage(
'http://restaurants.unicomerp.net/images/Restaurant/1010000001/Item/Items/100000003.jpg'),
fit: BoxFit.fill),
),
alignment: Alignment.center,
),
),
],
),
),
)
],
)),*/
