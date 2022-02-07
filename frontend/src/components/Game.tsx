import React, { useState } from "react";
// import fetch from "node-fetch";

export enum GameState {
  UNINITIALIZED,
  CREATING_ROOM,
  PLAYING,
  PAUSED,
  OVER,
}

interface IGameProps {
  setState: (newState: GameState) => void;
}

const UninitializedGame: React.FC<IGameProps> = ({ setState }) => {
  const createNewGameSession = () => {
    // Create a new game, this game is held in memory
    return fetch("http://localhost:4000/game_session", {
      method: "post",
      body: JSON.stringify({ data: "hello from post" }),
    })
      .then((response) => console.log("response", response))
      .then(() => setState(GameState.CREATING_ROOM));
  };

  return (
    <div>
      <h2>Game is UNINITIALIZED</h2>

      <button onClick={() => createNewGameSession()}>New Game</button>
    </div>
  );
};

const Lobby: React.FC<IGameProps> = ({ setState }) => {
  const closeRoom = () => {
    return fetch("http://localhost:4000/game_session", {
      method: "delete",
    })
      .then((response) => console.log("response", response))
      .then(() => setState(GameState.UNINITIALIZED));
  };

  return (
    <div>
      <h2>Waiting for players to join</h2>
      <button onClick={() => closeRoom()}>Close Room</button>
    </div>
  );
};

const Game: React.FC = () => {
  const [state, setState] = useState(GameState.UNINITIALIZED);

  switch (state) {
    case GameState.UNINITIALIZED:
      return <UninitializedGame setState={setState} />;
    case GameState.CREATING_ROOM:
      return <Lobby setState={setState} />;
    default:
      break;
  }

  return <div></div>;
};

export default Game;
