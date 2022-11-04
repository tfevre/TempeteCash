const { expect } = require("chai");
const { ethers } = require('hardhat');

let TempeteCT;

describe('ERC20Stacking', function () {

    beforeEach(async function() {

        [owner, wallet1, wallet2] = await ethers.getSigners();

        const tempeteCT = await ethers.getContractFactory('Tempete');

        TempeteCT = await tempeteCT.deploy();
        await TempeteCT.deployed();

    });


    describe('depositTokens', function () {

        it('should deposit ETH', async function () {
            TempeteCT.deposit({value: 10});
            expect(await TempeteCT.getBalance()).to.equal(10);
        });

        it('should get a message', async function () {
            TempeteCT.deposit({value: 10});
            expect(await TempeteCT.getMessage()).not.to.equal("");
        });

    })

    describe('withdrawTokens', function () {

        it('should withdraw ETH', async function () {
            TempeteCT.deposit({value: 10});
            const message = await TempeteCT.getMessage();
            await TempeteCT.withdraw(message, owner.address, 10);
            expect(await TempeteCT.getBalance()).to.equal(0);
        });

        // xit('should get a message', async function () {
        //     TempeteCT.deposit({value: 10});
        //     expect(await TempeteCT.getMessage()).not.to.equal("");
        // });

    })


})