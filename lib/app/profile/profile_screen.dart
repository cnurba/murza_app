import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/auth/application/auth/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  "Профайл",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "Обновите настройки, такие как редактирование профиля и т. д.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ProfileMenuCard(
                  icon: Icon(Icons.account_box_outlined),
                  title: "Информация о профиле",
                  subTitle: "Изменить информацию о профиле",
                  press: () {},
                ),
                ProfileMenuCard(
                  icon: Icon(Icons.password),
                  title: "Изменить пароль",
                  subTitle: "Изменить свой пароль",
                  press: () {},
                ),

                ProfileMenuCard(
                  icon: Icon(Icons.delete),
                  title: "Удалить аккаунт",
                  subTitle:
                      "Пожалуйста, обратите внимание, что удаление вашего аккаунта приведет к безвозвратной потере всего ваших данных.",
                  press: () {},
                ),

                ProfileMenuCard(
                  icon: Icon(Icons.signpost_outlined),
                  title: "Выход из аккаунта",
                  subTitle:
                      "После выхода придется заново войти используя свой Email",
                  press: () {
                    ref.read(authProvider.notifier).signOut();
                    Future.delayed(const Duration(seconds: 1), () {
                      ref.refresh(authProvider);
                      //RestartWidget.restartApp(context);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    this.title,
    this.subTitle,
    this.icon,
    this.press,
  });

  final String? title, subTitle;
  final VoidCallback? press;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              icon!,
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subTitle!,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF010F07).withOpacity(0.54),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios_outlined, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
