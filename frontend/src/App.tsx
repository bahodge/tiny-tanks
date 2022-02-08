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

const getIdentity = ({ id }: { id: string }) => {
  const url = new URL("http://localhost:4000/identity");
  url.search = new URLSearchParams({ id }).toString();

  return fetch(url.toString(), {
    method: "get",
  }).then((response) => console.log("response", response.body));
};

const createIdentity = () => {
  return fetch("http://localhost:4000/identity/create", {
    method: "post",
  }).then((response) => console.log("response", response.body));
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
      .then(({ data }) => setSessions(data));
  };

  const joinGameSession = (): Promise<void> => {
    const params = {
      id: "0da095ec-dde7-4556-8f2c-aeb442b155f0",
      name: "my name",
    };

    return fetch("http://localhost:4000/game_session/join", {
      method: "post",
      body: JSON.stringify(params),
      headers: {
        "Content-Type": "application/json",
      },
    }).then((response) => response.json());
  };

  return (
    <div className="App">
      <div>
        <h3>Sessions</h3>
        <button onClick={() => createGameSession()}>Create Game</button>
        <button onClick={() => deleteGameSession()}>Delete Game</button>
        <button onClick={() => getGameSessions()}>Get Game Sessions</button>
        <button onClick={() => getGameSession()}>Get Game Session</button>
        <button onClick={() => joinGameSession()}>Join Game Session</button>
      </div>

      <div>
        <h3>Identity</h3>
        <button onClick={() => getIdentity({ id: "asdf" })}>getIdentity</button>
        <button onClick={() => createIdentity()}>createIdentity</button>
      </div>

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
