import React, { useEffect, useState, useRef } from "react";

import "./Game.css";

import { Application } from "pixi.js";

const Game: React.FC = () => {
  const [app, setApp] = useState<Application>();
  const targetEl = useRef() as React.MutableRefObject<HTMLInputElement>;

  // Create the application that will be used by the user
  useEffect(() => {
    setApp(
      new Application({
        resolution: 2,
        autoDensity: true,
        // backgroundAlpha: 0,
        antialias: true,
        backgroundColor: 0x000000,
      })
    );
  }, []);

  // Create the world
  useEffect(() => {
    if (!app) return;
    if (!targetEl.current) return;

    app.ticker.maxFPS = 60;

    // Styling canvas
    app.view.style.width = "100%";
    app.view.style.height = "100%";
    app.view.style.objectFit = "fill";

    // Attach the pixiApp to the target
    targetEl.current.appendChild(app.view);

    // Clean up the world
    return () => {
      app?.destroy();
    };
  }, [app]);

  return (
    <div className="game-container">
      <span ref={targetEl} id="stage"></span>
    </div>
  );
};

export default Game;
