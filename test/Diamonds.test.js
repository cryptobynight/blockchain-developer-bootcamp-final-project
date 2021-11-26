const {assert} = require('chai')
const {expect} = require('chai')

const Diamonds = artifacts.require('./Diamonds');

require('chai')
.use(require('chai-as-promised'))
.should()

contract('Diamonds', (accounts) => {
    let contract
    // Before hook tells our tests to run this first
    before( async() => {
        contract = await Diamonds.deployed()
    })

    // Create testing container
    describe('Contract deploys successfully', async() => {
        it('Contract deploys successfully', async() => {
            const address = await contract.address;
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })

        it('Contract name correct', async() => {
            const name = await contract.name();
            assert.equal(name, 'Diamond Hands')
        })
        
        it('Contract symbol correct', async() => {
            const symbol = await contract.symbol();
            assert.equal(symbol, 'DH')
        })
    })

    describe('NFT minting', async() => {
        it('Create new NFT', async() => {
            const minted = await contract.mint('NFT_1')
            const totalSupply = await contract.totalSupply()

            assert.equal(totalSupply, 1)
            const event = minted.logs[0].args
            assert.equal(event._to, accounts[0])
            assert.equal(event._from, '0x0000000000000000000000000000000000000000')
        })
    })

    describe('Check that diamonds are indexed properly', async() => {
        it('List all diamonds', async() => {
            await contract.mint('NFT_2')
            await contract.mint('NFT_3')
            await contract.mint('NFT_4')
            await contract.mint('NFT_5')
            const totalSupply = await contract.totalSupply()

            let diamonds = []
            let chem

            for(i = 0; i < totalSupply; i++) {
                const temp = await contract.diamonds(i)
                chem = temp.chemistry
                diamonds.push(chem)
            }

            let expectedResult = ['NFT_1','NFT_2','NFT_3','NFT_4','NFT_5']
            assert.equal(diamonds.join(','), expectedResult.join(','))
        })
    })

    describe('Only owner can transfer', async() => {
        it('Transfer NFT Success', async() => {
            const transferred = await contract.transferFrom(accounts[0],accounts[1],0)
            const ownerOf = await contract.ownerOf(0)

            assert.equal(ownerOf, accounts[1])
            const event = transferred.logs[0].args
            assert.equal(event._from, accounts[0])
            assert.equal(event._to, accounts[1])
            assert.equal(event._tokenId, 0)
        })

        it('Try to transfer diamond owned by another wallet', async() => {
            
            await expect(contract.transferFrom(accounts[0],accounts[2],0)).to.be.rejectedWith(Error)
            
        })
    })

})