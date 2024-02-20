// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals, camel_case_types, non_constant_identifier_names

class Subject {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Subject({this.id, this.iDs, this.name, this.count});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Impact {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Impact({this.id, this.iDs, this.name, this.count});

  Impact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Urgency {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Urgency({this.id, this.iDs, this.name, this.count});

  Urgency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Priority {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Priority({this.id, this.iDs, this.name, this.count});

  Priority.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class PriorityFilter {
  int? id;
  String? iDs;
  String? name;
  int? count;

  PriorityFilter({this.id, this.iDs, this.name, this.count});

  PriorityFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Techgroup {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Techgroup({this.id, this.iDs, this.name, this.count});

  Techgroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Tech {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Tech({this.id, this.iDs, this.name, this.count});

  Tech.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class TechListByTechgroup {
  int? id;
  String? iDs;
  String? name;
  int? count;

  TechListByTechgroup({this.id, this.iDs, this.name, this.count});

  TechListByTechgroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Status {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Status({this.id, this.iDs, this.name, this.count});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Category {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Category({this.id, this.iDs, this.name, this.count});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Requester {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Requester({this.id, this.iDs, this.name, this.count});

  Requester.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Asset {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Asset({this.id, this.iDs, this.name, this.count});

  Asset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Manufacturer {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Manufacturer({this.id, this.iDs, this.name, this.count});

  Manufacturer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Model {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Model({this.id, this.iDs, this.name, this.count});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class ModelListByManufacturer {
  int? id;
  String? iDs;
  String? name;
  int? count;

  ModelListByManufacturer({this.id, this.iDs, this.name, this.count});

  ModelListByManufacturer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Province {
  int? id;
  String? iDs;
  String? name;
  int? count;

  Province({this.id, this.iDs, this.name, this.count});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class SymptomListByCIType {
  int? id;
  String? iDs;
  String? name;
  int? count;

  SymptomListByCIType({this.id, this.iDs, this.name, this.count});

  SymptomListByCIType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iDs = json['iDs'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iDs'] = this.iDs;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class DeviceListByCIType {
  String? agentId;
  String? assetnumber;
  String? name;
  String? ipAddress;
  String? brand;
  String? model;
  String? ciType;
  String? contact;
  String? owner;
  String? serialnumber;
  String? deviceType;

  DeviceListByCIType(
      {this.agentId,
      this.assetnumber,
      this.name,
      this.ipAddress,
      this.brand,
      this.model,
      this.ciType,
      this.contact,
      this.owner,
      this.serialnumber,
      this.deviceType});

  DeviceListByCIType.fromJson(Map<String, dynamic> json) {
    agentId = json['agentId'];
    assetnumber = json['assetnumber'];
    name = json['name'];
    ipAddress = json['ipAddress'];
    brand = json['brand'];
    model = json['model'];
    ciType = json['ciType'];
    contact = json['contact'];
    owner = json['owner'];
    serialnumber = json['serialnumber'];
    deviceType = json['deviceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agentId'] = this.agentId;
    data['assetnumber'] = this.assetnumber;
    data['name'] = this.name;
    data['ipAddress'] = this.ipAddress;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['ciType'] = this.ciType;
    data['contact'] = this.contact;
    data['owner'] = this.owner;
    data['serialnumber'] = this.serialnumber;
    data['deviceType'] = this.deviceType;
    return data;
  }
}

class Devices {
  String? agentID;
  int? symptom;
  String? symptomOther;
  String? symptomDetail;

  Devices({this.agentID, this.symptom, this.symptomOther, this.symptomDetail});

  Devices.fromJson(Map<String, dynamic> json) {
    agentID = json['agentID'];
    symptom = json['symptom'];
    symptomOther = json['symptomOther'];
    symptomDetail = json['symptomDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agentID'] = this.agentID;
    data['symptom'] = this.symptom;
    data['symptomOther'] = this.symptomOther;
    data['symptomDetail'] = this.symptomDetail;
    return data;
  }
}

class ShowDevices {
  String? agentID;
  int? symptom;
  String? symptomOther;
  String? symptomDetail;
  String? asset;
  String? symptomName;
  String? serialNumber;

  ShowDevices(
      {this.agentID,
      this.symptom,
      this.symptomOther,
      this.symptomDetail,
      this.asset,
      this.symptomName,
      this.serialNumber});

  ShowDevices.fromJson(Map<String, dynamic> json) {
    agentID = json['agentID'];
    symptom = json['symptom'];
    symptomOther = json['symptomOther'];
    symptomDetail = json['symptomDetail'];
    asset = json['asset'];
    symptomName = json['symptomName'];
    serialNumber = json['serialNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agentID'] = this.agentID;
    data['symptom'] = this.symptom;
    data['symptomOther'] = this.symptomOther;
    data['symptomDetail'] = this.symptomDetail;
    data['asset'] = this.asset;
    data['symptomName'] = this.symptomName;
    data['serialNumber'] = this.serialNumber;
    return data;
  }
}

class DetailUser {
  String? userID;
  String? firstname;
  String? lastname;
  String? password;
  String? position;
  String? email;
  String? email_Other;
  String? location;
  String? department;
  String? extension;
  String? extension1;
  String? building;
  String? floor;
  String? room;

  DetailUser(
      {this.userID,
      this.firstname,
      this.lastname,
      this.password,
      this.position,
      this.email,
      this.email_Other,
      this.location,
      this.department,
      this.extension,
      this.extension1,
      this.building,
      this.floor,
      this.room});

  DetailUser.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    password = json['password'];
    position = json['position'];
    email = json['email'];
    email_Other = json['email_Other'];
    location = json['location'];
    department = json['department'];
    extension = json['extension'];
    extension1 = json['extension1'];
    building = json['building'];
    floor = json['floor'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['password'] = this.password;
    data['position'] = this.position;
    data['email'] = this.email;
    data['email_Other'] = this.email_Other;
    data['location'] = this.location;
    data['department'] = this.department;
    data['extension'] = this.extension;
    data['extension1'] = this.extension1;
    data['building'] = this.building;
    data['floor'] = this.floor;
    data['room'] = this.room;
    return data;
  }
}

class Files {
  String? fileId;
  String? fileName;
  String? contentBase64;

  Files({this.fileId, this.fileName, this.contentBase64});

  Files.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    fileName = json['fileName'];
    contentBase64 = json['contentBase64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['fileName'] = this.fileName;
    data['contentBase64'] = this.contentBase64;
    return data;
  }
}

class SaveIncidentTicket {
  int? id;
  int? departmentID;
  int? ciType;
  String? manufacture;
  int? province;
  String? description;
  int? techgroup;
  String? technician;
  int? statusID;
  String? creater;
  List<Files>? files;
  SendRequest? requester;
  List<Devices>? devices;

  SaveIncidentTicket(
      {this.id,
      this.departmentID,
      this.ciType,
      this.manufacture,
      this.province,
      this.description,
      this.techgroup,
      this.technician,
      this.statusID,
      this.creater,
      this.files,
      this.requester,
      this.devices});

  SaveIncidentTicket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentID = json['departmentID'];
    ciType = json['ciType'];
    manufacture = json['manufacture'];
    province = json['province'];
    description = json['description'];
    techgroup = json['techgroup'];
    technician = json['technician'];
    statusID = json['statusID'];
    creater = json['creater'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    requester = json['requester'] != null
        ? new SendRequest.fromJson(json['requester'])
        : null;
    if (json['devices'] != null) {
      devices = <Devices>[];
      json['devices'].forEach((v) {
        devices!.add(new Devices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['departmentID'] = this.departmentID;
    data['ciType'] = this.ciType;
    data['manufacture'] = this.manufacture;
    data['province'] = this.province;
    data['description'] = this.description;
    data['techgroup'] = this.techgroup;
    data['technician'] = this.technician;
    data['statusID'] = this.statusID;
    data['creater'] = this.creater;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.requester != null) {
      data['requester'] = this.requester!.toJson();
    }
    if (this.devices != null) {
      data['devices'] = this.devices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SendRequest {
  String? userID;
  String? fullname;
  String? email;
  String? phone;
  String? officePhone;

  SendRequest(
      {this.userID, this.fullname, this.email, this.phone, this.officePhone});

  SendRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    officePhone = json['officePhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['officePhone'] = this.officePhone;
    return data;
  }
}

class resData {
  String? statusCode;
  String? data;
}

class SaveRequestTicket {
  int? id;
  int? subjectID;
  String? otherSubject;
  String? description;
  int? impactID;
  String? impactDetail;
  int? priorityID;
  int? urgencyID;
  int? techgroupID;
  String? technician;
  int? statusID;
  String? creater;
  List<Catgory>? catgory;
  SendRequest? requester;
  List<Files>? files;

  SaveRequestTicket(
      {this.id,
      this.subjectID,
      this.otherSubject,
      this.description,
      this.impactID,
      this.impactDetail,
      this.priorityID,
      this.urgencyID,
      this.techgroupID,
      this.technician,
      this.statusID,
      this.creater,
      this.catgory,
      this.requester,
      this.files});

  SaveRequestTicket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectID = json['subjectID'];
    otherSubject = json['otherSubject'];
    description = json['description'];
    impactID = json['impactID'];
    impactDetail = json['impactDetail'];
    priorityID = json['priorityID'];
    urgencyID = json['urgencyID'];
    techgroupID = json['techgroupID'];
    technician = json['technician'];
    statusID = json['statusID'];
    creater = json['creater'];
    if (json['catgory'] != null) {
      catgory = <Catgory>[];
      json['catgory'].forEach((v) {
        catgory!.add(new Catgory.fromJson(v));
      });
    }
    requester = json['requester'] != null
        ? new SendRequest.fromJson(json['requester'])
        : null;
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjectID'] = this.subjectID;
    data['otherSubject'] = this.otherSubject;
    data['description'] = this.description;
    data['impactID'] = this.impactID;
    data['impactDetail'] = this.impactDetail;
    data['priorityID'] = this.priorityID;
    data['urgencyID'] = this.urgencyID;
    data['techgroupID'] = this.techgroupID;
    data['technician'] = this.technician;
    data['statusID'] = this.statusID;
    data['creater'] = this.creater;
    if (this.catgory != null) {
      data['catgory'] = this.catgory!.map((v) => v.toJson()).toList();
    }
    if (this.requester != null) {
      data['requester'] = this.requester!.toJson();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Catgory {
  int? id;
  String? name;
  int? level;

  Catgory({this.id, this.name, this.level});

  Catgory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    return data;
  }
}

class ShowCatgory {
  int? id;
  String? name;
  int? level;
  String? levelname;

  ShowCatgory({this.id, this.name, this.level, this.levelname});

  ShowCatgory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    levelname = json['levelname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    data['levelname'] = this.levelname;
    return data;
  }
}

class RequestDataByID {
  int? id;
  String? format;
  int? subjectID;
  String? otherSubject;
  String? description;
  int? impactID;
  String? impactDetail;
  int? priorityID;
  int? urgencyID;
  int? techgroupID;
  String? technician;
  int? statusID;
  String? creater;
  List<Catgory>? catgory;
  SendRequest? requester;
  List<Files>? files;

  RequestDataByID(
      {this.id,
      this.format,
      this.subjectID,
      this.otherSubject,
      this.description,
      this.impactID,
      this.impactDetail,
      this.priorityID,
      this.urgencyID,
      this.techgroupID,
      this.technician,
      this.statusID,
      this.creater,
      this.catgory,
      this.requester,
      this.files});

  RequestDataByID.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    format = json['format'];
    subjectID = json['subjectID'];
    otherSubject = json['otherSubject'];
    description = json['description'];
    impactID = json['impactID'];
    impactDetail = json['impactDetail'];
    priorityID = json['priorityID'];
    urgencyID = json['urgencyID'];
    techgroupID = json['techgroupID'];
    technician = json['technician'];
    statusID = json['statusID'];
    creater = json['creater'];
    if (json['catgory'] != null) {
      catgory = <Catgory>[];
      json['catgory'].forEach((v) {
        catgory!.add(new Catgory.fromJson(v));
      });
    }
    requester = json['requester'] != null
        ? new SendRequest.fromJson(json['requester'])
        : null;
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['format'] = this.format;
    data['subjectID'] = this.subjectID;
    data['otherSubject'] = this.otherSubject;
    data['description'] = this.description;
    data['impactID'] = this.impactID;
    data['impactDetail'] = this.impactDetail;
    data['priorityID'] = this.priorityID;
    data['urgencyID'] = this.urgencyID;
    data['techgroupID'] = this.techgroupID;
    data['technician'] = this.technician;
    data['statusID'] = this.statusID;
    data['creater'] = this.creater;
    if (this.catgory != null) {
      data['catgory'] = this.catgory!.map((v) => v.toJson()).toList();
    }
    if (this.requester != null) {
      data['requester'] = this.requester!.toJson();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
