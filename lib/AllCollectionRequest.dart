import 'package:flutter/material.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ApiService .dart';
import 'Request.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(baseUrl: 'https://android-material.ir/test/login_.php');
});
final requestsProvider = FutureProvider<List<Request>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.getRequests();
});

class AllCollectionRequest extends ConsumerWidget {
  const AllCollectionRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(requestsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('لیست درخواست‌ها'),
      ),
      body: requestsAsync.when(
        data: (requests) {
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              Request request = requests[index];
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
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}