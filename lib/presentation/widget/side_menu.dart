import 'package:apod_app/presentation/routes.dart';
import 'package:flutter/material.dart';

///Side menu widget for navigation
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green, image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/apod.png'))),
            child: null,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
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
            leading: const Icon(Icons.archive),
            title: const Text('Archive'),
            onTap: () => {Navigator.pop(context), Navigator.pushReplacementNamed(context, AppRoutes.archive)},
          ),
        ],
      ),
    );
  }
}
