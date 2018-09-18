/*
 * registers
 */

// ENC424J600/624J600 register addresses
// SPI Bank 0 registers --------
#define ETXST        0x0000
#define ETXSTL       0x0000
#define ETXSTH       0x0001
#define ETXLEN       0x0002
#define ETXLENL      0x0002
#define ETXLENH      0x0003
#define ERXST        0x0004
#define ERXSTL       0x0004
#define ERXSTH       0x0005
#define ERXTAIL      0x0006
#define ERXTAILL     0x0006
#define ERXTAILH     0x0007
#define ERXHEAD      0x0008
#define ERXHEADL     0x0008
#define ERXHEADH     0x0009
#define EDMAST       0x000A
#define EDMASTL      0x000A
#define EDMASTH      0x000B
#define EDMALEN      0x000C
#define EDMALENL     0x000C
#define EDMALENH     0x000D
#define EDMADST      0x000E
#define EDMADSTL     0x000E
#define EDMADSTH     0x000F
#define EDMACS       0x0010
#define EDMACSL      0x0010
#define EDMACSH      0x0011
#define ETXSTAT      0x0012
#define ETXSTATL     0x0012
#define ETXSTATH     0x0013
#define ETXWIRE      0x0014
#define ETXWIREL     0x0014
#define ETXWIREH     0x0015

// SPI all bank registers
#define EUDAST       0x0016
#define EUDASTL      0x0016
#define EUDASTH      0x0017
#define EUDAND       0x0018
#define EUDANDL      0x0018
#define EUDANDH      0x0019
#define ESTAT        0x001A
#define ESTATL       0x001A
#define ESTATH       0x001B
#define EIR          0x001C
#define EIRL         0x001C
#define EIRH         0x001D
#define ECON1        0x001E
#define ECON1L       0x001E
#define ECON1H       0x001F


// SPI Bank 1 registers -----
#define EHT1         0x0000
#define EHT1L        0x0000
#define EHT1H        0x0001
#define EHT2         0x0002
#define EHT2L        0x0002
#define EHT2H        0x0003
#define EHT3         0x0004
#define EHT3L        0x0004
#define EHT3H        0x0005
#define EHT4         0x0006
#define EHT4L        0x0006
#define EHT4H        0x0007
#define EPMM1        0x0008
#define EPMM1L       0x0008
#define EPMM1H       0x0009
#define EPMM2        0x000A
#define EPMM2L       0x000A
#define EPMM2H       0x000B
#define EPMM3        0x000C
#define EPMM3L       0x000C
#define EPMM3H       0x000D
#define EPMM4        0x000E
#define EPMM4L       0x000E
#define EPMM4H       0x000F
#define EPMCS        0x0010
#define EPMCSL       0x0010
#define EPMCSH       0x0011
#define EPMO         0x0012
#define EPMOL        0x0012
#define EPMOH        0x0013
#define ERXFCON      0x0014
#define ERXFCONL     0x0014
#define ERXFCONH     0x0015

// SPI all bank registers from 0x36 to 0x3F


// SPI Bank 2 registers -----
#define MACON1       0x0000
#define MACON1L      0x0000
#define MACON1H      0x0001
#define MACON2       0x0002
#define MACON2L      0x0002
#define MACON2H      0x0003
#define MABBIPG      0x0004
#define MABBIPGL     0x0004
#define MABBIPGH     0x0005
#define MAIPG        0x0006
#define MAIPGL       0x0006
#define MAIPGH       0x0007
#define MACLCON      0x0008
#define MACLCONL     0x0008
#define MACLCONH     0x0009
#define MAMXF        0x000A
#define MAMXFL       0x000A
#define MAMXFLL      0x000A
#define MAMXFLH      0x000B
#define MICMD        0x0012
#define MICMDL       0x0012
#define MICMDH       0x0013
#define MIREGADR     0x0014
#define MIREGADRL    0x0014
#define MIREGADRH    0x0015

// SPI all bank registers from 0x56 to 0x5F


// SPI Bank 3 registers -----
#define MAADR3       0x0000
#define MAADR3L      0x0000
#define MAADR3H      0x0001
#define MAADR2       0x0002
#define MAADR2L      0x0002
#define MAADR2H      0x0003
#define MAADR1       0x0004
#define MAADR1L      0x0004
#define MAADR1H      0x0005
#define MIWR         0x0006
#define MIWRL        0x0006
#define MIWRH        0x0007
#define MIRD         0x0008
#define MIRDL        0x0008
#define MIRDH        0x0009
#define MISTAT       0x000A
#define MISTATL      0x000A
#define MISTATH      0x000B
#define EPAUS        0x000C
#define EPAUSL       0x000C
#define EPAUSH       0x000D
#define ECON2        0x000E
#define ECON2L       0x000E
#define ECON2H       0x000F
#define ERXWM        0x0010
#define ERXWML       0x0010
#define ERXWMH       0x0011
#define EIE          0x0012
#define EIEL         0x0012
#define EIEH         0x0013
#define EIDLED       0x0014
#define EIDLEDL      0x0014
#define EIDLEDH      0x0015

// SPI all bank registers from 0x66 to 0x6F


// SPI Non-banked Special Function Registers
#define EGPDATA         0x0080
#define EGPDATAL        0x0080
#define ERXDATA         0x0082
#define ERXDATAL        0x0082
#define EUDADATA        0x0084
#define EUDADATAL       0x0084
#define EGPRDPT         0x0086
#define EGPRDPTL        0x0086
#define EGPRDPTH        0x0087
#define EGPWRPT         0x0088
#define EGPWRPTL        0x0088
#define EGPWRPTH        0x0089
#define ERXRDPT         0x008A
#define ERXRDPTL        0x008A
#define ERXRDPTH        0x008B
#define ERXWRPT         0x008C
#define ERXWRPTL        0x008C
#define ERXWRPTH        0x008D
#define EUDARDPT        0x008E
#define EUDARDPTL       0x008E
#define EUDARDPTH       0x008F
#define EUDAWRPT        0x0090
#define EUDAWRPTL       0x0090
#define EUDAWRPTH       0x0091

// ENC424J600/624J600 PHY Register Addresses   //
#define PHCON1        0x00
#define PHSTAT1       0x01
#define PHANA         0x04
#define PHANLPA       0x05
#define PHANE         0x06
#define PHCON2        0x11
#define PHSTAT2       0x1B
#define PHSTAT3       0x1F


#define MISTAT_BUSY 1
#define MIIRD    0x01

/*
 * SPI commands
 */
#define BFSCMD  0b10000000      // bit field set
#define BFCCMD  0b10100000      // bit field clear
#define WCRCMD  0b01000000      // write control register
#define WCRUCMD 0b00100010
#define RCRCMD  0b00000000      // read control register
#define RCRUCMD 0b00100000      //

#define RRXDATA 0x2C            // read ERXDATA
#define WRXDATA 0x2E            // write ERXDATA

/*
 * maximum packet length
 */
#define BUF_SIZE        1518

/*
 * ENC memory allocation
 */
#define RAM_SIZE        0x6000                         // 24kB RAM available
#define TRANSMIT_START  0                              // transmit buffer start address
#define TRANSMIT_LENGTH  (BUF_SIZE + 100)              // transmit buffer length
#define RECEIVE_START   0x5340                         // receive buffer start address
#define RECEIVE_END     0x5FFF                         // receive buffer end address
#define RECEIVE_SIZE    (0x5FFF-RECEIVE_START+1)       // receive buffer size
#define REPLY_START     (TRANSMIT_START)               // reply buffer starts after per packet control byte

#define Net_Ethernet_24j600_HALFDUPLEX     0xFF
#define Net_Ethernet_24j600_FULLDUPLEX     0xFE
#define Net_Ethernet_24j600_SPD10          0xFF
#define Net_Ethernet_24j600_SPD100         0xFD
#define Net_Ethernet_24j600_AUTO_NEGOTIATION      0xFB
#define Net_Ethernet_24j600_MANUAL_NEGOTIATION    0xFF
#define Net_Ethernet_24j600_ETHERNET_CUSTOM_MAC   0xF7
#define Net_Ethernet_24j600_ETHERNET_DEFAULT_MAC  0xFF


#define NO_ADDR 0xFFFF

/*
 * library globals
 */
typedef struct {
    unsigned char valid; // valid/invalid entry flag
    unsigned long tmr; // timestamp
    unsigned char ip[4]; // IP address
    unsigned char mac[6]; // MAC address behind the IP address
} Net_Ethernet_24j600_arpCacheStruct;

extern Net_Ethernet_24j600_arpCacheStruct Net_Ethernet_24j600_arpCache[]; // ARP cash, 3 entries max

extern unsigned char Net_Ethernet_24j600_macAddr[6]; // MAC address of the controller
extern unsigned char Net_Ethernet_24j600_ipAddr[4]; // IP address of the device
extern unsigned char Net_Ethernet_24j600_gwIpAddr[4]; // GW
extern unsigned char Net_Ethernet_24j600_ipMask[4]; // network mask
extern unsigned char Net_Ethernet_24j600_dnsIpAddr[4]; // DNS serveur IP
extern unsigned char Net_Ethernet_24j600_rmtIpAddr[4]; // remote IP Address of host (DNS server reply)

extern unsigned long Net_Ethernet_24j600_userTimerSec; // must be incremented by user 1 time per second

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef struct {
  char remoteIP[4];                 // Remote IP address
  char remoteMAC[6];                // Remote MAC address
  unsigned int remotePort;          // Remote TCP port
  unsigned int destPort;            // Destination TCP port
  unsigned int dataLength;          // Current TCP payload size
  unsigned int broadcastMark;       // =0 -> Not broadcast; =1 -> Broadcast
} UDP_24j600_Dsc;
// Each field refers to the last received package

extern UDP_24j600_Dsc udpRecord_24j600;

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

} SOCKET_24j600_Dsc;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern const char NUM_OF_SOCKET_24j600;
extern const unsigned int TCP_TX_SIZE_24j600;
extern const unsigned int MY_MSS_24j600;
extern const unsigned int SYN_FIN_WAIT_24j600;
extern const unsigned int RETRANSMIT_WAIT_24j600;

extern char tx_buffers_24j600[][];
extern SOCKET_24j600_Dsc socket_24j600[];



/*
 * prototypes for public functions
 */

extern void Net_Ethernet_24j600_Init(unsigned char *mac, unsigned char *ip, unsigned char fullDuplex);

extern unsigned char Net_Ethernet_24j600_doPacket();
extern void          Net_Ethernet_24j600_putByte(unsigned char b);
extern void          Net_Ethernet_24j600_putBytes(unsigned char *ptr, unsigned int n);
extern void          Net_Ethernet_24j600_putConstBytes(const unsigned char *ptr, unsigned int n);
extern unsigned char Net_Ethernet_24j600_getByte();
extern void          Net_Ethernet_24j600_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n);
extern unsigned int  Net_Ethernet_24j600_UserUDP(UDP_24j600_Dsc *udpDsc);
extern void          Net_Ethernet_24j600_payloadInitUDP();
extern void          Net_Ethernet_24j600_UserTCP(SOCKET_24j600_Dsc *socket);
extern void          Net_Ethernet_24j600_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);

extern char          Net_Ethernet_24j600_connectTCP(char *remoteIP, unsigned int remote_port ,unsigned int my_port, SOCKET_24j600_Dsc **used_socket);
extern char          Net_Ethernet_24j600_disconnectTCP(SOCKET_24j600_Dsc *socket);

extern char          Net_Ethernet_24j600_putByteTCP(char ch, SOCKET_24j600_Dsc *socket);
extern unsigned int  Net_Ethernet_24j600_putBytesTCP(char *ptr,unsigned int n, SOCKET_24j600_Dsc *socket);
extern unsigned int  Net_Ethernet_24j600_putConstBytesTCP(const char *ptr,unsigned int n, SOCKET_24j600_Dsc *socket);
extern unsigned int  Net_Ethernet_24j600_putStringTCP(char *ptr, SOCKET_24j600_Dsc *socket);
extern unsigned int  Net_Ethernet_24j600_putConstStringTCP(const char *ptr, SOCKET_24j600_Dsc *socket);
extern char          Net_Ethernet_24j600_bufferEmptyTCP(SOCKET_24j600_Dsc *socket);
extern void          Net_Ethernet_24j600_stackInitTCP();
extern char          Net_Ethernet_24j600_startSendTCP(SOCKET_24j600_Dsc *socket);