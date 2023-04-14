/** @format */
import { ethers } from 'hardhat';

/**
 * ローカル用デプロイ
 */

const main = async () => {
    // コントラクトが ⭐コンパイル され、必要なファイルがartifactsディレクトリの直下に生成
    // hre.ethers.getContractFactoryについて getContractFactory関数は、
    // デプロイをサポートするライブラリのアドレスとMyEpicNFTコントラクトの連携を行っています。
    // このタイミングで、 MyEpicNFT のコンストラクター呼び出しも実行している。
    const nftContractFactory = await ethers.getContractFactory('MyEpicNFT');
    // 順番に実行して、⭐デプロイする。
    const nftContract = nftContractFactory.deploy();
    // ⭐Mint → 承認の意味。 コントラクトが承認されて、ガス代等を払った後にブロックにデプロイされる。
    // デプロイされたアドレスをコンソールに表示する。
    // NFTにおける「Mint」とは、スマートコントラクトを用いて、NFT を新らしく作成・発行すること。
    console.log(
        'Contract deploay to (address) : ' + (await nftContract).address
    );

    // makeAnEpicNFT 関数を呼び出す。NFT が Mint される。
    let txn = (await nftContract).makeAnEpicNFT;
    // Minting が仮想マイナーにより、承認されるのを待つ。
    await txn();

    // makeAnEpicNFT 関数をもう一度呼び出す。NFT がまた Mint される。
    txn = (await nftContract).makeAnEpicNFT;
    // Minting が仮想マイナーにより、承認されるのを待つ。
    await txn();
};

const runMain = async () => {
    try {
        await main();
        // success' コード 0 をNodeに送信する
        process.exit(0);
    } catch (error) {
        console.log(error);
        // Error ' コード 1 をNodeに送信する
        process.exit(1);
    }
};

runMain();
