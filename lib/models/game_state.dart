enum GamePhase { lobby, setup, shipPlacement, gameplay, gameOver }

enum GameStatus {
  waitingForOpponent,
  ready,
  yourTurn,
  opponentTurn,
  won,
  lost,
  disconnected,
}

class GameState {
  final GamePhase phase;
  final GameStatus status;
  final String? localPlayerId;
  final String? remotePlayerId;
  final DateTime timestamp;

  const GameState({
    this.phase = GamePhase.lobby,
    this.status = GameStatus.waitingForOpponent,
    this.localPlayerId,
    this.remotePlayerId,
    required this.timestamp,
  });

  GameState copyWith({
    GamePhase? phase,
    GameStatus? status,
    String? localPlayerId,
    String? remotePlayerId,
    DateTime? timestamp,
  }) {
    return GameState(
      phase: phase ?? this.phase,
      status: status ?? this.status,
      localPlayerId: localPlayerId ?? this.localPlayerId,
      remotePlayerId: remotePlayerId ?? this.remotePlayerId,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
