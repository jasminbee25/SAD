import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'task_form.dart';
import 'auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _tasks = [];
  bool _isLoading = true;
  String _filterStatus = 'all';

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    setState(() => _isLoading = true);
    
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      var query = supabase
          .from('tasks')
          .select()
          .eq('user_id', user.id);

      if (_filterStatus != 'all') {
        query = query.eq('status', _filterStatus);
      }

      final data = await query;
      setState(() => _tasks = List<Map<String, dynamic>>.from(data));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching tasks: $error')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteTask(String taskId) async {
    try {
      await supabase.from('tasks').delete().eq('id', taskId);
      _fetchTasks();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task deleted')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting task: $error')),
      );
    }
  }

  Future<void> _updateTaskStatus(String taskId, String newStatus) async {
    try {
      await supabase
          .from('tasks')
          .update({'status': newStatus})
          .eq('id', taskId);
      _fetchTasks();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating task: $error')),
      );
    }
  }

  Future<void> _signOut() async {
    await supabase.auth.signOut();
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Academic Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() => _filterStatus = value);
              _fetchTasks();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Row(
                  children: [
                    Icon(Icons.all_inclusive, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('All Tasks'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'pending',
                child: Row(
                  children: [
                    Icon(Icons.pending, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Pending'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'in_progress',
                child: Row(
                  children: [
                    Icon(Icons.autorenew, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('In Progress'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'completed',
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Completed'),
                  ],
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _signOut,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskForm()),
          );
          _fetchTasks();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            )
          : _tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.task,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No tasks found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap + to add your first task',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    final dueDate = task['due_date'] != null
                        ? DateTime.parse(task['due_date']).toLocal()
                        : null;
                    
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 80,
                              decoration: BoxDecoration(
                                color: _getPriorityColor(task['priority'] ?? 'low'),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          task['title'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(task['status'])
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: _getStatusColor(task['status']),
                                            width: 1,
                                          ),
                                        ),
                                        child: DropdownButton<String>(
                                          value: task['status'],
                                          underline: const SizedBox(),
                                          iconSize: 20,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getStatusColor(task['status']),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          onChanged: (newValue) {
                                            if (newValue != null) {
                                              _updateTaskStatus(task['id'], newValue);
                                            }
                                          },
                                          items: const [
                                            DropdownMenuItem(
                                              value: 'pending',
                                              child: Text('Pending'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'in_progress',
                                              child: Text('In Progress'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'completed',
                                              child: Text('Completed'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (task['course_name'] != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.school,
                                            size: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            task['course_name'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (dueDate != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Due: ${_formatDate(dueDate)}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (task['description'] != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        task['description'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.red),
                              onPressed: () => _deleteTask(task['id']),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}