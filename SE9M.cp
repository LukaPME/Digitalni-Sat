#line 1 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 1 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/timelib.h"
#line 27 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/timelib.h"
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
#line 41 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/timelib.h"
extern long Time_jd1970 ;
#line 46 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/timelib.h"
long Time_dateToEpoch(TimeStruct *ts) ;
void Time_epochToDate(long e, TimeStruct *ts) ;
#line 1 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
#line 10 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
unsigned char Ethernet_readPacket();
#line 24 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_doTCP(unsigned int start, unsigned int ipHeaderLen, unsigned int payloadAddr);
#line 38 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_doUDP(unsigned int start, unsigned char ipHeaderLen, unsigned int payloadAddr);
char Ethernet_sendUDP2(unsigned char *destMAC, unsigned char *destIP, unsigned int sourcePort, unsigned int destPort, unsigned int pktLen);
#line 49 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_doDHCP();
unsigned char Ethernet_DHCPReceive(void);
unsigned char Ethernet_DHCPmsg(unsigned char messageType, unsigned char renewFlag);
#line 62 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_doDNS();
#line 72 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_doARP();
#line 84 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_checksum(unsigned int start, unsigned int l);
#line 100 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_RAMcopy(unsigned int start, unsigned int stop, unsigned int dest, unsigned char w);
#line 112 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_MACswap();
#line 123 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_IPswap(void);
#line 134 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
unsigned char Ethernet_txPacket(unsigned int l);
#line 148 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
unsigned char Ethernet_memcmp(unsigned int addr, unsigned char *s, unsigned char l);
#line 162 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_memcpy(unsigned int addr, unsigned char *s, unsigned int l);
#line 177 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_writeMemory(unsigned int addr, unsigned char v1, unsigned char v2);
#line 191 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_writeMemory2(unsigned int v);
#line 204 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_writeMem(unsigned int addr, unsigned char v1);
#line 216 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
unsigned char Ethernet_readMem(unsigned int addr);


void Ethernet_writeAddr2(unsigned char *addr, unsigned int v);
unsigned char Ethernet_readReg2(unsigned char *addr);
#line 234 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_setRxReadAddress(unsigned addr);
#line 248 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_writePHY(unsigned char reg, unsigned short h, unsigned short l);
#line 262 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_readPHY(unsigned char reg, unsigned char *h, unsigned char *l);
#line 274 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_delay();
#line 288 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60private.h"
void Ethernet_Init2(unsigned char fullDuplex);

extern unsigned int Ethernet_pktLen;
#line 1 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60.h"
#line 47 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60.h"
typedef struct
 {
 unsigned char valid;
 unsigned long tmr;
 unsigned char ip[4];
 unsigned char mac[6];
 } Ethernet_arpCacheStruct;

extern Ethernet_arpCacheStruct Ethernet_arpCache[];

extern unsigned char Ethernet_macAddr[6];
extern unsigned char Ethernet_ipAddr[4];
extern unsigned char Ethernet_gwIpAddr[4];
extern unsigned char Ethernet_ipMask[4];
extern unsigned char Ethernet_dnsIpAddr[4];
extern unsigned char Ethernet_rmtIpAddr[4];

extern unsigned long Ethernet_userTimerSec;

typedef struct {
 unsigned canCloseTCP: 1;
 unsigned isBroadcast: 1;
} TEthPktFlags;
#line 74 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/__ethj60.h"
extern void Ethernet_Init(unsigned char *mac, unsigned char *ip, unsigned char fullDuplex);
extern unsigned char Ethernet_doPacket();
extern void Ethernet_putByte(unsigned char b);
extern void Ethernet_putBytes(unsigned char *ptr, unsigned int n);
extern void Ethernet_putConstBytes(const unsigned char *ptr, unsigned int n);
extern unsigned char Ethernet_getByte();
extern void Ethernet_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n);
extern unsigned int Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags * flags);
extern unsigned int Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags * flags);
extern void Ethernet_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);
#line 1 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/httputils.h"
#line 31 "d:/luka-probe/microc/poe sat - nova sema !!!!!!!/httputils.h"
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
#line 16 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
sbit Eth1_Link at RB5_bit;
sbit SPI_Ethernet_Rst at RA5_bit;
sbit SPI_Ethernet_CS at RA4_bit;
sbit Eth1_Link_Direction at TRISB5_bit;
sbit SPI_Ethernet_Rst_Direction at TRISA5_bit;
sbit SPI_Ethernet_CS_Direction at TRISA4_bit;



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
#line 87 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
unsigned char macAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f} ;
#line 101 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 228 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 242 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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

const unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: " ;
const unsigned char httpMimeTypeHTML[] = "text/html\n\n" ;
const unsigned char httpMimeTypeScript[] = "text/plain\n\n" ;
#line 269 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 290 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 327 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *CSSred = "HTTP/1.1 200 OK\nContent-type: text/css\n\nbody {background-color: #ffccdd;}" ;
#line 333 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *CSSgreen = "HTTP/1.1 200 OK\nContent-type: text/css\n\nbody {background-color: #ddffcc;}" ;
#line 346 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLheader = "HTTP/1.1 200 OK\nContent-type: text/html\n\n<HTML><HEAD><TITLE>PME Clock</TITLE></HEAD><BODY><link rel=\"stylesheet\" type=\"text/css\" href=\"/s.css\"><center><h2>PME Clock</h2>" ;
#line 358 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLtime = "<h3>Time | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3><script src=/a></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Date and Time</td><td align=right><script>document.write(NOW)</script></td></tr><tr><td>Unix Epoch</td><td align=right><script>document.write(EPOCH)</script></td></tr><tr><td>Julian Day</td><td align=right><script>document.write(EPOCH / 24 / 3600 + 2440587.5)</script></td></tr><tr><td>Last sync</td><td align=right><script>document.write(LAST)</script></td></tr>" ;
#line 373 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLsntp = "<h3><a href=/>Time</a> | SNTP | <a href=/3>Network</a> | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3><script src=/b></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Server</td><td align=right><script>document.write(SNTP)</script></td></tr><tr><td>Leap</td><td align=right><script>document.write(LEAP)</script></td></tr><tr><td>Version</td><td align=right><script>document.write(VN)</script></td></tr><tr><td>Mode</td><td align=right><script>document.write(MODE)</script></td></tr><tr><td>Stratum</td><td align=right><script>document.write(STRATUM)</script></td></tr><tr><td>Precision</td><td align=right><script>document.write(Math.pow(2, PRECISION - 256))</script></td></tr>" ;
#line 387 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLnetwork = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | Network | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3><script src=/c></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Clock IP</td><td align=right><script>document.write(IP)</script></td></tr><tr><td>Clock MAC</td><td align=right><script>document.write(MAC)</script></td></tr><tr><td>Network Mask</td><td align=right><script>document.write(MASK)</script></td></tr><tr><td>Gateway</td><td align=right><script>document.write(GW)</script></td></tr><tr><td>DNS</td><td align=right><script>document.write(DNS)</script></td></tr><tr><td>Your IP</td><td align=right><script>document.write(CLIENT)</script></td></tr>" ;
#line 400 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLsystem = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | System | <a href=/admin>ADMIN</a></h3><script src=/d></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Ethernet device</td><td align=right><script>document.write(SYSTEM)</script></td></tr><tr><td>Fosc</td><td align=right><script>document.write(CLK/1000)</script> Mhz</td></tr><tr><td>Up Since</td><td align=right><script>document.write(UP)</script></td></tr><tr><td>HTTP Request #</td><td align=right><script>document.write(REQ)</script></td></tr>" ;
#line 420 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLredirect = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3><script>document.location.replace(\"/admin\")</script>" ;
#line 427 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLadmin0 = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3><script src=/admin/s></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000><tr> <td>Password</td> <td><script>document.write(PASS)</script></td> </tr>" ;
#line 439 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLadmin1 = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3><script src=/admin/s></script><meta http-equiv=\"refresh\" content=\"180\" /><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000><tr> <td>Password</td> <td><script>document.write(PASS0)</script></td> <td><script>document.write(PASS1)</script></td> <td align=center><a href=/admin/w>Update password</a></td> </tr><tr><td>Select</td><td align=right><script>document.write(SIP)</script></td></tr><tr><td>DHCP</td><td align=right><script>document.write(DHCPEN)</script></td></tr><tr> <td>IP Address</td> <td><script>document.write(IP0)</script></td> <td><script>document.write(IP1)</script></td> <td><script>document.write(IP2)</script></td> <td><script>document.write(IP3)</script></td> </tr><tr><td>Update IP</td><td align=right><a href=/admin/r>now</a></td></tr>" ;
#line 451 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLadmin2 = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3><script src=/admin/s></script><meta http-equiv=\"refresh\" content=\"180\" /><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000><tr> <td>Password</td> <td><script>document.write(PASS0)</script></td> <td><script>document.write(PASS1)</script></td> <td align=center><a href=/admin/w>Update password</a></td> </tr><tr><td>Select</td><td align=right><script>document.write(SIP)</script></td></tr><tr><td>DHCP</td><td align=right><script>document.write(DHCPEN)</script></td></tr><tr><td>Mask</td><td><script>document.write(M0)</script></td><td><script>document.write(M1)</script></td><td><script>document.write(M2)</script></td><td><script>document.write(M3)</script></td></tr><tr><td>Update IP</td><td align=right><a href=/admin/r>now</a></td></tr>" ;
#line 463 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLadmin3 = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3><script src=/admin/s></script><meta http-equiv=\"refresh\" content=\"180\" /><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000><tr> <td>Password</td> <td><script>document.write(PASS0)</script></td> <td><script>document.write(PASS1)</script></td> <td align=center><a href=/admin/w>Update password</a></td> </tr><tr><td>Select</td><td align=right><script>document.write(SIP)</script></td></tr><tr><td>DHCP</td><td align=right><script>document.write(DHCPEN)</script></td></tr><tr><td>Gateway</td><td><script>document.write(G0)</script></td><td><script>document.write(G1)</script></td><td><script>document.write(G2)</script></td><td><script>document.write(G3)</script></td></tr><tr><td>Update IP</td><td align=right><a href=/admin/r>now</a></td></tr>" ;
#line 475 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLadmin4 = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3><script src=/admin/s></script><meta http-equiv=\"refresh\" content=\"180\" /><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000><tr> <td>Password</td> <td><script>document.write(PASS0)</script></td> <td><script>document.write(PASS1)</script></td> <td align=center><a href=/admin/w>Update password</a></td> </tr><tr><td>Select</td><td align=right><script>document.write(SIP)</script></td></tr><tr><td>DHCP</td><td align=right><script>document.write(DHCPEN)</script></td></tr><tr><td>DNS Server</td><td><script>document.write(D0)</script></td><td><script>document.write(D1)</script></td><td><script>document.write(D2)</script></td><td><script>document.write(D3)</script></td></tr><tr><td>Update IP</td><td align=right><a href=/admin/r>now</a></td></tr>" ;
#line 486 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
const char *HTMLfooter = "<HTML><HEAD></table><br>Pogledajte ceo proizvodni program na <a href=http://www.pme.rs target=_blank>www.pme.rs</a></center></BODY></HTML>" ;
#line 501 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
char lease_tmr = 0;
char lease_time = 0;

void Eth_Obrada() {
 if (conf.dhcpen == 0) {

 if (lease_time >= 60) {
 lease_time = 0;
 while (!SPI_Ethernet_renewDHCP(5))
 ;
 }
 }
 if (link == 1) {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 Spi_Ethernet_doPacket() ;

 }
}
#line 524 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
void saveConf()
 {
#line 537 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 }
#line 542 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 611 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
void DNSavings() {
 tmzn = 2;
#line 653 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
}
#line 658 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 705 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 724 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
void ts2str(unsigned char *s, TimeStruct *t, unsigned char m)
 {
 unsigned char tmp[6] ;
#line 731 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 761 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 787 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 801 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
unsigned char nibble2hex(unsigned char n)
 {
 n &= 0x0f ;
 if(n >= 0x0a)
 {
 return(n + '7') ;
 }
 return(n + '0') ;
 }
#line 814 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
void byte2hex(unsigned char *s, unsigned char v)
 {
 *s++ = nibble2hex(v >> 4) ;
 *s++ = nibble2hex(v) ;
 *s = '.' ;
 }
#line 824 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
unsigned int mkLCDselect(unsigned char l, unsigned char m)
 {
 unsigned char i ;
 unsigned int len ;

 len =  SPI_Ethernet_putConstString ("<select onChange=\\\"document.location.href = '/admin/") ;
 SPI_Ethernet_putByte('0' + l) ; len++ ;
 len +=  SPI_Ethernet_putConstString ("/' + this.selectedIndex\\\">") ;
 for(i = 0 ; i < 2 ; i++)
 {
 len +=  SPI_Ethernet_putConstString ("<option ") ;
 if(i == m)
 {
 len +=  SPI_Ethernet_putConstString (" selected") ;
 }
 len +=  SPI_Ethernet_putConstString (">") ;
 len +=  SPI_Ethernet_putConstString (LCDoption[i]) ;
 }
 len +=  SPI_Ethernet_putConstString ("</select>\";") ;
 return(len) ;
 }
#line 849 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 902 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
void mkSNTPrequest()
 {
 unsigned char sntpPkt[50];
 unsigned char * remoteIpAddr;

 if (sntpSync)
 if (SPI_Ethernet_UserTimerSec >= sntpTimer)
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
 if(remoteIpAddr = SPI_Ethernet_dnsResolve(conf.sntpServer, 5))
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
#line 959 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 memset(sntpPkt, 0, 48) ;


 sntpPkt[0] = 0b00011001 ;




 sntpPkt[2] = 0x0a ;


 sntpPkt[3] = 0xfa ;


 sntpPkt[6] = 0x44 ;


 sntpPkt[9] = 0x10 ;
#line 988 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 SPI_Ethernet_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48) ;

 sntpSync = 1 ;
 lastSync = 0 ;
 sntpTimer = SPI_Ethernet_UserTimerSec + 2;
 }

void Rst_Eth() {
 SPI_Ethernet_Rst = 0;
 reset_eth = 1;

}
#line 1004 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
 {
 unsigned char dyna[64] ;
 unsigned char getRequest[ 128  + 1] ;

 unsigned int len = 0 ;
 int i ;

 char fbr;






 if (localPort != 80)
 {
 return(0) ;
 }
#line 1027 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 if (HTTP_getRequest(getRequest, &reqLength,  128 ) == 0)
 {
 return(0) ;
 }
#line 1036 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 if(memcmp(getRequest, path_private, sizeof(path_private) - 1) == 0)
 {

 unsigned char *ptr ;


 ptr = getRequest + sizeof(path_private) - 1;










 if(getRequest[sizeof(path_private)] == 's')
 {


 len =  SPI_Ethernet_putConstString (httpHeader) ;
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript) ;

 if (admin == 0) {


 len +=  SPI_Ethernet_putConstString ("var PASS=\"") ;
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString ("password") ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/v/' + this.value\\\" value=\\\"") ;
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;

 } else {

 uzobyte = 1;

 len +=  SPI_Ethernet_putConstString ("var DHCPEN=\"") ;
 len += mkLCDselect(1, conf.dhcpen) ;
#line 1087 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 len +=  SPI_Ethernet_putConstString ("var PASS0=\"") ;
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (oldSifra) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/x/' + this.value\\\" value=\\\"") ;
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;


 len +=  SPI_Ethernet_putConstString ("var PASS1=\"") ;
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (newSifra) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/y/' + this.value\\\" value=\\\"") ;
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
#line 1152 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 if (conf.dhcpen == 1) {

 len +=  SPI_Ethernet_putConstString ("var SIP=\"") ;
 len +=  SPI_Ethernet_putConstString ("<select onChange=\\\"document.location.href = '/admin/u/' + this.selectedIndex\\\">") ;
 for(i = 1 ; i < 5 ; i++)
 {
 len +=  SPI_Ethernet_putConstString ("<option ") ;
 if(i == s_ip)
 {
 len +=  SPI_Ethernet_putConstString (" selected") ;
 }
 len +=  SPI_Ethernet_putConstString (">") ;
 len +=  SPI_Ethernet_putConstString (IPoption[i-1]) ;


 }
 len +=  SPI_Ethernet_putConstString ("</select>\";") ;
 } else {
 s_ip = 1;
 }

 if (s_ip == 1) {

 len +=  SPI_Ethernet_putConstString ("var IP0=\"") ;
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (ipAddrPom0) ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
 }
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString (">\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var IP1=\"") ;
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (ipAddrPom1) ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
 }
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString (">\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var IP2=\"") ;
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (ipAddrPom2) ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
 }
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString (">\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var IP3=\"") ;
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (ipAddrPom3) ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
 }
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString (">\";") ;
 }
 }

 if (s_ip == 2) {

 len +=  SPI_Ethernet_putConstString ("var M0=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (ipMaskPom0) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var M1=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (ipMaskPom1) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var M2=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (ipMaskPom2) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var M3=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (ipMaskPom3) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }
 }

 if (s_ip == 3) {

 len +=  SPI_Ethernet_putConstString ("var G0=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (gwIpAddrPom0) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var G1=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (gwIpAddrPom1) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var G2=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (gwIpAddrPom2) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var G3=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (gwIpAddrPom3) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }
 }

 if (s_ip == 4) {

 len +=  SPI_Ethernet_putConstString ("var D0=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (dnsIpAddrPom0) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var D1=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (dnsIpAddrPom1) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var D2=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (dnsIpAddrPom2) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }

 len +=  SPI_Ethernet_putConstString ("var D3=\"") ;
 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("<input placeholder=") ;
 len +=  SPI_Ethernet_putString (dnsIpAddrPom3) ;
 len +=  SPI_Ethernet_putConstString (" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
 }


 if (conf.dhcpen == 1) {
 len +=  SPI_Ethernet_putConstString ("\\\">\" ;") ;
 } else {
 len +=  SPI_Ethernet_putConstString ("\";") ;
 }
 }

 }

 }
 else
 {

 switch(getRequest[sizeof(path_private)])
 {
 case '1' :

 conf.dhcpen = getRequest[sizeof(path_private) + 2] - '0' ;
 EEPROM_Write(103, conf.dhcpen);
 delay_ms(100);
 Rst_Eth();
 saveConf() ;
 break ;
#line 1421 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 case 'r':

 if (conf.dhcpen == 1) {


 if ( (ipAddrPom0[0] >= '1') && (ipAddrPom0[0] <= '9') && (ipAddrPom0[1] >= '0') && (ipAddrPom0[1] <= '9') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
 EEPROM_Write(1, (ipAddrPom0[0]-48)*100 + (ipAddrPom0[1]-48)*10 + (ipAddrPom0[2]-48));
 }
 if ( (ipAddrPom0[0] < '1') && (ipAddrPom0[1] >= '1') && (ipAddrPom0[1] <= '9') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
 EEPROM_Write(1, (ipAddrPom0[1]-48)*10 + (ipAddrPom0[2]-48));
 }
 if ( (ipAddrPom0[0] < '1') && (ipAddrPom0[1] < '1') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
 EEPROM_Write(1, (ipAddrPom0[2]-48));
 }

 if ( (ipAddrPom1[0] >= '1') && (ipAddrPom1[0] <= '9') && (ipAddrPom1[1] >= '0') && (ipAddrPom1[1] <= '9') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
 EEPROM_Write(2, (ipAddrPom1[0]-48)*100 + (ipAddrPom1[1]-48)*10 + (ipAddrPom1[2]-48));
 }
 if ( (ipAddrPom1[0] < '1') && (ipAddrPom1[1] >= '1') && (ipAddrPom1[1] <= '9') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
 EEPROM_Write(2, (ipAddrPom1[1]-48)*10 + (ipAddrPom1[2]-48));
 }
 if ( (ipAddrPom1[0] < '1') && (ipAddrPom1[1] < '1') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
 EEPROM_Write(2, (ipAddrPom1[2]-48));
 }

 if ( (ipAddrPom2[0] >= '1') && (ipAddrPom2[0] <= '9') && (ipAddrPom2[1] >= '0') && (ipAddrPom2[1] <= '9') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
 EEPROM_Write(3, (ipAddrPom2[0]-48)*100 + (ipAddrPom2[1]-48)*10 + (ipAddrPom2[2]-48));
 }
 if ( (ipAddrPom2[0] < '1') && (ipAddrPom2[1] >= '1') && (ipAddrPom2[1] <= '9') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
 EEPROM_Write(3, (ipAddrPom2[1]-48)*10 + (ipAddrPom2[2]-48));
 }
 if ( (ipAddrPom2[0] < '1') && (ipAddrPom2[1] < '1') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
 EEPROM_Write(3, (ipAddrPom2[2]-48));
 }

 if ( (ipAddrPom3[0] >= '1') && (ipAddrPom3[0] <= '9') && (ipAddrPom3[1] >= '0') && (ipAddrPom3[1] <= '9') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
 EEPROM_Write(4, (ipAddrPom3[0]-48)*100 + (ipAddrPom3[1]-48)*10 + (ipAddrPom3[2]-48));
 }
 if ( (ipAddrPom3[0] < '1') && (ipAddrPom3[1] >= '1') && (ipAddrPom3[1] <= '9') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
 EEPROM_Write(4, (ipAddrPom3[1]-48)*10 + (ipAddrPom3[2]-48));
 }
 if ( (ipAddrPom3[0] < '1') && (ipAddrPom3[1] < '1') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
 EEPROM_Write(4, (ipAddrPom3[2]-48));
 }


 if ( (gwIpAddrPom0[0] >= '1') && (gwIpAddrPom0[0] <= '9') && (gwIpAddrPom0[1] >= '0') && (gwIpAddrPom0[1] <= '9') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
 EEPROM_Write(5, (gwIpAddrPom0[0]-48)*100 + (gwIpAddrPom0[1]-48)*10 + (gwIpAddrPom0[2]-48));
 }
 if ( (gwIpAddrPom0[0] < '1') && (gwIpAddrPom0[1] >= '1') && (gwIpAddrPom0[1] <= '9') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
 EEPROM_Write(5, (gwIpAddrPom0[1]-48)*10 + (gwIpAddrPom0[2]-48));
 }
 if ( (gwIpAddrPom0[0] < '1') && (gwIpAddrPom0[1] < '1') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
 EEPROM_Write(5, (gwIpAddrPom0[2]-48));
 }

 if ( (gwIpAddrPom1[0] >= '1') && (gwIpAddrPom1[0] <= '9') && (gwIpAddrPom1[1] >= '0') && (gwIpAddrPom1[1] <= '9') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
 EEPROM_Write(6, (gwIpAddrPom1[0]-48)*100 + (gwIpAddrPom1[1]-48)*10 + (gwIpAddrPom1[2]-48));
 }
 if ( (gwIpAddrPom1[0] < '1') && (gwIpAddrPom1[1] >= '1') && (gwIpAddrPom1[1] <= '9') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
 EEPROM_Write(6, (gwIpAddrPom1[1]-48)*10 + (gwIpAddrPom1[2]-48));
 }
 if ( (gwIpAddrPom1[0] < '1') && (gwIpAddrPom1[1] < '1') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
 EEPROM_Write(6, (gwIpAddrPom1[2]-48));
 }

 if ( (gwIpAddrPom2[0] >= '1') && (gwIpAddrPom2[0] <= '9') && (gwIpAddrPom2[1] >= '0') && (gwIpAddrPom2[1] <= '9') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
 EEPROM_Write(7, (gwIpAddrPom2[0]-48)*100 + (gwIpAddrPom2[1]-48)*10 + (gwIpAddrPom2[2]-48));
 }
 if ( (gwIpAddrPom2[0] < '1') && (gwIpAddrPom2[1] >= '1') && (gwIpAddrPom2[1] <= '9') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
 EEPROM_Write(7, (gwIpAddrPom2[1]-48)*10 + (gwIpAddrPom2[2]-48));
 }
 if ( (gwIpAddrPom2[0] < '1') && (gwIpAddrPom2[1] < '1') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
 EEPROM_Write(7, (gwIpAddrPom2[2]-48));
 }

 if ( (gwIpAddrPom3[0] >= '1') && (gwIpAddrPom3[0] <= '9') && (gwIpAddrPom3[1] >= '0') && (gwIpAddrPom3[1] <= '9') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
 EEPROM_Write(8, (gwIpAddrPom3[0]-48)*100 + (gwIpAddrPom3[1]-48)*10 + (gwIpAddrPom3[2]-48));
 }
 if ( (gwIpAddrPom3[0] < '1') && (gwIpAddrPom3[1] >= '1') && (gwIpAddrPom3[1] <= '9') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
 EEPROM_Write(8, (gwIpAddrPom3[1]-48)*10 + (gwIpAddrPom3[2]-48));
 }
 if ( (gwIpAddrPom3[0] < '1') && (gwIpAddrPom3[1] < '1') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
 EEPROM_Write(8, (gwIpAddrPom3[2]-48));
 }


 if ( (ipMaskPom0[0] >= '1') && (ipMaskPom0[0] <= '9') && (ipMaskPom0[1] >= '0') && (ipMaskPom0[1] <= '9') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
 EEPROM_Write(9, (ipMaskPom0[0]-48)*100 + (ipMaskPom0[1]-48)*10 + (ipMaskPom0[2]-48));
 }
 if ( (ipMaskPom0[0] < '1') && (ipMaskPom0[1] >= '1') && (ipMaskPom0[1] <= '9') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
 EEPROM_Write(9, (ipMaskPom0[1]-48)*10 + (ipMaskPom0[2]-48));
 }
 if ( (ipMaskPom0[0] < '1') && (ipMaskPom0[1] < '1') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
 EEPROM_Write(9, (ipMaskPom0[2]-48));
 }

 if ( (ipMaskPom1[0] >= '1') && (ipMaskPom1[0] <= '9') && (ipMaskPom1[1] >= '0') && (ipMaskPom1[1] <= '9') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
 EEPROM_Write(10, (ipMaskPom1[0]-48)*100 + (ipMaskPom1[1]-48)*10 + (ipMaskPom1[2]-48));
 }
 if ( (ipMaskPom1[0] < '1') && (ipMaskPom1[1] >= '1') && (ipMaskPom1[1] <= '9') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
 EEPROM_Write(10, (ipMaskPom1[1]-48)*10 + (ipMaskPom1[2]-48));
 }
 if ( (ipMaskPom1[0] < '1') && (ipMaskPom1[1] < '1') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
 EEPROM_Write(10, (ipMaskPom1[2]-48));
 }

 if ( (ipMaskPom2[0] >= '1') && (ipMaskPom2[0] <= '9') && (ipMaskPom2[1] >= '0') && (ipMaskPom2[1] <= '9') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
 EEPROM_Write(11, (ipMaskPom2[0]-48)*100 + (ipMaskPom2[1]-48)*10 + (ipMaskPom2[2]-48));
 }
 if ( (ipMaskPom2[0] < '1') && (ipMaskPom2[1] >= '1') && (ipMaskPom2[1] <= '9') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
 EEPROM_Write(11, (ipMaskPom2[1]-48)*10 + (ipMaskPom2[2]-48));
 }
 if ( (ipMaskPom2[0] < '1') && (ipMaskPom2[1] < '1') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
 EEPROM_Write(11, (ipMaskPom2[2]-48));
 }

 if ( (ipMaskPom3[0] >= '1') && (ipMaskPom3[0] <= '9') && (ipMaskPom3[1] >= '0') && (ipMaskPom3[1] <= '9') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
 EEPROM_Write(12, (ipMaskPom3[0]-48)*100 + (ipMaskPom3[1]-48)*10 + (ipMaskPom3[2]-48));
 }
 if ( (ipMaskPom3[0] < '1') && (ipMaskPom3[1] >= '1') && (ipMaskPom3[1] <= '9') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
 EEPROM_Write(12, (ipMaskPom3[1]-48)*10 + (ipMaskPom3[2]-48));
 }
 if ( (ipMaskPom3[0] < '1') && (ipMaskPom3[1] < '1') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
 EEPROM_Write(12, (ipMaskPom3[2]-48));
 }


 if ( (dnsIpAddrPom0[0] >= '1') && (dnsIpAddrPom0[0] <= '9') && (dnsIpAddrPom0[1] >= '0') && (dnsIpAddrPom0[1] <= '9') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
 EEPROM_Write(13, (dnsIpAddrPom0[0]-48)*100 + (dnsIpAddrPom0[1]-48)*10 + (dnsIpAddrPom0[2]-48));
 }
 if ( (dnsIpAddrPom0[0] < '1') && (dnsIpAddrPom0[1] >= '1') && (dnsIpAddrPom0[1] <= '9') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
 EEPROM_Write(13, (dnsIpAddrPom0[1]-48)*10 + (dnsIpAddrPom0[2]-48));
 }
 if ( (dnsIpAddrPom0[0] < '1') && (dnsIpAddrPom0[1] < '1') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
 EEPROM_Write(13, (dnsIpAddrPom0[2]-48));
 }

 if ( (dnsIpAddrPom1[0] >= '1') && (dnsIpAddrPom1[0] <= '9') && (dnsIpAddrPom1[1] >= '0') && (dnsIpAddrPom1[1] <= '9') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
 EEPROM_Write(14, (dnsIpAddrPom1[0]-48)*100 + (dnsIpAddrPom1[1]-48)*10 + (dnsIpAddrPom1[2]-48));
 }
 if ( (dnsIpAddrPom1[0] < '1') && (dnsIpAddrPom1[1] >= '1') && (dnsIpAddrPom1[1] <= '9') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
 EEPROM_Write(14, (dnsIpAddrPom1[1]-48)*10 + (dnsIpAddrPom1[2]-48));
 }
 if ( (dnsIpAddrPom1[0] < '1') && (dnsIpAddrPom1[1] < '1') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
 EEPROM_Write(14, (dnsIpAddrPom1[2]-48));
 }

 if ( (dnsIpAddrPom2[0] >= '1') && (dnsIpAddrPom2[0] <= '9') && (dnsIpAddrPom2[1] >= '0') && (dnsIpAddrPom2[1] <= '9') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
 EEPROM_Write(15, (dnsIpAddrPom2[0]-48)*100 + (dnsIpAddrPom2[1]-48)*10 + (dnsIpAddrPom2[2]-48));
 }
 if ( (dnsIpAddrPom2[0] < '1') && (dnsIpAddrPom2[1] >= '1') && (dnsIpAddrPom2[1] <= '9') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
 EEPROM_Write(15, (dnsIpAddrPom2[1]-48)*10 + (dnsIpAddrPom2[2]-48));
 }
 if ( (dnsIpAddrPom2[0] < '1') && (dnsIpAddrPom2[1] < '1') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
 EEPROM_Write(15, (dnsIpAddrPom2[2]-48));
 }

 if ( (dnsIpAddrPom3[0] >= '1') && (dnsIpAddrPom3[0] <= '9') && (dnsIpAddrPom3[1] >= '0') && (dnsIpAddrPom3[1] <= '9') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
 EEPROM_Write(16, (dnsIpAddrPom3[0]-48)*100 + (dnsIpAddrPom3[1]-48)*10 + (dnsIpAddrPom3[2]-48));
 }
 if ( (dnsIpAddrPom3[0] < '1') && (dnsIpAddrPom3[1] >= '1') && (dnsIpAddrPom3[1] <= '9') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
 EEPROM_Write(16, (dnsIpAddrPom3[1]-48)*10 + (dnsIpAddrPom3[2]-48));
 }
 if ( (dnsIpAddrPom3[0] < '1') && (dnsIpAddrPom3[1] < '1') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
 EEPROM_Write(16, (dnsIpAddrPom3[2]-48));
 }
 delay_ms(100);
 Rst_Eth();
 }
 break ;
 case 'n':

 if (conf.dhcpen == 1) {
 if (s_ip == 1) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,IpAddrPom0);
 }
 if (s_ip == 2) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,ipMaskPom0);
 }
 if (s_ip == 3) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,gwIpAddrPom0);
 }
 if (s_ip == 4) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,dnsIpAddrPom0);
 }
 }
 break ;
 case 'o':

 if (conf.dhcpen == 1) {
 if (s_ip == 1) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,IpAddrPom1);
 }
 if (s_ip == 2) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,ipMaskPom1);
 }
 if (s_ip == 3) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,gwIpAddrPom1);
 }
 if (s_ip == 4) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,dnsIpAddrPom1);
 }
 }
 break ;
 case 'p':

 if (conf.dhcpen == 1) {
 if (s_ip == 1) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,IpAddrPom2);
 }
 if (s_ip == 2) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,ipMaskPom2);
 }
 if (s_ip == 3) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,gwIpAddrPom2);
 }
 if (s_ip == 4) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,dnsIpAddrPom2);
 }
 }
 break ;
 case 'q':

 if (conf.dhcpen == 1) {
 if (s_ip == 1) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,IpAddrPom3);
 }
 if (s_ip == 2) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,ipMaskPom3);
 }
 if (s_ip == 3) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,gwIpAddrPom3);
 }
 if (s_ip == 4) {
 pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
 ByteToStr(pomocni,dnsIpAddrPom3);
 }
 }
 break ;
 case 'v':


 pomocnaSifra[0] = getRequest[sizeof(path_private) + 2] ;
 pomocnaSifra[1] = getRequest[sizeof(path_private) + 3] ;
 pomocnaSifra[2] = getRequest[sizeof(path_private) + 4] ;
 pomocnaSifra[3] = getRequest[sizeof(path_private) + 5] ;
 pomocnaSifra[4] = getRequest[sizeof(path_private) + 6] ;
 pomocnaSifra[5] = getRequest[sizeof(path_private) + 7] ;
 pomocnaSifra[6] = getRequest[sizeof(path_private) + 8] ;
 pomocnaSifra[7] = getRequest[sizeof(path_private) + 9] ;
 pomocnaSifra[8] = 0;
 if (strcmp(sifra,pomocnaSifra) == 0) {
 tmr_rst_en = 1;
 admin = 1;
 len = 0;
 len +=  SPI_Ethernet_putConstString (HTMLheader) ;
 len +=  SPI_Ethernet_putConstString (HTMLredirect) ;
 len +=  SPI_Ethernet_putConstString (HTMLfooter) ;
 goto ZAVRSI;

 }
 break ;
 case 'x':


 oldSifra[0] = getRequest[sizeof(path_private) + 2] ;
 oldSifra[1] = getRequest[sizeof(path_private) + 3] ;
 oldSifra[2] = getRequest[sizeof(path_private) + 4] ;
 oldSifra[3] = getRequest[sizeof(path_private) + 5] ;
 oldSifra[4] = getRequest[sizeof(path_private) + 6] ;
 oldSifra[5] = getRequest[sizeof(path_private) + 7] ;
 oldSifra[6] = getRequest[sizeof(path_private) + 8] ;
 oldSifra[7] = getRequest[sizeof(path_private) + 9] ;
 oldSifra[8] = 0;
 break ;
 case 'y':


 newSifra[0] = getRequest[sizeof(path_private) + 2] ;
 newSifra[1] = getRequest[sizeof(path_private) + 3] ;
 newSifra[2] = getRequest[sizeof(path_private) + 4] ;
 newSifra[3] = getRequest[sizeof(path_private) + 5] ;
 newSifra[4] = getRequest[sizeof(path_private) + 6] ;
 newSifra[5] = getRequest[sizeof(path_private) + 7] ;
 newSifra[6] = getRequest[sizeof(path_private) + 8] ;
 newSifra[7] = getRequest[sizeof(path_private) + 9] ;
 newSifra[8] = 0;
 break ;
#line 1747 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 case 'w' :
 if (strcmp(sifra, oldSifra) == 0) {
 rest = strcpy(sifra, newSifra);
 admin = 0;
 }
 EEPROM_Write(20, sifra[0]);
 EEPROM_Write(21, sifra[1]);
 EEPROM_Write(22, sifra[2]);
 EEPROM_Write(23, sifra[3]);
 EEPROM_Write(24, sifra[4]);
 EEPROM_Write(25, sifra[5]);
 EEPROM_Write(26, sifra[6]);
 EEPROM_Write(27, sifra[7]);
 EEPROM_Write(28, sifra[8]);
 strcpy(oldSifra, "OLD     ");
 strcpy(newSifra, "NEW     ");
 delay_ms(100);
 break ;
 case 'u':
 if (conf.dhcpen == 1) {
 s_ip = atoi(&getRequest[sizeof(path_private) + 2]) ;
 s_ip += 1 ;
 }
 saveConf() ;
 break ;
#line 1778 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
 case 't':

 conf.tz = atoi(&getRequest[sizeof(path_private) + 2]) ;
 conf.tz -= 11 ;
 Eeprom_Write(102, conf.tz);
 delay_ms(100);
 break ;
 }

 len +=  SPI_Ethernet_putConstString (HTMLheader) ;
 if (admin == 0) {
 len +=  SPI_Ethernet_putConstString (HTMLadmin0);
 } else {
 if (s_ip == 1) {
 len +=  SPI_Ethernet_putConstString (HTMLadmin1) ;
 }
 if (s_ip == 2) {
 len +=  SPI_Ethernet_putConstString (HTMLadmin2) ;
 }
 if (s_ip == 3) {
 len +=  SPI_Ethernet_putConstString (HTMLadmin3) ;
 }
 if (s_ip == 4) {
 len +=  SPI_Ethernet_putConstString (HTMLadmin4) ;
 }
 }
 len +=  SPI_Ethernet_putConstString (HTMLfooter) ;
 }

 }
 else switch(getRequest[1])
 {

 case 's':

 if(lastSync == 0)
 {
 len =  SPI_Ethernet_putConstString (CSSred) ;
 }
 else
 {
 len =  SPI_Ethernet_putConstString (CSSgreen) ;
 }
 break ;
 case 'a':


 len =  SPI_Ethernet_putConstString (httpHeader) ;
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript) ;


 ts2str(dyna, &ts,  ( 1  | 2 )  |  4 ) ;
 len +=  SPI_Ethernet_putConstString ("var NOW=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;


 int2str(epoch, dyna) ;
 len +=  SPI_Ethernet_putConstString ("var EPOCH=") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString (";") ;


 if(lastSync == 0)
 {
 strcpy(dyna, "???") ;
 }
 else
 {
 Time_epochToDate(lastSync + tmzn * 3600, &ls) ;
 DNSavings();
 ts2str(dyna, &ls,  ( 1  | 2 )  |  4 ) ;
 }
 len +=  SPI_Ethernet_putConstString ("var LAST=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;

 break ;

 case 'b':


 len =  SPI_Ethernet_putConstString (httpHeader) ;
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript) ;


 ip2str(dyna, conf.sntpIP) ;
 len +=  SPI_Ethernet_putConstString ("var SNTP=\"") ;
 len +=  SPI_Ethernet_putString (conf.sntpServer) ;
 len +=  SPI_Ethernet_putConstString (" (") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString (")") ;
 len +=  SPI_Ethernet_putConstString ("\";") ;


 if(serverStratum == 0)
 {
 strcpy(dyna, "Unspecified") ;
 }
 else if(serverStratum == 1)
 {
 strcpy(dyna, "1 (primary)") ;
 }
 else if(serverStratum < 16)
 {
 int2str(serverStratum, dyna) ;
 strcat(dyna, "(secondary)") ;
 }
 else
 {
 int2str(serverStratum, dyna) ;
 strcat(dyna, " (reserved)") ;
 }
 len +=  SPI_Ethernet_putConstString ("var STRATUM=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;


 switch(serverFlags & 0b11000000)
 {
 case 0b00000000: strcpy(dyna, "No warning") ; break ;
 case 0b01000000: strcpy(dyna, "Last minute has 61 seconds") ; break ;
 case 0b10000000: strcpy(dyna, "Last minute has 59 seconds") ; break ;
 case 0b11000000: strcpy(dyna, "SNTP server not synchronized") ; break ;
 }
 len +=  SPI_Ethernet_putConstString ("var LEAP=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;

 int2str(serverPrecision, dyna) ;
 len +=  SPI_Ethernet_putConstString ("var PRECISION=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;

 switch(serverFlags & 0b00111000)
 {
 case 0b00011000: strcpy(dyna, "IPv4 only") ; break ;
 case 0b00110000: strcpy(dyna, "IPv4, IPv6 and OSI") ; break ;
 default: strcpy(dyna, "Undefined") ; break ;
 }
 len +=  SPI_Ethernet_putConstString ("var VN=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;

 switch(serverFlags & 0b00000111)
 {
 case 0b00000000: strcpy(dyna, "Reserved") ; break ;
 case 0b00000001: strcpy(dyna, "Symmetric active") ; break ;
 case 0b00000010: strcpy(dyna, "Symmetric passive") ; break ;
 case 0b00000011: strcpy(dyna, "Client") ; break ;
 case 0b00000100: strcpy(dyna, "Server") ; break ;
 case 0b00000101: strcpy(dyna, "Broadcast") ; break ;
 case 0b00000110: strcpy(dyna, "Reserved for NTP control message") ; break ;
 case 0b00000111: strcpy(dyna, "Reserved for private use") ; break ;
 }
 len +=  SPI_Ethernet_putConstString ("var MODE=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;

 break ;

 case 'c':


 len =  SPI_Ethernet_putConstString (httpHeader) ;
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript) ;


 ip2str(dyna, ipAddr) ;
 len +=  SPI_Ethernet_putConstString ("var IP=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;

 byte2hex(dyna, macAddr[0]) ;
 byte2hex(dyna + 3, macAddr[1]) ;
 byte2hex(dyna + 6, macAddr[2]) ;
 byte2hex(dyna + 9, macAddr[3]) ;
 byte2hex(dyna + 12, macAddr[4]) ;
 byte2hex(dyna + 15, macAddr[5]) ;
 *(dyna + 17) = 0 ;
 len +=  SPI_Ethernet_putConstString ("var MAC=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;


 ip2str(dyna, remoteHost) ;
 len +=  SPI_Ethernet_putConstString ("var CLIENT=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;


 ip2str(dyna, gwIpAddr) ;
 len +=  SPI_Ethernet_putConstString ("var GW=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;


 ip2str(dyna, ipMask) ;
 len +=  SPI_Ethernet_putConstString ("var MASK=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;


 ip2str(dyna, dnsIpAddr) ;
 len +=  SPI_Ethernet_putConstString ("var DNS=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;

 break ;

 case 'd':
 {

 TimeStruct t ;

 len =  SPI_Ethernet_putConstString (httpHeader) ;
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript) ;

 len +=  SPI_Ethernet_putConstString ("var SYSTEM=\"ENC28J60\";") ;

 int2str(Clock_kHz(), dyna) ;
 len +=  SPI_Ethernet_putConstString ("var CLK=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;


 int2str(httpCounter, dyna) ;
 len +=  SPI_Ethernet_putConstString ("var REQ=") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString (";") ;

 Time_epochToDate(epoch - SPI_Ethernet_UserTimerSec + tmzn * 3600, &t) ;
 DNSavings();
 ts2str(dyna, &t,  ( 1  | 2 )  |  4 ) ;
 len +=  SPI_Ethernet_putConstString ("var UP=\"") ;
 len +=  SPI_Ethernet_putString (dyna) ;
 len +=  SPI_Ethernet_putConstString ("\";") ;


 break ;
 }

 case '4':
 admin = 0;
 strcpy(oldSifra, "OLD     ");
 strcpy(newSifra, "NEW     ");

 len +=  SPI_Ethernet_putConstString (HTMLheader) ;
 len +=  SPI_Ethernet_putConstString (HTMLsystem) ;
 len +=  SPI_Ethernet_putConstString (HTMLfooter) ;
 break ;

 case '3':
 admin = 0;
 strcpy(oldSifra, "OLD     ");
 strcpy(newSifra, "NEW     ");

 len +=  SPI_Ethernet_putConstString (HTMLheader) ;
 len +=  SPI_Ethernet_putConstString (HTMLnetwork) ;
 len +=  SPI_Ethernet_putConstString (HTMLfooter) ;
 break ;

 case '2':
 admin = 0;
 strcpy(oldSifra, "OLD     ");
 strcpy(newSifra, "NEW     ");

 len +=  SPI_Ethernet_putConstString (HTMLheader) ;
 len +=  SPI_Ethernet_putConstString (HTMLsntp) ;
 len +=  SPI_Ethernet_putConstString (HTMLfooter) ;
 break ;

 case '1':
 default:
 if (uzobyte == 1) {
 uzobyte = 0;
 } else {
 admin = 0;
 strcpy(oldSifra, "OLD     ");
 strcpy(newSifra, "NEW     ");
 }

 len +=  SPI_Ethernet_putConstString (HTMLheader) ;
 len +=  SPI_Ethernet_putConstString (HTMLtime) ;
 len +=  SPI_Ethernet_putConstString (HTMLfooter) ;
 }

 httpCounter++ ;




 ZAVRSI:

 return(len) ;
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
 PRINT_S(Print_Seg(sec2, 0));
 PRINT_S(Print_Seg(sec1, 0));
 PRINT_S(Print_Seg(min2, 0));
 PRINT_S(Print_Seg(min1, 0));
 PRINT_S(Print_Seg(hr2, tacka1));
 PRINT_S(Print_Seg(hr1, tacka2));
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
#line 2246 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags)
 {
 unsigned char i ;
 char broadcmd[20];

 if (destPort == 10001) {
 if (reqLength == 9) {
 for (i = 0 ; i < 9 ; i++) {
 broadcmd[i] = SPI_Ethernet_getByte() ;
 }
 if ( (broadcmd[0] == 'I') && (broadcmd[1] == 'D') && (broadcmd[2] == 'E') && (broadcmd[3] == 'N') && (broadcmd[4] == 'T') && (broadcmd[5] == 'I') && (broadcmd[6] == 'F') && (broadcmd[7] == 'Y') && (broadcmd[8] == '!') ) {
 Print_IP();
 }
 }
 }

 if(destPort == 123)
 {
 if (reqLength == 48) {

 unsigned long tts ;

 serverFlags = SPI_Ethernet_getByte() ;
 serverStratum = SPI_Ethernet_getByte() ;
 SPI_Ethernet_getByte() ;
 serverPrecision = SPI_Ethernet_getByte() ;

 for(i = 0 ; i < 36 ; i++)
 {
 SPI_Ethernet_getByte() ;
 }


  ((char *)&tts)[3]  = SPI_Ethernet_getByte() ;
  ((char *)&tts)[2]  = SPI_Ethernet_getByte() ;
  ((char *)&tts)[1]  = SPI_Ethernet_getByte() ;
  ((char *)&tts)[0]  = SPI_Ethernet_getByte() ;


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



 SPI_Ethernet_UserTimerSec++ ;
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
#line 2535 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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

 SPI_Ethernet_Rst_Direction = 0;
 SPI_Ethernet_Rst = 0;
 SPI_Ethernet_CS_Direction = 0;
 SPI_Ethernet_CS = 0;

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
#line 2613 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
 SPI_Ethernet_Rst = 1;
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

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 Print_Pme();
 if (conf.dhcpen == 0) {
 Mem_Read();
 ipAddr[0] = 0;
 ipAddr[1] = 0;
 ipAddr[2] = 0;
 ipAddr[3] = 0;

 dhcp_flag = 1;
 EEPROM_Write(105, dhcp_flag);

 Spi_Ethernet_Init(macAddr, ipAddr,  1 ) ;

 while (SPI_Ethernet_initDHCP(5) == 0) ;
 memcpy(ipAddr, SPI_Ethernet_getIpAddress(), 4) ;
 memcpy(ipMask, SPI_Ethernet_getIpMask(), 4) ;
 memcpy(gwIpAddr, SPI_Ethernet_getGwIpAddress(), 4) ;
 memcpy(dnsIpAddr, SPI_Ethernet_getDnsIpAddress(), 4) ;

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
 Spi_Ethernet_Init(macAddr, ipAddr,  1 ) ;
 SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr) ;
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
#line 2932 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
#line 2956 "D:/Luka-Probe/MicroC/PoE sat - NOVA SEMA !!!!!!!/SE9M.c"
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
