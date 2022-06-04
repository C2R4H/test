import 'dart:convert';
import 'package:hive/hive.dart';

part 'moreToExplore_model.g.dart';

MoreToExplore moreToExploreFromJson(String str) => MoreToExplore.fromJson(json.decode(str));

String moreToExploreToJson(MoreToExplore data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class MoreToExplore extends HiveObject{
    MoreToExplore({
        this.count,
        this.totalPages,
        this.perPage,
        this.currentPage,
        this.results,
    });

    @HiveType(typeId: 0)
    int? count;
    @HiveType(typeId: 1)
    int? totalPages;
    @HiveType(typeId: 2)
    int? perPage;
    @HiveType(typeId: 3)
    int? currentPage;
    @HiveType(typeId: 4)
    List<Result>? results;

    factory MoreToExplore.fromJson(Map<String, dynamic> json) => MoreToExplore(
        count: json["count"],
        totalPages: json["total_pages"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "total_pages": totalPages,
        "per_page": perPage,
        "curent_page": currentPage,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.category,
        required this.name,
        required this.details,
        required this.size,
        required this.colour,
        required this.price,
        required this.mainImage,
        required this.id,
    });

    Category category;
    String name;
    String details;
    String size;
    String colour;
    double price;
    String mainImage;
    int id;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: Category.fromJson(json["category"]),
        name: json["name"],
        details: json["details"],
        size: json["size"],
        colour: json["colour"],
        price: json["price"],
        mainImage: json["main_image"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "name": name,
        "details": details,
        "size": size,
        "colour": colour,
        "price": price,
        "main_image": mainImage,
        "id": id,
    };
}

class Category {
    Category({
        required this.name,
        required this.icon,
        required this.id,
    });

    String name;
    String icon;
    int id;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        icon: json["icon"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon,
        "id": id,
    };
}
