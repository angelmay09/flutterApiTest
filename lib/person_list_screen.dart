import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'person_detail_screen.dart';

class PersonListScreen extends StatefulWidget {
  @override
  _PersonListScreenState createState() => _PersonListScreenState();
}

class _PersonListScreenState extends State<PersonListScreen> {
  List<dynamic> persons = [];
  bool isLoading = false;
  int loadCount = 0;
  final ApiService apiService = ApiService();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }
  Future<void> fetchData() async {
    if (loadCount >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No more data available")));
      return;
    }
    setState(() => isLoading = true);
    final newPersons = await apiService.fetchPersons();
    setState(() {
      persons.addAll(newPersons);
      isLoading = false;
      loadCount++;
    });
  }

  Future<void> refreshData() async {
    setState(() {
      persons.clear();
      loadCount = 0;
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Persons List")),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: persons.length + 1,
          itemBuilder: (context, index) {
            if (index == persons.length) {
              return isLoading ? Center(child: CircularProgressIndicator()) : SizedBox();
            }
            final person = persons[index];
            return ListTile(
              title: Text("${person['firstname']} ${person['lastname']}"),
              subtitle: Text(person['email'] ?? 'No Email'),
              leading: person['image'] != null && person['image'].isNotEmpty
                  ? Image.network(
                person['image'],
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: 50);
                },
              )
                  : Icon(Icons.person, size: 50),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => PersonDetailScreen(person)));
              },
            );
          },
        ),
      ),
    );
  }
}