import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/clients/application/clients/clients_future_provider.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';
import 'package:murza_app/core/extensions/router_extension.dart';
import 'package:murza_app/core/presentation/buttons/app_animated_button.dart';
import 'package:murza_app/core/presentation/buttons/app_elevated_button.dart';
import 'package:murza_app/core/presentation/textforms/app_text_field_form.dart';

import '../../../core/presentation/textforms/app_email_text_field.dart';
import '../../../core/presentation/textforms/app_phone_text_field.dart';
import '../application/new_client/new_client_provider.dart';

class ClientForm extends StatefulWidget {
  final void Function(ClientModel client) onSave;

  const ClientForm({super.key, required this.onSave});

  @override
  State<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String email = '';
  String inn = '';
  String contactPerson = '';
  String region = '';
  String marketName = '';
  String boothNumber = '';
  bool isWholesaler = false;
  String notes = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Добавить клиента',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          CheckboxListTile(
            title: const Text('Оптовик'),
            value: isWholesaler,
            onChanged: (v) => setState(() => isWholesaler = v ?? false),
          ),
          AppTextFieldForm(
            labelText: "Имя",
            validator: (v) => v!.isEmpty ? 'Введите имя' : null,
            onSaved: (v) => name = v ?? '',
          ),
          AppTextFieldForm(
            labelText: "ИНН",
            keyboardType: TextInputType.number,
            validator: (v) => v!.isEmpty ? 'Введите имя' : null,
            onSaved: (v) => inn = v ?? '',
          ),
          PhoneEditField(onSaved: (v) => phone = v ?? ''),
          EmailTextField(onSaved: (v) => email = v ?? ''),
          AppTextFieldForm(
            labelText: "Контактное лицо",
            validator: (v) => v!.isEmpty ? 'Введите контактное лицо' : null,
            onSaved: (v) => contactPerson = v ?? '',
          ),
          AppTextFieldForm(
            labelText: "Регион",
            validator: (v) => v!.isEmpty ? 'Введите регисон' : null,
            onSaved: (v) => region = v ?? '',
          ),
          AppTextFieldForm(
            labelText: "Рынок",
            validator: (v) => v!.isEmpty ? 'Введите рынок' : null,
            onSaved: (v) => marketName = v ?? '',
          ),
          AppTextFieldForm(
            labelText: "№ павильона",
            validator: (v) => v!.isEmpty ? 'Введите павильон' : null,
            keyboardType: TextInputType.number,
            onSaved: (v) => boothNumber = v ?? '',
          ),
          AppTextFieldForm(
            labelText: "Заметки",
            onSaved: (v) => notes = v ?? '',
          ),
          const SizedBox(height: 16),
          Consumer(
            builder: (context, ref, child) {
              final newClientState = ref.watch(newClientProvider);
              return AppAnimatedButton(
                title: "Сохранить",
                stateType: newClientState.stateType,
                onPressedBack: () {
                  /// refresh clients list after saving
                 ref.refresh(clientsFutureProvider);
                 context.pop();
                },
                onPressed: newClientState.stateType == BlocStateType.initial
                    ? () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          widget.onSave(
                            ClientModel(
                              id: 0,
                              name: name,
                              phone: phone,
                              email: email,
                              inn: inn,
                              contactPerson: contactPerson,
                              region: region,
                              marketName: marketName,
                              boothNumber: boothNumber,
                              isWholesaler: isWholesaler,
                              notes: notes,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            ),
                          );
                        }
                      }
                    : null,
              );
            },
            child: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
