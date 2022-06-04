import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/services.dart';
import 'presentation/page_controller.dart';
import 'data/models/product_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await Hive.initFlutter();
  //Hive.registerAdapter(());

  runApp(MobileShop());
}

class MobileShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: PageViewController(),
      ),
    );
  }
}
