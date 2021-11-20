import React, { Component } from 'react';
import Web3 from 'web3';
import Diamonds from '../abis/Diamonds.json';
import {MDBCard, MDBCardBody, MDBCardTitle} from 'mdb-react-ui-kit';
import './App.css';
import {diamondbox, diamondcolor} from './Colors.js';

class App extends Component {

    async componentWillMount() {
        await this.loadWeb3()
        await this.loadBlockchainData()
    }

    async loadWeb3() {
        if (window.ethereum) {
          window.web3 = new Web3(window.ethereum)
            await window.ethereum.send('eth_requestAccounts')
        }
        else if (window.web3) {
          window.web3 = new Web3(window.web3.currentProvider)
        }
        else {
          window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!')
        }
      }

    async loadBlockchainData() {
        const web3 = window.web3
        const accounts = await web3.eth.getAccounts()
        this.setState({account:accounts[0]})

        /// Get contract
        const networkId = await web3.eth.net.getId();
        const networkData = Diamonds.networks[networkId];

        if(networkData) {
            const abi = Diamonds.abi;
            const address = networkData.address;
            const contract = new web3.eth.Contract(abi, address);
            this.setState({contract})

            /// Get total supply
            const totalSupply = await contract.methods.totalSupply().call()
            this.setState({totalSupply})

            /// Get my supply (for user)
            const mySupply = await contract.methods.tokensOfOwner(this.state.account).call()
            this.setState({mySupply})
            
            /// Load all diamonds
            for(let i = 0; i < totalSupply; i++) {
                const diamond = await contract.methods.diamonds(i).call()
                this.setState({
                    diamonds:[...this.state.diamonds, diamond]
                })
            }

            /// Load mydiamonds (for user)
            for(let i = 0; i < mySupply.length; i++) {
                const index = mySupply[i]
                const temp = await contract.methods.diamonds(index).call()
                const myDiamond = [temp.chemistry, temp.diamondId]
                
                this.setState({
                    myDiamonds:[...this.state.myDiamonds, myDiamond]
                })
            }
    
        } else {
            window.alert("Smart contract not deployed.")
        }
    }

    mint = (diamond) => {
        this.state.contract.methods.mint(diamond).send({from:this.state.account})
        .once('receipt', (receipt) => {
            this.setState({
                diamonds:[...this.state.diamonds, diamond]
            })
        })
        .on('confirmation', function(confNumber, receipt, latestBlockHash){ 
            window.alert("Congratulations! Your diamond has been mined!")
            window.location.reload(false)
        })
        .on('error', function(error){ 
            window.alert("Mint failed!\n\nDiamond may already be mined or mine is empty.")
        })
    }

    transfer = (to, diamondId) => {
        console.log(diamondId)
        this.state.contract.methods.transferFrom(this.state.account, to, diamondId).send({from:this.state.account})
        .on('confirmation', function(confNumber, receipt, latestBlockHash){ 
            window.alert("Your diamond has been transferred.")
            window.location.reload(false)
        })
        .on('error', function(error){ 
            window.alert("Transfer failed.\n\nPlease check your details and try again.")
        })

    }

    generateBackground() {
        var num = Math.floor(Math.random() * 99);
        var color = diamondbox[num]
        return color;
    }

    generateDiamondColor() {
        var num = Math.floor(Math.random() * 99);
        var color = diamondcolor[num]
        return color;
    }

    generateImperfection() {
        var possible = '01111';
        var imperfection = possible[Math.floor(Math.random() * 5)];
    
        return imperfection;
    }

    generateSparkle() {
        var num = Math.floor(Math.random() * 2);
        
        /// Case 0: solid, Case 1: solid + flicker, Case 2: none
        switch (num) {
            case 0:
                var sparkle = '1xxxxxxx ';
                break
            case 1:
                sparkle = '1flicker ';
                break
            case 2:
                sparkle = '0xxxxxxx ';
                break
            default:
                sparkle = '0xxxxxxx ';
                break
        }

        return sparkle;
    }

    constructor(props) {
        super(props);
        this.state = {
            account: '',
            contract: null,
            totalSupply: 0,
            mySupply: [],
            diamonds:[],
            myDiamonds:[]
        }
    }

    render() {
        return (
            <div className='container-full'>
                <nav className='navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow'>
                    <div className='navbar-brand col-sm-3 col-md-3 mr-0' style={{color:'white', fontSize: '1rem'}}>
                        diamonds mined: {this.state.totalSupply.toString()}
                    </div>
                    <ul className='nav-bar-nav px-3'>
                        <li className='navbar-brand text-nowrap d-none d-sm-none d-sm-block'>
                            <small className='text-white' style={{fontSize: '0.8rem'}}>
                                wallet: {this.state.account}
                            </small>
                        </li>
                    </ul>
                </nav>

                <div className='container-fluid mt-1'>
                    <div className='row'>
                        <main className='col-lg-12 text-center'>
                            <div className='content mr-auto ml-auto'>
                                <h1 style={{color:'black', fontSize: '7rem'}}>
                                    Diamond Hands
                                </h1>

                                <div className='diamondmain'>
                                    <svg  version="1.1" viewBox="0 0 211.67 211.67" xmlns="http://www.w3.org/2000/svg">    
                                        
                                        <g id="dbody">
                                            <path className="diamond_body" fill="#181285" d="m50.635 25.94-17.636 19.99 21.499-0.077514 12.417-19.912h-16.279zm25.804 0-9.4484 20.12 38.573-0.39118 0.14521-0.0016h0.061l38.652 0.35448-9.3177-20.082h-58.665zm68.238 0 12.373 20.069 21.622 0.14418-17.669-20.213h-16.325zm-111.68 25.968 36.589 66.724 35.975 67.097-25.348-67.097-25.717-66.566-21.499-0.15968zm72.564 133.82 19.268-66.933 19.592-66.558-38.655 0.2067-0.20619-0.0016 0.17673 0.0021h-0.0315l-0.14521-0.0021-38.57-0.53898 19.448 66.724 19.123 67.097zm0 0 36.25-66.933 36.859-66.558-21.622 0.06149-25.946 66.494-25.54 66.933z" fillRule="evenodd" strokeWidth=".97154"/>
                                            <path className="flicker" opacity="1" id="small_sparkle" d="m177.82 54.405-1.6726 6.5908-0.38773-6.8497-5.9836 0.21276 5.5616-2.5394-2.0255-6.4592 3.825 5.2802 4.7318-4.2048-3.1977 5.8029 4.9498 3.8606z" strokeWidth=".11306"/>
                                            <path className="flicker" opacity="1" id="big_sparkle" d="m80.832 26.361-3.5654 10.707-0.82655-11.127-12.755 0.34563 11.856-4.1254-4.3179-10.493 8.1539 8.5778 10.087-6.8307-6.8166 9.4269 10.552 6.2715z" strokeWidth=".21041"/>
                                        </g>
                                        
                                        <rect className="imperfection_middle" opacity="0" x="113.68" y="79.171" width="2.6458" height="2.6458"/>
                                        <rect className="imperfection_top" opacity="0" x="127.52" y="38.325" width="2.6458" height="2.6458"/>
                                        <rect className="imperfection_left" opacity="0" x="45.872" y="63.368" width="2.6458" height="2.6458"/>
                                    </svg>
                                </div>

                                <form onSubmit={(event) => {
                                    event.preventDefault()
                                    
                                    const backgroundcolor = this.generateBackground()
                                    const diamondbody = this.generateDiamondColor()
                                    const mid_imp = this.generateImperfection()
                                    const top_imp = this.generateImperfection()
                                    const left_imp = this.generateImperfection()
                                    const small_sparkle = this.generateSparkle() + 'small_sparkle'
                                    const big_sparkle = this.generateSparkle() + 'big_sparkle'
                                    const diamond = backgroundcolor + diamondbody + mid_imp + top_imp + left_imp + small_sparkle + big_sparkle
                                    
                                    this.mint(diamond)
                                }}>
                                    <input type='submit' className='btn btn-colour-1' value='Mine Diamond' style={{marginTop:'40px'}}/>
                                </form>
                            </div>
                        </main>
                    </div>
                    <hr></hr>
                    
                    <p>
                    Welcome to Diamond Hands - the diamond mine for unique, generative NFTs.
                    </p>
                    <p>
                    Diamonds are all uniquely mined and one of a kind. Each diamond can only be owned by a single person and only 7777 diamonds will ever be mined.
                    </p>
                    <p>
                    Every diamond is algorithmically generated and assigned a unique chemistry. 
                    Rarity of each color combination is 1 in 10,000 - that means there's a 0.01% chance of achieving any particular color combination.
                    </p>
                    <p>
                    Attributes are another story. Big sparkles and small sparkles, if you're lucky enough to get them, will be solid or flickering.
                    Imperfections are common and there three different locations. Imperfections are either there or they're not, and there's a 1 in 5 chance of each individual imperfection.
                    </p>
                    <p>
                    A flawless diamond will have zero imperfections and two flickering sparkles. Your odds of mining a flawless diamond of any color combination are 1 in 1,125 - or 0.09%.
                    </p>

                    <hr></hr>

                    <div style={{display: 'flex',  justifyContent:'center', alignItems:'center'}}>
                        <MDBCard className='transfercard' >
                            <form onSubmit={(event)=>{
                                event.preventDefault()
                                const address = this.addressinput.value
                                const diamond = this.diamondId.value

                                this.transfer(address, diamond)

                                this.addressinput.value = ''
                                this.diamondId.value = ''
                            }}>
                                <input type='text' placeholder='diamond #...' className='form-control mb-1 inputbox' style={{fontFamily:'sans-serif'}} ref={(input) => this.diamondId = input}/>
                                <input type='text' placeholder='wallet address...' className='form-control mb-1 inputbox' style={{fontFamily:'sans-serif'}} ref={(input) => this.addressinput = input}/>
                                <input type='submit' className='btn btn-colour-1' value='Transfer' style={{margin:'10px'}}/>
                            </form>
                        </MDBCard>
                    </div>

                    <hr></hr>

                    <h1 style={{color:'black', fontSize: '3rem'}}>
                            My Diamonds
                    </h1>

                    <div className='row textCenter'>
                        {this.state.myDiamonds.map((diamond, key) => 
                        { 
                            return (
                                <div key={diamond}> 
                                    <div>
                                        <MDBCard className='token' style={{maxWidth:'25rem'}}>
                                            <div className='diamond'>
                                                <svg  version="1.1" viewBox="0 0 211.67 211.67" xmlns="http://www.w3.org/2000/svg">    
                                                    <rect className="backgroundcolor" width="211.67" height="211.67" fill={diamond[0].substring(0, 7)} strokeWidth=".22252"/>
                                                    
                                                    <g id="dbody">
                                                        <path className="diamond_body" fill={diamond[0].substring(7, 14)} d="m50.635 25.94-17.636 19.99 21.499-0.077514 12.417-19.912h-16.279zm25.804 0-9.4484 20.12 38.573-0.39118 0.14521-0.0016h0.061l38.652 0.35448-9.3177-20.082h-58.665zm68.238 0 12.373 20.069 21.622 0.14418-17.669-20.213h-16.325zm-111.68 25.968 36.589 66.724 35.975 67.097-25.348-67.097-25.717-66.566-21.499-0.15968zm72.564 133.82 19.268-66.933 19.592-66.558-38.655 0.2067-0.20619-0.0016 0.17673 0.0021h-0.0315l-0.14521-0.0021-38.57-0.53898 19.448 66.724 19.123 67.097zm0 0 36.25-66.933 36.859-66.558-21.622 0.06149-25.946 66.494-25.54 66.933z" fillRule="evenodd" strokeWidth=".97154"/>
                                                        <path className={diamond[0].substring(18, 39)} opacity={diamond[0].substring(17, 18)} id="small_sparkle" d="m177.82 54.405-1.6726 6.5908-0.38773-6.8497-5.9836 0.21276 5.5616-2.5394-2.0255-6.4592 3.825 5.2802 4.7318-4.2048-3.1977 5.8029 4.9498 3.8606z" strokeWidth=".11306"/>
                                                        <path className={diamond[0].substring(40, 59)} opacity={diamond[0].substring(39, 40)} id="big_sparkle" d="m80.832 26.361-3.5654 10.707-0.82655-11.127-12.755 0.34563 11.856-4.1254-4.3179-10.493 8.1539 8.5778 10.087-6.8307-6.8166 9.4269 10.552 6.2715z" strokeWidth=".21041"/>
                                                    </g>
                                                    
                                                    <rect className="imperfection_middle" opacity={diamond[0].substring(14, 15)} x="113.68" y="79.171" width="2.6458" height="2.6458"/>
                                                    <rect className="imperfection_top" opacity={diamond[0].substring(15, 16)} x="127.52" y="38.325" width="2.6458" height="2.6458"/>
                                                    <rect className="imperfection_left" opacity={diamond[0].substring(16, 17)} x="45.872" y="63.368" width="2.6458" height="2.6458"/>
                                                </svg>
                                            </div>
                                            <MDBCardBody>
                                                <MDBCardTitle>Diamond #{diamond[1].toString()}</MDBCardTitle> 
                                            </MDBCardBody>
                                        </MDBCard>
                                    </div>
                                </div>
                            )
                        })}
                    </div>   

                </div>

            </div>
        )
    }

}

export default App;