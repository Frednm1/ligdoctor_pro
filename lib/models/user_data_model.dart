class UserDataModel {
  bool? success;
  User? user;

  UserDataModel({this.success, this.user});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic mobile;
  dynamic type;
  dynamic emailVerifiedAt;
  dynamic receivedId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic rg;
  dynamic cpf;
  dynamic typeProfessional;
  dynamic numberDoctor;
  dynamic state;
  dynamic city;
  dynamic idZoom;
  dynamic text;
  dynamic price;
  dynamic country;
  dynamic street;
  dynamic streetNumber;
  dynamic stateAddress;
  dynamic cityAddress;
  dynamic neighborhood;
  dynamic complement;
  dynamic zipcode;
  dynamic timeInit;
  dynamic timeEnd;
  dynamic facebook;
  dynamic instagram;
  dynamic linkedin;
  dynamic sex;
  dynamic status;
  dynamic online;
  dynamic stageId;
  dynamic statusId;
  dynamic birthday;
  dynamic dependent;
  dynamic titularId;
  dynamic playerId;
  dynamic chat;
  dynamic deletedAt;
  dynamic qrcodeId;
  dynamic companyId;
  dynamic specialty;
  dynamic avatar;
  Customer? customer;
  Business? business;
  bool? acessTeleconsulta;
  bool? acessChat;
  int? qtdTeleconsultaExec;
  int? qtdChatExec;

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
      this.avatar,
      this.customer,
      this.business,
      this.acessTeleconsulta,
      this.acessChat,
      this.qtdTeleconsultaExec,
      this.qtdChatExec});

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
    avatar = json['avatar'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    business =
        json['business'] != null ? Business.fromJson(json['business']) : null;
    acessTeleconsulta = json['acessTeleconsulta'];
    acessChat = json['acessChat'];
    qtdTeleconsultaExec = json['qtdTeleconsultaExec'];
    qtdChatExec = json['qtdChatExec'];
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
    data['avatar'] = avatar;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (business != null) {
      data['business'] = business!.toJson();
    }
    data['acessTeleconsulta'] = acessTeleconsulta;
    data['acessChat'] = acessChat;
    data['qtdTeleconsultaExec'] = qtdTeleconsultaExec;
    data['qtdChatExec'] = qtdChatExec;
    return data;
  }
}

class Customer {
  int? id;
  dynamic name;
  dynamic email;
  dynamic cpf;
  dynamic cnpj;
  dynamic peopleType;
  dynamic phone;
  dynamic mobile;
  dynamic city;
  dynamic state;
  dynamic origin;
  dynamic status;
  dynamic updated;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  int? companyId;
  int? serviceId;
  dynamic qrcodeId;
  dynamic subscriptionId;
  dynamic idIntClient;
  dynamic zipcode;
  dynamic street;
  dynamic neighborhood;
  dynamic complement;
  dynamic streetNumber;
  dynamic sex;
  dynamic customerId;
  Company? company;
  Service? service;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.cpf,
      this.cnpj,
      this.peopleType,
      this.phone,
      this.mobile,
      this.city,
      this.state,
      this.origin,
      this.status,
      this.updated,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.companyId,
      this.serviceId,
      this.qrcodeId,
      this.subscriptionId,
      this.idIntClient,
      this.zipcode,
      this.street,
      this.neighborhood,
      this.complement,
      this.streetNumber,
      this.sex,
      this.customerId,
      this.company,
      this.service});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    cnpj = json['cnpj'];
    peopleType = json['people_type'];
    phone = json['phone'];
    mobile = json['mobile'];
    city = json['city'];
    state = json['state'];
    origin = json['origin'];
    status = json['status'];
    updated = json['updated'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    companyId = json['company_id'];
    serviceId = json['service_id'];
    qrcodeId = json['qrcode_id'];
    subscriptionId = json['subscription_id'];
    idIntClient = json['id_int_client'];
    zipcode = json['zipcode'];
    street = json['street'];
    neighborhood = json['neighborhood'];
    complement = json['complement'];
    streetNumber = json['street_number'];
    sex = json['sex'];
    customerId = json['customer_id'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['cpf'] = cpf;
    data['cnpj'] = cnpj;
    data['people_type'] = peopleType;
    data['phone'] = phone;
    data['mobile'] = mobile;
    data['city'] = city;
    data['state'] = state;
    data['origin'] = origin;
    data['status'] = status;
    data['updated'] = updated;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['company_id'] = companyId;
    data['service_id'] = serviceId;
    data['qrcode_id'] = qrcodeId;
    data['subscription_id'] = subscriptionId;
    data['id_int_client'] = idIntClient;
    data['zipcode'] = zipcode;
    data['street'] = street;
    data['neighborhood'] = neighborhood;
    data['complement'] = complement;
    data['street_number'] = streetNumber;
    data['sex'] = sex;
    data['customer_id'] = customerId;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class Company {
  int? id;
  dynamic name;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  int? lifeQuantity;
  int? serviceId;
  int? value;
  dynamic status;
  dynamic fantasyName;
  dynamic split;
  dynamic score;
  dynamic qrcode;
  int? percent;
  dynamic cnpj;
  dynamic companyType;
  dynamic type;
  dynamic businessArea;
  dynamic integration;
  dynamic host;
  dynamic token;
  dynamic secret;
  dynamic comment;
  dynamic companyId;
  dynamic cep;
  dynamic complement;
  dynamic state;
  dynamic street;
  dynamic district;
  dynamic city;
  dynamic number;
  dynamic customerId;
  dynamic email;
  dynamic phone;
  dynamic clientId;
  dynamic simpleNational;
  Plans? plans;

  Company(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.lifeQuantity,
      this.serviceId,
      this.value,
      this.status,
      this.fantasyName,
      this.split,
      this.score,
      this.qrcode,
      this.percent,
      this.cnpj,
      this.companyType,
      this.type,
      this.businessArea,
      this.integration,
      this.host,
      this.token,
      this.secret,
      this.comment,
      this.companyId,
      this.cep,
      this.complement,
      this.state,
      this.street,
      this.district,
      this.city,
      this.number,
      this.customerId,
      this.email,
      this.phone,
      this.clientId,
      this.simpleNational,
      this.plans});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    lifeQuantity = json['life_quantity'];
    serviceId = json['service_id'];
    value = json['value'];
    status = json['status'];
    fantasyName = json['fantasyName'];
    split = json['split'];
    score = json['score'];
    qrcode = json['qrcode'];
    percent = json['percent'];
    cnpj = json['cnpj'];
    companyType = json['companyType'];
    type = json['type'];
    businessArea = json['businessArea'];
    integration = json['integration'];
    host = json['host'];
    token = json['token'];
    secret = json['secret'];
    comment = json['comment'];
    companyId = json['company_id'];
    cep = json['cep'];
    complement = json['complement'];
    state = json['state'];
    street = json['street'];
    district = json['district'];
    city = json['city'];
    number = json['number'];
    customerId = json['customer_id'];
    email = json['email'];
    phone = json['phone'];
    clientId = json['client_id'];
    simpleNational = json['simple_national'];
    plans = json['plans'] != null ? Plans.fromJson(json['plans']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['life_quantity'] = lifeQuantity;
    data['service_id'] = serviceId;
    data['value'] = value;
    data['status'] = status;
    data['fantasyName'] = fantasyName;
    data['split'] = split;
    data['score'] = score;
    data['qrcode'] = qrcode;
    data['percent'] = percent;
    data['cnpj'] = cnpj;
    data['companyType'] = companyType;
    data['type'] = type;
    data['businessArea'] = businessArea;
    data['integration'] = integration;
    data['host'] = host;
    data['token'] = token;
    data['secret'] = secret;
    data['comment'] = comment;
    data['company_id'] = companyId;
    data['cep'] = cep;
    data['complement'] = complement;
    data['state'] = state;
    data['street'] = street;
    data['district'] = district;
    data['city'] = city;
    data['number'] = number;
    data['customer_id'] = customerId;
    data['email'] = email;
    data['phone'] = phone;
    data['client_id'] = clientId;
    data['simple_national'] = simpleNational;
    if (plans != null) {
      data['plans'] = plans!.toJson();
    }
    return data;
  }
}

class Plans {
  int? id;
  dynamic service;
  dynamic description;
  int? cost;
  dynamic type;
  dynamic end;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic model;
  int? dependentes;
  int? qtdTeleconsult;
  int? qtdChat;
  dynamic format;
  int? idContract;
  int? companyId;
  dynamic planId;
  int? oldCost;
  dynamic externalId;

  Plans(
      {this.id,
      this.service,
      this.description,
      this.cost,
      this.type,
      this.end,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.model,
      this.dependentes,
      this.qtdTeleconsult,
      this.qtdChat,
      this.format,
      this.idContract,
      this.companyId,
      this.planId,
      this.oldCost,
      this.externalId});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    description = json['description'];
    cost = json['cost'];
    type = json['type'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    model = json['model'];
    dependentes = json['dependentes'];
    qtdTeleconsult = json['qtd_teleconsult'];
    qtdChat = json['qtd_chat'];
    format = json['format'];
    idContract = json['id_contract'];
    companyId = json['company_id'];
    planId = json['plan_id'];
    oldCost = json['old_cost'];
    externalId = json['external_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['description'] = description;
    data['cost'] = cost;
    data['type'] = type;
    data['end'] = end;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['model'] = model;
    data['dependentes'] = dependentes;
    data['qtd_teleconsult'] = qtdTeleconsult;
    data['qtd_chat'] = qtdChat;
    data['format'] = format;
    data['id_contract'] = idContract;
    data['company_id'] = companyId;
    data['plan_id'] = planId;
    data['old_cost'] = oldCost;
    data['external_id'] = externalId;
    return data;
  }
}

class Service {
  int? id;
  dynamic service;
  dynamic description;
  int? cost;
  dynamic type;
  dynamic end;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic model;
  int? dependentes;
  int? qtdTeleconsult;
  int? qtdChat;
  dynamic format;
  dynamic idContract;
  dynamic companyId;
  dynamic planId;
  int? oldCost;
  dynamic externalId;

  Service(
      {this.id,
      this.service,
      this.description,
      this.cost,
      this.type,
      this.end,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.model,
      this.dependentes,
      this.qtdTeleconsult,
      this.qtdChat,
      this.format,
      this.idContract,
      this.companyId,
      this.planId,
      this.oldCost,
      this.externalId});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    description = json['description'];
    cost = json['cost'];
    type = json['type'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    model = json['model'];
    dependentes = json['dependentes'];
    qtdTeleconsult = json['qtd_teleconsult'];
    qtdChat = json['qtd_chat'];
    format = json['format'];
    idContract = json['id_contract'];
    companyId = json['company_id'];
    planId = json['plan_id'];
    oldCost = json['old_cost'];
    externalId = json['external_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['description'] = description;
    data['cost'] = cost;
    data['type'] = type;
    data['end'] = end;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['model'] = model;
    data['dependentes'] = dependentes;
    data['qtd_teleconsult'] = qtdTeleconsult;
    data['qtd_chat'] = qtdChat;
    data['format'] = format;
    data['id_contract'] = idContract;
    data['company_id'] = companyId;
    data['plan_id'] = planId;
    data['old_cost'] = oldCost;
    data['external_id'] = externalId;
    return data;
  }
}

class Business {
  int? id;
  int? customerId;
  dynamic date;
  dynamic time;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  int? userId;
  dynamic dependenteId;
  dynamic text;
  dynamic age;
  dynamic weightHeight;
  dynamic chronicDiseases;
  dynamic alergy;
  dynamic medicine;

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
