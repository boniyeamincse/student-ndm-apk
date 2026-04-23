import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

class MemberDirectoryScreen extends ConsumerStatefulWidget {
  const MemberDirectoryScreen({super.key});

  @override
  ConsumerState<MemberDirectoryScreen> createState() => _MemberDirectoryScreenState();
}

class _MemberDirectoryScreenState extends ConsumerState<MemberDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<MemberProfile> _filteredMembers = MockMemberData.directoryMembers;
  String _selectedFilter = 'All';

  void _filterMembers(String query) {
    setState(() {
      _filteredMembers = MockMemberData.directoryMembers.where((member) {
        final matchesQuery = member.fullName.toLowerCase().contains(query.toLowerCase()) ||
            member.memberNo.toLowerCase().contains(query.toLowerCase());
        
        final matchesFilter = _selectedFilter == 'All' || member.committeeLevel == _selectedFilter;
        
        return matchesQuery && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 140,
            backgroundColor: AppColors.surface,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Member Directory',
                style: TextStyle(color: AppColors.textHigh, fontWeight: FontWeight.w900, fontSize: 18),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 56, bottom: 64),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterMembers,
                  decoration: InputDecoration(
                    hintText: 'Search by name or Member NO...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.surfaceVariant.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ),
            ),
          ),
          
          // Filter Chips
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 12),
              child: Row(
                children: ['All', 'Central', 'District', 'Campus'].map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (val) {
                        setState(() {
                          _selectedFilter = filter;
                          _filterMembers(_searchController.text);
                        });
                      },
                      selectedColor: AppColors.primary.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.primary : AppColors.textLow,
                        fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
                        fontSize: 12,
                      ),
                      backgroundColor: AppColors.surface,
                      checkmarkColor: AppColors.primary,
                      shape: StadiumBorder(side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border, width: 0.5)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final member = _filteredMembers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.m),
                    child: FadeInAnimation(
                      delay: Duration(milliseconds: index * 50),
                      child: GestureDetector(
                        onTap: () => context.push('/directory/${member.id}'),
                        child: PremiumCard(
                          child: Row(
                            children: [
                              AvatarWidget(imageUrl: member.avatar, fallback: member.fullName, size: 56),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          member.fullName,
                                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.textHigh),
                                        ),
                                        StatusBadge(
                                          text: member.committeeLevel.toUpperCase(),
                                          color: member.committeeLevel == 'Central' ? AppColors.accent : AppColors.primary,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      member.primaryPosition,
                                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 12),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      member.primaryCommittee,
                                      style: const TextStyle(color: AppColors.textLow, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: AppColors.border),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: _filteredMembers.length,
              ),
            ),
          ),
          
          if (_filteredMembers.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.person_search_outlined, size: 64, color: AppColors.textLow),
                      SizedBox(height: 16),
                      Text('No members found', style: TextStyle(color: AppColors.textLow, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}
