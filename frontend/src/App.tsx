import React, { useEffect } from "react";
import "./App.css";

// import Game from "./components/Game";
// import Connection from "./services/connection";

const createGameSession = () => {
  return fetch("http://localhost:4000/game_session", {
    method: "post",
    body: JSON.stringify({ data: "hello from post" }),
  }).then((response) => console.log("response", response.body));
};

const deleteGameSession = () => {
  return fetch("http://localhost:4000/game_session", {
    method: "delete",
    body: JSON.stringify({ data: "deleteing game session" }),
  }).then((response) => console.log("response", response.body));
};

const getGameSessions = () => {
  return fetch("http://localhost:4000/game_sessions", {
    method: "get",
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
  useEffect(() => {
    // const connection = new Connection({ url: "ws://localhost:4000/" });
    // console.log("connection.socket", connection.ws);
    // return () => {
    //   connection.ws.close();
    // };
  }, []);

  return (
    <div className="App">
      <button onClick={() => createGameSession()}>Create Game</button>
      <button onClick={() => deleteGameSession()}>Delete Game</button>
      <button onClick={() => getGameSessions()}>Get Game Sessions</button>
      <button onClick={() => getGameSession()}>Get Game Session</button>

      {/* <header className="App-header"></header>

      <Game /> */}
    </div>
  );
};

export default App;
