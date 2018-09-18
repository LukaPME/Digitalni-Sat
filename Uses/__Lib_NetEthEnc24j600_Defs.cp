#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Packages/Network_Ethernet_PIC/Uses/__Lib_NetEthEnc24j600_Defs.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc24j600.h"
#line 249 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc24j600.h"
typedef struct {
 unsigned char valid;
 unsigned long tmr;
 unsigned char ip[4];
 unsigned char mac[6];
} Net_Ethernet_24j600_arpCacheStruct;

extern Net_Ethernet_24j600_arpCacheStruct Net_Ethernet_24j600_arpCache[];

extern unsigned char Net_Ethernet_24j600_macAddr[6];
extern unsigned char Net_Ethernet_24j600_ipAddr[4];
extern unsigned char Net_Ethernet_24j600_gwIpAddr[4];
extern unsigned char Net_Ethernet_24j600_ipMask[4];
extern unsigned char Net_Ethernet_24j600_dnsIpAddr[4];
extern unsigned char Net_Ethernet_24j600_rmtIpAddr[4];

extern unsigned long Net_Ethernet_24j600_userTimerSec;



typedef struct {
 char remoteIP[4];
 char remoteMAC[6];
 unsigned int remotePort;
 unsigned int destPort;
 unsigned int dataLength;
 unsigned int broadcastMark;
} UDP_24j600_Dsc;


extern UDP_24j600_Dsc udpRecord_24j600;




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


} SOCKET_24j600_Dsc;


extern const char NUM_OF_SOCKET_24j600;
extern const unsigned int TCP_TX_SIZE_24j600;
extern const unsigned int MY_MSS_24j600;
extern const unsigned int SYN_FIN_WAIT_24j600;
extern const unsigned int RETRANSMIT_WAIT_24j600;

extern char tx_buffers_24j600[][];
extern SOCKET_24j600_Dsc socket_24j600[];
#line 340 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc24j600.h"
extern void Net_Ethernet_24j600_Init(unsigned char *mac, unsigned char *ip, unsigned char fullDuplex);

extern unsigned char Net_Ethernet_24j600_doPacket();
extern void Net_Ethernet_24j600_putByte(unsigned char b);
extern void Net_Ethernet_24j600_putBytes(unsigned char *ptr, unsigned int n);
extern void Net_Ethernet_24j600_putConstBytes(const unsigned char *ptr, unsigned int n);
extern unsigned char Net_Ethernet_24j600_getByte();
extern void Net_Ethernet_24j600_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n);
extern unsigned int Net_Ethernet_24j600_UserUDP(UDP_24j600_Dsc *udpDsc);
extern void Net_Ethernet_24j600_payloadInitUDP();
extern void Net_Ethernet_24j600_UserTCP(SOCKET_24j600_Dsc *socket);
extern void Net_Ethernet_24j600_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);

extern char Net_Ethernet_24j600_connectTCP(char *remoteIP, unsigned int remote_port ,unsigned int my_port, SOCKET_24j600_Dsc **used_socket);
extern char Net_Ethernet_24j600_disconnectTCP(SOCKET_24j600_Dsc *socket);

extern char Net_Ethernet_24j600_putByteTCP(char ch, SOCKET_24j600_Dsc *socket);
extern unsigned int Net_Ethernet_24j600_putBytesTCP(char *ptr,unsigned int n, SOCKET_24j600_Dsc *socket);
extern unsigned int Net_Ethernet_24j600_putConstBytesTCP(const char *ptr,unsigned int n, SOCKET_24j600_Dsc *socket);
extern unsigned int Net_Ethernet_24j600_putStringTCP(char *ptr, SOCKET_24j600_Dsc *socket);
extern unsigned int Net_Ethernet_24j600_putConstStringTCP(const char *ptr, SOCKET_24j600_Dsc *socket);
extern char Net_Ethernet_24j600_bufferEmptyTCP(SOCKET_24j600_Dsc *socket);
extern void Net_Ethernet_24j600_stackInitTCP();
extern char Net_Ethernet_24j600_startSendTCP(SOCKET_24j600_Dsc *socket);
#line 3 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Packages/Network_Ethernet_PIC/Uses/__Lib_NetEthEnc24j600_Defs.c"
char const ARPCACHESIZE_24j600 = 3;
Net_Ethernet_24j600_arpCacheStruct Net_Ethernet_24j600_arpCache[ARPCACHESIZE_24j600];

const char NUM_OF_SOCKET_24j600 = 5;
const unsigned int TCP_TX_SIZE_24j600 = 512;
const unsigned int MY_MSS_24j600 = 30;
const unsigned int SYN_FIN_WAIT_24j600 = 3;
const unsigned int RETRANSMIT_WAIT_24j600 = 3;

char tx_buffers_24j600[NUM_OF_SOCKET_24j600][TCP_TX_SIZE_24j600];

UDP_24j600_Dsc udpRecord_24j600;

SOCKET_24j600_Dsc socket_24j600[NUM_OF_SOCKET_24j600];
