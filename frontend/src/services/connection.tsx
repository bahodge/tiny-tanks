interface IConnectionOptions {
  url: string;
}

class Connection {
  ws: WebSocket;
  constructor(options: IConnectionOptions) {
    this.ws = new WebSocket(options.url);

    this.ws.onopen = (event) => {
      this.ws.send("Here's some text that the server is urgently awaiting!");
    };

    this.ws.onmessage = (message) => {
      console.log("message", message.data);
    };
  }
}

export default Connection;
