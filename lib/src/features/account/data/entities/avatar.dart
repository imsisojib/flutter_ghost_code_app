class Avatar{
  String? name;
  String? url;

  Avatar.fromJson(Map<String,dynamic> json){
    name = json['name'];
    url = json['url'];
  }

  @override
  String toString() {
    return 'Avatar{name: $name, url: $url}';
  }
}