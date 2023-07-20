
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/manage_excel/cubit/state.dart';

class ExcelFileCubit extends Cubit<ImportExcelState>{
  ExcelFileCubit():super(InitialState());

  static ExcelFileCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  File? excelFile;
  incrementNumber(int index){
    currentIndex = index;
    print(index);
    emit(ChangeIndexState());
  }

  selectFile(file){
      excelFile = file;
    emit(SelectNewExcelFile());
  }

  sendFileToServer(){

  }


}