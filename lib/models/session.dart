class Session {
  final String codeUE;
  final String title;
  final String teacher;
  final String startTime;
  final String endTime;
  final int numberOfSession;
  final bool active;
  final String sessionStatus;

  Session({
    required this.title,
    required this.teacher,
    required this.startTime,
    required this.endTime,
    required this.numberOfSession,
    required this.active,
    required this.sessionStatus,
    required this.codeUE,
  });
}
