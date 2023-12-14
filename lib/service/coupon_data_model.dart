class Couponinuse {
  String? status;
  List<Responsecoupon>? response;

  Couponinuse({this.status, this.response});

  Couponinuse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['response'] != null) {
      response = <Responsecoupon>[];
      json['response'].forEach((v) {
        response!.add(Responsecoupon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Responsecoupon {
  String? id;
  String? userid;
  String? mobile;
  String? offerdata;
  String? claimstatus;

  Responsecoupon(
      {this.id, this.userid, this.mobile, this.offerdata, this.claimstatus});

  Responsecoupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    mobile = json['mobile'];
    offerdata = json['offerdata'];
    claimstatus = json['claimstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['mobile'] = mobile;
    data['offerdata'] = offerdata;
    data['claimstatus'] = claimstatus;
    return data;
  }
}
