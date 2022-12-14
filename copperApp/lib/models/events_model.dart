import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';

class Event extends Equatable {
  final String? eventId;
  final String? eventLocation;
  final String? dateTime;
  final String? eventImageUrls;
  final String? info;
  final List<String>? group;
  final List<String>? rsvp;
  final List<String>? declined;
  final List<String>? attended;
  final List<String>? finalMatches;

  const Event({
    this.eventId,
    required this.eventLocation,
    required this.dateTime,
    required this.eventImageUrls,
    required this.info,
    this.group,
    this.rsvp,
    this.declined,
    this.attended,
    this.finalMatches,
  });

  @override
  List<Object?> get props => [
        eventId,
        eventLocation,
        dateTime,
        eventImageUrls,
        info,
        group,
        rsvp,
        declined,
        attended,
        finalMatches,
      ];

  static Event fromSnapshot(DocumentSnapshot snap) {
    Event event = Event(
      eventId: snap.id,
      eventLocation: snap['name'],
      dateTime: snap['dateTime'],
      eventImageUrls: snap['eventImageUrls'],
      info: snap['info'],
      group: (snap['group'] as List).map((group) => group as String).toList(),
      rsvp: (snap['rsvp'] as List).map((rsvp) => rsvp as String).toList(),
      declined: (snap['declined'] as List)
          .map((declined) => declined as String)
          .toList(),
      attended: (snap['attended'] as List)
          .map((attended) => attended as String)
          .toList(),
      finalMatches: (snap['finalMatches'] as List)
          .map((finalMatches) => finalMatches as String)
          .toList(),
    );
    return event;
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'eventLocation': eventLocation,
      'dateTime': dateTime,
      'eventImageUrls': eventImageUrls,
      'info': info,
      'group': group,
      'rsvp': rsvp,
      'declined': declined,
      'attended': attended,
      'finalMatches': finalMatches,
    };
  }

  Event copyWith({
    String? eventId,
    String? eventLocation,
    String? dateTime,
    String? eventImageUrls,
    String? info,
    List<String>? group,
    List<String>? rsvp,
    List<String>? declined,
    List<String>? attended,
    List<String>? finalMatches,
  }) {
    return Event(
      eventId: eventId ?? this.eventId,
      eventLocation: eventLocation ?? this.eventLocation,
      dateTime: dateTime ?? this.dateTime,
      eventImageUrls: eventImageUrls ?? this.eventImageUrls,
      info: info ?? this.info,
      group: group ?? this.group,
      rsvp: rsvp ?? this.rsvp,
      declined: declined ?? this.declined,
      attended: attended ?? this.attended,
      finalMatches: finalMatches ?? this.finalMatches,
    );
  }

  static List<Event> events = [
    Event(
      eventId: '1',
      eventLocation: 'The Spaniard',
      dateTime: '8th of December 2022, 8:00pm',
      eventImageUrls:
          'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YmFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
      info: 'The Spaniard is speakeasy, cozy bar in the West Village.',
    ),
    Event(
      eventId: '2',
      eventLocation: 'The Spaniard',
      dateTime: '29th of November 2022, 08:30 pm',
      eventImageUrls:
          'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YmFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
      info: 'The Spaniard is speakeasy, cozy bar in the West Village.',
    ),
    Event(
      eventId: '3',
      eventLocation: 'The Spaniard',
      dateTime: '15th of December 2022, 8:00pm',
      eventImageUrls:
          'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YmFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
      info: 'The Spaniard is speakeasy, cozy bar in the West Village.',
    ),
    Event(
      eventId: '4',
      eventLocation: 'The Spaniard',
      dateTime: '28th of December 2022, 8:30pm',
      eventImageUrls:
          'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YmFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
      info: 'The Spaniard is speakeasy, cozy bar in the West Village.',
    ),
    Event(
      eventId: '5',
      eventLocation: 'The Spaniard',
      dateTime: '5th of January 2023, 8:00pm',
      eventImageUrls:
          'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YmFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
      info: 'The Spaniard is speakeasy, cozy bar in the West Village.',
    ),
  ];
}
