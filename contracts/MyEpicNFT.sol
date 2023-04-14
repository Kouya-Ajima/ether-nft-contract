// MyEpicNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// OpenZeppelin のコントラクトをインポートします。
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

/**
 * @notice
 * ブロックチェーンで、連絡をすることはできない。
 * なぜなら、いちど デプロイしたコントラクトを解散できないから。
 * そのため、コンソールログを、ヘルメットの機能を使って実施する。
 */

/**
 * @notice
 * インポートした OpenZeppelin のコントラクトを継承
 * NFTのトークンは ERC721 トークン → 付加価値をつけられるトークン
 */
contract MyEpicNFT is ERC721URIStorage {
    // OpenZeppelinが_tokenIdsを追跡するために提供するライブラリを呼び出しています。
    //  これにより、トラッキングの際に起こりうるオーバーフローを防ぎます。
    using Counters for Counters.Counter;

    // _tokenIdsを初期化しています。_tokenIdsの初期値は0です。
    // tokenIdはNFTの一意な識別子で、0, 1, 2, .. Nのように付与されます。
    //  Counters.Counter → オーバーフロー対策
    Counters.Counter private _tokenIds;

    /**
     * ERC721モジュールを使用したconstructorを定義しています。
     * ここでは任意のNFTトークンの名前とシンボルを引数として渡しています。
     * RumuNFT :  NFTトークンの名前
     * RUMU : NFTトークンのそのシンボル
     */
    constructor() ERC721("RumuNFT", "RUMU") {
        console.log("This is my NFT contract.");
    }

    /**
     * User から呼び出される関数. NFTを取得する。
     */
    function makeAnEpicNFT() public {
        // 0,1,2,3,4 というように、対象のトークンのIDを増やしていく。
        // この場合、0番目の ERC721 トークン（NFT）が販売される。
        uint256 newItemId = _tokenIds.current();

        // 関数を呼び出した 送信者に NFT を Mint する。（新しく発行して、渡してあげる）
        //  → _setTokenURI とセットで使う。
        _safeMint(msg.sender, newItemId);

        // 渡したNFT のデータを設定 → ブロックチェーン上のデータを皆がみて確認できるようにする
        // NFTの一意の識別子と、その一意の識別子に関連付けられたデータが紐付けられます。
        //   → Valuable data - RUMU ! が、実際にNFT として渡されたデータ。
        /**
         * tokenURIは、下記のような「メタデータ」と呼ばれるJSONファイルにリンクされています。
            {
                "name": "Rumu",
                "description": "まる顔のかわいい猫ちゃん (=^・^=) ",
                "image": "https://i.imgur.com/JBvN2gW.jpg"
            }
            → OpenSea のURLに貼り付ける → NFT のERC721トークンとして認識される。
                https://www.npoint.io/  (NFTのJSONデータをホストする)
         */
        _setTokenURI(newItemId, "https://api.npoint.io/de53a7ea0c45a4bc3023");

        // コンソールで、NFTがいつ誰に作成されたかを確認します。
        console.log(
            "An NFT : w/ ,  ID : %s,  has been minted to : %s",
            newItemId,
            msg.sender
        );

        // 次のNFTが 渡されるときのトークンのカウンターをインクリメントする
        _tokenIds.increment();
    }
}
