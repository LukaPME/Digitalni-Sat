#include "__NetEthEnc28j60.h"

const char ARPCACHESIZE_28j60 = 1;     // Size of arpcache.
Net_Ethernet_28j60_arpCacheStruct Net_Ethernet_28j60_arpCache[ARPCACHESIZE_28j60];

const char         NUM_OF_SOCKET_28j60 = 4;      // Max number of socket We can open.
const unsigned int TCP_TX_SIZE_28j60 = 512;       // Size of Tx buffer in RAM.
const unsigned int MY_MSS_28j60 = 30;           // Our maximum segment size.
const unsigned int SYN_FIN_WAIT_28j60 = 3;       // Wait-time (in second) on remote SYN/FIN segment.
const unsigned int RETRANSMIT_WAIT_28j60 = 3;    // Wait-time (in second) on ACK which we expect.

char               tx_buffers_28j60[NUM_OF_SOCKET_28j60][TCP_TX_SIZE_28j60];  // Tx buffers. Every socket has its buffer.

UDP_28j60_Dsc      udpRecord_28j60;                      // This record contains properties of last received UDP packet.

SOCKET_28j60_Dsc   socket_28j60[NUM_OF_SOCKET_28j60];    // This record contains properties of each socket.