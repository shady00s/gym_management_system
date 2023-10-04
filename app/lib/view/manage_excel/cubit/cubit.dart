// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/database_management/models/backup_data_models.dart';
import 'package:gym_management/database_management/tables/generate_table.dart';
import 'package:gym_management/view/manage_excel/cubit/state.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../../../../database_management/models/employees_model.dart';
import '../../../database_management/models/teams_model.dart';
import '../model/sheets_model.dart';


class TeamsNumbersInfo{
  final int playersNumber;
  final String teamName;

  TeamsNumbersInfo({required this.playersNumber,required this.teamName});
}
class ExcelFileCubit extends Cubit<ImportExcelState> {
  ExcelFileCubit() : super(InitialState());

  static ExcelFileCubit get(context) => BlocProvider.of(context);
  final Dio _dio = Dio()..interceptors.add(CookieManager(CookieJar()));

  int currentIndex = 0;
  List<SheetsModel> listOfSheets = [];
  List<SheetsModel> selectedList = [];
  List<GlobalKey<FormState>> globalKeyList = [];
  List<EmployeesModel> employeesList = [];
  final List<EmployeesTableCompanion> employeesListCompanion = [];
  final List<TeamsDataTableCompanion> teamsListCompanion = [];
  List<TeamsModel> teamsList = [];

  void generateEmployeesList() {
    for (var element in selectedList) {
      employeesList.add(EmployeesModel(
          employeeName: "",
          employeePhoneNumber: 0,
          employeeSpecialization: "",
          employeePosition: "",
          employeeSalary: 0,
          employeeAddress: "",
          teamId: -1));
    }
  }

  void generateTeamsList() {
    for (var element in selectedList) {
      teamsList.add(TeamsModel(
          teamId: element.id,
          teamName: element.name,
          teamCaptainId: -1,
          teamPrivate: -1));
    }
  }

  void generateFormList() {
    for (var element in selectedList) {
      globalKeyList.add(GlobalKey<FormState>());
    }
  }

  void generateEmployeesCompanion() {
    for (var element in employeesList) {
      employeesListCompanion.add(EmployeesTableCompanion.insert(
          employeeName: element.employeeName,
          employeePhoneNumber: element.employeePhoneNumber,
          employeeSpecialization: element.employeeSpecialization,
          employeePosition: element.employeePosition,
          employeeSalary: Value(element.employeeSalary),
          employeeAddress: element.employeeAddress, employeeImage: const Value('no image'), employeeNationalId: 0, employeeNationalIdImage: 'no-image'));
    }
  }

  void generateTeamsCompanion() {
    for (var element in teamsList) {
      teamsListCompanion.add(TeamsDataTableCompanion.insert(
          teamId: element.teamId,
          teamName: element.teamName,
          teamCaptainId: element.teamCaptainId));
    }
  }

  bool checkValidation() {
    bool allValid =
        globalKeyList.every((element) => element.currentState!.validate());
    emit(SetValidation());
    return allValid;
  }

  void setSelectedListOfSheets(List<SheetsModel> newList) {
    selectedList = [];
    selectedList = newList;
  }

  List<ExcelPlayers> excelPlayersList = [];
  PlatformFile? excelFile;

  List<TeamsNumbersInfo>getNumberOfPlayersInEachTeam(){
    var teams = {};

    for (var element in excelPlayersList) {
      for (var sheets in selectedList) {

        if(element.team.runtimeType != int){

          for(var team in element.team){
            if(team == sheets.id) {
              teams[sheets.name] != null ? teams[sheets.name] +=1 :teams[sheets.name] = 1;
            }
          }

      }else{
          if(element.team == sheets.id){
            teams[sheets.name] != null? teams[sheets.name] +=  1 : teams[sheets.name]= 1;

          }
      }
      }

    }
    return teams.entries.map<TeamsNumbersInfo>((e) => TeamsNumbersInfo(playersNumber: e.value, teamName: e.key)).toList();

  }
  incrementNumber(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  decrementNumber(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  selectFile(file) {
    excelFile = file;
    emit(SelectNewExcelFile());
  }

  Future<int> sendFileToServer() async {
    int responseStatus = 0;
    emit(LoadingState());
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(excelFile!.path!,
          filename: excelFile!.name),
    });
    listOfSheets = [];

    await _dio
        .post(
      "http://127.0.0.1:3000/get_excel_file",
      data: formData,
      options: Options(
          responseType: ResponseType.json,
          contentType: "multipart/form-data",
          followRedirects: true,
          validateStatus: (status) {
            return status! < 500;
          }),
    )
        .then((response) async {
      if (response.statusCode == 302) {
        String redirectedLocation = response.headers['location']![0];
        String url = "http://127.0.0.1:3000$redirectedLocation";
        // Make a new request to get the processed data
        await _dio.get(
          url,
          options: Options(validateStatus: (status) {
            return status! < 500;
          }),
        ).then((processedResponse) {
          if (processedResponse.statusCode == 200) {
            dynamic processedData = processedResponse.data;

            listOfSheets = parseSheetList(processedData);
            responseStatus = processedResponse.statusCode!;
            emit(SuccessfulUploading());
          } else {
            debugPrint("Error getting processed data");
          }
        });
      }
    });
    return responseStatus;
  }

  Future<int> sendSelectedSheets() async {
    int responseCode = 0;
    emit(LoadingState());

    List convertedList =
        listOfSheets.map((e) => SheetsModel.toJson(e)).toList();

    FormData formData = FormData.fromMap(
      {"selectedSheet": json.encode(convertedList)},
    );

    await _dio
        .post("http://127.0.0.1:3000/get_data_form_excel",
            options: Options(
                followRedirects: true,
                validateStatus: (status) {
                  return status! < 500;
                }),
            data: formData)
        .then((response) async {
      if (response.statusCode == 302) {
        String redirectedLocation = response.headers['location']![0];

        String url = "http://127.0.0.1:3000$redirectedLocation";
        // Make a new request to get the processed data
        await _dio.get(
          url,
          options: Options(validateStatus: (status) {
            return status! < 500;
          }),
        ).then((processedResponse) {
          if (processedResponse.statusCode == 200) {
            dynamic processedData = processedResponse.data;
            responseCode = processedResponse.statusCode!;
            excelPlayersList =
                parseExcelPlayersList(processedData['resultData']);
            getNumberOfPlayersInEachTeam();
            emit(SuccessfulUploadingList());
          } else {
            debugPrint("Error getting processed data");
            responseCode = processedResponse.statusCode!;
          }
        });
      }
    });
    return responseCode;
  }
}

List<ExcelPlayers> parseExcelPlayersList(List<dynamic> list) {
  return list.map((e) => ExcelPlayers.fromJson(e)).toList();
}

List<SheetsModel> parseSheetList(List<dynamic> list) {
  return list.map((item) => SheetsModel.fromJson(item)).toList();
}
