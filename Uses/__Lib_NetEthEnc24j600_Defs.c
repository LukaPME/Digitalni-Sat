#include "__NetEthEnc24j600.h"

char const ARPCACHESIZE_24j600 = 3;   // Size of arpcache.
Net_Ethernet_24j600_arpCacheStruct Net_Ethernet_24j600_arpCache[ARPCACHESIZE_24j600];

const char         NUM_OF_SOCKET_24j600 = 5;      // Max number of socket We can open.
const unsigned int TCP_TX_SIZE_24j600 = 512;       // Size of Tx buffer in RAM.
const unsigned int MY_MSS_24j600 = 30;           // Our maximum segment size.
const unsigned int SYN_FIN_WAIT_24j600 = 3;       // Wait-time (in second) on remote SYN/FIN segment.
const unsigned int RETRANSMIT_WAIT_24j600 = 3;    // Wait-time (in second) on ACK which we expect.

char               tx_buffers_24j600[NUM_OF_SOCKET_24j600][TCP_TX_SIZE_24j600];  // Tx buffers. Every socket has its buffer.

UDP_24j600_Dsc     udpRecord_24j600;                                             // This record contains properties of last received UDP packet.

SOCKET_24j600_Dsc  socket_24j600[NUM_OF_SOCKET_24j600];                          // This record contains properties of each socket.