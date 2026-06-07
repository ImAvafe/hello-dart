/// A simple command runner to handle command-line arguments.
///
/// More extensive documentation for this library goes here.
library;

export 'src/command_runner_base.dart';

class CommandRunner {
  Future<void> run(List<String> input) async {
    print("Command runner args: $input");
  }
}

// TODO: Export any other libraries intended for clients of this package.
