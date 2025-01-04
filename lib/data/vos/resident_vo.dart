// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResidentVo {
  String name;
  ResidentDataVo data;

  ResidentVo(this.name,this.data);
}

class ResidentDataVo {
  String? name;
  String? gender;
  String? dob;
  String? race;
  String? nationality;
  String? nrc;
  String? contactNumber;
  String? relatedTo;
  ResidentDataVo({
     this.name,
     this.gender,
     this.dob,
     this.race,
     this.nationality,
     this.nrc,
     this.contactNumber,
     this.relatedTo,
  });

  
}
