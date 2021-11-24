# ConsenSys Bootcamp Final Project - Diamond Hands
## About Diamond Hands
Diamond Hands is the home of unique, generative NFTs. The marketplace randomly generates ERC-721 diamonds on the Ethereum Ropsten testnet. The original diamond design was created in Inkscape and exported as an SVG that has been layered and coded into the frontend. This means that background colours and attributes like sparkles and imperfections (including CSS animations) can be randomly generated to make each diamond with a chance of 1 in 11,250,000. With only 7777 diamonds possible to mine, it makes the collection itself one of a kind. More information on stats and rarity can be found on the website. 

Smart contracts are written with Solidity and the frontend is written in JavaScript with React. Many libraries were used to pull together a comprehensive project that aligns with ERC-721 Standards and can be used as a launch point for a commercial NFT solution. I decided to build an NFT project because I wanted to have as much fun as possible. I hope you get some sparkles in your diamonds and enjoy minting some NFTs (or mining some diamonds in this case).
## MetaMask
* Visit [MetaMask](https://metamask.io/)
* Download extension in browser you'll be using (I recommend [Brave Browser](https://brave.com/))
## How to Use
* Go to [Diamond Hands](https://diamondhandsnft.netlify.app/)
* * https://diamondhandsnft.netlify.app/
* Make sure your MetaMask wallet is connect to the Ropsten testnet
* * If you don't have Ropsten test Ether you can search online for a faucet to have some sent to you
* Login with MetaMask
### Mining Diamonds
* Simply click the `Mine Diamond` button and approve the transaction to mine a diamond
* The NFT is randomly generated and comprised of a unique string that is interpreted by the frontend
### Transferring Diamonds
* Type the diamond ID located under the diamond (it must be owned by you)
* Copy in the address of another Ethereum wallet where you'd like to send your token and press `Transfer`
* * You can switch between accounts to see the update of wallets and there's also a notification to show that the transfer was successful
### Showing All Diamonds
* The `See All Diamonds` button will show you all diamonds mined - even those that aren't in your wallet
* After this button is pressed, you can press the `Reload My Diamonds` button to refresh the page and see your diamonds again
* Mine a diamond!
* Transfer a diamond to a friend on Ropsten or another wallet of your own to test
* View all diamonds in the collection by toggling the list view at the bottom
### Screencast Link
[Screencast Link](https://www.loom.com/share/82595e43f2e647edb03ff7e7a461e810)
## Run Locally (Developers):
### Required:
* Node.js >= v14
* Truffle
* Ganache
* MetaMask
### Smart Contract & Blockchain Setup:
* Clone this repository to your local machine
* Run `npm install` to install all dependencies
* Run local testnet on port `7545` with Ganache
* Ensure truffle-config.js file is added to project in Ganache
* Import an account from Ganache to MetaMask if you haven't already ([See here](https://www.trufflesuite.com/docs/truffle/getting-started/truffle-with-metamask/))
* `truffle migrate --network development` or `sudo truffle migrate --network development`
* `truffle console --network development` or `sudo truffle console --network development`
* `test` to run local tests in Truffle console
### Frontend Setup
* `npm run start`
* If browser doesn't automically open, go to http://localhost:3000/
* Your MetaMask wallet should automatically connect
* * If it doesn't, refresh the page and ensure your local Ganache network is selected in MetaMask along with the correct imported account
## Developer Notes
### Directory
* `designAndSecuirty`: Files for `design pattern decisions` and `avoiding common attacks`
* `migrations`: Migration files for deploying contracts in `src/contracts`
* `public`: Frontend files `favicon.ico` and `index.html`
* `src`: ABIs, smart contracts and React frontend
* * `abis`: ABI files for the project
* * `components`: Frontend React files
* * `contracts`: Interfaces, libraries and contracts deployed on Ropsten testnet
* `test`: Smart contract unit tests
### Design Patterns and Attack Vectors
* [Design Pattern Decisions](/designAndSecurity/design_pattern_decisions.md)
* [Avoiding Common Attacks](/designAndSecurity/avoiding_common_attacks.md)
### Future Updates
* Uncomment functions in the `IERC721` interface and add functions to `ERC721` to create fully compliant ERC-721 contract
* Create engine to upload generate image to IPFS so it is decentralised and viewable on NFT marketplaces
* Produce 'chemistry' string of numbers with interpreter to translate data to the frontend and store smaller amount of data on the blockchain
* Display 'chemistry' string on frontend along with attributes and rarity for each diamond
* Fix toggle for `Reload My Diamonds` to perform realtime update rather than screen refresh
* Optimise frontend for mobile
### Environment Variables (required for non-local deployment)
* You will need to create a `.env` file and add the below items if you wish to deploy on a network other than local
```
INFURA_API_KEY="your key here - no quotations"
MNEMONIC="your mnemonic here - include quotations"
```
## Public Ethereum Wallet Address (for NFT certification)
`0x7d48936462D0cf9457c71e1102776Ef676E6054a`