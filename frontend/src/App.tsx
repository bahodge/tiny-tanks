import React, { useState } from "react";
import "./App.css";

type User = {
  id: string;
  name: string;
};

const BASE_URL = "http://127.0.0.1:4000";
const USERS_ROUTE = "/users";
const CREATE_USER_ROUTE = "/users/create";

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

  const createUser = (event: React.SyntheticEvent): Promise<void> => {
    event.preventDefault();
    const target = event.target as typeof event.target & {
      name: { value: string };
    };
    return fetch(BASE_URL + CREATE_USER_ROUTE, {
      method: "post",
      body: JSON.stringify({ name: target.name.value }),
      headers: { "content-type": "application/json" },
    })
      .then((response) => {
        if (response.status >= 400) {
          throw new Error(response.statusText);
        }
        return response.json();
      })
      .then((responsePayload) => console.log(responsePayload))
      .catch((error) => error.message);
  };

  return (
    <div>
      <div>
        <h3>Users</h3>
        <button onClick={() => getUsers()}>getUsers</button>
        <form onSubmit={createUser}>
          <label>
            Name
            <input id="name-input" name="name" type="text" />
            <button>Submit</button>
          </label>
        </form>
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
