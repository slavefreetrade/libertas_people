class ProfileModel {
  String workplaceId;
  Gender gender;

  ProfileModel({
    this.workplaceId,
    this.gender,
  });
}

enum Gender { male, female, other, preferNotToSay }

extension ParseToString on Gender {
  String toShortString() => toString().split('.').last;
}
