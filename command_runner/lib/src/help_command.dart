import 'dart:async';
import 'arguments.dart';

class HelpCommand extends Command {
  HelpCommand() {
    addFlag(
      'verbose',
      abbreviation: 'v',
      help:
          'When true, prints greater detail for each command and its options.',
    );
    addOption(
      'command',
      abbreviation: 'c',
      help: "Prints details on a particular command.",
    );
  }

  @override
  String get name => 'help';

  @override
  String get description => 'Prints usage information to the CLI.';

  @override
  String? get help => "Prints usage information.";

  @override
  FutureOr<Object?> run(ArgumentResults arguments) async {
    var usage = runner.usage;
    for (var command in runner.commands) {
      usage += '\n ${command.usage}';
    }

    return usage;
  }
}
