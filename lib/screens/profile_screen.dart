import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/index.dart';
import '../providers/index.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final gameState = ref.watch(gameStateProvider);
    final businessesAsync = ref.watch(businessesProvider);

    // Count owned properties from game state
    final ownedCount = gameState.values.where((p) => p.isOwned).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Player Profile')),
      body: player == null
          ? _buildNoPlayerState(context, ref)
          : _buildPlayerState(
              context,
              ref,
              player,
              ownedCount,
              gameState,
              businessesAsync,
            ),
    );
  }

  Widget _buildNoPlayerState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 64),
          const SizedBox(height: 16),
          const Text('No player loaded'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Initialize default player
              ref
                  .read(playerProvider.notifier)
                  .setPlayer(
                    Player(
                      id: 'player_1',
                      name: 'Explorer',
                      balance: 1000,
                      ownedPropertyIds: [],
                      totalVisits: 0,
                      createdAt: DateTime.now(),
                    ),
                  );
            },
            child: const Text('Start Game'),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerState(
    BuildContext context,
    WidgetRef ref,
    Player player,
    int ownedCount,
    Map<String, Property> gameState,
    AsyncValue<List<Business>> businessesAsync,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Player card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Balance: \$${player.balance}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Stats
          Text('Stats', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Total Visits',
                  value: player.totalVisits.toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Properties Owned',
                  value: ownedCount.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Owned properties
          Text(
            'Owned Properties ($ownedCount)',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (ownedCount == 0)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.blue[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Visit businesses to own them! Each business requires multiple visits to become yours.',
              ),
            )
          else
            businessesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (businesses) {
                final ownedBusinesses = businesses
                    .where((b) => gameState[b.id]?.isOwned ?? false)
                    .toList();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ownedBusinesses.length,
                  itemBuilder: (context, index) {
                    final business = ownedBusinesses[index];
                    return ListTile(
                      leading: const Icon(Icons.home, color: Colors.green),
                      title: Text(business.name),
                      subtitle: Text(business.category),
                      trailing: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
