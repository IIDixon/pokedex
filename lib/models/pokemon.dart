class Pokemon{
  Pokemon({required this.name});

  Pokemon.fromJson(Map<String, dynamic> json) : name = json["name"];

  String name;

  Map<String, dynamic> toJson(){
    return {'name' : name};
  }
}