import 'package:dm_notes/models/campaign.dart';
import 'package:flutter/material.dart';

class CampaignFormWidget extends StatelessWidget {
  final String? name;
  final String? description;
  final String? theme;

  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedTheme;

  const CampaignFormWidget({
    Key? key,
    this.name = '',
    this.description = '',
    this.theme = '',
    required this.onChangedName,
    required this.onChangedDescription,
    required this.onChangedTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildName(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '${CampaignModel.name}...',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'The Name cannot be empty' : null,
        onChanged: onChangedName,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '${CampaignModel.description}...',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (description) => description != null && description.isEmpty
            ? 'The Description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}
