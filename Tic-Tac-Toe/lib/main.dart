import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF238636),     // green
          secondary: Color(0xFF58A6FF),   // blue
          surface: Color(0xFF161B22),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF238636),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: const TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));
  String currentPlayer = 'X';
  String? winner;
  bool gameOver = false;
  int xScore = 0;
  int oScore = 0;

  void _makeMove(int row, int col) {
    if (board[row][col].isNotEmpty || gameOver) return;

    setState(() {
      board[row][col] = currentPlayer;
    });

    if (_checkWin(currentPlayer)) {
      setState(() {
        winner = currentPlayer;
        gameOver = true;
        if (currentPlayer == 'X') xScore++; else oScore++;
      });
      _showResultDialog();
      return;
    }

    if (_isBoardFull()) {
      setState(() => gameOver = true);
      _showResultDialog();
      return;
    }

    setState(() {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    });
  }

  bool _checkWin(String player) {
    // rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player && board[i][1] == player && board[i][2] == player) return true;
    }
    // columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == player && board[1][i] == player && board[2][i] == player) return true;
    }
    // diagonals
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true;
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) return true;

    return false;
  }

  bool _isBoardFull() {
    for (var row in board) {
      for (var cell in row) {
        if (cell.isEmpty) return false;
      }
    }
    return true;
  }

  void _showResultDialog() {
    String message = winner != null ? '$winner Wins!' : "It's a Draw!";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: Text(message, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            child: const Text('Play Again', style: TextStyle(fontSize: 18, color: Color(0xFF58A6FF))),
          ),
        ],
      ),
    );
  }

  void _resetGame({bool resetScores = false}) {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      currentPlayer = 'X';
      winner = null;
      gameOver = false;
      if (resetScores) {
        xScore = 0;
        oScore = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TIC TAC TOE',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              gameOver ? (winner ?? 'Draw') : "$currentPlayer's Turn",
              style: TextStyle(
                fontSize: 28,
                color: currentPlayer == 'X' ? Colors.red : Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  String value = board[row][col];

                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F2937),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade700, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 60,
                            color: value == 'X' ? Colors.red : Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _resetGame(),
                  child: const Text('New Game'),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () => _resetGame(resetScores: true),
                  child: const Text('Reset Scores'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('X: $xScore   |   O: $oScore', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}