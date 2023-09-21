class SheetsModel{
  final int id;
final String name;
  SheetsModel({required this.id, required this.name});
  factory SheetsModel.fromJson(Map<String,dynamic>json){
    return SheetsModel(id: json["id"], name: json['name']);
  }

  static Map<String, dynamic> toJson(SheetsModel json){
    return{
      "id":json.id,
      "name":json.name
    };
   }
}