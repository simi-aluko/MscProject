import 'package:flutter/material.dart';
import 'package:msc_project/utils.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("HealthCompany.co"),
            accountEmail: const Text("healthcompany@appmaking.co"),
            currentAccountPicture: CircleAvatar(
              child: Image.asset(
                imgHospBuilding,
                height: 45,
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xff384656),
            ),
          ),
          const DrawerListTile(
            icon: imgLiver,
            title: liver,
          ),
          const DrawerListTile(
            icon: imgPancreas,
            title: pancreas,
          ),
          const DrawerListTile(
            icon: imgHeart,
            title: heart,
          ),
          const Divider(),
          const DrawerListTile(
            icon: imgBox,
            title: addScubaBox,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String icon;
  final String title;
  const DrawerListTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 28,
        child: Image.asset(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(primaryColor),
          fontSize: 16,
        ),
      ),
      minLeadingWidth: 10,
      onTap: () {},
    );
  }
}
