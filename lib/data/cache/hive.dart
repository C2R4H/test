import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../models/moreToExplore_model.dart';


class HiveDatabase{

  late Box box;

  loadDatabase() async {
    box = await Hive.openBox<MoreToExplore>('Favorites');
  }

  Future<void> favoritesSave(MoreToExplore product) async {
    await box.put('Favorite',product);
  }

  Future<MoreToExplore> favoritesGet(){

  }

  HiveDatabase(){
    loadDatabase();
  }
}
