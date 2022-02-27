// ignore_for_file: file_names, non_constant_identifier_names, avoid_print
import 'dart:convert';
import 'package:gabon_plan/models/categories.dart';
import 'package:gabon_plan/models/points.dart';
import 'package:gabon_plan/models/ville.dart';
import 'package:http/http.dart' as http;

class RequestHTTP{


  static String URL_BASIC = "https://serveur-sodepsi.com/gabonplan/api/";

 //Fonction de recuperation des points medical en fonction de la ville
  static Future<List<PointlModel>> fetchAllMedicalForCity(id) async {

    var url = Uri.parse(URL_BASIC +"getAllMedical.php?ville=$id");

    var request = await http.get(url);
    List <PointlModel> listMedical = [];
    if(request.statusCode == 200){
      var response = jsonDecode(request.body);
      var datas = response["datas"];
      listMedical =  datas.map<PointlModel>((json) => PointlModel.fromJson(json)).toList();
      return listMedical;
    }else{
      return listMedical;
    }
  }


  //Fonction de recuperation des points Loisir en fonction de la ville
  static Future<List<PointlModel>> fetchAllLoisirForCity(id) async {
    var url = Uri.parse(URL_BASIC +"/getAllLoisir.php?ville=$id");

    var request = await http.get(url);
    List <PointlModel> listMedical = [];
    if(request.statusCode == 200){
      var response = jsonDecode(request.body);
      var datas = response["datas"];
      listMedical =  datas.map<PointlModel>((json) => PointlModel.fromJson(json)).toList();
      return listMedical;
    }else{
      return listMedical;
    }
  }
  

  //Fonction de recuperation des points Loisir en fonction de la ville
  static Future<List<PointlModel>> fetchAllServiceForCity(id) async {
    var url = Uri.parse(URL_BASIC +"/getAllService.php?ville=$id");

    var request = await http.get(url);
    List <PointlModel> listMedical = [];
    if(request.statusCode == 200){
      var response = jsonDecode(request.body);
      var datas = response["datas"];
      listMedical =  datas.map<PointlModel>((json) => PointlModel.fromJson(json)).toList();
      return listMedical;
    }else{
      return listMedical;
    }
  }

 //Fonction de recuperation des points Loisir en fonction de la ville
  static Future<List<PointlModel>> fetchAllEducationForCity(id) async {

    var url = Uri.parse(URL_BASIC +"/getAllEducation.php?ville=$id");

    var request = await http.get(url);

    List <PointlModel> listEducation = [];
    if(request.statusCode == 200){
      var response = jsonDecode(request.body);
      var datas = response["datas"];
      listEducation =  datas.map<PointlModel>((json) => PointlModel.fromJson(json)).toList();
      return listEducation;
    }else{
      return listEducation;
    }
  }


  //Fonction de recuperation des points education en fonction de la ville
  static Future<List<PointlModel>> fetchAllFilterMedicalForCity({ville, cat}) async {

    var url = Uri.parse(URL_BASIC +"resultMedical.php?ville=$ville&cat=$cat");

    var request = await http.get(url);
    List <PointlModel> listMedical = [];
    if(request.statusCode == 200){

      var response = jsonDecode(request.body);
      var datas = response["datas"];

      listMedical =  datas.map<PointlModel>((json) => PointlModel.fromJson(json)).toList();

      return listMedical;
    }else{
      return listMedical;
    }
  }


  //Fonction de recuperation des points loisir en fonction de la ville
  static Future<List<PointlModel>> fetchAllFilterLoisirForCity(id, cat) async {

    var url = Uri.parse(URL_BASIC +"resultLoisir.php?ville=$id&cat=$cat");

    var request = await http.get(url);
    List <PointlModel> listMedical = [];
    if(request.statusCode == 200){
      var response = jsonDecode(request.body);
      var datas = response["datas"];
      listMedical =  datas.map<PointlModel>((json) => PointlModel.fromJson(json)).toList();
      return listMedical;
    }else{
      return listMedical;
    }
  }

   //Fonction de recuperation des points education en fonction de la ville
  static Future<List<PointlModel>> fetchAllFilterEducationForCity(id, cat) async {

    var url = Uri.parse(URL_BASIC +"resultEducation.php?ville=$id&cat=$cat");

    var request = await http.get(url);
    List <PointlModel> listMedical = [];
    if(request.statusCode == 200){
      var response = jsonDecode(request.body);
      var datas = response["datas"];
      listMedical =  datas.map<PointlModel>((json) => PointlModel.fromJson(json)).toList();
      return listMedical;
    }else{
      return listMedical;
    }
  }

  //Fonction de recuperation des points service en fonction de la ville
  static Future<List<PointlModel>> fetchAllFilterServiceForCity(id, cat) async {

    var url = Uri.parse(URL_BASIC +"resultService.php?ville=$id&cat=$cat");

    var request = await http.get(url);
    List <PointlModel> listMedical = [];
    if(request.statusCode == 200){
      var response = jsonDecode(request.body);
      var datas = response["datas"];
      listMedical =  datas.map<PointlModel>((json) => PointlModel.fromJson(json)).toList();
      return listMedical;
    }else{
      return listMedical;
    }
  }

  static Future<List<Ville>> fetchVilles() async {

    var url = Uri.parse(URL_BASIC +"villes.php");

    var request = await http.get(url);
    List <Ville> listeville = [];
    if(request.statusCode == 200){
      var response = jsonDecode(request.body);
      var datas = response["data"];
      listeville =  datas.map<Ville>((json) => Ville.fromJson(json)).toList();
      return listeville;
    }else{
      return listeville;
    }
  }

  // recuperation des catégorie par nom de la table dans la base de données
  static Future<List<Categories>> fetchCategories({ categorie }) async {

    var url = Uri.parse(URL_BASIC +"getCategories.php?cat=$categorie");

    var request = await http.get(url);
    List <Categories> categories = [];
    if(request.statusCode == 200){
      var response = jsonDecode(request.body);
      var datas = response["data"];
      categories =  datas.map<Categories>((json) => Categories.fromJson(json)).toList();
      return categories;
    }else{
      return categories;
    }
  }


}