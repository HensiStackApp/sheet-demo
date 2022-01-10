import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/gridview_page/showdetail.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class GridPage extends StatefulWidget {
  const GridPage({Key key}) : super(key: key);

  @override
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  int variableSet = 0;
  ScrollController _scrollController;
  TabController tabController;
  List grid1 = [
    {"name": "Java", "color": themeColor1},
    {"name": "Flutter", "color": themeColor2},
    {"name": "Ios", "color": themeColor2},
    {"name": "Android", "color": themeColor4},
    {"name": "Python", "color": themeColor5},
  ];

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      body: DragAndDropGridView(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4.5,
        ),
        itemCount: grid1.length,
        itemBuilder: (BuildContext ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowDetailPage(
                        color: grid1[index]["color"],
                        name: grid1[index]["name"],
                      ),
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                // child: Text(
                //   grid1[index]["name"],
                //   style: TextStyle(fontSize: 17, color: white),
                // ),
                decoration: BoxDecoration(
                    color: grid1[index]["color"],
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          );
        },
        onWillAccept: (oldIndex, newIndex) {
          // Implement you own logic

          // Example reject the reorder if the moving item's value is something specific
          if (grid1[newIndex] == "something") {
            return false;
          }
          return true; // If you want to accept the child return true or else return false
        },
        onReorder: (oldIndex, newIndex) {
          final temp = grid1[oldIndex];
          grid1[oldIndex] = grid1[newIndex];
          grid1[newIndex] = temp;

          setState(() {});
        },
      ),

      // GridView.builder(
      //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //         maxCrossAxisExtent: 200,
      //         childAspectRatio: 3 / 2,
      //         crossAxisSpacing: 10,
      //         mainAxisSpacing: 10),
      //     itemCount: grid1.length,
      //     itemBuilder: (BuildContext ctx, index) {
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: InkWell(
      //           onTap: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => ShowDetailPage(
      //                     color: grid1[index]["color"],
      //                     name: grid1[index]["name"],
      //                   ),
      //                 ));
      //           },
      //           child: Container(
      //             alignment: Alignment.center,
      //             child: Text(
      //               grid1[index]["name"],
      //               style: TextStyle(fontSize: 17, color: white),
      //             ),
      //             decoration: BoxDecoration(
      //                 color: grid1[index]["color"], borderRadius: BorderRadius.circular(15)),
      //           ),
      //         ),
      //       );
      //     }),

      // bottomNavigationBar: BottomNavigationBar(
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.green),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.search), label: 'Search', backgroundColor: Colors.yellow),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Profile',
      //         backgroundColor: Colors.blue,
      //       ),
      //     ],
      //     // type: BottomNavigationBarType.shifting,
      //     currentIndex: _selectedIndex,
      //     selectedItemColor: Colors.black,
      //     iconSize: 40,
      //     onTap: _onItemTapped,
      //     elevation: 5),
    );
  }
//
// void _onItemTapped(int index) {
//   setState(() {
//     _selectedIndex = index;
//   });
// }
}
/*

import 'package:flutter/material.dart';

class GridPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GridPageState();
  }
}

class _GridPageState extends State<GridPage> with TickerProviderStateMixin {
  String move;
  List<Tween> _switchTween = List();
  List<Animation> _switchAnim = List();
  List<AnimationController> _switchAnimCont = List();
  double width;

  @override
  void initState() {
    // Add a tween and a controller for each element
    for (int i = 0; i < 5; i++) {
      _switchAnimCont.add(AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
      ));
      _switchTween.add(Tween<Offset>(begin: Offset.zero, end: Offset(0, 1)));
      _switchAnim.add(_switchTween[i].animate(_switchAnimCont[i]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width / 5;
    return Stack(
      children: <Widget>[
        square(0, 0, 0),
        square(1, width, 0),
        square(2, 2 * width, 0),
        square(3, 3 * width, 0),
        square(4, 4 * width, 0),
      ],
    );
  }

  Widget square(int index, double left, double bottom) {
    return Positioned(
      left: left,
      bottom: bottom,
      width: width,
      height: width,
      child: SlideTransition(
        position: _switchAnim[index],
        child: GestureDetector(
          // Figure out swipe's direction
          onHorizontalDragUpdate: (drag) {
            if (drag.delta.dx > 10) move = 'right';
            if (drag.delta.dx < -10) move = 'left';
          },
          onHorizontalDragEnd: (drag) {
            switch (move) {
              case 'right':
                {
                  moveRight(index);
                  break;
                }
              case 'left':
                {
                  moveLeft(index);
                  break;
                }
            }
          },
          child: Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.0))),
          ),
        ),
      ),
    );
  }

  void moveRight(int index) {
    // Move the grid element that you swiped on
    _switchTween[index].end = Offset(1, 0);
    _switchAnimCont[index].forward();

    // Move the element next to it the opposite way
    _switchTween[index + 1].end = Offset(-1, 0);
    _switchAnimCont[index + 1].forward();

    // You could need to refresh the corresponding controller to animate again
  }

  void moveLeft(int index) {
    _switchTween[index].end = Offset(-1, 0);
    _switchAnimCont[index].forward();
    _switchTween[index - 1].end = Offset(1, 0);
    _switchAnimCont[index - 1].forward();
  }
}
*/
