import 'package:flutter/material.dart';
import 'package:msc_project/app_utils.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(),
          DrawerListTile(
            icon: imgLiver,
            title: liver,
          ),
          DrawerListTile(
            icon: imgPancreas,
            title: pancreas,
          ),
          DrawerListTile(
            icon: imgHeart,
            title: heart,
          ),
          Divider(),
          DrawerListTile(
            icon: imgBox,
            title: addScubaBox,
          ),
        ],
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
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
