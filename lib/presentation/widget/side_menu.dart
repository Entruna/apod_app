import 'package:apod_app/constants/constants.dart';
import 'package:apod_app/presentation/routes.dart';
import 'package:flutter/material.dart';

///Side menu widget for navigation
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          border:Border(
            right: BorderSide( color: Colors.grey,
              style: BorderStyle.solid,
              width: 1.0,),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0, bottom: 20.0),
              decoration: BoxDecoration(border:Border(
                bottom: BorderSide( color: Colors.grey,
                  style: BorderStyle.solid,
                  width: 1.0,),
              ),
                  image: DecorationImage(fit: BoxFit.contain, image: AssetImage(StringConstants.sideMenuImage))),
              child: null,
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white,),
              title: const Text(StringConstants.home, style: TextStyle(color: Colors.white, fontSize: 18),),
              onTap: () => {
                if (ModalRoute.of(context)?.settings.name == AppRoutes.home)
                  {Navigator.pop(context)}
                else
                  {
                    Navigator.pop(context),
                    Navigator.pushReplacementNamed(context, AppRoutes.home),
                  }
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive, color: Colors.white,),
              title: const Text(StringConstants.archive, style: TextStyle(color: Colors.white, fontSize: 18)),
              onTap: () => {Navigator.pop(context), Navigator.pushReplacementNamed(context, AppRoutes.archive)},
            ),
          ],
        ),
      ),
    );
  }
}
