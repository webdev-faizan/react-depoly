import logo from "./logo.svg";
import "./App.css";

function App() {
  const name = process.env.name;
  console.log(name);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          faizan ali Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn Reacts
          {process.env.USER_NMAE} last check
        </a>
      </header>
    </div>
  );
}

export default App;
