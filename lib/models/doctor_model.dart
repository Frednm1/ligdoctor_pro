// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, prefer_if_null_operators

import 'dart:convert';

DoctorModel doctorModelFromJson(dynamic str) =>
    DoctorModel.fromJson(json.decode(str));

dynamic doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  DoctorModel({
    this.success,
    this.manager,
  });

  dynamic success;
  dynamic manager;

  factory DoctorModel.fromJson(Map<dynamic, dynamic> json) => DoctorModel(
        success: json["success"] == null ? null : json["success"],
        manager:
            json["manager"] == null ? null : Manager.fromJson(json["manager"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "success": success == null ? null : success,
        "manager": manager == null ? null : manager.toJson(),
      };
}

class Manager {
  Manager({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.mobile,
    this.type,
    this.emailVerifiedAt,
    this.password,
    this.receivedId,
    this.rememberToken,
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
  });

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic mobile;
  dynamic type;
  dynamic emailVerifiedAt;
  dynamic password;
  dynamic receivedId;
  dynamic rememberToken;
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

  factory Manager.fromJson(Map<dynamic, dynamic> json) => Manager(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"],
        mobile: json["mobile"],
        type: json["type"] == null ? null : json["type"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"] == null ? null : json["password"],
        receivedId: json["received_id"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        rg: json["rg"],
        cpf: json["cpf"] == null ? null : json["cpf"],
        typeProfessional: json["type_professional"] == null
            ? null
            : json["type_professional"],
        numberDoctor: json["number_doctor"],
        state: json["state"],
        city: json["city"],
        idZoom: json["id_zoom"],
        text: json["text"] == null ? null : json["text"],
        price: json["price"] == null ? null : json["price"],
        country: json["country"],
        street: json["street"],
        streetNumber: json["street_number"],
        stateAddress: json["state_address"],
        cityAddress: json["city_address"],
        neighborhood: json["neighborhood"],
        complement: json["complement"],
        zipcode: json["zipcode"],
        timeInit: json["time_init"],
        timeEnd: json["time_end"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        linkedin: json["linkedin"],
        sex: json["sex"] == null ? null : json["sex"],
        status: json["status"] == null ? null : json["status"],
        online: json["online"] == null ? null : json["online"],
        stageId: json["stage_id"] == null ? null : json["stage_id"],
        statusId: json["status_id"] == null ? null : json["status_id"],
        birthday: json["birthday"],
        dependent: json["dependent"],
        titularId: json["titular_id"],
        playerId: json["player_id"] == null ? null : json["player_id"],
        chat: json["chat"] == null ? null : json["chat"],
        deletedAt: json["deleted_at"],
        qrcodeId: json["qrcode_id"],
        companyId: json["company_id"],
        specialty: json["specialty"] == null ? null : json["specialty"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone,
        "mobile": mobile,
        "type": type == null ? null : type,
        "email_verified_at": emailVerifiedAt,
        "password": password == null ? null : password,
        "received_id": receivedId,
        "remember_token": rememberToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "rg": rg,
        "cpf": cpf == null ? null : cpf,
        "type_professional": typeProfessional == null ? null : typeProfessional,
        "number_doctor": numberDoctor,
        "state": state,
        "city": city,
        "id_zoom": idZoom,
        "text": text == null ? null : text,
        "price": price == null ? null : price,
        "country": country,
        "street": street,
        "street_number": streetNumber,
        "state_address": stateAddress,
        "city_address": cityAddress,
        "neighborhood": neighborhood,
        "complement": complement,
        "zipcode": zipcode,
        "time_init": timeInit,
        "time_end": timeEnd,
        "facebook": facebook,
        "instagram": instagram,
        "linkedin": linkedin,
        "sex": sex == null ? null : sex,
        "status": status == null ? null : status,
        "online": online == null ? null : online,
        "stage_id": stageId == null ? null : stageId,
        "status_id": statusId == null ? null : statusId,
        "birthday": birthday,
        "dependent": dependent,
        "titular_id": titularId,
        "player_id": playerId == null ? null : playerId,
        "chat": chat == null ? null : chat,
        "deleted_at": deletedAt,
        "qrcode_id": qrcodeId,
        "company_id": companyId,
        "specialty": specialty == null ? null : specialty,
      };
}
