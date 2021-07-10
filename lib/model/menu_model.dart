class Menu {
 late List<Menus>? menus;

  Menu({this.menus});

  Menu.fromJson(Map<String, dynamic> json) {
    if (json['menus'] != null) {
      menus =  <Menus>[];
      json['menus'].forEach((v) {
        menus?.add(new Menus.fromJson(v));
      });
    }
  }
}

class Menus {
  late String? key;
  late String? description;
  late List<Items>? items;
  late String? orderTag;

  Menus({this.key, this.description, this.items, this.orderTag});

  Menus.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    description = json['description'];
    if (json['items'] != null) {
      items =  <Items>[];
      json['items'].forEach((v) {
        items?.add(new Items.fromJson(v));
      });
    }
    orderTag = json['orderTag'];
  }
}

class Items {

late  String? name;
late  String? caption;
late  String? image;
late  List<SubItems>? items;
late  String? price;

  Items({this.name, this.caption, this.image, this.items, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    caption = json['caption'];
    image = json['image'];
    if (json['items'] != null) {
      items = <SubItems>[];
      json['items'].forEach((v) {
        items?.add(new SubItems.fromJson(v));
      });
    }
    price = json['price'].toString();
  }


}

class SubItems {
 late String? name;
 late String? caption;
 late String? price;
 late List<String>? subMenus;
 late String? image;

  SubItems({this.name, this.caption, this.price, this.subMenus, this.image});

  SubItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    caption = json['caption'];
    price = json['price'].toString();
    subMenus = json['subMenus']?.cast<String>();
    image = json['image'];
  }
}