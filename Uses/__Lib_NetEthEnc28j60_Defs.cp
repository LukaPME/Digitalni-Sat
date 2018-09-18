#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Packages/Network_Ethernet_PIC/Uses/__Lib_NetEthEnc28j60_Defs.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60.h"
#line 111 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60.h"
typedef struct
 {
 unsigned char valid;
 unsigned long tmr;
 unsigned char ip[4];
 unsigned char mac[6];
 } Net_Ethernet_28j60_arpCacheStruct;

extern Net_Ethernet_28j60_arpCacheStruct Net_Ethernet_28j60_arpCache[];

extern unsigned char Net_Ethernet_28j60_macAddr[6];
extern unsigned char Net_Ethernet_28j60_ipAddr[4];
extern unsigned char Net_Ethernet_28j60_gwIpAddr[4];
extern unsigned char Net_Ethernet_28j60_ipMask[4];
extern unsigned char Net_Ethernet_28j60_dnsIpAddr[4];
extern unsigned char Net_Ethernet_28j60_rmtIpAddr[4];

extern unsigned long Net_Ethernet_28j60_userTimerSec;



typedef struct {
 char remoteIP[4];
 char remoteMAC[6];
 unsigned int remotePort;
 unsigned int destPort;
 unsigned int dataLength;
 unsigned int broadcastMark;
} UDP_28j60_Dsc;


extern UDP_28j60_Dsc udpRecord_28j60;



typedef struct {
 char remoteIP[4];
 char remoteMAC[6];
 unsigned int remotePort;
 unsigned int destPort;

 unsigned int dataLength;
 unsigned int remoteMSS;
 unsigned int myWin;
 unsigned int myMSS;
 unsigned long mySeq;
 unsigned long myACK;

 char stateTimer;
 char retransmitTimer;
 unsigned int packetID;
 char open;
 char ID;
 char broadcastMark;
 char state;









 unsigned int nextSend;
 unsigned int lastACK;
 unsigned int lastSent;
 unsigned int lastWritten;
 unsigned int numToSend;
 char buffState;
 char *txBuffer;


} SOCKET_28j60_Dsc;


extern const char NUM_OF_SOCKET_28j60;
extern const unsigned int TCP_TX_SIZE_28j60;
extern const unsigned int MY_MSS_28j60;
extern const unsigned int SYN_FIN_WAIT_28j60;
extern const unsigned int RETRANSMIT_WAIT_28j60;

extern char tx_buffers_28j60[][];
extern SOCKET_28j60_Dsc socket_28j60[];
#line 206 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60.h"
extern void Net_Ethernet_28j60_Init(unsigned char *resetPort, unsigned char resetBit, unsigned char *CSport, unsigned char CSbit, unsigned char *mac, unsigned char *ip, unsigned char configuration);
extern unsigned char Net_Ethernet_28j60_doPacket();
extern void Net_Ethernet_28j60_putByte(unsigned char b);
extern void Net_Ethernet_28j60_putBytes(unsigned char *ptr, unsigned int n);
extern void Net_Ethernet_28j60_putConstBytes(const unsigned char *ptr, unsigned int n);
extern unsigned char Net_Ethernet_28j60_getByte();
extern void Net_Ethernet_28j60_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n);
extern unsigned int Net_Ethernet_28j60_UserUDP(UDP_28j60_Dsc *udpDsc);
extern void Net_Ethernet_28j60_payloadInitUDP();
extern void Net_Ethernet_28j60_UserTCP(SOCKET_28j60_Dsc *socket);
extern void Net_Ethernet_28j60_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);

extern char Net_Ethernet_28j60_connectTCP(char *remoteIP, unsigned int remote_port ,unsigned int my_port, SOCKET_28j60_Dsc **used_socket);
extern char Net_Ethernet_28j60_disconnectTCP(SOCKET_28j60_Dsc *socket);
extern char Net_Ethernet_28j60_startSendTCP(SOCKET_28j60_Dsc *socket);

extern char Net_Ethernet_28j60_putByteTCP(char ch, SOCKET_28j60_Dsc *socket);
extern unsigned int Net_Ethernet_28j60_putBytesTCP(char *ptr,unsigned int n, SOCKET_28j60_Dsc *socket);
extern unsigned int Net_Ethernet_28j60_putConstBytesTCP(const char *ptr,unsigned int n, SOCKET_28j60_Dsc *socket);
extern unsigned int Net_Ethernet_28j60_putStringTCP(char *ptr, SOCKET_28j60_Dsc *socket);
extern unsigned int Net_Ethernet_28j60_putConstStringTCP(const char *ptr, SOCKET_28j60_Dsc *socket);
extern char Net_Ethernet_28j60_bufferEmptyTCP(SOCKET_28j60_Dsc *socket);
extern void Net_Ethernet_28j60_stackInitTCP();
#line 3 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Packages/Network_Ethernet_PIC/Uses/__Lib_NetEthEnc28j60_Defs.c"
const char ARPCACHESIZE_28j60 = 1;
Net_Ethernet_28j60_arpCacheStruct Net_Ethernet_28j60_arpCache[ARPCACHESIZE_28j60];

const char NUM_OF_SOCKET_28j60 = 4;
const unsigned int TCP_TX_SIZE_28j60 = 512;
const unsigned int MY_MSS_28j60 = 30;
const unsigned int SYN_FIN_WAIT_28j60 = 3;
const unsigned int RETRANSMIT_WAIT_28j60 = 3;

char tx_buffers_28j60[NUM_OF_SOCKET_28j60][TCP_TX_SIZE_28j60];

UDP_28j60_Dsc udpRecord_28j60;

SOCKET_28j60_Dsc socket_28j60[NUM_OF_SOCKET_28j60];
