import { expect } from "chai";
import { ethers } from "hardhat";
import { Depositor__factory } from "../typechain";

const GAME_VAULT_ADDRESS = "0x8043e6836416d13095567ac645be7C629715885c";

describe("CTF Hats2", () => {
  it("should play scenario", async () => {
    const signers = await ethers.getSigners();
    const deployer = signers[0];

    const depositor = await new Depositor__factory(deployer).deploy(
      GAME_VAULT_ADDRESS
    );
    await depositor.deployed();
    // fund depositor
    await deployer.sendTransaction({
      to: depositor.address,
      value: ethers.utils.parseEther("100"),
    });
    // attack
    await depositor.attack();
  });
});
