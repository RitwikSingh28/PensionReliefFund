const { expect } = require("chai");
const { ethers } = require("hardhat");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("Funds Transfer Contract", function () {
  async function deployContracts() {
    const [empEOA] = await ethers.getSigners();
    const initAmount = ethers.utils.parseEther("10");

    //deploying pension_fund smart contract
    const PensionFund = await ethers.getContractFactory("PensionFund");
    const PensionToken = await PensionFund.deploy(100, empEOA.address);
    await PensionToken.deployed();

    //deploying company smart contract
    const Company = await ethers.getContractFactory("Company");
    const CompanyToken = await Company.deploy(PensionToken.address, 10000, 0, {
      value: initAmount,
    });
    await CompanyToken.deployed();

    return { initAmount, empEOA, PensionToken, CompanyToken };
  }

  it("Should transfer initial eth in Company contract", async function () {
    const { initAmount, CompanyToken } = await loadFixture(deployContracts);
    expect(await ethers.provider.getBalance(CompanyToken.address)).to.equal(
      initAmount
    );
  });

  it("Should transfer current_sal from company to empFund", async function () {
    const { empEOA, PensionToken, CompanyToken } = await loadFixture(
      deployContracts
    );
    const currentSalary = await CompanyToken.currentSalary();

    await expect(CompanyToken.sendAmount()).to.changeEtherBalances(
      [CompanyToken, PensionToken, empEOA],
      [-currentSalary, currentSalary / 2, currentSalary / 2]
    );
  });
});
