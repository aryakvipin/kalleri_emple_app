class BookingItem {
  final String title;
  final String imageUrl;
  final String date;
  final String time;
  final String status; // CONFIRMED / CLOSED
  final String? price;

  const BookingItem({
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.status,
    this.price,
  });
}

class DonationItem {
  final String title;
  final IconType icon;
  final String status;
  final String amount;
  final String? date;
  final String? time;

  const DonationItem({
    required this.title,
    required this.icon,
    required this.status,
    required this.amount,
    this.date,
    this.time,
  });
}

enum IconType { food, temple }