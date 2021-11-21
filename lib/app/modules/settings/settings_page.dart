import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/app_widget.dart';
import 'package:flutter_padrao/app/modules/settings/settings_store.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final String title;

  const SettingsPage({Key? key, this.title = 'Settings'}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final SettingsStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.buscaTheme();
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.3;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(altura),
          child: AppBar(
            title: Text(widget.title),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Modular.to.navigate('/home')),
          ),
        ),
        body: ListView(
          children: [
            Observer(builder: (_) {
              return ListTile(
                leading: const Icon(Icons.wb_sunny),
                title: Switch(
                    value: store.isSwitched,
                    onChanged: (value) async {
                      await store.changeSwitch(value);
                      store.isSwitched
                          ? AppWidget.of(context)!.changeTheme(ThemeMode.dark)
                          : AppWidget.of(context)!.changeTheme(ThemeMode.light);
                    }),
                trailing: const Icon(Icons.nights_stay),
              );
            }),
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () {
                store.logoff();
              },
            )
          ],
        ));
  }
}
