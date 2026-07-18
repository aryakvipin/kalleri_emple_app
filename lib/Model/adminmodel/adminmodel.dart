enum BookingStatus { confirmed, pending }

class Booking {
  final String id;
  final String poojaName;
  final String imageUrl;
  final DateTime dateTime;
  final int devotees;
  final BookingStatus status;
  final String bookedBy;
  final String phone;
  final double amount;
  final String paymentMode;
  final String transactionId;
  final String specialRequest;

  const Booking({
    required this.id,
    required this.poojaName,
    required this.imageUrl,
    required this.dateTime,
    required this.devotees,
    required this.status,
    this.bookedBy = '',
    this.phone = '',
    this.amount = 0,
    this.paymentMode = '',
    this.transactionId = '',
    this.specialRequest = 'Nil',
  });
}

class EventItem {
  final String title;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final int registrations;

  const EventItem({
    required this.title,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.registrations,
  });
}

class AppNotification {
  final String title;
  final String message;
  final String timeAgo;
  final NotificationType type;

  const AppNotification({
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.type,
  });
}

enum NotificationType { booking, donation, event, pooja }

/// Sample/mock data used across screens.
class MockData {
  static List<Booking> bookings = [
    Booking(
      id: 'BK1025',
      poojaName: 'Kuttichathan Vellatt',
      imageUrl: '',
      dateTime: DateTime(2026, 5, 22, 6, 0),
      devotees: 14,
      status: BookingStatus.confirmed,
      bookedBy: 'Pooja',
      phone: '+91 98765 43210',
      amount: 1120,
      paymentMode: 'Online',
      transactionId: 'TXN123456789',
    ),
    Booking(
      id: 'BK1024',
      poojaName: 'Ganapathi Homam',
      imageUrl: '',
      dateTime: DateTime(2026, 5, 22, 9, 0),
      devotees: 8,
      status: BookingStatus.pending,
    ),
    Booking(
      id: 'BK1023',
      poojaName: 'Gulikan Vellatt',
      imageUrl: '',
      dateTime: DateTime(2026, 5, 22, 11, 0),
      devotees: 4,
      status: BookingStatus.confirmed,
    ),
    Booking(
      id: 'BK1022',
      poojaName: 'Payasa Dhanam',
      imageUrl: '',
      dateTime: DateTime(2026, 5, 22, 16, 0),
      devotees: 6,
      status: BookingStatus.pending,
    ),
  ];

  static List<EventItem> events = [
    EventItem(
      title: 'Payasa Dhanam',
      imageUrl: '',
      startDate: DateTime(2026, 9, 20),
      endDate: DateTime(2026, 9, 29),
      registrations: 156,
    ),
    EventItem(
      title: 'Gulikan Vellatt',
      imageUrl: '',
      startDate: DateTime(2026, 12, 15),
      endDate: DateTime(2027, 1, 14),
      registrations: 98,
    ),
    EventItem(
      title: 'Vishu Mahotsavam',
      imageUrl: '',
      startDate: DateTime(2026, 4, 14),
      endDate: DateTime(2026, 4, 16),
      registrations: 210,
    ),
  ];

  static List<AppNotification> notifications = const [
    AppNotification(
      title: 'New Booking',
      message: 'Kuttichathan Vellatt booked by Arun Kumar',
      timeAgo: '2m ago',
      type: NotificationType.booking,
    ),
    AppNotification(
      title: 'New Donation',
      message: '₹1100 donation received from Arun Kumar',
      timeAgo: '15m ago',
      type: NotificationType.donation,
    ),
    AppNotification(
      title: 'Event Registration',
      message: 'New registration for Navarathri 2024',
      timeAgo: '1h ago',
      type: NotificationType.event,
    ),
    AppNotification(
      title: 'Pooja Completed',
      message: 'Udayastamana Pooja has been completed successfully.',
      timeAgo: '2h ago',
      type: NotificationType.pooja,
    ),
  ];
}
