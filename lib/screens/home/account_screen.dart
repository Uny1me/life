import 'package:aproko_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../profile/personal_information_screen.dart';
import '../profile/health_profile_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200.h,
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Account',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16.w),
          sliver: SliverToBoxAdapter(
            child: _buildProfileSection(context),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16.w),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildSettingTile(
                context,
                'Personal Information',
                const Icon(Icons.person_outline),
                () {
                  context.push('/personal-information');
                },
              ),
              _buildSettingTile(
                context,
                'Health Profile',
                const Icon(
                  Icons.favorite_outline,
                  color: Colors.red,
                ),
                () {
                  context.push('/health-profile');
                },
              ),
              _buildSettingTile(
                context,
                'Challenges',
                const Icon(
                  Icons.flag_outlined,
                  color: AppTheme.secondaryDark,
                ),
                () {
                  context.push('/challenges');
                },
              ),
              _buildSettingTile(
                context,
                'Notifications',
                const Icon(Icons.notifications_outlined),
                () {
                  context.push('/notification-settings');
                },
              ),
              _buildSettingTile(
                context,
                'Dark Mode',
                const Icon(Icons.dark_mode_outlined),
                () {
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
              _buildSettingTile(
                context,
                'Help & Support',
                const Icon(Icons.help_outline),
                () {
                  context.push('/help-support');
                },
              ),
              _buildSettingTile(
                context,
                'Logout',
                const Icon(Icons.logout_outlined),
                () {
                  context.push('/logout');
                },
              ),
            ]),
          ),
        ),
      ],
    ));
  }

  Widget _buildProfileSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: 50.sp,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Emeka Pius',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 4.h),
            Text(
              'emekapius@gmail.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileStat(
                  context,
                  'Workouts',
                  '24',
                  SvgPicture.asset('assets/icons/exercise.svg',
                      width: 24.w, height: 24.h, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                ),
                _buildProfileStat(
                  context,
                  'Streak',
                  '7 days',
                  SvgPicture.asset('assets/icons/flame.svg', width: 24.w, height: 24.h),
                ),
                _buildProfileStat(
                  context,
                  'Challenges',
                  '3',
                  SvgPicture.asset('assets/icons/goal.svg',
                      width: 24.w, height: 24.h, colorFilter: const ColorFilter.mode(AppTheme.secondaryDark, BlendMode.srcIn)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(
    BuildContext context,
    String label,
    String value,
    Widget? icon,
  ) {
    return Column(
      children: [
        if (icon != null) icon,
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context,
    String title,
    Widget icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      child: ListTile(
        leading: icon,
        // leading: Icon(
        //   icon,
        //   color: Theme.of(context).primaryColor,
        // ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
