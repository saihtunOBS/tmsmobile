// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResidentVo {
  String name;
  ResidentDataVO data;

  ResidentVo(this.name,this.data);
}

class ResidentDataVO {
  String? name;
  String? gender;
  String? dob;
  String? race;
  String? nationality;
  String? nrcOrpassport;
  String? contactNumber;
  String? relatedTo;
  ResidentDataVO({
     this.name,
     this.gender,
     this.dob,
     this.race,
     this.nationality,
     this.nrcOrpassport,
     this.contactNumber,
     this.relatedTo,
  });

  
}
