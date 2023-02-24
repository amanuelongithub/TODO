import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  // const NavigationDrawerWidget({}) ;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(0)),
      child: Drawer(
        child: Material(
            child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 180,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 225, 225, 225)),
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "TODO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Efimah",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 15,
            ),
            buildMenuItem(
                context: context,
                text: 'Home',
                size: 20,
                icons: Icons.home,
                onClicked: () => selectedItem(context, 0)),
            const SizedBox(
              height: 15,
            ),
            buildMenuItem(
                context: context,
                text: 'Favourites',
                size: 20,
                icons: Icons.favorite,
                onClicked: () => selectedItem(context, 2)),
            const SizedBox(
              height: 10,
            ),
            buildMenuItem(
                context: context,
                text: 'Recycle bin',
                size: 20,
                icons: Icons.recycling_outlined,
                onClicked: () => selectedItem(context, 2)),
            const SizedBox(
              height: 10,
            ),
            Divider(),
            buildMenuItem(
                context: context,
                text: 'Setting',
                size: 20,
                icons: Icons.settings,
                onClicked: () => selectedItem(context, 4)),
            const SizedBox(
              height: 10,
            ),
            buildMenuItem(
                context: context,
                text: 'Help',
                size: 20,
                icons: Icons.help,
                onClicked: () => selectedItem(context, 4)),
          ],
        )),
      ),
    );
  }

  Widget buildMenuItem(
      {String? text,
      double? size,
      IconData? icons,
      VoidCallback? onClicked,
      BuildContext? context}) {
    final color = Color.fromARGB(255, 130, 130, 130);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 30),
        onTap: onClicked,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor:
            icons == Icons.home ? Color.fromARGB(141, 207, 207, 207) : null,
        leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: icons == Icons.home
                    ? Colors.black
                    : Color.fromARGB(255, 215, 215, 215),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(
              icons,
              color: icons == Icons.home ? Colors.white : Colors.black,
              size: 20,
            )),
        title: Text(
          text!,
          style: TextStyle(
              color: color, fontSize: size, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Container()));

        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => Container(),
        // ));

        break;
      case 2:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => Material(child: Container()),
        // ));

        break;
      case 3:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => Material(child: Container()),
        // ));

        break;
      default:
    }
  }
}
