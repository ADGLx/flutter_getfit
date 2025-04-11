import 'package:flutter/material.dart';

enum EventType {
  exercise,
  weightProgress,
  caloriesCount,
  stepsTaken,
}

class Event {
  final EventType type;
  final String value;
  final DateTime timestamp;

  Event({
    required this.type,
    required this.value,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  String get typeString {
    switch (type) {
      case EventType.exercise:
        return 'Exercise';
      case EventType.weightProgress:
        return 'Weight Progress';
      case EventType.caloriesCount:
        return 'Calories Count';
      case EventType.stepsTaken:
        return 'Steps Taken';
    }
  }

  IconData get icon {
    switch (type) {
      case EventType.exercise:
        return Icons.fitness_center;
      case EventType.weightProgress:
        return Icons.monitor_weight;
      case EventType.caloriesCount:
        return Icons.local_fire_department;
      case EventType.stepsTaken:
        return Icons.directions_walk;
    }
  }

  Color get color {
    switch (type) {
      case EventType.exercise:
        return Colors.blue;
      case EventType.weightProgress:
        return Colors.green;
      case EventType.caloriesCount:
        return Colors.orange;
      case EventType.stepsTaken:
        return Colors.purple;
    }
  }

  String get formattedTime {
    final timeFormat = TimeOfDay.fromDateTime(timestamp);
    return '${timestamp.month}/${timestamp.day}/${timestamp.year} - $timeFormat';
  }
}

class RecentEventsCard extends StatefulWidget {
  const RecentEventsCard({super.key});

  @override
  _RecentEventsCardState createState() => _RecentEventsCardState();
}

class _RecentEventsCardState extends State<RecentEventsCard> {
  final List<Event> _events = [];
  final _formKey = GlobalKey<FormState>();
  final _eventTypeController = ValueNotifier<EventType>(EventType.exercise);
  final _valueController = TextEditingController();

  void _addEvent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Event'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<EventType>(
                valueListenable: _eventTypeController,
                builder: (context, value, _) {
                  return DropdownButtonFormField<EventType>(
                    value: value,
                    items: EventType.values.map((type) {
                      return DropdownMenuItem<EventType>(
                        value: type,
                        child: Row(
                          children: [
                            Icon(
                              Event(type: type, value: '').icon,
                              color: Event(type: type, value: '').color,
                            ),
                            const SizedBox(width: 8),
                            Text(Event(type: type, value: '').typeString),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (type) => _eventTypeController.value = type!,
                    decoration: const InputDecoration(
                      labelText: 'Event Type',
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(
                  labelText: 'Value',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a value' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                setState(() {
                  _events.insert(
                    0,
                    Event(
                      type: _eventTypeController.value,
                      value: _valueController.text,
                    ),
                  );
                  _valueController.clear();
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _deleteEvent(int index) {
    setState(() {
      _events.removeAt(index);
    });
  }

  void _showAllEvents(BuildContext context) {
    if (_events.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('All Events'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _events
                .map((event) => _buildEventTile(event))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTile(Event event) {
    final timeFormat = TimeOfDay.fromDateTime(event.timestamp).format(context);
    final dateFormat = '${event.timestamp.month}/${event.timestamp.day}/${event.timestamp.year}';
    
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: event.color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(event.icon, color: event.color),
      ),
      title: Text('${event.typeString}: ${event.value}'),
      subtitle: Text('$dateFormat - $timeFormat'),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => _deleteEvent(_events.indexOf(event)),
      ),
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    _eventTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Events',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addEvent,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _events.isEmpty
                ? const Center(
                    child: Text(
                      'No events yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : Column(
                    children: _events
                        .take(3)
                        .map((event) => _buildEventTile(event))
                        .toList(),
                  ),
            if (_events.length > 3) ...[
              const SizedBox(height: 8),
              Text(
                '... and ${_events.length - 3} more',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => _showAllEvents(context),
                child: const Text('View All Events'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}