import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseController = TextEditingController();
  
  String _priority = 'medium';
  String _status = 'pending';
  DateTime? _dueDate;
  
  bool _isLoading = false;
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login first')),
        );
        Navigator.of(context).pop();
        return;
      }

      final taskData = {
        'user_id': user.id,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'course_name': _courseController.text.trim(),
        'due_date': _dueDate?.toIso8601String(),
        'priority': _priority,
        'status': _status,
      };

      taskData.removeWhere((key, value) => 
          value == null || (value is String && value.isEmpty));

      await supabase.from('tasks').insert(taskData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task created successfully')),
      );
      
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating task: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Create New Task',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: 500, // Fixed width for centering
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0), // Reduced padding
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.add_task,
                          size: 40, // Smaller icon
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'New Task',
                          style: TextStyle(
                            fontSize: 20, // Smaller font
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Fill in the details to create a new task',
                          style: TextStyle(
                            fontSize: 12, // Smaller font
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Task Title*',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8), // Smaller radius
                            ),
                            prefixIcon: const Icon(Icons.title, size: 20), // Smaller icon
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12, // Reduced padding
                            ),
                          ),
                          style: const TextStyle(fontSize: 14), // Smaller text
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter task title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _courseController,
                          decoration: InputDecoration(
                            labelText: 'Course Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.school, size: 20),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 2, // Reduced from 3
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.description, size: 20),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _priority,
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.priority_high, size: 20),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4, // Reduced padding
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                          items: const [
                            DropdownMenuItem(
                              value: 'low',
                              child: Row(
                                children: [
                                  Icon(Icons.circle, color: Colors.green, size: 14),
                                  SizedBox(width: 6),
                                  Text('Low'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'medium',
                              child: Row(
                                children: [
                                  Icon(Icons.circle, color: Colors.orange, size: 14),
                                  SizedBox(width: 6),
                                  Text('Medium'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'high',
                              child: Row(
                                children: [
                                  Icon(Icons.circle, color: Colors.red, size: 14),
                                  SizedBox(width: 6),
                                  Text('High'),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _priority = value);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _status,
                          decoration: InputDecoration(
                            labelText: 'Status',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.person, size: 20),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                          items: const [
                            DropdownMenuItem(
                              value: 'pending',
                              child: Row(
                                children: [
                                  Icon(Icons.pending, color: Colors.orange, size: 14),
                                  SizedBox(width: 6),
                                  Text('Pending'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'in_progress',
                              child: Row(
                                children: [
                                  Icon(Icons.autorenew, color: Colors.blue, size: 14),
                                  SizedBox(width: 6),
                                  Text('In Progress'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'completed',
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green, size: 14),
                                  SizedBox(width: 6),
                                  Text('Completed'),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _status = value);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                controller: TextEditingController(
                                  text: _dueDate != null
                                      ? DateFormat('yyyy-MM-dd').format(_dueDate!)
                                      : '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Due Date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: const Icon(Icons.calendar_today, size: 20),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 48, // Reduced height
                              child: ElevatedButton(
                                onPressed: _pickDate,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16, // Reduced padding
                                    vertical: 12,
                                  ),
                                ),
                                child: const Icon(Icons.calendar_month, size: 20),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 44, // Reduced height
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _isLoading ? null : _submitForm,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Create Task',
                                    style: TextStyle(
                                      fontSize: 14, // Smaller font
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _courseController.dispose();
    super.dispose();
  }
}