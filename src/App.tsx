import { ConnectButton } from "@rainbow-me/rainbowkit"

function App() {
  return (
    <div className="min-h-screen bg-slate-50">
      <header className="flex items-center justify-between px-6 py-4">
        <h1 className="text-xl font-semibold text-slate-900">Vouch Protocol</h1>
        <ConnectButton />
      </header>
    </div>
  );
}

export default App
