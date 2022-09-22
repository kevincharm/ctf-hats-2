**Project Name:** Capture The Flag

**Title:** CTF 2: Force send ETH, then re-enter

**Description:**

The vault contract returns its own ETH balance when calling `totalAssets()`. Although there is a payable function `deposit`, we can bypass this function by forcing ETH to be sent via selfdestruct. `ERC4626ETH.sol:158` calculates an excess ETH amount to be transferred out of the contract, using `totalAssets()` in its calculation, which as we mentioned before, can be manipulated.

So to exploit this contract, we force send ETH to the vault, thereby messing up the internal accounting as `totalSupply()` does not go up (because tokens aren't minted). We withdraw some amount that we deposited, and when the vault sends back our ETH, we simply re-enter `withdraw` again to empty the vault.
