/** @format */

import { ethers } from 'hardhat';

const main = async () => {
    // コントラクトがコンパイルします
    // コントラクトを扱うために必要なファイルが `artifacts` ディレクトリの直下に生成されます。
    const nftContractFactory = await ethers.getContractFactory('MyEpicNFT');
    // Hardhat がローカルの Ethereum ネットワークを作成します。
    const nftContract = await nftContractFactory.deploy();

    // コントラクトが Mint され、ローカルのブロックチェーンにデプロイされるまで待ちます。
    await nftContract.deployed();
    console.log('Contract deployed to:', nftContract.address);

    // makeAnEpicNFT 関数を呼び出す。NFT が Mint される。
    let txn = nftContract.makeAnEpicNFT;
    // Minting が仮想マイナーにより、承認されるのを待ちます。
    await txn();
    console.log('Minted NFT #1');

    // 2回目
    txn = nftContract.makeAnEpicNFT;
    await txn;
    console.log('Minted NFT #2');
};

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
