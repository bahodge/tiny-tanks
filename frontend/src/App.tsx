import React, { useState } from "react";
import "./App.css";

// type Player = {
//   id: string;
//   name: string;
// };

// type GameSession = {
//   id: string;
//   players: Player[];
// };

// const getIdentity = ({ id }: { id: string }) => {
//   const url = new URL("http://localhost:4000/identity");
//   url.search = new URLSearchParams({ id }).toString();

//   return fetch(url.toString(), {
//     method: "get",
//   }).then((response) => console.log("response", response.body));
// };

// const createIdentity = () => {
//   return fetch("http://localhost:4000/identity/create", {
//     method: "post",
//   }).then((response) => console.log("response", response.body));
// };

// // import Game from "./components/Game";
// // import Connection from "./services/connection";

// const createGameSession = () => {
//   return fetch("http://localhost:4000/game_session/create", {
//     method: "post",
//     body: JSON.stringify({ data: "hello from post" }),
//   }).then((response) => console.log("response", response.body));
// };

// const deleteGameSession = () => {
//   return fetch("http://localhost:4000/game_session/delete", {
//     method: "delete",
//     body: JSON.stringify({ data: "deleting game session" }),
//   }).then((response) => console.log("response", response.body));
// };

// const getGameSession = () => {
//   const url = new URL("http://localhost:4000/game_session");
//   url.search = new URLSearchParams({ id: "some id" }).toString();

//   return fetch(url.toString(), {
//     method: "get",
//   }).then((response) => console.log("response", response.body));
// };

// const getGameSessions = (): Promise<void> => {
//   return fetch("http://localhost:4000/game_sessions")
//     .then((response) => response.json())
//     .then(({ data }) => setSessions(data));
// };

// const joinGameSession = (): Promise<void> => {
//   const params = {
//     id: "0da095ec-dde7-4556-8f2c-aeb442b155f0",
//     name: "my name",
//   };

//   return fetch("http://localhost:4000/game_session/join", {
//     method: "post",
//     body: JSON.stringify(params),
//     headers: {
//       "Content-Type": "application/json",
//     },
//   }).then((response) => response.json());
// };

type User = {
  id: string;
  name: string;
};

const BASE_URL = "http://127.0.0.1:4000";
const USERS_ROUTE = "/users";

const App: React.FC = () => {
  const [users, setUsers] = useState<User[]>([]);

  const getUsers = (): Promise<User[]> => {
    return fetch(BASE_URL + USERS_ROUTE)
      .then((response) => response.json())
      .then((json) => {
        console.log("data", json.data);
        setUsers(json.data);
        return json.data;
      });
  };

  const updateCounter = (): Promise<void> => {
    return fetch(BASE_URL + "/update_counter")
      .then((response) => response.body)
      .then((r) => console.log("r", r))
      .catch((e) => console.log("error", e));
  };

  return (
    <div>
      <div>
        <h3>Users</h3>
        <button onClick={() => getUsers()}>getUsers</button>
        <button onClick={() => updateCounter()}>updateCounter</button>
      </div>

      <div>
        <ul>
          {users.map((user, idx) => (
            <li key={idx}>
              users #{idx} - {user.id}, {user.name}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default App;
