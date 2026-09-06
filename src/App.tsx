import { ConnectButton } from "@rainbow-me/rainbowkit";
import { useReadContract } from "wagmi";
import { VOUCH_ADDRESS, VOUCH_ABI } from "./contract";

function App() {
  const { data: owner, isLoading, error } = useReadContract({
    address: VOUCH_ADDRESS,
    abi: VOUCH_ABI,
    functionName: "owner",
  });

  return (
    <div className="min-h-screen">
      <header className="flex items-center justify-between px-6 py-4 ">
        <h1 className="text-xl font-semibold">Vouch</h1>
        <ConnectButton />
      </header>

      <main className="p-6">
        {isLoading && <p>Loading...</p>}
        {error && <p>Error: {error.message}</p>}
        {owner ? <p>Contract owner: {String(owner)}</p> : null}
      </main>
    </div>
  );
}

export default App;
