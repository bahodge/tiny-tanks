import React, { useState } from "react";
import "./App.css";

type Player = {
  id: string;
  name: string;
};

type GameSession = {
  id: string;
  players: Player[];
};

// import Game from "./components/Game";
// import Connection from "./services/connection";

const createGameSession = () => {
  return fetch("http://localhost:4000/game_session/create", {
    method: "post",
    body: JSON.stringify({ data: "hello from post" }),
  }).then((response) => console.log("response", response.body));
};

const deleteGameSession = () => {
  return fetch("http://localhost:4000/game_session/delete", {
    method: "delete",
    body: JSON.stringify({ data: "deleting game session" }),
  }).then((response) => console.log("response", response.body));
};

const getGameSession = () => {
  const url = new URL("http://localhost:4000/game_session");
  url.search = new URLSearchParams({ id: "some id" }).toString();

  return fetch(url.toString(), {
    method: "get",
  }).then((response) => console.log("response", response.body));
};

const App: React.FC = () => {
  const [sessions, setSessions] = useState<GameSession[]>([]);

  const getGameSessions = (): Promise<void> => {
    return fetch("http://localhost:4000/game_sessions")
      .then((response) => response.json())
      .then((payload) => {
        const { data } = payload;
        console.log("data", data);
        setSessions(data);
      });
  };

  return (
    <div className="App">
      <button onClick={() => createGameSession()}>Create Game</button>
      <button onClick={() => deleteGameSession()}>Delete Game</button>
      <button onClick={() => getGameSessions()}>Get Game Sessions</button>
      <button onClick={() => getGameSession()}>Get Game Session</button>

      <div>
        <ul>
          {sessions.map((session, idx) => (
            <li key={idx}>
              Session #{idx} - {session.id}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default App;
