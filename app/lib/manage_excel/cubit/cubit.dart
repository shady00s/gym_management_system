
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/manage_excel/cubit/state.dart';

import '../model/sheets_model.dart';

class ExcelFileCubit extends Cubit<ImportExcelState>{
  ExcelFileCubit():super(InitialState());

  static ExcelFileCubit get(context) => BlocProvider.of(context);
  final Dio _dio = Dio();

  int currentIndex = 0;
  List<SheetsModel> listOfSheets = [];
  List<SheetsModel> selectedList = [];
  PlatformFile? excelFile;
  incrementNumber(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }

  selectFile(file){
      excelFile = file;
    emit(SelectNewExcelFile());
  }

  Future sendFileToServer() async {
    emit(UploadExcelFile());
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
            print("Processed data: $processedData");
            emit(SuccessfulUploading());
              listOfSheets =parseSheetList(processedData);
          } else {
            print("Error getting processed data");
          }
        });
      }
    });

   
  }

  Future sendSelectedSheets()async{

        List convertedList = listOfSheets.map((e) => SheetsModel.toJson(e)).toList() ;
          await _dio.post("http://127.0.0.1:3000/get_data_form_excel",data: {"selectedSheets":convertedList}).then((response) async{
            if (response.statusCode == 302) {
              String redirectedLocation = response.headers['location']![0];
              print(redirectedLocation);
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
                  print("Processed data: $processedData");

                } else {
                  print("Error getting processed data");
                }
              });
            }
          });

  }
  
}
List<SheetsModel> parseSheetList(List<dynamic> list) {
  return list.map((item) => SheetsModel.fromJson(item)).toList();
}