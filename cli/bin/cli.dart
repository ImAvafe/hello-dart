import "dart:io";
import "package:http/http.dart" as http;

const version = "0.1.0";

void printHelp() {
  print("Valid commands:\nhelp\nversion\nsearch <TITLE>");
}

Future<String> fetchWikipediaArticle(String articleType) async {
  final response = await http.get(
    Uri.https('en.wikipedia.org', '/api/rest_v1/page/summary/$articleType'),
  );

  if (response.statusCode == 200) {
    return response.body;
  }

  return 'Failed to fetch article. Code ${response.statusCode}';
}

void searchWikipedia(List<String>? arguments) async {
  final String searchQuery;

  if (arguments == null || arguments.isEmpty) {
    print("Please provide a search query:");
    searchQuery = stdin.readLineSync() ?? '';
  } else {
    searchQuery = arguments.join(' ');
  }

  print('Searching Wikipedia for $searchQuery articles...');

  final articleContent = await fetchWikipediaArticle(searchQuery);
  print(articleContent);
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
