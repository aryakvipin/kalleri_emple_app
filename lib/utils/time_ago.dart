String timeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);

  if (diff.inSeconds < 60) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours} hr ago';
  if (diff.inDays == 1) return 'yesterday';
  return '${diff.inDays} days ago';
}
