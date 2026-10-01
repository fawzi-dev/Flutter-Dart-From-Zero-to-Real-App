/// Which bucket a contact belongs in.
///
/// An enum, because a group is a fixed menu and not free text — the same
/// argument as `Category` in the Module 6 capstone. And it is here mainly
/// because JSON has no idea what an enum is, which is half of lesson 15.3.
enum ContactGroup { family, work, friends, other }

/// One person.
///
/// Two of these fields are the whole difficulty of saving: `group` is an enum
/// and `addedOn` is a DateTime, and **JSON can take neither raw**. The move is
/// always the same — turn it into a string on the way out, turn the string
/// back on the way in.
class Contact {
  final String name;
  final String phone;
  final ContactGroup group;
  final DateTime addedOn;
  bool favourite;

  Contact({
    required this.name,
    required this.phone,
    this.group = ContactGroup.other,
    DateTime? addedOn,
    this.favourite = false,
  }) : addedOn = addedOn ?? DateTime.now();

  String get initial => name.isEmpty ? '?' : name[0].toUpperCase();

  /// Object → Map. The mirror of `fromJson`, and the first half of the trip
  /// to disk.
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        // 'work', not ContactGroup.work — JSON only speaks strings.
        'group': group.name,
        // A standard date string: readable, sortable, universal.
        'addedOn': addedOn.toIso8601String(),
        'favourite': favourite,
      };

  /// Map → object.
  ///
  /// Every fallback here exists for one reason: **data saved by an older
  /// version of the app**. Rename a group and every contact stored under the
  /// old name would crash the launch without `orElse`. Add a field later and
  /// old records won't have it, hence the `??`s.
  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json['name'] as String,
        phone: json['phone'] as String? ?? '',
        group: ContactGroup.values.firstWhere(
          (g) => g.name == json['group'],
          orElse: () => ContactGroup.other,
        ),
        addedOn: DateTime.tryParse(json['addedOn'] as String? ?? ''),
        favourite: json['favourite'] as bool? ?? false,
      );
}
