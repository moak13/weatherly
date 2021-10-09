class LocationModel {
  String title;
  String locationType;
  int woeid;
  String lattLong;

  LocationModel({this.title, this.locationType, this.woeid, this.lattLong});

  factory LocationModel.fromJson(List json) {
    if (json.isEmpty)
      return LocationModel(
        title: '',
        locationType: '',
        woeid: 0,
        lattLong: '',
      );
    final jsonData = json.first as Map<String, dynamic>;
    print('Json: $jsonData');
    return LocationModel(
      title: jsonData['title'],
      locationType: jsonData['location_type'],
      woeid: jsonData['woeid'],
      lattLong: jsonData['latt_long'],
    );
  }

  @override
  String toString() {
    return 'title: $title, locationType: $locationType, woeid: $woeid, lattLong: $lattLong';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['location_type'] = this.locationType;
    data['woeid'] = this.woeid;
    data['latt_long'] = this.lattLong;
    return data;
  }
}
