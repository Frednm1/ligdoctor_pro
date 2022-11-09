class PatientsModel {
  bool? success;
  List<Patients>? patients;

  PatientsModel({this.success, this.patients});

  PatientsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients!.add(Patients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (patients != null) {
      data['patients'] = patients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patients {
  int? id;
  int? teamId;
  int? managerId;
  int? consultantId;
  int? customerId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Customer? customer;
  Business? business;

  Patients(
      {this.id,
      this.teamId,
      this.managerId,
      this.consultantId,
      this.customerId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.customer,
      this.business});

  Patients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    managerId = json['manager_id'];
    consultantId = json['consultant_id'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    business =
        json['business'] != null ? Business.fromJson(json['business']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['manager_id'] = managerId;
    data['consultant_id'] = consultantId;
    data['customer_id'] = customerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (business != null) {
      data['business'] = business!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? cpf;
  dynamic rg;
  String? peopleType;
  String? phone;
  String? mobile;
  String? city;
  String? state;
  String? origin;
  int? userId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic medicalInsurance;
  String? sex;
  String? birthday;
  dynamic dependent;
  dynamic titularId;
  int? companyId;
  String? active;
  String? updated;
  int? serviceId;
  String? clientId;
  dynamic qrcodeId;
  dynamic deficient;
  String? service;
  int? qtdAttChat;
  int? qtdAttTeleconsulta;
  User? user;
  Avatar? avatar;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.cpf,
      this.rg,
      this.peopleType,
      this.phone,
      this.mobile,
      this.city,
      this.state,
      this.origin,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.medicalInsurance,
      this.sex,
      this.birthday,
      this.dependent,
      this.titularId,
      this.companyId,
      this.active,
      this.updated,
      this.serviceId,
      this.clientId,
      this.qrcodeId,
      this.deficient,
      this.service,
      this.qtdAttChat,
      this.qtdAttTeleconsulta,
      this.user,
      this.avatar});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    rg = json['rg'];
    peopleType = json['people_type'];
    phone = json['phone'];
    mobile = json['mobile'];
    city = json['city'];
    state = json['state'];
    origin = json['origin'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    medicalInsurance = json['medical_insurance'];
    sex = json['sex'];
    birthday = json['birthday'];
    dependent = json['dependent'];
    titularId = json['titular_id'];
    companyId = json['company_id'];
    active = json['active'];
    updated = json['updated'];
    serviceId = json['service_id'];
    clientId = json['client_id'];
    qrcodeId = json['qrcode_id'];
    deficient = json['deficient'];
    service = json['service'];
    qtdAttChat = json['qtd_att_chat'];
    qtdAttTeleconsulta = json['qtd_att_teleconsulta'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    avatar = json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['cpf'] = cpf;
    data['rg'] = rg;
    data['people_type'] = peopleType;
    data['phone'] = phone;
    data['mobile'] = mobile;
    data['city'] = city;
    data['state'] = state;
    data['origin'] = origin;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['medical_insurance'] = medicalInsurance;
    data['sex'] = sex;
    data['birthday'] = birthday;
    data['dependent'] = dependent;
    data['titular_id'] = titularId;
    data['company_id'] = companyId;
    data['active'] = active;
    data['updated'] = updated;
    data['service_id'] = serviceId;
    data['client_id'] = clientId;
    data['qrcode_id'] = qrcodeId;
    data['deficient'] = deficient;
    data['service'] = service;
    data['qtd_att_chat'] = qtdAttChat;
    data['qtd_att_teleconsulta'] = qtdAttTeleconsulta;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic phone;
  String? mobile;
  String? type;
  dynamic emailVerifiedAt;
  dynamic receivedId;
  String? createdAt;
  String? updatedAt;
  dynamic rg;
  String? cpf;
  dynamic typeProfessional;
  dynamic numberDoctor;
  String? state;
  String? city;
  dynamic idZoom;
  dynamic text;
  dynamic price;
  dynamic country;
  String? street;
  String? streetNumber;
  dynamic stateAddress;
  dynamic cityAddress;
  String? neighborhood;
  String? complement;
  String? zipcode;
  dynamic timeInit;
  dynamic timeEnd;
  dynamic facebook;
  dynamic instagram;
  dynamic linkedin;
  String? sex;
  String? status;
  String? online;
  dynamic stageId;
  dynamic statusId;
  String? birthday;
  dynamic dependent;
  dynamic titularId;
  String? playerId;
  dynamic chat;
  dynamic deletedAt;
  dynamic qrcodeId;
  dynamic companyId;
  String? specialty;
  dynamic typeProfessionalId;
  dynamic typeSpecialistId;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.mobile,
      this.type,
      this.emailVerifiedAt,
      this.receivedId,
      this.createdAt,
      this.updatedAt,
      this.rg,
      this.cpf,
      this.typeProfessional,
      this.numberDoctor,
      this.state,
      this.city,
      this.idZoom,
      this.text,
      this.price,
      this.country,
      this.street,
      this.streetNumber,
      this.stateAddress,
      this.cityAddress,
      this.neighborhood,
      this.complement,
      this.zipcode,
      this.timeInit,
      this.timeEnd,
      this.facebook,
      this.instagram,
      this.linkedin,
      this.sex,
      this.status,
      this.online,
      this.stageId,
      this.statusId,
      this.birthday,
      this.dependent,
      this.titularId,
      this.playerId,
      this.chat,
      this.deletedAt,
      this.qrcodeId,
      this.companyId,
      this.specialty,
      this.typeProfessionalId,
      this.typeSpecialistId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    mobile = json['mobile'];
    type = json['type'];
    emailVerifiedAt = json['email_verified_at'];
    receivedId = json['received_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rg = json['rg'];
    cpf = json['cpf'];
    typeProfessional = json['type_professional'];
    numberDoctor = json['number_doctor'];
    state = json['state'];
    city = json['city'];
    idZoom = json['id_zoom'];
    text = json['text'];
    price = json['price'];
    country = json['country'];
    street = json['street'];
    streetNumber = json['street_number'];
    stateAddress = json['state_address'];
    cityAddress = json['city_address'];
    neighborhood = json['neighborhood'];
    complement = json['complement'];
    zipcode = json['zipcode'];
    timeInit = json['time_init'];
    timeEnd = json['time_end'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
    sex = json['sex'];
    status = json['status'];
    online = json['online'];
    stageId = json['stage_id'];
    statusId = json['status_id'];
    birthday = json['birthday'];
    dependent = json['dependent'];
    titularId = json['titular_id'];
    playerId = json['player_id'];
    chat = json['chat'];
    deletedAt = json['deleted_at'];
    qrcodeId = json['qrcode_id'];
    companyId = json['company_id'];
    specialty = json['specialty'];
    typeProfessionalId = json['type_professional_id'];
    typeSpecialistId = json['type_specialist_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['mobile'] = mobile;
    data['type'] = type;
    data['email_verified_at'] = emailVerifiedAt;
    data['received_id'] = receivedId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['rg'] = rg;
    data['cpf'] = cpf;
    data['type_professional'] = typeProfessional;
    data['number_doctor'] = numberDoctor;
    data['state'] = state;
    data['city'] = city;
    data['id_zoom'] = idZoom;
    data['text'] = text;
    data['price'] = price;
    data['country'] = country;
    data['street'] = street;
    data['street_number'] = streetNumber;
    data['state_address'] = stateAddress;
    data['city_address'] = cityAddress;
    data['neighborhood'] = neighborhood;
    data['complement'] = complement;
    data['zipcode'] = zipcode;
    data['time_init'] = timeInit;
    data['time_end'] = timeEnd;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['linkedin'] = linkedin;
    data['sex'] = sex;
    data['status'] = status;
    data['online'] = online;
    data['stage_id'] = stageId;
    data['status_id'] = statusId;
    data['birthday'] = birthday;
    data['dependent'] = dependent;
    data['titular_id'] = titularId;
    data['player_id'] = playerId;
    data['chat'] = chat;
    data['deleted_at'] = deletedAt;
    data['qrcode_id'] = qrcodeId;
    data['company_id'] = companyId;
    data['specialty'] = specialty;
    data['type_professional_id'] = typeProfessionalId;
    data['type_specialist_id'] = typeSpecialistId;
    return data;
  }
}

class Avatar {
  int? id;
  String? file;
  int? userId;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? title;
  dynamic dealId;

  Avatar(
      {this.id,
      this.file,
      this.userId,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.dealId});

  Avatar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    userId = json['user_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    dealId = json['deal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file'] = file;
    data['user_id'] = userId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    data['deal_id'] = dealId;
    return data;
  }
}

class Business {
  int? id;
  int? customerId;
  String? date;
  String? time;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? userId;
  dynamic dependenteId;
  String? text;
  String? age;
  String? weightHeight;
  String? chronicDiseases;
  String? alergy;
  String? medicine;

  Business(
      {this.id,
      this.customerId,
      this.date,
      this.time,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.dependenteId,
      this.text,
      this.age,
      this.weightHeight,
      this.chronicDiseases,
      this.alergy,
      this.medicine});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    date = json['date'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    userId = json['user_id'];
    dependenteId = json['dependente_id'];
    text = json['text'];
    age = json['age'];
    weightHeight = json['weight_height'];
    chronicDiseases = json['chronic_diseases'];
    alergy = json['alergy'];
    medicine = json['medicine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['date'] = date;
    data['time'] = time;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['user_id'] = userId;
    data['dependente_id'] = dependenteId;
    data['text'] = text;
    data['age'] = age;
    data['weight_height'] = weightHeight;
    data['chronic_diseases'] = chronicDiseases;
    data['alergy'] = alergy;
    data['medicine'] = medicine;
    return data;
  }
}
