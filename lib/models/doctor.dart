class Doctor {
  final int id;
  final String name;
  final String speciality;
  final double rating;
  final bool available;
  final String image;

  Doctor({
    required this.id,
    required this.name,
    required this.speciality,
    required this.rating,
    required this.available,
    required this.image,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      speciality: json['speciality'],
      rating: (json['rating'] as num).toDouble(),
      available: json['available'],
      image: json['image'],
    );
  }
}
