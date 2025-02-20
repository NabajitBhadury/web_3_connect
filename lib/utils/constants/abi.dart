final abi = [
  {
    "inputs": [
      {"internalType": "address", "name": "_hook", "type": "address"}
    ],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {"inputs": [], "name": "AlreadyVoted", "type": "error"},
  {"inputs": [], "name": "AppealALreadyExecuted", "type": "error"},
  {"inputs": [], "name": "ExecutionWindowClosed", "type": "error"},
  {"inputs": [], "name": "ExecutionWindowNotOpen", "type": "error"},
  {"inputs": [], "name": "HookCheckFailed", "type": "error"},
  {
    "inputs": [
      {"internalType": "address", "name": "hookType", "type": "address"}
    ],
    "name": "HookNotRegisterd",
    "type": "error"
  },
  {
    "inputs": [
      {"internalType": "uint256", "name": "min", "type": "uint256"},
      {"internalType": "uint256", "name": "max", "type": "uint256"}
    ],
    "name": "InvalidVotingPeriod",
    "type": "error"
  },
  {"inputs": [], "name": "VotingEnded", "type": "error"},
  {"inputs": [], "name": "VotingNotStarted", "type": "error"},
  {"inputs": [], "name": "startTimeInPast", "type": "error"},
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "uint256",
        "name": "appealId",
        "type": "uint256"
      },
      {
        "indexed": true,
        "internalType": "address",
        "name": "appealer",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "string",
        "name": "uri",
        "type": "string"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "startTime",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "endTime",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "bytes",
        "name": "executionData",
        "type": "bytes"
      },
      {
        "indexed": false,
        "internalType": "address",
        "name": "target",
        "type": "address"
      }
    ],
    "name": "AppealCreated",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "uint256",
        "name": "appealId",
        "type": "uint256"
      }
    ],
    "name": "AppealExecuted",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "uint256",
        "name": "appealId",
        "type": "uint256"
      },
      {
        "indexed": true,
        "internalType": "address",
        "name": "voter",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "int256",
        "name": "weight",
        "type": "int256"
      }
    ],
    "name": "voteCast",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "appealCount",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "name": "appeals",
    "outputs": [
      {"internalType": "address", "name": "appealer", "type": "address"},
      {"internalType": "string", "name": "uri", "type": "string"},
      {"internalType": "uint256", "name": "startTime", "type": "uint256"},
      {"internalType": "uint256", "name": "endTime", "type": "uint256"},
      {"internalType": "bool", "name": "executed", "type": "bool"},
      {"internalType": "int128", "name": "forScore", "type": "int128"},
      {"internalType": "int128", "name": "againstScore", "type": "int128"},
      {"internalType": "bytes", "name": "executionData", "type": "bytes"},
      {"internalType": "address", "name": "target", "type": "address"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "components": [
          {"internalType": "uint256", "name": "appealId", "type": "uint256"},
          {"internalType": "int256", "name": "weight", "type": "int256"},
          {"internalType": "bytes", "name": "hookData", "type": "bytes"}
        ],
        "internalType": "struct IVote.casteVoteParams",
        "name": "params",
        "type": "tuple"
      }
    ],
    "name": "castVote",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "components": [
          {"internalType": "string", "name": "uri", "type": "string"},
          {"internalType": "bytes", "name": "executionData", "type": "bytes"},
          {"internalType": "address", "name": "target", "type": "address"},
          {"internalType": "uint256", "name": "startTime", "type": "uint256"},
          {
            "internalType": "uint256",
            "name": "votingPeriod",
            "type": "uint256"
          },
          {"internalType": "bytes", "name": "hookData", "type": "bytes"}
        ],
        "internalType": "struct IVote.createAppealParams",
        "name": "params",
        "type": "tuple"
      }
    ],
    "name": "createAppeal",
    "outputs": [
      {"internalType": "uint256", "name": "appealId", "type": "uint256"}
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "uint256", "name": "appealId", "type": "uint256"}
    ],
    "name": "executeAppeal",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "executionDelay",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "executionWindow",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "hook",
    "outputs": [
      {"internalType": "contract IHook", "name": "", "type": "address"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "votingPeriodRange",
    "outputs": [
      {"internalType": "uint256", "name": "min", "type": "uint256"},
      {"internalType": "uint256", "name": "max", "type": "uint256"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
];
