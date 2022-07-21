import { TestData } from "../../types/TestData";

export const fungibleTokenTestData : TestData = {
  tests: [
    {
      input: {
        cart: {
          me: "0xbeef",
          from: "0xbeef",
          now: "~2022.6.19..18.12.18..1e4",
          'town-id': "0x1",
          owns: []
        },
        embryo: {
          action: {
            type: "give",
            to: "0xcafe",
            account: "0xcafe",
            amount: "100",
            budget: "10"
          },
          grains: []
        }
      }
    }
  ],
  grains: [
    {
      id: "0x7367697a",
      lord: "0x7367697a",
      holder: "0x7367697a",
      'town-id': "0x1",
      type: "token-metadata",
      rice: {
        name: "Zigs: UQ| Tokens",
        symbol: "ZIG",
        decimals: "18",
        supply: "1000000",
        cap: "",
        mintable: "false",
        minters: "[0xbeef]",
        deployer: "0x0",
        salt: "1936157050"
      }
    },
    {
      id: "0x1.beef",
      lord: "0x7367697a",
      holder: "0xbeef",
      'town-id': "0x1",
      type: "account",
      rice: {
        salt: "1936157050",
        'metadata-id': "0x7367697a",
        balance: "50",
        allowances: "{ '0xdead': 1000 }"
      }
    },
    {
      id: "0x1.dead",
      lord: "0x7367697a",
      holder: "0xdead",
      'town-id': "0x1",
      type: "account",
      rice: {
        salt: "1936157050",
        'metadata-id': "0x7367697a",
        balance: "30",
        allowances: "{ '0xbeef': 10 }"
      }
    },
    {
      id: "0x1.cafe",
      lord: "0x7367697a",
      holder: "0xcafe",
      'town-id': "0x1",
      type: "account",
      rice: {
        salt: "1936157050",
        'metadata-id': "0x7367697a",
        balance: "20",
        allowances: "{ '0xbeef': 10, '0xdead': 20 }"
      }
    },
    {
      id: "0x1.face",
      lord: "0x656c.6269.676e.7566",
      holder: "0xface",
      'town-id': "0x1",
      type: "account",
      rice: {
        salt: "1717987684",
        'metadata-id': "0x2174.6e65.7265.6666.6964",
        balance: "20",
        allowances: "{ '0xbeef': 10 }"
      }
    }
  ]
}
