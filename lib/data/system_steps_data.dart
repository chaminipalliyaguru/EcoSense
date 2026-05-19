class SystemStep {
  final String stepNumber;
  final String title;
  final String description;

  SystemStep({
    required this.stepNumber,
    required this.title,
    required this.description,
  });
}

final List<SystemStep> systemSteps = [
  SystemStep(
    stepNumber: "1",
    title: "User takes photo of emission testing reports",
    description: "Capture the report using the in-app camera.",
  ),
  SystemStep(
    stepNumber: "2",
    title: "System processes data",
    description:
    "The system app scans and extracts the required information.",
  ),
  SystemStep(
    stepNumber: "3",
    title: "Model predicts emission levels",
    description:
    "Our intelligent model analyzes the data and predicts results.",
  ),
  SystemStep(
    stepNumber: "4",
    title: "Results are displayed",
    description:
    "You get results along with reasons and recommendations",
  ),
];