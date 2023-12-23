// all_collection_request_view.dart
import 'package:desktop_pishco_app/viewModel/apiViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // استفاده از Provider
import 'model/Request.dart';

class AllCollectionRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiViewModel = Provider.of<ApiViewModel>(context);  // استفاده از Provider

    return Scaffold(
      appBar: AppBar(
        title: Text('لیست درخواست‌ها'),
      ),
      body: FutureBuilder<List<Request>>(
        future: apiViewModel.getRequests(),
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
                        style: TextStyle(fontSize: 28),
                      ),
                      subtitle: Text(
                        request.message,
                        style: TextStyle(fontSize: 24),
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