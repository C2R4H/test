import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

class CategoriesModel {
    CategoriesModel({
        required this.count,
        required this.totalPages,
        required this.perPage,
        required this.currentPage,
        required this.results,
    });

    int count;
    int totalPages;
    int perPage;
    int currentPage;
    List<Result> results;

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        count: json["count"],
        totalPages: json["total_pages"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );
}

class Result {
    Result({
        required this.name,
        required this.icon,
    });

    String name;
    String icon;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        icon: json["icon"],
    );
}

