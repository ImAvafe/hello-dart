import "dart:io";

const version = "0.1.0";

void printHelp() {
  print("Valid commands:\nhelp\nversion\nsearch <TITLE>");
}

void searchWikipedia(List<String>? arguments) {
  final String searchQuery;

  if (arguments == null || arguments.isEmpty) {
    print("Please provide a search query:");
    searchQuery = stdin.readLineSync() ?? '';
  } else {
    searchQuery = arguments.join(' ');
  }

  print('Search Wikipedia: $searchQuery');
}

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments[0] == "help") {
    printHelp();
  } else if (arguments[0] == "version") {
    print('CLI version is $version');
  } else if (arguments[0] == "search") {
    searchWikipedia(arguments.length > 1 ? arguments.sublist(1) : null);
  } else {
    printHelp();
  }
}
