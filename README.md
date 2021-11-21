# ConsenSys Bootcamp Final Project - Diamond Hands
## About Diamond Hands

## How to Use

## Website:
[Diamond Hands](https://diamondhandsnft.netlify.app/)
## How to run Diamond Hands locally:
### Required:

* Node.js >= v14
* Truffle
* Ganache
* MetaMask

### MetaMask

* Visit [MetaMask](https://metamask.io/)
* Download extension in browser you'll be using (I recommend [Brave Browser](https://brave.com/))
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

### Developer Notes
#### Directory 

### Screencast Link

### Public Ethereum Wallet Address (for NFT certification)
### Future Updates

