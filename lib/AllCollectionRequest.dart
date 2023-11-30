import 'package:flutter/material.dart';
import 'ApiService .dart';
import 'Request.dart';

class AllCollectionRequest extends StatefulWidget {
  const AllCollectionRequest({super.key});

  @override
  _AllCollectionRequestState createState() => _AllCollectionRequestState();
}

class _AllCollectionRequestState extends State<AllCollectionRequest> {
  late ApiService _apiService;
  late Future<List<Request>> _requests;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService(baseUrl: 'https://android-material.ir/test/login_.php');
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    try {
      _requests = _apiService.getRequests();
    } catch (e) {
      print('Error loading requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لیست درخواست‌ها'),
      ),
      body: FutureBuilder<List<Request>>(
        future: _requests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No requests available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Request request = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        request.status,
                        style: TextStyle(fontSize: 28), // تغییر اندازه فونت
                      ),
                      subtitle: Text(
                        request.message,
                        style: TextStyle(fontSize: 24), // تغییر اندازه فونت
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}