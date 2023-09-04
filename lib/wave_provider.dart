// import 'dart:convert';

// import 'package:flutter/material.dart';
// // import 'package:todo/models/todo_item.dart';
// import 'package:http/http.dart' as http;
// import 'package:wave/models/todo_item.dart';

// class TodoProvider with ChangeNotifier{
//   final List<TodoItem> _items = [];
//   final url = 'http://localhost:5000/todo';

//   List<TodoItem> get items {
//     return [..._items];
//   }

//   Future<void> addTodo(String task) async {
//       if(task.isEmpty){
//       return;
//     }

//     Map<String, dynamic> request = {"name": task, "is_executed": false};
//     final headers = {'Content-Type': 'application/json'};
//     final response = await http.post(Uri.parse(url), headers: headers, body: json.encode(request));
//     Map<String, dynamic> responsePayload = json.decode(response.body);
//     final todo = TodoItem(
//         id: responsePayload["id"],
//         itemName: responsePayload["name"],