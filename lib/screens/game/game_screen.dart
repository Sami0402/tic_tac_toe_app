import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';
import 'package:tic_tac_toe_app/core/constants/asset_constant.dart';
import 'package:tic_tac_toe_app/providers/game_provider.dart';
import 'package:tic_tac_toe_app/providers/room_provider.dart';
import 'package:tic_tac_toe_app/service/socket_service.dart';
import 'package:tic_tac_toe_app/utils/app_typography.dart';
import 'package:tic_tac_toe_app/widgets/game_tile.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late RoomProvider roomProvider;

  void _listnerHandler(){
      if (!mounted) {return;}

      if (roomProvider.didHostWin || roomProvider.didGuestWin){
        _animationController.forward(from: 0);
        WidgetsBinding.instance.addPostFrameCallback((_){
          roomProvider.setDidHostWin = false;
          roomProvider.setDidGuestWin = false;
        });
      }
    
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    roomProvider = context.read<RoomProvider>();

    roomProvider.addListener(_listnerHandler);

  }

  @override
  void dispose() {
    _animationController.dispose();
    roomProvider.removeListener(_listnerHandler);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoom = context.watch<RoomProvider>().currentRoom;

    final game = context.watch<GameProvider>();

    final playerTurn = currentRoom!.currentTurn == currentRoom.hostSymbol
        ? currentRoom.hostUsername
        : currentRoom.guestUsername;

    final gameResult = context.select<RoomProvider, String?>(
      (provider) => provider.gameResult,
    );

    // FOR WINNER ANIMATIONs
    var didHostWin = context.read<RoomProvider>().didHostWin;
    var didGuestWin = context.read<RoomProvider>().didGuestWin;

    // If Opponent left the Game
    context.read<RoomProvider>().showDialogBox = (message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColor.blue,
            title: Text(
              message,
              style: AppTypographyPoppins.bodyLarge,
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, 'menu'),
      );
    };

    void exitOnTap(){
      SocketService().playerLeave();
      Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, 'menu'),
      );
    }


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 24, 81),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              // SCORE BORAD
              Row(
                children: [
                  Text(
                    'Score',
                    style: AppTypographyEvilEmpire.h3.copyWith(
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: AppColor.blue,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: exitOnTap, icon: Icon(Icons.exit_to_app_outlined,color: Colors.red,))
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: .center,
                    children: [
                      SizedBox(height: 2),
                      Text(
                        currentRoom.hostUsername!,
                        style: AppTypographyEvilEmpire.displayMedium.copyWith(
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              blurRadius: 20.0,
                              color: AppColor.blue,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        currentRoom.hostScore.toString(),
                        style: AppTypographyEvilEmpire.displayMedium.copyWith(
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        currentRoom.guestUsername ?? 'Waiting for Opponent',
                        style: AppTypographyEvilEmpire.displayMedium.copyWith(
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              blurRadius: 20.0,
                              color: AppColor.darkRed,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        currentRoom.guestScore.toString(),
                        style: AppTypographyEvilEmpire.displayMedium.copyWith(
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              // BOARD
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GameTile(
                      index: index,
                      value: currentRoom.board![index],
                      currentTurn: currentRoom.currentTurn!,
                      valueChanged: (value) {
                        game.tileOnTap(index, value, currentRoom);
                      },
                    );
                  },
                ),
              ),

              // WHO'S TURN & WHO Won
              Column(
                children: [
                  // Winning Animation
                  if (didHostWin)
                    Lottie.asset(
                      AssetConstant.blueFire,
                      height: 30,
                      onLoaded: (composition) {
                        _animationController.duration = const Duration(seconds: 3);
                        
                      },
                    )
                  else if (didGuestWin)
                    Lottie.asset(
                      AssetConstant.redFire,
                      height: 30,
                      onLoaded: (composition) {
                        _animationController.duration = const Duration(seconds: 3);
                      },
                    )
                  else
                    SizedBox(),

                  SizedBox(height: 5),
                  Text(
                    gameResult ?? playerTurn ?? "",
                    style: AppTypographyEvilEmpire.displayLarge.copyWith(
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: AppColor.blue,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
