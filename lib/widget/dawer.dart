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
            const SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 30),
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.amber,
                    backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=600',
                    ),
                  ),
                  title: Text(
                    'Olivia',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'student',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Color.fromARGB(131, 224, 224, 224),
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
                Imageurl: 'home',
                onClicked: () => selectedItem(context, 0)),
            const SizedBox(
              height: 15,
            ),
            buildMenuItem(
                context: context,
                text: 'Notification',
                size: 20,
                Imageurl: 'notification',
                onClicked: () => selectedItem(context, 1)),
            const SizedBox(
              height: 15,
            ),
            buildMenuItem(
                context: context,
                text: 'Todo',
                size: 20,
                Imageurl: 'todo',
                onClicked: () => selectedItem(context, 2)),
            const SizedBox(
              height: 15,
            ),
            buildMenuItem(
                context: context,
                text: 'Video',
                size: 20,
                Imageurl: 'video',
                onClicked: () => selectedItem(context, 2)),
            const SizedBox(
              height: 10,
            ),
            Divider(),
            buildMenuItem(
                context: context,
                text: 'Setting',
                size: 20,
                Imageurl: 'settings',
                onClicked: () => selectedItem(context, 4)),
            buildMenuItem(
                context: context,
                text: 'Help',
                size: 20,
                Imageurl: 'help',
                onClicked: () => selectedItem(context, 4)),
          ],
        )),
      ),
    );
  }

  Widget buildMenuItem(
      {String? text,
      double? size,
      String? Imageurl,
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
            Imageurl == 'home' ? Color.fromARGB(141, 207, 207, 207) : null,
        leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 235, 235),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(
              Icons.home,
              color: Colors.black,
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
