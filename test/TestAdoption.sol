pragma solidity ^0.4.17;

import "truffle/Assert.sol";   // 引入的断言文件
import "truffle/DeployedAddresses.sol";  // 用来获取被测试合约的地址
// 上面两个文件是Truffle框架提供, 本身并没有

import "../contracts/Adoption.sol";      // 被测试合约

//这个合约是用来测试合约的, 每个用例都会被执行, 通过断言判断是否有问题


contract TestAdoption {
  Adoption adoption = Adoption(DeployedAddresses.Adoption());

  // 领养测试用例
  function testUserCanAdoptPet() public {
    uint returnedId = adoption.adopt(8);
    // 这里传入是8 返回也应该是8
    uint expected = 8;
    Assert.equal(returnedId, expected, "Adoption of pet ID 8 should be recorded.");
  }

  // 宠物所有者测试用例
  function testGetAdopterAddressByPetId() public {
    // 期望领养者的地址就是本合约地址，因为交易是由测试合约发起交易，
    address expected = this;
    address adopter = adoption.adopters(8);
    // 当前地址和返回地址的判断, adopters明明是Array啊, 还能这样?
    Assert.equal(adopter, expected, "Owner of pet ID 8 should be recorded.");
  }

    // 测试所有领养者
  function testGetAdopterAddressByPetIdInArray() public {
  // 领养者的地址就是本合约地址
    address expected = this;
    address[16] memory adopters = adoption.getAdopters(); // 内存分配,不是storage
    Assert.equal(adopters[8], expected, "Owner of pet ID 8 should be recorded.");
  }
}

// 关于 this的使用, this代表当前合约, 也是ADDRESS