import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Study Planner Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> subjects = [];
  final TextEditingController _nameController = TextEditingController();
  String _priority = 'High';
  bool _isMajor = true;

  // 타이머 변수
  Timer? _timer;
  int _seconds = 0;

  // 타이머 시작
  void _startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    }
  }

  // 타이머 정지
  void _stopTimer() {
    _timer?.cancel();
  }

  // 타이머 초기화
  void _resetTimer() {
    _stopTimer();
    setState(() {
      _seconds = 0;
    });
  }

  // Flask 서버에서 과목 가져오기
  Future<void> fetchSubjects() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/subjects'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );
    if (response.statusCode == 200) {
      setState(() {
        subjects = json.decode(utf8.decode(response.bodyBytes));
      });
    } else {
      debugPrint('Failed to load subjects');
    }
  }

  // 과목 추가
  Future<void> addSubject() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/subjects'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: json.encode({
        'subject_name': _nameController.text,
        'is_major': _isMajor,
        'priority': _priority,
        'exam_date': DateTime.now().toIso8601String().split('T')[0],
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('과목이 성공적으로 추가되었습니다!')),
        );
      }
      _nameController.clear();
      fetchSubjects(); // 목록 갱신
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('과목 추가에 실패했습니다.')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // 타이머 UI
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  '공부 시간: $_seconds초',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: _startTimer, child: const Text('시작')),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: _stopTimer, child: const Text('정지')),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: _resetTimer, child: const Text('초기화')),
                  ],
                ),
              ],
            ),
          ),
          // 과목 추가 UI
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: '과목 이름'),
                ),
                DropdownButtonFormField<String>(
                  value: _priority,
                  items: ['High', 'Medium', 'Low']
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _priority = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: '우선순위'),
                ),
                SwitchListTile(
                  title: const Text('전공 과목 여부'),
                  value: _isMajor,
                  onChanged: (value) {
                    setState(() {
                      _isMajor = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: addSubject,
                  child: const Text('과목 추가'),
                ),
              ],
            ),
          ),
          // 과목 리스트
          Expanded(
            child: subjects.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      final subjectName = subject['subject_name'] ?? '이름 없음';
                      final priority = subject['priority'] ?? '우선순위 없음';
                      final isMajor = subject['is_major'] != null
                          ? (subject['is_major'] == 1 ? '전공' : '비전공')
                          : '정보 없음';

                      return ListTile(
                        title: Text(subjectName),
                        subtitle: Text("우선순위: $priority | 전공 여부: $isMajor"),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
