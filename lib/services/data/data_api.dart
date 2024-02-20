// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_function_literals_in_foreach_calls, duplicate_ignore

import 'dart:convert';
import 'package:rems/model/data/data_model.dart';
import 'package:rems/services/main_service.dart';
import 'package:rems/services/pref_data.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class DataAPI {
  Future<List<Subject>> getSubjectList() async {
    String token = await PrefData.getToken();
    List<Subject> subject = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetSubjectList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    
    jsonlist.forEach((e) {
      subject.add(Subject.fromJson(e));
    });
    return subject;
  }

  Future<List<Impact>> getImpactList() async {
    String token = await PrefData.getToken();
    List<Impact> impact = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetImpactList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    
    jsonlist.forEach((e) {
      impact.add(Impact.fromJson(e));
    });
    return impact;
  }

  Future<List<Urgency>> getUrgencyList() async {
    String token = await PrefData.getToken();
    List<Urgency> urgency = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetUrgencyList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    
    jsonlist.forEach((e) {
      urgency.add(Urgency.fromJson(e));
    });
    return urgency;
  }

  Future<List<Priority>> getPriorityList() async {
    String token = await PrefData.getToken();
    List<Priority> priority = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetPriorityList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    jsonlist.forEach((e) {
      priority.add(Priority.fromJson(e));
    });
    return priority;
  }

  Future<List<PriorityFilter>> getPriorityFilter(
      int urgencyID, int impactID) async {
    String token = await PrefData.getToken();
    List<PriorityFilter> priorityfilter = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetPriorityFilter?Urgency=$urgencyID&Impact=$impactID'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      priorityfilter.add(PriorityFilter.fromJson(e));
    });
    return priorityfilter;
  }

  Future<List<Techgroup>> getTechgroupList() async {
    String token = await PrefData.getToken();
    List<Techgroup> techgroup = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetTechgroupList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      techgroup.add(Techgroup.fromJson(e));
    });
    return techgroup;
  }

  Future<List<Tech>> getTechList() async {
    String token = await PrefData.getToken();
    List<Tech> tech = [];
    final response = await http.get(
      Uri.parse('${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetTechList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      tech.add(Tech.fromJson(e));
    });
    return tech;
  }

  Future<List<TechListByTechgroup>> getTechListByTechgroup(
      int TechgroupID) async {
    String token = await PrefData.getToken();
    List<TechListByTechgroup> techListByTechgroup = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetTechListByTechgroup?Techgroup=${TechgroupID}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      techListByTechgroup.add(TechListByTechgroup.fromJson(e));
    });
    return techListByTechgroup;
  }

  Future<List<Status>> getStatusList() async {
    String token = await PrefData.getToken();
    List<Status> status = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetStatusList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      status.add(Status.fromJson(e));
    });
    return status;
  }

  Future<List<Category>> getCategoryDefaultList(int parentID) async {
    String token = await PrefData.getToken();
    List<Category> category = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetCategoryList?ParentID=$parentID'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      category.add(Category.fromJson(e));
    });
    return category;
  }

  Future<List<Category>> getCategoryList(int parentID) async {
    String token = await PrefData.getToken();
    List<Category> category = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetCategoryList?ParentID=$parentID'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      category.add(Category.fromJson(e));
    });
    return category;
  }

  Future<List<Requester>> getRequesterList() async {
    String token = await PrefData.getToken();
    List<Requester> requester = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetRequesterList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      requester.add(Requester.fromJson(e));
    });
    return requester;
  }

  Future<List<Asset>> getAssetList() async {
    String token = await PrefData.getToken();
    List<Asset> asset = [];
    final response = await http.get(
      Uri.parse('${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetAssetList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      asset.add(Asset.fromJson(e));
    });
    return asset;
  }

  Future<Manufacturer> getManufacturerList() async {
    String token = await PrefData.getToken();
    Manufacturer manufacturer = Manufacturer();
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetManufacturerList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    String data = response.body.toString();
    manufacturer = Manufacturer.fromJson(json.decode(data));
    return manufacturer;
  }

  Future<Model> getModelList() async {
    String token = await PrefData.getToken();
    Model model = Model();
    final response = await http.get(
      Uri.parse('${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetModelList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    String data = response.body.toString();
    model = Model.fromJson(json.decode(data));
    return model;
  }

  Future<ModelListByManufacturer> getModelListByManufacturer(
      int manufacturer) async {
    String token = await PrefData.getToken();
    ModelListByManufacturer modelListByManufacturer = ModelListByManufacturer();
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetModelListByManufacturer?Manufacturer=$manufacturer'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    String data = response.body.toString();
    modelListByManufacturer =
        ModelListByManufacturer.fromJson(json.decode(data));
    return modelListByManufacturer;
  }

  Future<List<Province>> getProvinceList() async {
    String token = await PrefData.getToken();
    List<Province> province = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetProvinceList'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      province.add(Province.fromJson(e));
    });
    return province;
  }

  Future<List<SymptomListByCIType>> getSymptomListByCIType(int cITypeID) async {
    String token = await PrefData.getToken();
    List<SymptomListByCIType> symptomListByCIType = [];
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetSymptomListByCIType?CITypeId=$cITypeID'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      symptomListByCIType.add(SymptomListByCIType.fromJson(e));
    });
    return symptomListByCIType;
  }

  Future<List<DeviceListByCIType>> getDeviceListByCIType(
      int cITypeID, String search, int page) async {
    String token = await PrefData.getToken();
    List<DeviceListByCIType> deviceListByCIType = [];
    final response = await http.get(
      Uri.parse(
          // '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetDeviceListByCIType?CITypeID=53&Search=12&Page=1'),
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetDeviceListByCIType?CITypeID=$cITypeID&Search=$search&Page=$page'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var jsonlist = json.decode(response.body.toString()) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonlist.forEach((e) {
      deviceListByCIType.add(DeviceListByCIType.fromJson(e));
    });
    return deviceListByCIType;
  }

  Future<DetailUser> getDetailUser(String userId) async {
    String token = await PrefData.getToken();
    DetailUser detailUser = DetailUser();
    final response = await http.get(
      Uri.parse(
          '${MyBaseServiceManager.getBaseApiUrl()}api/Data/GetDetailUser?UserId=$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    String data = response.body.toString();
    detailUser = DetailUser.fromJson(json.decode(data));
    return detailUser;
  }
}
