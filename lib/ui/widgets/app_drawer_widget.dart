import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../core/images.dart';
import '../../core/strings.dart';
import '../../data/models/organ.dart';
import '../bloc/scuba_tx_bloc.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(),
          DrawerListTile(
            icon: imgLiver,
            title: stringLiver,
            organType: OrganType.liver,
          ),
          DrawerListTile(
            icon: imgPancreas,
            title: stringPancreas,
            organType: OrganType.pancreas,
          ),
          DrawerListTile(
            icon: imgHeart,
            title: stringHeart,
            organType: OrganType.heart,
          ),
          DrawerListTile(
            icon: imgAll,
            title: stringAllOrgans,
          ),
          Divider(),
          DrawerListTile(
            icon: imgBox,
            title: stringAddScubaBox,
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
  OrganType? organType;
  DrawerListTile({super.key, required this.icon, required this.title, this.organType});

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
      onTap: () {
        Navigator.of(context).pop();
        if (organType != null) {
          BlocProvider.of<OrgansListBloc>(context).add(GetOrgansByTypeEvent(organType!));
        } else if (title == stringAllOrgans) {
          BlocProvider.of<OrgansListBloc>(context).add(GetAllOrgansEvent());
        }
      },
    );
  }
}
