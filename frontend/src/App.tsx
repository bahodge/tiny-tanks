import React, { useEffect } from "react";
import "./App.css";

import Game from "./components/Game";
// import Connection from "./services/connection";

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
      <header className="App-header"></header>

      <Game />
    </div>
  );
};

export default App;
