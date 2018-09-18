#line 1 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 1 "d:/luka-probe/git/digitalni-sat/timelib.h"
#line 27 "d:/luka-probe/git/digitalni-sat/timelib.h"
typedef struct
 {
 unsigned char ss ;
 unsigned char mn ;
 unsigned char hh ;
 unsigned char md ;
 unsigned char wd ;
 unsigned char mo ;
 unsigned int yy ;
 } TimeStruct ;
#line 41 "d:/luka-probe/git/digitalni-sat/timelib.h"
extern long Time_jd1970 ;
#line 46 "d:/luka-probe/git/digitalni-sat/timelib.h"
long Time_dateToEpoch(TimeStruct *ts) ;
void Time_epochToDate(long e, TimeStruct *ts) ;
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
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
#line 10 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
unsigned char Net_Ethernet_28j60_readPacket();
#line 24 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
char Net_Ethernet_28j60_doTCP(unsigned int start, unsigned int ipHeaderLen, unsigned int payloadAddr);
#line 38 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_doUDP(unsigned int start, unsigned char ipHeaderLen, unsigned int payloadAddr);
unsigned int Net_Ethernet_28j60_flushUDP(unsigned char *destMac, unsigned char *destIP, unsigned int sourcePort, unsigned int destPort, unsigned int pktLen);
#line 49 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_doDHCP();
unsigned char Net_Ethernet_28j60_DHCPReceive(void);
unsigned char Net_Ethernet_28j60_DHCPmsg(unsigned char messageType, unsigned char renewFlag);
#line 62 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_doDNS();
#line 72 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_doARP();
#line 84 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_checksum(unsigned int start, unsigned int l);
#line 100 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_RAMcopy(unsigned int start, unsigned int stop, unsigned int dest, unsigned char w);
#line 111 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_MACswap();
#line 122 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_IPswap(void);
#line 133 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
unsigned char Net_Ethernet_28j60_TXpacket(unsigned int l);
#line 147 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
unsigned char Net_Ethernet_28j60_memcmp(unsigned int addr, unsigned char *s, unsigned char l);
#line 161 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_memcpy(unsigned int addr, unsigned char *s, unsigned int l);
#line 176 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_writeMemory(unsigned int addr, unsigned char v1, unsigned char v2);
#line 190 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_writeMemory2(unsigned int v);
#line 203 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_writeMem(unsigned int addr, unsigned char v1);
#line 215 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
unsigned char Net_Ethernet_28j60_readMem(unsigned int addr);
#line 228 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
unsigned char Net_Ethernet_28j60_readReg(unsigned char addr);
#line 242 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_writeReg(unsigned char addr, unsigned short v);
#line 256 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_setBitReg(unsigned char addr, unsigned char mask);
#line 270 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_clearBitReg(unsigned char addr, unsigned char mask);
#line 284 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_setRxReadAddress(unsigned addr);
#line 298 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_writeAddr(unsigned char addr, unsigned int v);
#line 312 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_writePHY(unsigned char reg, unsigned short h, unsigned short l);
#line 326 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_readPHY(unsigned char reg, unsigned char *h, unsigned char *l);
#line 338 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_delay();
#line 352 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/network_ethernet_pic/uses/__netethenc28j60private.h"
void Net_Ethernet_28j60_Init2(unsigned char fullDuplex);
void Net_Ethernet_28j60_socketInitTCP(char id);
void Net_Ethernet_28j60_timerTCP();

extern unsigned int Net_Ethernet_28j60_pktLen;

extern char Net_Ethernet_28j60_bufferTCP(char c, char tx, char curr_sock);
extern char Net_Ethernet_28j60_txTCP (char flag, char curr_sock);
#line 1 "d:/luka-probe/git/digitalni-sat/httputils.h"
#line 31 "d:/luka-probe/git/digitalni-sat/httputils.h"
unsigned char HTTP_basicRealm(unsigned int l, unsigned char *passwd) ;
unsigned char HTTP_getRequest(unsigned char *ptr, unsigned int *len, unsigned int max) ;
unsigned int HTTP_accessDenied(const unsigned char *zn, const unsigned char *m) ;
unsigned int http_putString(char *s) ;
unsigned int http_putConstString(const char *s) ;
unsigned int http_putConstData(const char *s, unsigned int l) ;
unsigned int HTTP_redirect(unsigned char *url) ;
unsigned int HTTP_html(const unsigned char *html) ;
unsigned int HTTP_imageGIF(const unsigned char *img, unsigned int l) ;
unsigned int HTTP_error() ;
#line 12 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
sbit Eth1_Link at RB5_bit;
sbit Net_Ethernet_28j60_Rst at LATA5_bit;
sbit Net_Ethernet_28j60_CS at LATA4_bit;
sbit Eth1_Link_Direction at TRISB5_bit;
sbit Net_Ethernet_28j60_Rst_Direction at TRISA5_bit;
sbit Net_Ethernet_28j60_CS_Direction at TRISA4_bit;
SOCKET_28j60_Dsc *socketHTML;
char sendHTML_mark = 0;
unsigned int pos[10];



sbit Com_En at RB0_bit;
sbit Com_En_Direction at TRISB0_bit;
sbit Kom_En_1 at RB1_bit;
sbit Kom_En_1_Direction at TRISB1_bit;
sbit Kom_En_2 at RB3_bit;
sbit Kom_En_2_Direction at TRISB3_bit;



sbit SV_DATA at RA1_bit;
sbit SV_CLK at RA2_bit;
sbit STROBE at RA3_bit;
sbit BCKL at RC2_bit;
sbit SV_DATA_Direction at TRISA1_bit;
sbit SV_CLK_Direction at TRISA2_bit;
sbit STROBE_Direction at TRISA3_bit;
sbit BCKL_Direction at TRISC2_bit;



sbit MSSPEN at RE0_bit;
sbit MSSPEN_Direction at TRISE0_bit;



sbit RSTPIN at RD4_bit;
sbit RSTPIN_Direction at TRISD4_bit;



sbit DISPEN at RE2_bit;
sbit DISPEN_Direction at TRISE2_bit;
#line 86 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
unsigned char macAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f} ;


unsigned char ipAddr[4] = {192, 168, 1, 18} ;
unsigned char gwIpAddr[4] = {192, 168, 1, 1 } ;
unsigned char ipMask[4] = {255, 255, 255, 0 } ;
unsigned char dnsIpAddr[4] = {8, 8, 8, 8 } ;

char ipAddrPom0[4] = "";
char ipAddrPom1[4] = "";
char ipAddrPom2[4] = "";
char ipAddrPom3[4] = "";
char gwIpAddrPom0[4] = "";
char gwIpAddrPom1[4] = "";
char gwIpAddrPom2[4] = "";
char gwIpAddrPom3[4] = "";
char ipMaskPom0[4] = "";
char ipMaskPom1[4] = "";
char ipMaskPom2[4] = "";
char ipMaskPom3[4] = "";
char dnsIpAddrPom0[4] = "";
char dnsIpAddrPom1[4] = "";
char dnsIpAddrPom2[4] = "";
char dnsIpAddrPom3[4] = "";

char sifra[9];
char pomocnaSifra[9] = "        ";
char oldSifra[9] = "OLD     ";
char newSifra[9] = "NEW     ";
unsigned char admin = 0;
char uzobyte = 0;
char mode;
char server1[27];
char server2[27];
char server3[27];


TimeStruct ts, ls ;
long epoch = 0 ;
long lastSync = 0 ;
unsigned long sntpTimer = 0;
unsigned int presTmr = 0 ;

unsigned char bufInfo[200] ;
unsigned char *marquee = 0;
unsigned char lcdEvent = 0;
unsigned int lcdTmr = 0;

unsigned char sntpSync = 0 ;
unsigned char reloadDNS = 1 ;
unsigned char serverStratum = 0 ;
unsigned char serverFlags = 0 ;
char serverPrecision = 0 ;
short tmzn = 0;
char txt[5];
char junk;

char chksum;
char prkomanda = 0;
char komgotovo = 0;
char ipt = 0;
char comand[20];

char pom_time_pom;
char uzosam = 0;
char prebaci_dan;
char prebaci_flag = 0;

char sec1, sec2, sekundi, min1, min2, minuti, hr1, hr2, sati, day1, day2, dan, mn1, mn2, mesec, year1, year2, fingodina;
char godyear1, godyear2, godyear3, godyear4;
unsigned godina;
char danuned;
char sec_pom = 0;

char reset_eth = 1;
char link = 0;
char prvi_timer = 0;
char drugi_timer = 0;
char timer_flag = 0;
char link_enable = 0;

char req_tmr_1 = 0;
char req_tmr_2 = 0;
char req_tmr_3 = 0;

char tacka1 = 0;
char tacka2 = 0;

char rst_flag = 0;
char rst_flag_1 = 0;

char pom_mat_sek = 0;
char disp_mode = 1;
char bljump;

char prolaz = 1;

unsigned char s_ip = 1;

char rst_fab = 0;
char rst_fab_tmr = 0;
char rst_fab_flag = 0;

unsigned light_res = 0;
float result;
int rest;

char light_level = 0;

char pomocni;

char notime = 0;
char notime_ovf = 0;

char max_light, min_light;

char j;

char tmr_rst_en = 0;
char tmr_rst = 0;

char dhcp_flag;

char ik;

char sta = 0;
#line 216 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
unsigned char *wday[] =
 {
 "Mon",
 "Tue",
 "Wed",
 "Thu",
 "Fri",
 "Sat",
 "Sun"
 } ;
#line 230 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
unsigned char *mon[] =
 {
 "",
 "Jan",
 "Feb",
 "Mar",
 "Apr",
 "May",
 "Jun",
 "Jul",
 "Aug",
 "Sep",
 "Oct",
 "Nov",
 "Dec"
 } ;

unsigned int httpCounter = 0 ;
unsigned char path_private[] = "/admin" ;
#line 252 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-Length: 7787\nConnection: close\nContent-type: ";
unsigned char httpMimeTypeHTML[] = "text/html\n\n";
const unsigned char httpMimeTypeScript[] = "text/plain\n\n" ;
unsigned char httpMethod[] = "GET /";
unsigned char httpRequ[] = "GET / HTTP/1.1";
#line 260 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
struct
 {
 unsigned char dhcpen ;
 unsigned char lcdL2 ;
 short tz ;
 unsigned char sntpIP[4] ;
 unsigned char sntpServer[128] ;
 } conf =
 {
 0,
 2,
 0,
 {0, 0, 0, 0},
 "swisstime.ethz.ch"


 } ;
#line 281 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
const unsigned char *LCDoption[] =
 {
 "Enable",
 "Disable"
 } ;

const unsigned char *IPoption[] =
 {
 "IPaddress",
 "Mask",
 "Gateway",
 "DNS server"
 } ;

const unsigned char *MODEoption[] =
 {
 "Unicast",
 "Server 1",
 "Server 2",
 "Server 3"
 } ;
#line 311 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
const char *CSSred = "HTTP/1.1 200 OK\nContent-type: text/css\n\nbody {background-color: #ffccdd;}" ;
#line 317 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
const char *CSSgreen = "HTTP/1.1 200 OK\nContent-type: text/css\n\nbody {background-color: #ddffcc;}" ;
#line 356 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
char HTMLheader[] = "<HTML><HEAD><TITLE>PME Clock</TITLE></HEAD><BODY><link rel=\"stylesheet\" type=\"text/css\" href=\"/s.css\"><center><h2>PME Clock</h2><h3>Time | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3><script src=/a></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Date and Time</td><td align=right><script>document.write(NOW)</script></td></tr><tr><td>Unix Epoch</td><td align=right><script>document.write(EPOCH)</script></td></tr><tr><td>Julian Day</td><td align=right><script>document.write(EPOCH / 24 / 3600 + 2440587.5)</script></td></tr><tr><td>Last sync</td><td align=right><script>document.write(LAST)</script></td></tr><HTML><HEAD></table><br>Pogledajte ceo proizvodni program na <a href=http://www.pme.rs target=_blank>www.pme.rs</a></center></BODY></HTML>";
#line 370 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
const char *HTMLtime = "<h3>Time | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3><script src=/a></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Date and Time</td><td align=right><script>document.write(NOW)</script></td></tr><tr><td>Unix Epoch</td><td align=right><script>document.write(EPOCH)</script></td></tr><tr><td>Julian Day</td><td align=right><script>document.write(EPOCH / 24 / 3600 + 2440587.5)</script></td></tr><tr><td>Last sync</td><td align=right><script>document.write(LAST)</script></td></tr>" ;
#line 484 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
const char *HTMLfooter = "<HTML><HEAD></table><br>Pogledajte ceo proizvodni program na <a href=http://www.pme.rs target=_blank>www.pme.rs</a></center></BODY></HTML>" ;
#line 491 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
char lease_tmr = 0;
char lease_time = 0;


void Eth_Obrada() {
 if (conf.dhcpen == 0) {

 if (lease_time >= 60) {
 lease_time = 0;
 while (!Net_Ethernet_28j60_renewDHCP(5));
 }
 }
 if (link == 1) {



 Net_Ethernet_28j60_doPacket();

 for (ik = 0; ik < NUM_OF_SOCKET_28j60; ik++) {
 if (socket_28j60[ik].open == 0)
 pos[ik] = 0;
 }

 }
}
#line 520 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void saveConf()
 {
#line 533 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 }
#line 537 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void mkMarquee(unsigned char l)
 {
 unsigned char len ;
 char marqeeBuff[17] ;

 if((*marquee == 0) || (marquee == 0))
 {
 marquee = bufInfo ;
 }
 if((len=strlen(marquee)) < 16) {
 memcpy(marqeeBuff, marquee, len) ;
 memcpy(marqeeBuff+len, bufInfo, 16-len) ;
 }
 else
 memcpy(marqeeBuff, marquee, 16) ;
 marqeeBuff[16] = 0 ;


 }




void DNSavings() {
 tmzn = 2;

}
#line 568 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void int2str(long l, unsigned char *s)
 {
 unsigned char i, j, n ;

 if(l == 0)
 {
 s[0] = '0' ;
 s[1] = 0 ;
 }
 else
 {
 if(l < 0)
 {
 l *= -1 ;
 n = 1 ;
 }
 else
 {
 n = 0 ;
 }
 s[0] = 0 ;
 i = 0 ;
 while(l > 0)
 {
 for(j = i + 1 ; j > 0 ; j--)
 {
 s[j] = s[j - 1] ;
 }
 s[0] = l % 10 ;
 s[0] += '0' ;
 i++ ;
 l /= 10 ;
 }
 if(n)
 {
 for(j = i + 1 ; j > 0 ; j--)
 {
 s[j] = s[j - 1] ;
 }
 s[0] = '-' ;
 }
 }
 }
#line 615 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void ip2str(unsigned char *s, unsigned char *ip)
 {
 unsigned char i ;
 unsigned char buf[4] ;

 *s = 0 ;
 for(i = 0 ; i < 4 ; i++)
 {
 int2str(ip[i], buf) ;
 strcat(s, buf) ;
 if(i != 3)
 strcat(s, ".") ;
 }
 }
#line 634 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void ts2str(unsigned char *s, TimeStruct *t, unsigned char m)
 {
 unsigned char tmp[6] ;
#line 641 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 if(m &  1 )
 {
 strcpy(s, wday[t->wd]) ;
 danuned = t->wd;
 strcat(s, " ") ;
 ByteToStr(t->md, tmp) ;
 dan = t->md;
 strcat(s, tmp + 1) ;
 strcat(s, " ") ;
 strcat(s, mon[t->mo]) ;
 mesec = t->mo;
 strcat(s, " ") ;
 WordToStr(t->yy, tmp) ;
 godina = t->yy;
 godyear1 = godina / 1000;
 godyear2 = (godina - godyear1 * 1000) / 100;
 godyear3 = (godina - godyear1 * 1000 - godyear2 * 100) / 10;
 godyear4 = godina - godyear1 * 1000 - godyear2 * 100 - godyear3 * 10;
 fingodina = godyear3 * 10 + godyear4;
 strcat(s, tmp + 1) ;
 strcat(s, " ") ;
 }
 else
 {
 *s = 0 ;
 }
#line 671 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 if(m &  2 )
 {
 ByteToStr(t->hh, tmp) ;
 sati = t->hh;
 strcat(s, tmp + 1) ;
 strcat(s, ":") ;
 ByteToStr(t->mn, tmp) ;
 minuti = (t->mn);
 if(*(tmp + 1) == ' ')
 {
 *(tmp + 1) = '0' ;
 }
 strcat(s, tmp + 1) ;
 strcat(s, ":") ;
 ByteToStr(t->ss, tmp) ;
 sekundi = t->ss;
 if(*(tmp + 1) == ' ')
 {
 *(tmp + 1) = '0' ;
 }
 strcat(s, tmp + 1) ;
 }
#line 697 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 if(m &  4 )
 {
 strcat(s, " GMT") ;
 if(conf.tz > 0)
 {
 strcat(s, "+") ;
 }
 int2str(conf.tz, s + strlen(s)) ;
 }
 }
#line 711 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
unsigned char nibble2hex(unsigned char n)
 {
 n &= 0x0f ;
 if(n >= 0x0a)
 {
 return(n + '7') ;
 }
 return(n + '0') ;
 }
#line 724 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void byte2hex(unsigned char *s, unsigned char v)
 {
 *s++ = nibble2hex(v >> 4) ;
 *s++ = nibble2hex(v) ;
 *s = '.' ;
 }
#line 759 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void mkLCDLine(unsigned char l, unsigned char m)
 {
 switch(m)
 {
 case 0:

 memset(bufInfo, 0, sizeof(bufInfo)) ;
 if(lastSync)
 {

 strcpy(bufInfo, "Today is ") ;
 ts2str(bufInfo + strlen(bufInfo), &ts,  1 ) ;
 strcat(bufInfo, ". Please visit www.micro-examples.com for more details about the Ethernal Clock. You can browse ") ;
 ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
 strcat(bufInfo, " to set the clock preferences.    ") ;
 }
 else
 {

 strcpy(bufInfo, "The SNTP server did not respond, please browse ") ;
 ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
 strcat(bufInfo, " to check clock settings.    ") ;
 }
 mkMarquee(l) ;
 break ;
 case 1:



 ts2str(bufInfo, &ts,  1 ) ;





 break ;
 case 2:



 ts2str(bufInfo, &ts,  2 ) ;





 break ;
 }
 }
#line 812 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void mkSNTPrequest()
 {
 unsigned char sntpPkt[50];
 unsigned char * remoteIpAddr;

 if (sntpSync)
 if (Net_Ethernet_28j60_UserTimerSec >= sntpTimer)
 if (!lastSync) {
 sntpSync = 0;
 if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
 reloadDNS = 1 ;
 }

 if(reloadDNS)
 {

 if(isalpha(*conf.sntpServer))
 {

 memset(conf.sntpIP, 0, 4);
 if(remoteIpAddr = Net_Ethernet_28j60_dnsResolve(conf.sntpServer, 5))
 {

 memcpy(conf.sntpIP, remoteIpAddr, 4) ;
 }
 }
 else
 {

 unsigned char *ptr = conf.sntpServer ;

 conf.sntpIP[0] = atoi(ptr) ;
 ptr = strchr(ptr, '.') + 1 ;
 conf.sntpIP[1] = atoi(ptr) ;
 ptr = strchr(ptr, '.') + 1 ;
 conf.sntpIP[2] = atoi(ptr) ;
 ptr = strchr(ptr, '.') + 1 ;
 conf.sntpIP[3] = atoi(ptr) ;
 }

 saveConf() ;

 reloadDNS = 0 ;

 sntpSync = 0 ;
 }

 if(sntpSync)
 {
 return ;
 }
#line 867 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 memset(sntpPkt, 0, 48) ;


 sntpPkt[0] = 0b00011001 ;




 sntpPkt[2] = 0x0a ;


 sntpPkt[3] = 0xfa ;


 sntpPkt[6] = 0x44 ;


 sntpPkt[9] = 0x10 ;
#line 896 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 Net_Ethernet_28j60_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48) ;

 sntpSync = 1 ;
 lastSync = 0 ;
 sntpTimer = Net_Ethernet_28j60_UserTimerSec + 2;
 }

void Rst_Eth() {
 Net_Ethernet_28j60_Rst = 0;
 reset_eth = 1;

}


char Print_Seg(char segm, char tacka) {
 char napolje;
 if (segm == 0) {
 napolje = 0b01111110 | tacka;
 }
 if (segm == 1) {
 napolje = 0b00011000 | tacka;
 }
 if (segm == 2) {
 napolje = 0b10110110 | tacka;
 }
 if (segm == 3) {
 napolje = 0b10111100 | tacka;
 }
 if (segm == 4) {
 napolje = 0b11011000 | tacka;
 }
 if (segm == 5) {
 napolje = 0b11101100 | tacka;
 }
 if (segm == 6) {
 napolje = 0b11101110 | tacka;
 }
 if (segm == 7) {
 napolje = 0b00111000 | tacka;
 }
 if (segm == 8) {
 napolje = 0b11111110 | tacka;
 }
 if (segm == 9) {
 napolje = 0b11111100 | tacka;
 }

 if (segm == 10) {
 napolje = 0b11110010 | tacka;
 }
 if (segm == 11) {
 napolje = 0b01110010 | tacka;
 }
 if (segm == 12) {
 napolje = 0b01111000 | tacka;
 }
 if (segm == 13) {
 napolje = 0b11100110 | tacka;
 }
 if (segm == 14) {
 napolje = 0b00000100 | tacka;
 }
 if (segm == 15) {
 napolje = 0b00000000;
 }
 if (segm == 16) {
 napolje = 0b00000001;
 }
 if (segm == 17) {
 napolje = 0b10000000;
 }

 return napolje;
}

void PRINT_S(char ledovi) {
 char pom1, pom, ir;
 pom = 0;
 for ( ir = 0; ir < 8; ir++ ) {
 pom1 = (ledovi << pom) & 0b10000000;
 if (pom1 == 0b10000000) {
 SV_DATA = 1;
 }
 if (pom1 == 0b00000000) {
 SV_DATA = 0;
 }
 asm nop;
 asm nop;
 asm nop;
 SV_CLK = 0;
 asm nop;
 asm nop;
 asm nop;
 SV_CLK = 1;
 pom++;
 }
}


void Display_Time() {

 sec1 = sekundi / 10;
 sec2 = sekundi - sec1 * 10;
 min1 = minuti / 10;
 min2 = minuti - min1 * 10;
 hr1 = sati / 10;
 hr2 = sati - hr1 * 10;
 day1 = dan / 10;
 day2 = dan - day1 * 10;
 mn1 = mesec / 10;
 mn2 = mesec - mn1 * 10;
 year1 = fingodina / 10;
 year2 = fingodina - year1 * 10;

 if (disp_mode == 1) {
 STROBE = 0;
 asm nop;
 asm nop;
 asm nop;
#line 1021 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 PRINT_S(Print_Seg(sta, 0));
 PRINT_S(Print_Seg(sta, 0));
 PRINT_S(Print_Seg(sta, 0));
 PRINT_S(Print_Seg(sta, 0));
 PRINT_S(Print_Seg(sta, 0));
 PRINT_S(Print_Seg(sta, 0));
 asm nop;
 asm nop;
 asm nop;
 STROBE = 1;
 }
 if (disp_mode == 2) {
 STROBE = 0;
 asm nop;
 asm nop;
 asm nop;
 PRINT_S(Print_Seg(year2, 0));
 PRINT_S(Print_Seg(year1, 0));
 PRINT_S(Print_Seg(mn2, 0));
 PRINT_S(Print_Seg(mn1, 0));
 PRINT_S(Print_Seg(day2, tacka1));
 PRINT_S(Print_Seg(day1, tacka2));
 asm nop;
 asm nop;
 asm nop;
 STROBE = 1;
 }

}
#line 1055 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void Net_Ethernet_28j60_UserTCP(SOCKET_28j60_Dsc *socket) {

 unsigned char dyna[64] ;
 unsigned char getRequest[ 128  + 1] ;
 unsigned int len = 0 ;
 int res;

 int i ;
 char fbr;
 unsigned int ij;

 if (socket->destPort != 80)
 {
 return;
 }
 for(len = 0; len < 10; len++){
 getRequest[len] = Net_Ethernet_28j60_getByte();
 }
 getRequest[len] = 0;
#line 1083 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 if(memcmp(getRequest, httpMethod, 5)&&(socket->state != 3)){
 return;
 }

 if(memcmp(getRequest, httpRequ, 9)==0){
 sendHTML_mark = 1;
 socketHTML = socket;
 }

 if((sendHTML_mark == 1)&&(socketHTML == socket)) {

 if(pos[socket->ID]==0) {

 sta = 1;
 Net_Ethernet_28j60_putStringTCP(httpHeader, socket);
 Net_Ethernet_28j60_putStringTCP(httpMimeTypeHTML, socket);
 }

 while(pos[socket->ID] < (strlen(HTMLheader+1)) ) {
 sta = 2;
 if(Net_Ethernet_28j60_putByteTCP(HTMLheader[pos[socket->ID]++], socket) == 0) {
 pos[socket->ID]--;
 sta = 3;
 break;
 }
 }
#line 1122 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= (strlen(HTMLheader)+1))) {

 Net_Ethernet_28j60_disconnectTCP(socket);
 socket_28j60[socket->ID].state = 0;
 sendHTML_mark = 0;
 pos[socket->ID] = 0;
 }
#line 2081 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
 httpCounter++ ;


 ZAVRSI:


 junk = 0;

 }
 }


void Print_IP() {
 char cif1;
 char cif2;
 char cif3;
 cif1 = ipAddr[3] / 100;
 cif2 = (ipAddr[3] - cif1 * 100) / 10;
 cif3 = ipAddr[3] - cif1 * 100 - cif2 * 10;
 STROBE = 0;
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(cif3, 0));
 PRINT_S(Print_Seg(cif2, 0));
 PRINT_S(Print_Seg(cif1, 0));
 STROBE = 1;
 asm CLRWDT;
 delay_ms(2000);
 asm CLRWDT;
 STROBE = 0;
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 STROBE = 1;
 asm CLRWDT;
 delay_ms(500);
 asm CLRWDT;
}
#line 2128 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
unsigned int Net_Ethernet_28j60_UserUDP(UDP_28j60_Dsc *udpDsc)
 {
 unsigned char i ;
 char broadcmd[20];

 if (udpDsc->destPort == 10001) {
 if (udpDsc->dataLength == 9) {
 for (i = 0 ; i < 9 ; i++) {
 broadcmd[i] = Net_Ethernet_28j60_getByte() ;
 }
 if ( (broadcmd[0] == 'I') && (broadcmd[1] == 'D') && (broadcmd[2] == 'E') && (broadcmd[3] == 'N') && (broadcmd[4] == 'T') && (broadcmd[5] == 'I') && (broadcmd[6] == 'F') && (broadcmd[7] == 'Y') && (broadcmd[8] == '!') ) {
 Print_IP();
 }
 }
 }

 if(udpDsc->destPort == 123)
 {
 if (udpDsc->dataLength == 48) {

 unsigned long tts ;

 serverFlags = Net_Ethernet_28j60_getByte() ;
 serverStratum = Net_Ethernet_28j60_getByte() ;
 Net_Ethernet_28j60_getByte() ;
 serverPrecision = Net_Ethernet_28j60_getByte() ;

 for(i = 0 ; i < 36 ; i++)
 {
 Net_Ethernet_28j60_getByte() ;
 }


  ((char *)&tts)[3]  = Net_Ethernet_28j60_getByte() ;
  ((char *)&tts)[2]  = Net_Ethernet_28j60_getByte() ;
  ((char *)&tts)[1]  = Net_Ethernet_28j60_getByte() ;
  ((char *)&tts)[0]  = Net_Ethernet_28j60_getByte() ;


 epoch = tts - 2208988800 ;


 lastSync = epoch ;


 marquee = bufInfo ;

 notime = 0;
 notime_ovf = 0;

 Time_epochToDate(epoch + tmzn * 3600l, &ts) ;
 presTmr = 0;
 DNSavings();
 if (lcdEvent) {
 mkLCDLine(1, conf.dhcpen) ;
 mkLCDLine(2, conf.lcdL2) ;
 lcdEvent = 0 ;
 marquee++ ;
 }

 presTmr = 0;
 lcdTmr = 0;
 Display_Time();
 } else {
 return(0) ;
 }
 } else {
 return(0) ;
 }
 }

void interrupt() {

 if (PIR1.RCIF == 1) {
 prkomanda = UART1_Read();
 if ( ( (ipt == 0) && (prkomanda == 0xAA) ) || (ipt != 0) ) {
 comand[ipt] = prkomanda;
 ipt++;
 }
 if (prkomanda == 0xBB) {
 komgotovo = 1;
 ipt = 0;
 }
 if (ipt > 18) {
 ipt = 0;
 }
 }

 if (INTCON.TMR0IF) {
 presTmr++ ;
 lcdTmr++ ;
 if (presTmr == 15625) {


 if (tmr_rst_en == 1) {
 tmr_rst++;
 if (tmr_rst == 178) {
 tmr_rst = 0;
 tmr_rst_en = 0;
 admin = 0;
 }
 } else {
 tmr_rst = 0;
 }



 notime++;
 if (notime == 32) {
 notime = 0;
 notime_ovf = 1;
 }



 if ( (lease_tmr == 1) && (lease_time < 250) ) {
 lease_time++;
 } else {
 lease_time = 0;
 }



 Net_Ethernet_28j60_UserTimerSec++ ;
 epoch++ ;
 presTmr = 0 ;



 if (timer_flag < 2555) {
 timer_flag++;
 } else {
 timer_flag = 0;
 }




 req_tmr_1++;
 if (req_tmr_1 == 60) {
 req_tmr_1 = 0;
 req_tmr_2++;
 }
 if (req_tmr_2 == 60) {
 req_tmr_2 = 0;
 req_tmr_3++;
 }



 if (rst_flag == 1) {
 rst_flag_1++;
 }



 if ( (rst_fab_tmr == 1) && (rst_fab_flag < 200) ) {
 rst_fab_flag++;
 }


 }

 if (lcdTmr == 3125) {
 lcdEvent = 1;
 lcdTmr = 0;
 }
 INTCON.TMR0IF = 0 ;
 }
}


void Print_Blank() {
 STROBE = 0;
 PRINT_S(Print_Seg(8, 0));
 PRINT_S(Print_Seg(8, 0));
 PRINT_S(Print_Seg(8, 0));
 PRINT_S(Print_Seg(8, 0));
 PRINT_S(Print_Seg(8, 0));
 PRINT_S(Print_Seg(8, 0));
 STROBE = 1;
 asm CLRWDT;
 delay_ms(1000);
 asm CLRWDT;
 STROBE = 0;
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 STROBE = 1;
 asm CLRWDT;
 delay_ms(500);
 asm CLRWDT;
}

void Print_All() {
 char pebr;
 char tck1;
 char tck2;
 STROBE = 0;
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 0));
 PRINT_S(Print_Seg(15, 1));
 PRINT_S(Print_Seg(15, 1));
 STROBE = 1;
 asm CLRWDT;
 delay_ms(500);
 asm CLRWDT;
 for (pebr = 0; pebr <= 9; pebr++) {
 STROBE = 0;
 if ( (pebr == 1) || (pebr == 3) || (pebr == 5) || (pebr == 7) || (pebr == 9) ) {
 tck1 = 1;
 tck2 = 0;
 } else {
 tck1 = 0;
 tck2 = 1;
 }
 PRINT_S(Print_Seg(pebr, 0));
 PRINT_S(Print_Seg(pebr, 0));
 PRINT_S(Print_Seg(pebr, 0));
 PRINT_S(Print_Seg(pebr, 0));
 PRINT_S(Print_Seg(pebr, tck1));
 PRINT_S(Print_Seg(pebr, tck2));
 STROBE = 1;
 asm CLRWDT;
 delay_ms(500);
 asm CLRWDT;
 }
}


void Print_Pme() {
 STROBE = 0;
 PRINT_S(Print_Seg(14, 0));
 PRINT_S(Print_Seg(14, 0));
 PRINT_S(Print_Seg(13, 0));
 PRINT_S(Print_Seg(12, 0));
 PRINT_S(Print_Seg(11, 0));
 PRINT_S(Print_Seg(10, 0));
 STROBE = 1;
}


void Print_Light() {
 ADCON0 = 0b00000001;
 light_res = ADC_Read(0);
 result = light_res * 0.00322265625;

 if (result <= 1.3) {
 PWM1_Set_Duty(max_light);
 }
 if ( (result > 1.3) && (result <= 2.3) ) {
 PWM1_Set_Duty((max_light*2)/3);
 }
 if (result > 2.3) {
 PWM1_Set_Duty(max_light/3);
 }

 Eth_Obrada();
}


void Mem_Read() {
 char membr;
 MSSPEN = 1;
 asm nop;
 asm nop;
 asm nop;
 I2C1_Init(100000);
 I2C1_Start();
 I2C1_Wr(0xA2);
 I2C1_Wr(0xFA);
 I2C1_Repeated_Start();
 I2C1_Wr(0xA3);
 for(membr=0 ; membr<=4 ; membr++) {
 macAddr[membr] = I2C1_Rd(1);
 }
 macAddr[5] = I2C1_Rd(0);
 I2C1_Stop();
 MSSPEN = 0;
 asm nop;
 asm nop;
 asm nop;

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

}
#line 2423 "D:/Luka-Probe/Git/Digitalni-Sat/SE9M.c"
void main() {

 TRISA = 0b00000001;
 PORTA = 0;
 TRISB = 0;
 PORTB = 0;
 TRISC = 0;
 PORTC = 0;

 Com_En_Direction = 0;
 Com_En = 0;

 Kom_En_1_Direction = 0;
 Kom_En_1 = 1;

 Kom_En_2_Direction = 0;
 Kom_En_2 = 0;

 Eth1_Link_Direction = 1;

 Net_Ethernet_28j60_Rst_Direction = 0;
 Net_Ethernet_28j60_Rst = 0;
 Net_Ethernet_28j60_CS_Direction = 0;
 Net_Ethernet_28j60_CS = 0;

 RSTPIN_Direction = 1;

 DISPEN_Direction = 0;
 DISPEN = 0;

 MSSPEN_Direction = 0;
 MSSPEN = 0;

 SV_DATA_Direction = 0;
 SV_DATA = 0;
 SV_CLK_Direction = 0;
 SV_CLK = 0;
 STROBE_Direction = 0;
 STROBE = 1;

 BCKL_Direction = 0;
 BCKL = 0;

 ANSEL = 0;
 ANSELH = 0;

 ADCON0 = 0b00000001;
 ADCON1 = 0b00001110;

 max_light = 180;
 min_light = 30;

 PWM1_Init(2000);
 PWM1_Start();
 PWM1_Set_Duty(max_light);


 for(ik = 0; ik < NUM_OF_SOCKET_28j60; ik++)
 pos[ik] = 0;

 UART1_Init(9600);
 PIE1.RCIE = 1;
 GIE_bit = 1;
 PEIE_bit = 1;

 T0CON = 0b11000000 ;
 INTCON.TMR0IF = 0 ;
 INTCON.TMR0IE = 1 ;



 while(1) {

 pom_time_pom = EEPROM_Read(0);

 if ( (pom_time_pom != 0xAA) || (rst_fab == 1) ) {

 conf.dhcpen = 1;
 EEPROM_Write(103, conf.dhcpen);
 mode = 1;
 EEPROM_Write(104, mode);
 dhcp_flag = 0;
 EEPROM_Write(105, dhcp_flag);

 strcpy(sifra, "adminpme");
 for (j=0;j<=8;j++) {
 EEPROM_Write(j+20, sifra[j]);
 }

 strcpy(server1, "swisstime.ethz.ch");
 for (j=0;j<=26;j++) {
 EEPROM_Write(j+29, server1[j]);
 }
 strcpy(server2, "0.rs.pool.ntp.org");
 for (j=0;j<=26;j++) {
 EEPROM_Write(j+56, server2[j]);
 }
 strcpy(server3, "pool.ntp.org");
 for (j=0;j<=26;j++) {
 EEPROM_Write(j+110, server3[j]);
 }


 ipAddr[0] = 192;
 ipAddr[1] = 168;
 ipAddr[2] = 1;
 ipAddr[3] = 99;
 gwIpAddr[0] = 192;
 gwIpAddr[1] = 168;
 gwIpAddr[2] = 1;
 gwIpAddr[3] = 1;
 ipMask[0] = 255;
 ipMask[1] = 255;
 ipMask[2] = 255;
 ipMask[3] = 0;
 dnsIpAddr[0] = 192;
 dnsIpAddr[1] = 168;
 dnsIpAddr[2] = 1;
 dnsIpAddr[3] = 1;


 EEPROM_Write(1, ipAddr[0]);
 EEPROM_Write(2, ipAddr[1]);
 EEPROM_Write(3, ipAddr[2]);
 EEPROM_Write(4, ipAddr[3]);
 EEPROM_Write(5, gwIpAddr[0]);
 EEPROM_Write(6, gwIpAddr[1]);
 EEPROM_Write(7, gwIpAddr[2]);
 EEPROM_Write(8, gwIpAddr[3]);
 EEPROM_Write(9, ipMask[0]);
 EEPROM_Write(10, ipMask[1]);
 EEPROM_Write(11, ipMask[2]);
 EEPROM_Write(12, ipMask[3]);
 EEPROM_Write(13, dnsIpAddr[0]);
 EEPROM_Write(14, dnsIpAddr[1]);
 EEPROM_Write(15, dnsIpAddr[2]);
 EEPROM_Write(16, dnsIpAddr[3]);

 ByteToStr(ipAddr[0], IpAddrPom0);
 ByteToStr(ipAddr[1], IpAddrPom1);
 ByteToStr(ipAddr[2], IpAddrPom2);
 ByteToStr(ipAddr[3], IpAddrPom3);

 ByteToStr(gwIpAddr[0], gwIpAddrPom0);
 ByteToStr(gwIpAddr[1], gwIpAddrPom1);
 ByteToStr(gwIpAddr[2], gwIpAddrPom2);
 ByteToStr(gwIpAddr[3], gwIpAddrPom3);

 ByteToStr(ipMask[0], ipMaskPom0);
 ByteToStr(ipMask[1], ipMaskPom1);
 ByteToStr(ipMask[2], ipMaskPom2);
 ByteToStr(ipMask[3], ipMaskPom3);

 ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
 ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
 ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
 ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);

 rst_fab = 0;
 pom_time_pom = 0xAA;
 EEPROM_Write(0, pom_time_pom);
 delay_ms(100);
 }

 Eth_Obrada();

 sifra[0] = EEPROM_Read(20);
 sifra[1] = EEPROM_Read(21);
 sifra[2] = EEPROM_Read(22);
 sifra[3] = EEPROM_Read(23);
 sifra[4] = EEPROM_Read(24);
 sifra[5] = EEPROM_Read(25);
 sifra[6] = EEPROM_Read(26);
 sifra[7] = EEPROM_Read(27);
 sifra[8] = EEPROM_Read(28);

 for (j=0;j<=26;j++) {
 server1[j] = EEPROM_Read(j+29);
 }
 for (j=0;j<=26;j++) {
 server2[j] = EEPROM_Read(j+56);
 }
 for (j=0;j<=26;j++) {
 server3[j] = EEPROM_Read(j+110);
 }

 ipAddr[0] = EEPROM_Read(1);
 ipAddr[1] = EEPROM_Read(2);
 ipAddr[2] = EEPROM_Read(3);
 ipAddr[3] = EEPROM_Read(4);
 gwIpAddr[0] = EEPROM_Read(5);
 gwIpAddr[1] = EEPROM_Read(6);
 gwIpAddr[2] = EEPROM_Read(7);
 gwIpAddr[3] = EEPROM_Read(8);
 ipMask[0] = EEPROM_Read(9);
 ipMask[1] = EEPROM_Read(10);
 ipMask[2] = EEPROM_Read(11);
 ipMask[3] = EEPROM_Read(12);
 dnsIpAddr[0] = EEPROM_Read(13);
 dnsIpAddr[1] = EEPROM_Read(14);
 dnsIpAddr[2] = EEPROM_Read(15);
 dnsIpAddr[3] = EEPROM_Read(16);


 if (prolaz == 1) {
 ByteToStr(ipAddr[0], IpAddrPom0);
 ByteToStr(ipAddr[1], IpAddrPom1);
 ByteToStr(ipAddr[2], IpAddrPom2);
 ByteToStr(ipAddr[3], IpAddrPom3);

 ByteToStr(gwIpAddr[0], gwIpAddrPom0);
 ByteToStr(gwIpAddr[1], gwIpAddrPom1);
 ByteToStr(gwIpAddr[2], gwIpAddrPom2);
 ByteToStr(gwIpAddr[3], gwIpAddrPom3);

 ByteToStr(ipMask[0], ipMaskPom0);
 ByteToStr(ipMask[1], ipMaskPom1);
 ByteToStr(ipMask[2], ipMaskPom2);
 ByteToStr(ipMask[3], ipMaskPom3);

 ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
 ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
 ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
 ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);

 prolaz = 0;
 Print_All();
 }

 conf.tz = EEPROM_Read(102);
 conf.dhcpen = EEPROM_Read(103);
 mode = EEPROM_Read(104);
 dhcp_flag = EEPROM_Read(105);

 if ( (conf.dhcpen == 0) && (dhcp_flag == 1) ) {
 conf.dhcpen = 1;
 EEPROM_Write(103, conf.dhcpen);
 dhcp_flag = 0;
 EEPROM_Write(105, dhcp_flag);
 delay_ms(100);
 }

 Eth_Obrada();

 if (reset_eth == 1) {
 reset_eth = 0;
 prvi_timer = 1;
 drugi_timer = 0;
 timer_flag = 0;

 Print_Pme();
 }
 if ( (prvi_timer == 1) && (timer_flag >= 1) ) {
 prvi_timer = 0;
 drugi_timer = 1;
 Net_Ethernet_28j60_Rst = 1;
 timer_flag = 0;
 Print_Pme();
 }
 if ( (drugi_timer == 1) && (timer_flag >= 1) ) {
 prvi_timer = 0;
 drugi_timer = 0;
 link_enable = 1;
 timer_flag = 0;
 Print_Pme();
 }
 if ( (Eth1_Link == 0) && (link == 0) && (link_enable == 1) ) {
 link = 1;
 tacka1 = 1;
 Print_Pme();


 Print_Pme();
 if (conf.dhcpen == 0) {
 Mem_Read();
 ipAddr[0] = 0;
 ipAddr[1] = 0;
 ipAddr[2] = 0;
 ipAddr[3] = 0;

 dhcp_flag = 1;
 EEPROM_Write(105, dhcp_flag);
 Net_Ethernet_28j60_Init(macAddr, ipAddr,  1 ) ;
 Net_Ethernet_28j60_stackInitTCP();
 while (Net_Ethernet_28j60_initDHCP(5) == 0) ;
 memcpy(ipAddr, Net_Ethernet_28j60_getIpAddress(), 4) ;
 memcpy(ipMask, Net_Ethernet_28j60_getIpMask(), 4) ;
 memcpy(gwIpAddr, Net_Ethernet_28j60_getGwIpAddress(), 4) ;
 memcpy(dnsIpAddr, Net_Ethernet_28j60_getDnsIpAddress(), 4) ;

 lease_tmr = 1;
 lease_time = 0;

 EEPROM_Write(1, ipAddr[0]);
 EEPROM_Write(2, ipAddr[1]);
 EEPROM_Write(3, ipAddr[2]);
 EEPROM_Write(4, ipAddr[3]);
 EEPROM_Write(5, gwIpAddr[0]);
 EEPROM_Write(6, gwIpAddr[1]);
 EEPROM_Write(7, gwIpAddr[2]);
 EEPROM_Write(8, gwIpAddr[3]);
 EEPROM_Write(9, ipMask[0]);
 EEPROM_Write(10, ipMask[1]);
 EEPROM_Write(11, ipMask[2]);
 EEPROM_Write(12, ipMask[3]);
 EEPROM_Write(13, dnsIpAddr[0]);
 EEPROM_Write(14, dnsIpAddr[1]);
 EEPROM_Write(15, dnsIpAddr[2]);
 EEPROM_Write(16, dnsIpAddr[3]);

 ByteToStr(ipAddr[0], IpAddrPom0);
 ByteToStr(ipAddr[1], IpAddrPom1);
 ByteToStr(ipAddr[2], IpAddrPom2);
 ByteToStr(ipAddr[3], IpAddrPom3);

 ByteToStr(gwIpAddr[0], gwIpAddrPom0);
 ByteToStr(gwIpAddr[1], gwIpAddrPom1);
 ByteToStr(gwIpAddr[2], gwIpAddrPom2);
 ByteToStr(gwIpAddr[3], gwIpAddrPom3);

 ByteToStr(ipMask[0], ipMaskPom0);
 ByteToStr(ipMask[1], ipMaskPom1);
 ByteToStr(ipMask[2], ipMaskPom2);
 ByteToStr(ipMask[3], ipMaskPom3);

 ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
 ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
 ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
 ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);

 dhcp_flag = 0;
 EEPROM_Write(105, dhcp_flag);
 delay_ms(100);
 Print_IP();
 }
 if (conf.dhcpen == 1) {
 lease_tmr = 0;
 Mem_Read();
 Net_Ethernet_28j60_stackInitTCP();
 SPI1_Init();
 SPI_Rd_Ptr = SPI1_Read;
 Net_Ethernet_28j60_Init(macAddr, ipAddr,  1 ) ;
 Net_Ethernet_28j60_confNetwork(ipMask, gwIpAddr, dnsIpAddr) ;

 Print_IP();
 }
 tacka1 = 0;
 Print_Pme();

 }


 if (Eth1_Link == 1) {
 link = 0;
 lastSync = 0;
 }

 Eth_Obrada();


 if (req_tmr_3 == 12) {
 sntpSync = 0;
 req_tmr_1 = 0;
 req_tmr_2 = 0;
 req_tmr_3 = 0;
 }


 if (RSTPIN == 0) {
 rst_fab_tmr = 1;
 } else {
 rst_fab_tmr = 0;
 rst_fab_flag = 0;
 }
 if (rst_fab_flag >= 5) {
 rst_fab_tmr = 0;
 rst_fab_flag = 0;
 rst_fab = 1;
 Rst_Eth();
 }

 Eth_Obrada();


 if (komgotovo == 1) {
 komgotovo = 0;
 chksum = (comand[3] ^ comand[4] ^ comand[5] ^ comand[6] ^ comand[7] ^comand[8] ^ comand[9] ^ comand[10] ^ comand[11]) & 0x7F;
 if ((comand[0] == 0xAA) && (comand[1] == 0xAA) && (comand[2] == 0xAA) && (comand[12] == chksum) && (comand[13] == 0xBB) && (link_enable == 1)) {
 sati = comand[3];
 minuti = comand[4];
 sekundi = comand[5];
 dan = comand[6];
 mesec = comand[7];
 fingodina = comand[8];
 notime = 0;
 notime_ovf = 0;
 }
 }

 if (pom_mat_sek != sekundi) {
 pom_mat_sek = sekundi;
 Eth_Obrada();

 if (disp_mode == 1) {
 tacka2 = 0;
 if (tacka1 == 0) {
 tacka1 = 1;
 goto DALJE2;
 }
 if (tacka1 == 1) {
 tacka1 = 0;
 goto DALJE2;
 }
 DALJE2:
 bljump = 0;
 }
 if (disp_mode == 2) {
 tacka1 = 0;
 tacka2 = 1;
 }
 if (notime_ovf == 1) {
 tacka1 = 1;
 tacka2 = 1;
 }
 if (notime_ovf == 0) {
 if ( (sekundi == 0) || (sekundi == 10) || (sekundi == 20) || (sekundi == 30) || (sekundi == 40) || (sekundi == 50) ) {
 Print_Light();
 }
 } else {
 PWM1_Set_Duty(min_light);
 }
 Display_Time();
 }

 Time_epochToDate(epoch + tmzn * 3600l, &ts) ;
 Eth_Obrada();
 DNSavings();
 if (lcdEvent) {
 mkLCDLine(1, conf.dhcpen) ;
 mkLCDLine(2, conf.lcdL2) ;
 lcdEvent = 0 ;
 marquee++ ;
 }

 asm CLRWDT;
 }
}
