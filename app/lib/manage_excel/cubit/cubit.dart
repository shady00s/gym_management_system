
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/database_management/models/backup_data_models.dart';
import 'package:gym_management/manage_excel/cubit/state.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../model/sheets_model.dart';

class ExcelFileCubit extends Cubit<ImportExcelState>{
  ExcelFileCubit():super(InitialState());

  static ExcelFileCubit get(context) => BlocProvider.of(context);
  final Dio _dio = Dio()..interceptors.add( CookieManager(CookieJar()));

  int currentIndex = 0;
  List<SheetsModel> listOfSheets = [];
  List<SheetsModel> selectedList = [];
  List<ExcelPlayers> excelPlayersList = [];
  PlatformFile? excelFile;
  incrementNumber(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }

  selectFile(file){
      excelFile = file;
    emit(SelectNewExcelFile());
  }

  Future<int> sendFileToServer() async {
    int responseStatus = 0;
    emit(LoadingState());
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(excelFile!.path!, filename: excelFile!.name),
    });

    await _dio.post(
      "http://127.0.0.1:3000/get_excel_file",
      data: formData,
      options: Options(responseType: ResponseType.json, contentType: "multipart/form-data", followRedirects: true, validateStatus: (status) {
        return status! < 500;
      }),
    ).then((response) async {

      if (response.statusCode == 302) {
        String redirectedLocation = response.headers['location']![0];
          String url =  "http://127.0.0.1:3000$redirectedLocation";
        // Make a new request to get the processed data
        await _dio.get(
         url,
          options: Options(validateStatus: (status) {
            return status! < 500;
          }),
        ).then((processedResponse) {


          if (processedResponse.statusCode == 200) {
            dynamic processedData = processedResponse.data;

              listOfSheets =parseSheetList(processedData);
              responseStatus = processedResponse.statusCode!;
            emit(SuccessfulUploading());
          } else {
            print("Error getting processed data");

          }
        });
      }
    });
 return responseStatus;
  }

  Future<int>  sendSelectedSheets()async{
    int responseCode = 0;
    emit(LoadingState());

    List convertedList = listOfSheets.map((e) => SheetsModel.toJson(e)).toList() ;

    FormData formData = FormData.fromMap(
  {"selectedSheet":json.encode(convertedList)},
);

          await _dio.post("http://127.0.0.1:3000/get_data_form_excel",
              options: Options(
                 followRedirects: true,
                  validateStatus: (status) {
                return status! < 500;
              }),
              data: formData).then((response) async{
            if (response.statusCode == 302) {
              String redirectedLocation = response.headers['location']![0];

              String url =  "http://127.0.0.1:3000$redirectedLocation";
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
                  excelPlayersList =  parseExcelPlayersList(processedData['resultData']);
                  emit(SuccessfulUploadingList());
                } else {
                  print("Error getting processed data");
                  responseCode = processedResponse.statusCode!;

                }
              });
            }
          });
    return responseCode;
  }

}

List<ExcelPlayers> parseExcelPlayersList(List<dynamic> list){


  return list.map((e) => ExcelPlayers.fromJson(e)).toList();
}
List<SheetsModel> parseSheetList(List<dynamic> list) {

      return list.map((item) => SheetsModel.fromJson(item)).toList();
}