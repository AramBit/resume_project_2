import 'package:app_b_839/screens/globalWidgets/custom_image_view.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/size_utils.dart';
import '../../../cubit/newGameCubit/new_game_cubit.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_texts.dart';
import 'player_card.dart';

class PlayersBox extends StatelessWidget {
  const PlayersBox({
    super.key,
    required this.decrementOnTap,
    required this.incrementOnTap,
    required this.playerCount,
    required this.players,
  });
  final Function()? incrementOnTap;
  final Function()? decrementOnTap;
  final String playerCount;
  final List<String> players;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: Assets.images.player.path,
                  width: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTexts.numberofPlayers,
                        style: AppTextStyles.bold16.copyWith(
                          color: AppColors.accentTwo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Minimum - 3, maximum - 6.',
                        style: AppTextStyles.news14.copyWith(
                          color: AppColors.layerThree,
                          fontSize: ResponsiveExtension.screenWidth / 32,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: decrementOnTap,
                  child: CustomImageView(
                    imagePath: playerCount == '3'
                        ? Assets.images.plus.path
                        : Assets.images.plusActive.path,
                    width: 30,
                  ),
                ),
                SizedBox(
                  width: ResponsiveExtension.screenWidth / 20,
                ),
                Text(
                  playerCount,
                  style: AppTextStyles.extraBold16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: ResponsiveExtension.screenWidth / 20,
                ),
                GestureDetector(
                  onTap: incrementOnTap,
                  child: CustomImageView(
                    imagePath: playerCount == '6'
                        ? Assets.images.plus.path
                        : Assets.images.plusActive.path,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: List.generate(
              players.length,
              (index) {
                return PlayerCard(
                  name: players[index],
                  number: (index + 1).toString(),
                  onTap: index > 0
                      ? () {
                          NewGameCubit.newGameCubit!.changePlayer(index);
                        }
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
