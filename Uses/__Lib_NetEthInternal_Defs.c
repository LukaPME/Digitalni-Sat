#include "__NetEthInternal.h"

const char ARPCACHESIZE_Intern = 3;     // Size of arpcache.
Net_Ethernet_Intern_arpCacheStruct Net_Ethernet_Intern_arpCache[ARPCACHESIZE_Intern];

const char         NUM_OF_SOCKET_Intern = 5;         // Max number of socket We can open.
const unsigned int TCP_TX_SIZE_Intern   = 512;       // Size of Tx buffer in RAM.
const unsigned int MY_MSS_Intern        = 30;       // Our maximum segment size.
const unsigned int SYN_FIN_WAIT_Intern  = 3;         // Wait-time (in second) on remote SYN/FIN segment.
const unsigned int RETRANSMIT_WAIT_Intern = 3;       // Wait-time (in second) on ACK which we expect.

char   tx_buffers_Intern[NUM_OF_SOCKET_Intern][TCP_TX_SIZE_Intern];  // Tx buffers. Every socket has its buffer.

UDP_Intern_Dsc     udpRecord_Intern;                    // This record contains properties of last received UDP packet.

SOCKET_Intern_Dsc  socket_Intern[NUM_OF_SOCKET_Intern]; // This record contains properties of each socket.