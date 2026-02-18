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

enum CellState { empty, ship, hit, miss, sunk }

enum ShipOrientation { horizontal, vertical }

enum ShotResult { hit, miss, sunk, alreadyShot }
