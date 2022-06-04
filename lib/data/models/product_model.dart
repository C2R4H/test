import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

class Product {
    Product({
        required this.category,
        required this.name,
        required this.details,
        required this.size,
        required this.colour,
        required this.price,
        required this.id,
        required this.mainImage,
        required this.images,
        required this.reviews,
    });

    Category category;
    String name;
    String details;
    String size;
    String colour;
    double price;
    int id;
    String mainImage;
    List<ProductImage> images;
    List<Review> reviews;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        category: Category.fromJson(json["category"]),
        name: json["name"],
        details: json["details"],
        size: json["size"],
        colour: json["colour"],
        price: json["price"],
        id: json["id"],
        mainImage: json["main_image"],
        images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    );
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
}

class ProductImage {
    ProductImage({
        required this.image,
    });

    String image;

    factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        image: json["image"],
    );
}

class Review {
    Review({
        required this.id,
        required this.modifiedAt,
        required this.createdAt,
        required this.firstName,
        required this.lastName,
        required this.image,
        required this.rating,
        required this.message,
    });

    int id;
    DateTime modifiedAt;
    DateTime createdAt;
    String firstName;
    String lastName;
    String image;
    int rating;
    String message;

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        modifiedAt: DateTime.parse(json["modified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        rating: json["rating"],
        message: json["message"],
    );
}
