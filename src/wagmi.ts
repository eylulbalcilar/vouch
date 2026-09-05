import  { getDefaultConfig } from "@rainbow-me/rainbowkit";
import { baseSepolia } from "wagmi/chains";

export const config = getDefaultConfig({
    appName: "Vouch",
    projectId: "b1f2914319fb4c1b170b4f04ef683797",
    chains: [baseSepolia],
});
