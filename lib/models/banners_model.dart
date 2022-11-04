class BannersModel {
  bool? success;
  List<Banners>? banners;

  BannersModel({this.success, this.banners});

  BannersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int? id;
  dynamic link;
  dynamic companyId;
  String? description;
  String? url;

  Banners({this.id, this.link, this.companyId, this.description, this.url});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    companyId = json['company_id'];
    description = json['description'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['company_id'] = companyId;
    data['description'] = description;
    data['url'] = url;
    return data;
  }
}
