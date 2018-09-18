
/*
 * PHY registers
 */
#define PHLCON  0x14
#define PHCON2  0x10
#define PHCON1  0x00

/*
 * maximum packet length
 */
#define BUF_SIZE        1518

/*
 * ENC memory allocation
 */
#define RAM_SIZE        8192                            // 8kb RAM available
#define RECEIVE_START   0                               // receive buffer start address : Should be an even memory address; must be 0 for errata
#define RECEIVE_END     (TRANSMIT_START - 1)            // receive buffer end address   : Odd for errata workaround
#define TRANSMIT_START  (RAM_SIZE - (BUF_SIZE + 100))   // transmit buffer start address, a few more bytes for padding pseudo header + transmit status : Even memory address
#define REPLY_START     (TRANSMIT_START + 1)            // reply buffer starts after per packet control byte
#define RECEIVE_SIZE          (RECEIVE_END-RECEIVE_START+1)   // receive buffer size


#define Net_Ethernet_Intern_HALFDUPLEX     0
#define Net_Ethernet_Intern_FULLDUPLEX     1

#define NO_ADDR 0xffff

/*
 * library globals
 */
typedef struct
        {
        unsigned char   valid;                         // valid/invalid entry flag
        unsigned long   tmr;                           // timestamp
        unsigned char   ip[4];                         // IP address
        unsigned char   mac[6];                        // MAC address behind the IP address
        } Net_Ethernet_Intern_arpCacheStruct;
        
extern Net_Ethernet_Intern_arpCacheStruct Net_Ethernet_Intern_arpCache[];    // ARP cash, 3 entries max

extern unsigned char    Net_Ethernet_Intern_macAddr[6];           // MAC address of the controller
extern unsigned char    Net_Ethernet_Intern_ipAddr[4];            // IP address of the device
extern unsigned char    Net_Ethernet_Intern_gwIpAddr[4];          // GW
extern unsigned char    Net_Ethernet_Intern_ipMask[4];            // network mask
extern unsigned char    Net_Ethernet_Intern_dnsIpAddr[4];         // DNS serveur IP
extern unsigned char    Net_Ethernet_Intern_rmtIpAddr[4];         // remote IP Address of host (DNS server reply)

extern unsigned long    Net_Ethernet_Intern_userTimerSec;         // must be incremented by user 1 time per second


typedef struct {
  char remoteIP[4];              // Remote IP address
  char remoteMAC[6];             // Remote MAC address
  unsigned int remotePort;       // Remote TCP port
  unsigned int destPort;         // Destination TCP port
  unsigned int dataLength;       // Current TCP payload size
  unsigned int broadcastMark;    // =0 -> Not broadcast; =1 -> Broadcast
} UDP_Intern_Dsc;
// Each field refers to the last received package

extern UDP_Intern_Dsc udpRecord_Intern;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//** Socket structure definition
typedef struct {
  char          remoteIP[4];        // Remote IP address
  char          remoteMAC[6];       // Remote MAC address
  unsigned int  remotePort;         // Remote TCP port
  unsigned int  destPort;           // Destination TCP port

  unsigned int  dataLength;         // TCP payload size (refers to the last received package)
  unsigned int  remoteMSS;          // Remote Max Segment Size
  unsigned int  myWin;              // My Window
  unsigned int  myMSS;              // My Max Segment Size
  unsigned long mySeq;              // My Current sequence
  unsigned long myACK;              // ACK

  char          stateTimer;         // State timer
  char          retransmitTimer;    // Retransmit timer
  unsigned int  packetID;           // ID of packet
  char          open;               // =0 -> Socket busy;  =1 -> Socket free
  char          ID;                 // ID of socket
  char          broadcastMark;      // =0 -> Not broadcast; =1 -> Broadcast
  char          state;              // State table:
                                     //             0 - connection closed
                                     //             1 - remote SYN segment received, our SYN segment sent, and We wait for ACK (server mode)
                                     //             3 - connection established
                                     //             4 - our SYN segment sent, and We wait for SYN response (client mode)
                                     //             5 - FIN segment sent, wait for ACK.
                                     //             6 - Received ACK on our FIN, wait for remote FIN.
                                     //             7 - Expired ACK wait time. We retransmit last sent packet, and again set Wait-Timer. If this happen again
                                     //                 connection close.
  // Buffer....................//
  unsigned int nextSend;       //    // "Pointer" on first byte in buffer we want to send.
  unsigned int lastACK;        //    // "Pointer" on last acknowledged byte in buffer.
  unsigned int lastSent;       //    // "Pointer" on last sent byte in buffer.
  unsigned int lastWritten;    //    // "Pointer" on last written byte in buffer which not sent yet.
  unsigned int numToSend;      //    // Number of bytes in buffer to be sent.
  char         buffState;      //    // Private variable.
  char        *txBuffer;       //    // Pointer on Tx bafer.
  //...........................//

} SOCKET_Intern_Dsc;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern const char         NUM_OF_SOCKET_Intern;
extern const unsigned int TCP_TX_SIZE_Intern;
extern const unsigned int MY_MSS_Intern;
extern const unsigned int SYN_FIN_WAIT_Intern;
extern const unsigned int RETRANSMIT_WAIT_Intern;

extern char tx_buffers_Intern[][];
extern SOCKET_Intern_Dsc socket_Intern[];


/*
 * prototypes for public functions
 */
extern  void            Net_Ethernet_Intern_Init(unsigned char *mac, unsigned char *ip, unsigned char fullDuplex);
extern  unsigned char   Net_Ethernet_Intern_doPacket();
extern  void            Net_Ethernet_Intern_putByte(unsigned char b);
extern  void            Net_Ethernet_Intern_putBytes(unsigned char *ptr, unsigned int n);
extern  void            Net_Ethernet_Intern_putConstBytes(const unsigned char *ptr, unsigned int n);
extern  unsigned char   Net_Ethernet_Intern_getByte();
extern  void            Net_Ethernet_Intern_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n);
extern  unsigned int    Net_Ethernet_Intern_UserUDP(UDP_Intern_Dsc *udpDsc);
extern  void            Net_Ethernet_Intern_payloadInitUDP();
extern  void            Net_Ethernet_Intern_UserTCP(SOCKET_Intern_Dsc *socket);
extern  void            Net_Ethernet_Intern_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);

extern char Net_Ethernet_Intern_connectTCP(char *remoteIP, unsigned int remote_port ,unsigned int my_port, SOCKET_Intern_Dsc **used_socket);
extern char Net_Ethernet_Intern_disconnectTCP(SOCKET_Intern_Dsc *socket);

extern char         Net_Ethernet_Intern_putByteTCP(char ch, SOCKET_Intern_Dsc *socket);
extern unsigned int Net_Ethernet_Intern_putBytesTCP(char *ptr,unsigned int n, SOCKET_Intern_Dsc *socket);
extern unsigned int Net_Ethernet_Intern_putConstBytesTCP(const char *ptr,unsigned int n, SOCKET_Intern_Dsc *socket);
extern unsigned int Net_Ethernet_Intern_putStringTCP(char *ptr, SOCKET_Intern_Dsc *socket);
extern unsigned int Net_Ethernet_Intern_putConstStringTCP(const char *ptr, SOCKET_Intern_Dsc *socket);
extern char         Net_Ethernet_Intern_bufferEmptyTCP(SOCKET_Intern_Dsc *socket);
extern void         Net_Ethernet_Intern_stackInitTCP();
extern char         Net_Ethernet_Intern_startSendTCP(SOCKET_Intern_Dsc *socket);