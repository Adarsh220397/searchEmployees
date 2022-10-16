class EmployeeDetails {
  int id;
  String name;
  String userName;
  String email;
  String profileImage;
  // Address? address;
  String phone;
  String website;
  // CompanyDetails? company;

  EmployeeDetails({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.profileImage,
    //  this.address,
    required this.phone,
    required this.website,
    // this.company,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['userName'] = userName;
    data['email'] = email;
    data['profileImage'] = profileImage;
    //  data['address'] = address!.toJson();
    data['phone'] = phone;
    data['website'] = website;
    // data['company'] = company!.toJson();

    return data;
  }

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) {
    return EmployeeDetails(
      id: json['id'] == null ? 0 : json['id'] as int,
      name: json['name'] == null ? '' : json['name'] as String,
      userName: json['userName'] == null ? '' : json['userName'] as String,
      email: json['email'] == null ? '' : json['email'] as String,
      profileImage:
          json['profileImage'] == null ? '' : json['profileImage'] as String,
      //    address: Address.fromJson(json['address']),
      phone: json['phone'] == null ? '' : json['phone'] as String,
      website: json['website'] == null ? '' : json['website'] as String,
      // company: json['company'] == null
      //     ? CompanyDetails(bs: '', catchPhrase: '', name: '')
      //     : CompanyDetails.fromJson(json['company']),
    );
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipCode;
  Geo? geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipCode,
    this.geo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['suite'] = suite;
    data['city'] = city;
    data['zipCode'] = zipCode;
    data['geo'] = geo!.toJson();

    return data;
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] == null ? '' : json['street'] as String,
      suite: json['suite'] == null ? '' : json['suite'] as String,
      city: json['city'] == null ? '' : json['city'] as String,
      zipCode: json['zipCode'] == null ? '' : json['zipCode'] as String,
      geo: Geo.fromJson(json['geo']),
    );
  }
}

class Geo {
  String lat;
  String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;

    return data;
  }

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );
  }
}

class CompanyDetails {
  String name;
  String catchPhrase;
  String bs;

  CompanyDetails({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['catchPhrase'] = catchPhrase;
    data['bs'] = bs;

    return data;
  }

  factory CompanyDetails.fromJson(Map<String, dynamic> json) {
    return CompanyDetails(
      name: json['name'] == null ? '' : json['name'] as String,
      catchPhrase:
          json['catchPhrase'] == null ? '' : json['catchPhrase'] as String,
      bs: json['bs'] == null ? '' : json['bs'] as String,
    );
  }
}
