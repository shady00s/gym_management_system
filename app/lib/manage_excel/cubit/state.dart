

abstract class ImportExcelState{}
 class InitialState extends ImportExcelState{}
 class ChangeIndexState extends ImportExcelState{}
class NewFileAdded extends ImportExcelState{}
class SelectNewExcelFile extends ImportExcelState{}

class LoadingState extends ImportExcelState{}
class SuccessfulUploading extends ImportExcelState{}

class SetSheetsList extends ImportExcelState{}
