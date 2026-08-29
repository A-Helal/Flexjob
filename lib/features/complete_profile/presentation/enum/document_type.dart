enum DocumentType { studentId, nationalId }

extension getDocumentType on DocumentType {
  static String documentName(DocumentType type) {
    switch (type) {
      case DocumentType.nationalId:
        return "national_id";
      case DocumentType.studentId:
        return "student_id";
    }
  }
}
