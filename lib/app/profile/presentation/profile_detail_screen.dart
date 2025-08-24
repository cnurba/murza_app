import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:murza_app/app/profile/application/current_user/current_user_provider.dart';
import 'package:murza_app/app/profile/application/current_user/current_user_controller.dart';
import 'package:murza_app/app/profile/application/current_user/current_user_state.dart';
import 'package:murza_app/app/profile/domain/models/user_model.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';

class ProfileDetailScreen extends ConsumerStatefulWidget {
  const ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends ConsumerState<ProfileDetailScreen> {
  bool _requested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = ref.read(currentUserProvider);
    if (!_requested && state.stateType == BlocStateType.initial) {
      _requested = true;
      ref.read(currentUserProvider.notifier).loadCurrentUser();
    }
  }

  void _reload() => ref.read(currentUserProvider.notifier).loadCurrentUser();

  @override
  Widget build(BuildContext context) {
    final CurrentUserState state = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            tooltip: 'Обновить',
            icon: const Icon(Icons.refresh),
            onPressed: state.stateType == BlocStateType.loading ? null : _reload,
          ),
        ],
      ),
      floatingActionButton: state.stateType == BlocStateType.loaded
          ? FloatingActionButton(
              onPressed: _reload,
              child: const Icon(Icons.refresh),
            )
          : null,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: state.stateType.when(
          initial: () => const _InitialPlaceholder(),
          loading: () => const _LoadingView(),
            error: () => _ErrorView(onRetry: _reload),
          loaded: () => RefreshIndicator(
            onRefresh: () async => _reload(),
            child: _UserView(user: state.user),
          ),
        ),
      ),
    );
  }
}

class _InitialPlaceholder extends StatelessWidget {
  const _InitialPlaceholder();
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorView({required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 48),
            const SizedBox(height: 12),
            const Text('Ошибка загрузки профиля', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserView extends StatelessWidget {
  final UserModel user;
  const _UserView({required this.user});

  String _initials() {
    final parts = [user.name, user.surname, user.lastname]
        .where((e) => e.trim().isNotEmpty)
        .map((e) => e.trim().characters.first.toUpperCase())
        .toList();
    if (parts.isEmpty) return user.username.isNotEmpty ? user.username.characters.first.toUpperCase() : '?';
    return parts.take(2).join();
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('dd.MM.yyyy HH:mm');
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        _HeaderCard(user: user, initials: _initials()),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Контакты',
          icon: Icons.contact_phone,
          children: [
            if (user.phone.isNotEmpty) _InfoTile(icon: Icons.phone, label: 'Телефон', value: user.phone),
            if (user.whatsapp.isNotEmpty) _InfoTile(icon: Icons.chat, label: 'WhatsApp', value: user.whatsapp),
            if (user.email.isNotEmpty) _InfoTile(icon: Icons.email, label: 'Email', value: user.email),
          ],
        ),
        if (user.address.isNotEmpty || user.city.isNotEmpty || user.state.isNotEmpty || user.country.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Адрес',
            icon: Icons.home,
            children: [
              if (user.address.isNotEmpty) _InfoTile(icon: Icons.location_on, label: 'Адрес', value: user.address),
              if (user.city.isNotEmpty) _InfoTile(icon: Icons.location_city, label: 'Город', value: user.city),
              if (user.state.isNotEmpty) _InfoTile(icon: Icons.map, label: 'Регион', value: user.state),
              if (user.country.isNotEmpty) _InfoTile(icon: Icons.public, label: 'Страна', value: user.country),
            ],
          ),
        ],
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Системно',
          icon: Icons.info_outline,
          children: [
            _InfoTile(icon: Icons.badge, label: 'ID', value: user.id.toString()),
            _InfoTile(icon: Icons.account_circle, label: 'Логин', value: user.username),
            _StatusTile(isActive: user.isActive),
            _InfoTile(icon: Icons.schedule, label: 'Создан', value: dateFmt.format(user.createdAt)),
            _InfoTile(icon: Icons.update, label: 'Обновлен', value: dateFmt.format(user.updatedAt)),
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            'Последнее обновление: ${dateFmt.format(user.updatedAt)}',
            style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withOpacity(0.6)),
          ),
        ),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final UserModel user;
  final String initials;
  const _HeaderCard({required this.user, required this.initials});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameLine = [user.surname, user.name, user.lastname]
        .where((e) => e.trim().isNotEmpty)
        .join(' ')
        .trim();

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                initials,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameLine.isNotEmpty ? nameLine : (user.username.isNotEmpty ? user.username : 'Без имени'),
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (user.username.isNotEmpty && nameLine.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text('@${user.username}', style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor)),
                  ],
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      _Chip(label: user.isActive ? 'Активен' : 'Неактивен', color: user.isActive ? Colors.green : Colors.grey),
                      if (user.email.isNotEmpty) _Chip(label: 'Email', color: theme.colorScheme.primary),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.icon, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 12),
            ..._withDividers(children),
          ],
        ),
      ),
    );
  }

  List<Widget> _withDividers(List<Widget> widgets) {
    final list = <Widget>[];
    for (var i = 0; i < widgets.length; i++) {
      list.add(widgets[i]);
      if (i != widgets.length - 1) {
        list.add(const Divider(height: 12));
      }
    }
    return list;
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTile({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.secondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor)),
              const SizedBox(height: 2),
              Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusTile extends StatelessWidget {
  final bool isActive;
  const _StatusTile({required this.isActive});
  @override
  Widget build(BuildContext context) {
    return _InfoTile(
      icon: isActive ? Icons.check_circle : Icons.remove_circle_outline,
      label: 'Статус',
      value: isActive ? 'Активен' : 'Неактивен',
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    final onColor = ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : Colors.black87;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        border: Border.all(color: color.withOpacity(.6)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: onColor),
      ),
    );
  }
}

class _FieldEntry {
  final String label;
  final String value;
  _FieldEntry(this.label, this.value);
}
