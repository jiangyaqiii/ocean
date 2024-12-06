#!/usr/bin/env bash

cat <<EOF > docker-compose.yml
services:
  ocean-node:
    image: oceanprotocol/ocean-node:latest
    pull_policy: always
    container_name: ocean-node
    restart: on-failure
    ports:
      - '8000:8000'
      - '9010:9010'
      - '9011:9011'
      - '9002:9002'
      - '9003:9003'
    environment:
      PRIVATE_KEY: '$PRIVATE_KEY'
      RPCS: '{"1":{"rpc":"https://api.securerpc.com/v1","fallbackRPCs":["https://rpc.ankr.com/eth"],"chainId":1,"network":"mainnet","chunkSize":100},"10":{"rpc":"https://mainnet.optimism.io","fallbackRPCs":["https://rpc.ankr.com/optimism"],"chainId":10,"network":"optimism","chunkSize":100},"137":{"rpc":"https://polygon-rpc.com/","fallbackRPCs":["https://rpc.ankr.com/polygon"],"chainId":137,"network":"polygon","chunkSize":100},"23294":{"rpc":"https://sapphire.oasis.io","fallbackRPCs":["https://1rpc.io/oasis/sapphire"],"chainId":23294,"network":"sapphire","chunkSize":100},"23295":{"rpc":"https://testnet.sapphire.oasis.io","chainId":23295,"network":"sapphire-testnet","chunkSize":100},"11155111":{"rpc":"https://eth-sepolia.api.onfinality.io/public","fallbackRPCs":["https://sepolia.gateway.tenderly.co"],"chainId":11155111,"network":"sepolia","chunkSize":100},"11155420":{"rpc":"https://sepolia.optimism.io","fallbackRPCs":["https://endpoints.omniatech.io/v1/op/sepolia/public","https://optimism-sepolia.blockpi.network/v1/rpc/public","https://optimism-sepolia.gateway.tenderly.co","https://api.zan.top/opt-sepolia"],"chainId":11155420,"network":"optimism-sepolia","chunkSize":100}}'
      DB_URL: 'http://typesense:8108/?apiKey=xyz'
      IPFS_GATEWAY: 'https://ipfs.io/'
      ARWEAVE_GATEWAY: 'https://arweave.net/'
#      LOAD_INITIAL_DDOS: ''
#      FEE_TOKENS: ''
#      FEE_AMOUNT: ''
#      ADDRESS_FILE: ''
#      NODE_ENV: ''
#      AUTHORIZED_DECRYPTERS: ''
#      OPERATOR_SERVICE_URL: ''
      INTERFACES: '["HTTP","P2P"]'
#      ALLOWED_VALIDATORS: ''
#      INDEXER_NETWORKS: '[]'
      ALLOWED_ADMINS: '["$ALLOWED_ADMINS"]'
#      INDEXER_INTERVAL: ''
      DASHBOARD: 'true'
#      RATE_DENY_LIST: ''
#      MAX_REQ_PER_SECOND: ''
#      MAX_CHECKSUM_LENGTH: ''
#      LOG_LEVEL: ''
      HTTP_API_PORT: '8000'
      P2P_ENABLE_IPV4: 'true'
      P2P_ENABLE_IPV6: 'false'
      P2P_ipV4BindAddress: '0.0.0.0'
      P2P_ipV4BindTcpPort: '9010'
      P2P_ipV4BindWsPort: '9011'
      P2P_ipV6BindAddress: '::'
      P2P_ipV6BindTcpPort: '9002'
      P2P_ipV6BindWsPort: '9003'
      P2P_ANNOUNCE_ADDRESSES: '["/ip4/$P2P_ANNOUNCE_ADDRESS/tcp/9010","/ip4/$P2P_ANNOUNCE_ADDRESS/ws/tcp/9011"]'
#      P2P_ANNOUNCE_PRIVATE: ''
#      P2P_pubsubPeerDiscoveryInterval: ''
#      P2P_dhtMaxInboundStreams: ''
#      P2P_dhtMaxOutboundStreams: ''
#      P2P_mDNSInterval: ''
#      P2P_connectionsMaxParallelDials: ''
#      P2P_connectionsDialTimeout: ''
#      P2P_ENABLE_UPNP: ''
#      P2P_ENABLE_AUTONAT: ''
#      P2P_ENABLE_CIRCUIT_RELAY_SERVER: ''
#      P2P_ENABLE_CIRCUIT_RELAY_CLIENT: ''
#      P2P_BOOTSTRAP_NODES: ''
#      P2P_FILTER_ANNOUNCED_ADDRESSES: ''
    networks:
      - ocean_network
    depends_on:
      - typesense

  typesense:
    image: typesense/typesense:26.0
    container_name: typesense
    ports:
      - '8108:8108'
    networks:
      - ocean_network
    volumes:
      - typesense-data:/data
    command: '--data-dir /data --api-key=xyz'

volumes:
  typesense-data:
    driver: local

networks:
  ocean_network:
    driver: bridge
EOF
