#include "built_in.h"
#include "timelib.h"
#include "__EthJ60Private.h"
#include "__EthJ60.h"
#include "httpUtils.h"

#define Spi_Ethernet_HALFDUPLEX     0
#define Spi_Ethernet_FULLDUPLEX     1

///////////////////////// ETHERNET /////////////////////////////////////////////
sbit Eth1_Link at RB5_bit;
sbit SPI_Ethernet_Rst at RA5_bit;
sbit SPI_Ethernet_CS  at RA4_bit;
sbit Eth1_Link_Direction at TRISB5_bit;
sbit SPI_Ethernet_Rst_Direction at TRISA5_bit;
sbit SPI_Ethernet_CS_Direction  at TRISA4_bit;
///////////////////////// ETHERNET /////////////////////////////////////////////

///////////////////////// RS485 COMMUNICATION //////////////////////////////////
sbit Com_En              at RB0_bit;
sbit Com_En_Direction    at TRISB0_bit;
sbit Kom_En_1            at RB1_bit;
sbit Kom_En_1_Direction  at TRISB1_bit;
sbit Kom_En_2            at RB3_bit;
sbit Kom_En_2_Direction  at TRISB3_bit;
///////////////////////// RS485 COMMUNICATION //////////////////////////////////

///////////////////////// DISPLAY //////////////////////////////////////////////
sbit SV_DATA at RA1_bit;
sbit SV_CLK at RA2_bit;
sbit STROBE at RA3_bit;
sbit BCKL at RC2_bit;
sbit SV_DATA_Direction at TRISA1_bit;
sbit SV_CLK_Direction at TRISA2_bit;
sbit STROBE_Direction at TRISA3_bit;
sbit BCKL_Direction at TRISC2_bit;
///////////////////////// DISPLAY //////////////////////////////////////////////

///////////////////////// I2C / SPI ////////////////////////////////////////////
sbit MSSPEN at RE0_bit;
sbit MSSPEN_Direction at TRISE0_bit;
///////////////////////// I2C / SPI ////////////////////////////////////////////

///////////////////////// RESET CONFIGURATION //////////////////////////////////
sbit RSTPIN at RD4_bit;
sbit RSTPIN_Direction at TRISD4_bit;
///////////////////////// RESET CONFIGURATION //////////////////////////////////

///////////////////////// DISPLAY ON/OFF ///////////////////////////////////////
sbit DISPEN at RE2_bit;
sbit DISPEN_Direction at TRISE2_bit;
///////////////////////// DISPLAY ON/OFF ///////////////////////////////////////

/*
 * select either dynamic (with dhcp) network configuration, or static configuration
 */
// #define WITH_DHCP

/*
 * ts2str() mode flags
 */
#define TS2STR_DATE     1
#define TS2STR_TIME     2
#define TS2STR_TZ       4
#define TS2STR_ALL      (TS2STR_DATE | TS2STR_TIME)

/*
 * number of byte to parse in HTTP request
 */
#define HTTP_REQUEST_SIZE       128

/*
 * basic realm : admin private zone
 */
#define PRIVATE_LOGINPASSWD     "admin:clock"                           // user + password
#define ZONE_NAME               "Ethernal Clock administration"         // zone signature
#define MSG_DENIED              "Authorization Required"                // access denied message

/***********************************
 * RAM variables
 */
unsigned char   macAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f} ;   // my MAC address

//postavljanje pocetnih parametara mreze
unsigned char ipAddr[4]    = {192, 168, 1, 18} ;  // my ip addr
unsigned char gwIpAddr[4]  = {192, 168, 1, 1 } ;  // gateway (router) IP address
unsigned char ipMask[4]    = {255, 255, 255,  0 } ;  // network mask (for example : 255.255.255.0)
unsigned char dnsIpAddr[4] = {8, 8, 8, 8 } ;  // DNS server IP address

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
char oldSifra[9]     = "OLD     ";
char newSifra[9]     = "NEW     ";
unsigned char   admin = 0;
char uzobyte = 0;
char mode;
char server1[27];
char server2[27];
char server3[27];


TimeStruct      ts, ls ;                // timestruct for now and last update
long    epoch = 0 ;                     // unix time now
long    lastSync = 0 ;                  // unix time of last sntp update
unsigned long   sntpTimer = 0;         // sntp response timer
unsigned int    presTmr = 0 ;             // timer prescaler

unsigned char   bufInfo[200] ;          // LCD buffer
unsigned char   *marquee = 0;           // marquee pointer
unsigned char   lcdEvent = 0;           // marquee event flag
unsigned int    lcdTmr   = 0;           // marquee timer

unsigned char   sntpSync = 0 ;          // sntp sync flag
unsigned char   reloadDNS = 1 ;         // dns up to date flag
unsigned char   serverStratum = 0 ;     // sntp server stratum
unsigned char   serverFlags = 0 ;       // sntp server flags
char            serverPrecision = 0 ;   // sntp server precision
short           tmzn = 0;
char            txt[5];

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
//char connect_eth = 1;
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

/*
 * week day names
 */
unsigned char   *wday[] =
        {
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat",
        "Sun"
        } ;

/*
 * month names
 */
unsigned char   *mon[] =
        {
        "",     // skip number zero, time library counts months from 1 to 12
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

unsigned int  httpCounter = 0 ;                         // number of http requests
unsigned char path_private[]    = "/admin" ;            // private zone path name

const unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: " ;  // HTTP header
const unsigned char httpMimeTypeHTML[] = "text/html\n\n" ;              // HTML MIME type
const unsigned char httpMimeTypeScript[] = "text/plain\n\n" ;           // TEXT MIME type

/*
 * configuration structure
 */
struct
        {
        unsigned char   dhcpen ;                 // LCD line 1 message type
        unsigned char   lcdL2 ;                 // LCD line 2 message type
        short           tz ;                    // time zone (diff in hours to GMT)
        unsigned char   sntpIP[4] ;             // SNTP ip address
        unsigned char   sntpServer[128] ;       // SNTP host name
        } conf =
                {
                0,
                2,
                0,
                {0, 0, 0, 0},
                "swisstime.ethz.ch"             // Zurich, Switzerland: Integrated Systems Lab, Swiss Fed. Inst. of Technology
                                                // 129.132.2.21: swisstime.ethz.ch
                                                // Service Area: Switzerland and Europe
                } ;

/*
 * LCD message type options
 */
const unsigned char   *LCDoption[] =
        {
        "Enable",
        "Disable"
        } ;
        
const unsigned char   *IPoption[] =
        {
        "IPaddress",
        "Mask",
        "Gateway",
        "DNS server"
        } ;
        
const unsigned char   *MODEoption[] =
        {
        "Unicast",
        "Server 1",
        "Server 2",
        "Server 3"
        } ;


/*
 * stylesheets
 */
// clock not synchronized : red background
const char    *CSSred = "\
HTTP/1.1 200 OK\nContent-type: text/css\n\n\
body {background-color: #ffccdd;}\
" ;

// clock synchronized : green background
const char    *CSSgreen = "\
HTTP/1.1 200 OK\nContent-type: text/css\n\n\
body {background-color: #ddffcc;}\
" ;

/*
 * HTTP + HTML common header
 */
const char    *HTMLheader = "\
HTTP/1.1 200 OK\nContent-type: text/html\n\n\
<HTML><HEAD>\
<TITLE>PME Clock</TITLE>\
</HEAD><BODY>\
<link rel=\"stylesheet\" type=\"text/css\" href=\"/s.css\">\
<center>\
<h2>PME Clock</h2>\
" ;

/*
 * Time info
 */
const char      *HTMLtime = "\
<h3>Time | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3>\
<script src=/a></script>\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500>\
<tr><td>Date and Time</td><td align=right><script>document.write(NOW)</script></td></tr>\
<tr><td>Unix Epoch</td><td align=right><script>document.write(EPOCH)</script></td></tr>\
<tr><td>Julian Day</td><td align=right><script>document.write(EPOCH / 24 / 3600 + 2440587.5)</script></td></tr>\
<tr><td>Last sync</td><td align=right><script>document.write(LAST)</script></td></tr>" ;

/*
 * SNTP info
 */
const char      *HTMLsntp = "\
<h3><a href=/>Time</a> | SNTP | <a href=/3>Network</a> | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3>\
<script src=/b></script>\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500>\
<tr><td>Server</td><td align=right><script>document.write(SNTP)</script></td></tr>\
<tr><td>Leap</td><td align=right><script>document.write(LEAP)</script></td></tr>\
<tr><td>Version</td><td align=right><script>document.write(VN)</script></td></tr>\
<tr><td>Mode</td><td align=right><script>document.write(MODE)</script></td></tr>\
<tr><td>Stratum</td><td align=right><script>document.write(STRATUM)</script></td></tr>\
<tr><td>Precision</td><td align=right><script>document.write(Math.pow(2, PRECISION - 256))</script></td></tr>\
" ;

/*
 * Network info
 */
const char      *HTMLnetwork = "\
<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | Network | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3>\
<script src=/c></script>\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500>\
<tr><td>Clock IP</td><td align=right><script>document.write(IP)</script></td></tr>\
<tr><td>Clock MAC</td><td align=right><script>document.write(MAC)</script></td></tr>\
<tr><td>Network Mask</td><td align=right><script>document.write(MASK)</script></td></tr>\
<tr><td>Gateway</td><td align=right><script>document.write(GW)</script></td></tr>\
<tr><td>DNS</td><td align=right><script>document.write(DNS)</script></td></tr>\
<tr><td>Your IP</td><td align=right><script>document.write(CLIENT)</script></td></tr>" ;

/*
 * System info
 */
const char      *HTMLsystem = "\
<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | System | <a href=/admin>ADMIN</a></h3>\
<script src=/d></script>\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500>\
<tr><td>Ethernet device</td><td align=right><script>document.write(SYSTEM)</script></td></tr>\
<tr><td>Fosc</td><td align=right><script>document.write(CLK/1000)</script> Mhz</td></tr>\
<tr><td>Up Since</td><td align=right><script>document.write(UP)</script></td></tr>\
<tr><td>HTTP Request #</td><td align=right><script>document.write(REQ)</script></td></tr>\
" ;


// Stranica za redirekciju na pocetnu admin stranicu
const char      *HTMLredirect = "\
<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3>\
<script>document.location.replace(\"/admin\")</script>\
" ;
// stranica za upisivanje sifre
const char      *HTMLadmin0 = "\
<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3>\
<script src=/admin/s></script>\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000>\
<tr> <td>Password</td> <td><script>document.write(PASS)</script></td> </tr>\
" ;
/*
 * ADMIN section (private zone)
 */
const char      *HTMLadmin1 = "\
<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3>\
<script src=/admin/s></script>\
<meta http-equiv=\"refresh\" content=\"180\" />\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000>\
<tr> <td>Password</td> <td><script>document.write(PASS0)</script></td> <td><script>document.write(PASS1)</script></td> <td align=center><a href=/admin/w>Update password</a></td> </tr>\
<tr><td>Select</td><td align=right><script>document.write(SIP)</script></td></tr>\
<tr><td>DHCP</td><td align=right><script>document.write(DHCPEN)</script></td></tr>\
<tr> <td>IP Address</td> <td><script>document.write(IP0)</script></td> <td><script>document.write(IP1)</script></td> <td><script>document.write(IP2)</script></td> <td><script>document.write(IP3)</script></td> </tr>\
<tr><td>Update IP</td><td align=right><a href=/admin/r>now</a></td></tr>\
" ;

const char      *HTMLadmin2 = "\
<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3>\
<script src=/admin/s></script>\
<meta http-equiv=\"refresh\" content=\"180\" />\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000>\
<tr> <td>Password</td> <td><script>document.write(PASS0)</script></td> <td><script>document.write(PASS1)</script></td> <td align=center><a href=/admin/w>Update password</a></td> </tr>\
<tr><td>Select</td><td align=right><script>document.write(SIP)</script></td></tr>\
<tr><td>DHCP</td><td align=right><script>document.write(DHCPEN)</script></td></tr>\
<tr><td>Mask</td><td><script>document.write(M0)</script></td><td><script>document.write(M1)</script></td><td><script>document.write(M2)</script></td><td><script>document.write(M3)</script></td></tr>\
<tr><td>Update IP</td><td align=right><a href=/admin/r>now</a></td></tr>\
" ;

const char      *HTMLadmin3 = "\
<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3>\
<script src=/admin/s></script>\
<meta http-equiv=\"refresh\" content=\"180\" />\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000>\
<tr> <td>Password</td> <td><script>document.write(PASS0)</script></td> <td><script>document.write(PASS1)</script></td> <td align=center><a href=/admin/w>Update password</a></td> </tr>\
<tr><td>Select</td><td align=right><script>document.write(SIP)</script></td></tr>\
<tr><td>DHCP</td><td align=right><script>document.write(DHCPEN)</script></td></tr>\
<tr><td>Gateway</td><td><script>document.write(G0)</script></td><td><script>document.write(G1)</script></td><td><script>document.write(G2)</script></td><td><script>document.write(G3)</script></td></tr>\
<tr><td>Update IP</td><td align=right><a href=/admin/r>now</a></td></tr>\
" ;

const char      *HTMLadmin4 = "\
<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3>\
<script src=/admin/s></script>\
<meta http-equiv=\"refresh\" content=\"180\" />\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=1000>\
<tr> <td>Password</td> <td><script>document.write(PASS0)</script></td> <td><script>document.write(PASS1)</script></td> <td align=center><a href=/admin/w>Update password</a></td> </tr>\
<tr><td>Select</td><td align=right><script>document.write(SIP)</script></td></tr>\
<tr><td>DHCP</td><td align=right><script>document.write(DHCPEN)</script></td></tr>\
<tr><td>DNS Server</td><td><script>document.write(D0)</script></td><td><script>document.write(D1)</script></td><td><script>document.write(D2)</script></td><td><script>document.write(D3)</script></td></tr>\
<tr><td>Update IP</td><td align=right><a href=/admin/r>now</a></td></tr>\
" ;

/*
 * HTML common footer
 */

const   char    *HTMLfooter = "<HTML><HEAD>\
</table>\
<br>\
Pogledajte ceo proizvodni program na <a href=http://www.pme.rs target=_blank>www.pme.rs</a>\
</center>\
</BODY></HTML>" ;


/*******************************************
 * functions
 */

char lease_tmr = 0;
char lease_time = 0;

//inicijalizacija i obrada ethernet paketa ukoliko je SPI omogucen link==1
void Eth_Obrada() {
    if (conf.dhcpen == 0) {
       
       if (lease_time >= 60) {
          lease_time = 0;
          while (!SPI_Ethernet_renewDHCP(5));  // try to renew until it works        
       }
    }
    if (link == 1) {
       
       SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
       Spi_Ethernet_doPacket() ;
       
    }
}

/*
 * save conf struct to EEPROM
 */
void    saveConf()
        {
        /*
         * uncomment the lines below if configuration is to be saved to eeprom
         */
        // unsigned char   *ptr ;
        // unsigned char   i ;

        // ptr = (unsigned char *)&conf ;
        // for(i = 0 ; i < sizeof(conf) ; i++)
        //        {
        //         EEPROM_Write(i, *ptr++) ;
        //        }
        }
/*
 * LCD marquee
 */
void    mkMarquee(unsigned char l)
        {
        unsigned char   len ;
        char            marqeeBuff[17] ;

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

/*
 * put the constant string pointed to by s to the ENC transmit buffer.
 */
/*unsigned int    putConstString(const char *s)
        {
        unsigned int ctr = 0 ;

        while(*s)
                {
                SPI_Ethernet_putByte(*s++) ;
                ctr++ ;
                }
        return(ctr) ;
        } */
/*
 * it will be faster to use library SPI_Ethernet_putConstString routine
 * instead of putConstString routine above. However, the code will be a little
 * bit bigger. User should choose between size and speed and pick the implementation that
 * suites him best. If you choose to go with the putConstString definition above
 * the #define line below should be commented out.
 *
 */
#define putConstString  SPI_Ethernet_putConstString

/*
 * put the string pointed to by s to the ENC transmit buffer
 */
/*unsigned int    putString(char *s)
        {
        unsigned int ctr = 0 ;

        while(*s)
                {
                SPI_Ethernet_putByte(*s++) ;

                ctr++ ;
                }
        return(ctr) ;
        }*/
/*
 * it will be faster to use library SPI_Ethernet_putString routine
 * instead of putString routine above. However, the code will be a little
 * bit bigger. User should choose between size and speed and pick the implementation that
 * suites him best. If you choose to go with the putString definition above
 * the #define line below should be commented out.
 *
 */
#define putString  SPI_Ethernet_putString

void DNSavings() {
     tmzn = 2;
  
}

/*
 * convert l (signed) to ascii string into s, no leading spaces
 */
void    int2str(long l, unsigned char *s)
        {
        unsigned char   i, j, n ;

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

/*
 * convert ip to ascii string into s
 */
void    ip2str(unsigned char *s, unsigned char *ip)
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

/*
 * convert time struct to t to ascii into s
 * m is mode
 */
void    ts2str(unsigned char *s, TimeStruct *t, unsigned char m)
        {
        unsigned char  tmp[6] ;

        /*
         * convert date members
         */
        if(m & TS2STR_DATE)
                {
                strcpy(s, wday[t->wd]) ;        // week day
                danuned = t->wd;
                strcat(s, " ") ;
                ByteToStr(t->md, tmp) ;         // day num
                dan = t->md;
                strcat(s, tmp + 1) ;
                strcat(s, " ") ;
                strcat(s, mon[t->mo]) ;        // month
                mesec = t->mo;
                strcat(s, " ") ;
                WordToStr(t->yy, tmp) ;         // year
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

        /*
         * convert time members
         */
        if(m & TS2STR_TIME)
                {
                ByteToStr(t->hh, tmp) ;         // hour
                sati = t->hh;
                strcat(s, tmp + 1) ;
                strcat(s, ":") ;
                ByteToStr(t->mn, tmp) ;         // minute
                minuti = (t->mn);
                if(*(tmp + 1) == ' ')
                        {
                        *(tmp + 1) = '0' ;
                        }
                strcat(s, tmp + 1) ;
                strcat(s, ":") ;
                ByteToStr(t->ss, tmp) ;         // second
                sekundi = t->ss;
                if(*(tmp + 1) == ' ')
                        {
                        *(tmp + 1) = '0' ;
                        }
                strcat(s, tmp + 1) ;
                }

        /*
         * convert time zone
         */
        if(m & TS2STR_TZ)
                {
                strcat(s, " GMT") ;
                if(conf.tz > 0)
                        {
                        strcat(s, "+") ;
                        }
                int2str(conf.tz, s + strlen(s)) ;
                }
        }

/*
 * convert integer to hex char
 */
unsigned char nibble2hex(unsigned char n)
        {
        n &= 0x0f ;
        if(n >= 0x0a)
                {
                return(n + '7') ;
                }
        return(n + '0') ;
        }

/*
 * convert byte to hex string
 */
void    byte2hex(unsigned char *s, unsigned char v)
        {
        *s++ = nibble2hex(v >> 4) ;
        *s++ = nibble2hex(v) ;
        *s = '.' ;
        }

/*
 * build select HTML tag with LCD options
 */
unsigned int    mkLCDselect(unsigned char l, unsigned char m)
        {
        unsigned char i ;
        unsigned int len ;

        len = putConstString("<select onChange=\\\"document.location.href = '/admin/") ;
        SPI_Ethernet_putByte('0' + l) ; len++ ;
        len += putConstString("/' + this.selectedIndex\\\">") ;
        for(i = 0 ; i < 2 ; i++)
                {
                len += putConstString("<option ") ;
                if(i == m)
                        {
                        len += putConstString(" selected") ;
                        }
                len += putConstString(">") ;
                len += putConstString(LCDoption[i]) ;
                }
        len += putConstString("</select>\";") ;
        return(len) ;
        }

/*
 * display line
 */
void mkLCDLine(unsigned char l, unsigned char m)
        {
        switch(m)
                {
                case 0:
                        // build marquee string
                        memset(bufInfo, 0, sizeof(bufInfo)) ;
                        if(lastSync)
                                {
                                // clock is synchronized
                                strcpy(bufInfo, "Today is ") ;
                                ts2str(bufInfo + strlen(bufInfo), &ts, TS2STR_DATE) ;
                                strcat(bufInfo, ". Please visit www.micro-examples.com for more details about the Ethernal Clock. You can browse ") ;
                                ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
                                strcat(bufInfo, " to set the clock preferences.    ") ;
                                }
                        else
                                {
                                // clock is not synchronized
                                strcpy(bufInfo, "The SNTP server did not respond, please browse ") ;
                                ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
                                strcat(bufInfo, " to check clock settings.    ") ;
                                }
                        mkMarquee(l) ;           // display marquee
                        break ;
                case 1:
                        // build date string
                        //if(lastSync)
                        //        {
                                ts2str(bufInfo, &ts, TS2STR_DATE) ;
                        //        }
                        //else
                        //        {
                        //        strcpy(bufInfo, "Date Not Ready !") ;
                        //        }
                        break ;
                case 2:
                        // build time string
                        //if(lastSync)
                        //        {
                                ts2str(bufInfo, &ts, TS2STR_TIME) ;
                        //        }
                        //else
                        //        {
                        //        strcpy(bufInfo, "Time Not Ready !") ;
                        //        }
                        break ;
                }
        }

/*
 * make SNTP request (ne koristi se u broadcast rezimu)
 */
void    mkSNTPrequest()
        {
        unsigned char sntpPkt[50];
        unsigned char * remoteIpAddr;

        if (sntpSync)
          if (SPI_Ethernet_UserTimerSec >= sntpTimer)
            if (!lastSync) {
              sntpSync = 0;
              if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
                reloadDNS = 1 ; // force to solve DNS
            }

        if(reloadDNS)   // is SNTP ip address to be reloaded from DNS ?
                {
              
                if(isalpha(*conf.sntpServer))   // doest host name start with an alphabetic character ?
                        {
                        // yes, try to solve with DNS request
                             memset(conf.sntpIP, 0, 4);
                              if(remoteIpAddr = SPI_Ethernet_dnsResolve(conf.sntpServer, 5))
                                {
                                // successful : save IP address
                                memcpy(conf.sntpIP, remoteIpAddr, 4) ;
                                }
                        }
                else
                        {
                        // host name is supposed to be an IP address, directly save it
                        unsigned char *ptr = conf.sntpServer ;

                        conf.sntpIP[0] = atoi(ptr) ;
                        ptr = strchr(ptr, '.') + 1 ;
                        conf.sntpIP[1] = atoi(ptr) ;
                        ptr = strchr(ptr, '.') + 1 ;
                        conf.sntpIP[2] = atoi(ptr) ;
                        ptr = strchr(ptr, '.') + 1 ;
                        conf.sntpIP[3] = atoi(ptr) ;
                        }

                saveConf() ;            // store to EEPROM

                reloadDNS = 0 ;         // no further call to DNS

                sntpSync = 0 ;          // clock is not sync for now
                }

        if(sntpSync)                    // is clock already synchronized from sntp ?
                {
                return ;                // yes, no need to request time
                }

        /*
         * prepare buffer for SNTP request
         */
        memset(sntpPkt, 0, 48) ;        // clear sntp packet

        // FLAGS : byte 0
        sntpPkt[0] = 0b00011001 ;       // LI = 0 ; VN = 3 ; MODE = 1

        // STRATUM : byte 1 = 0

        // POLL : byte 2
        sntpPkt[2] = 0x0a ;             // 1024 sec (arbitrary value)

        // PRECISION : byte 3
        sntpPkt[3] = 0xfa ;             // 0.015625 sec (arbitrary value)

        // DELAY : bytes 4 to 7 = 0.2656 sec (arbitrary value)
        sntpPkt[6] = 0x44 ;

        // DISPERSION : bytes 8 to 11 = 16 sec (arbitrary value)
        sntpPkt[9] = 0x10 ;

        // REFERENCE ID : bytes 12 to 15 = 0 (unspecified)

        // REFERENCE TIMESTAMP : bytes 16 to 23 (unspecified)

        // ORIGINATE TIMESTAMP : bytes 24 to 31 (unspecified)

        // RECEIVE TIMESTAMP : bytes 32 to 39 (unspecified)

        // TRANSMIT TIMESTAMP : bytes 40 to 47 (unspecified)

        SPI_Ethernet_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48) ; // transmit UDP packet

        sntpSync = 1 ;  // done
        lastSync = 0 ;
        sntpTimer = SPI_Ethernet_UserTimerSec + 2;
        }

void Rst_Eth() {
     SPI_Ethernet_Rst = 0;
     reset_eth = 1;
     //connect_eth = 1;
}

/*
 * incoming TCP request
 */
unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
        {
        unsigned char   dyna[64] ;
        unsigned char   getRequest[HTTP_REQUEST_SIZE + 1] ;

        unsigned int    len = 0 ;
        int    i ;

        char fbr;
        
        // should we close tcp socket after response is sent?
        // library closes tcp socket by default if canCloseTCP flag is not reset here
        // flags->canCloseTCP = 0; // 0 - do not close socket
                          // otherwise - close socket

        if (localPort != 80)                    // I listen only to web request on port 80
                {
                return(0) ;                     // return without reply
                }

        /*
         * parse TCP frame and check for a GET request
         */
        if (HTTP_getRequest(getRequest, &reqLength, HTTP_REQUEST_SIZE) == 0)
                {
                return(0) ;                     // no reply if no GET request
                }

        /*
         * parse TCP frame and try to find basic realm authorization
         */

        if(memcmp(getRequest, path_private, sizeof(path_private) - 1) == 0)   // is path under private section ?
                {
                
                unsigned char   *ptr ;

                // yes, points to sub path
                ptr = getRequest + sizeof(path_private) - 1;

                        // yes, parse request
                        if(getRequest[sizeof(path_private)] == 's')
                                {

                                // request for javascript variables
                                len = putConstString(httpHeader) ;              // HTTP header
                                len += putConstString(httpMimeTypeScript) ;     // with script MIME type

                                if (admin == 0) {
                                
                                // zahtev za sifru sa web servera
                                len += putConstString("var PASS=\"") ;
                                len += putConstString("<input placeholder=") ;
                                len += putString("password") ;
                                len += putConstString(" onChange=\\\"document.location.href = '/admin/v/' + this.value\\\" value=\\\"") ;
                                len += putConstString("\\\">\" ;") ;

                                } else {

                                uzobyte = 1;
                                // LCD line 1 select + options
                                len += putConstString("var DHCPEN=\"") ;
                                len += mkLCDselect(1, conf.dhcpen) ;


                                // Old pass
                                len += putConstString("var PASS0=\"") ;
                                len += putConstString("<input placeholder=") ;
                                len += putString(oldSifra) ;
                                len += putConstString(" onChange=\\\"document.location.href = '/admin/x/' + this.value\\\" value=\\\"") ;
                                len += putConstString("\\\">\" ;") ;

                                // New pass
                                len += putConstString("var PASS1=\"") ;
                                len += putConstString("<input placeholder=") ;
                                len += putString(newSifra) ;
                                len += putConstString(" onChange=\\\"document.location.href = '/admin/y/' + this.value\\\" value=\\\"") ;
                                len += putConstString("\\\">\" ;") ;


                                // ukoliko je omogucena dinamicka dodela IP adrese
                                if (conf.dhcpen == 1) {
                                // time zone select + options
                                len += putConstString("var SIP=\"") ;
                                len += putConstString("<select onChange=\\\"document.location.href = '/admin/u/' + this.selectedIndex\\\">") ;
                                for(i = 1 ; i < 5 ; i++)
                                        {
                                        len += putConstString("<option ") ;
                                        if(i == s_ip)
                                                {
                                                len += putConstString(" selected") ;
                                                }
                                        len += putConstString(">") ;
                                        len += putConstString(IPoption[i-1]) ;
                                        //int2str(i, dyna) ;
                                        //len += putString(dyna) ;
                                        }
                                len += putConstString("</select>\";") ;
                                } else {
                                   s_ip = 1;
                                }
                                // podesavanje IP adrese
                                if (s_ip == 1) {
                                // IP address 0
                                len += putConstString("var IP0=\"") ;
                                len += putConstString("<input placeholder=") ;
                                len += putString(ipAddrPom0) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
                                }
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString(">\";") ;
                                }
                                // IP address 1
                                len += putConstString("var IP1=\"") ;
                                len += putConstString("<input placeholder=") ;
                                len += putString(ipAddrPom1) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
                                }
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString(">\";") ;
                                }
                                // IP address 2
                                len += putConstString("var IP2=\"") ;
                                len += putConstString("<input placeholder=") ;
                                len += putString(ipAddrPom2) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
                                }
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString(">\";") ;
                                }
                                // IP address 3
                                len += putConstString("var IP3=\"") ;
                                len += putConstString("<input placeholder=") ;
                                len += putString(ipAddrPom3) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
                                }
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString(">\";") ;
                                }
                                }

                                // Izabrana opcija za postavljanje maske
                                if (s_ip == 2) {
                                // MASK address 0
                                len += putConstString("var M0=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(ipMaskPom0) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
                                }
                                
                                //len += putString(txt) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                // MASK address 1
                                len += putConstString("var M1=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(ipMaskPom1) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
                                }
                                
                                //len += putString(txt) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                // MASK address 2
                                len += putConstString("var M2=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(ipMaskPom2) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
                                }
                               
                                //len += putString(txt) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                // MASK address 3
                                len += putConstString("var M3=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(ipMaskPom3) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
                                }
                                
                                //len += putString(txt) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                }
                                
                                // izabrana opcija za podesavanje Gateway adrese
                                if (s_ip == 3) {
                                // GATEWAY address 0
                                len += putConstString("var G0=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(gwIpAddrPom0) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
                                }
                                
                                //len += putString(txt) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                // GATEWAY address 1
                                len += putConstString("var G1=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(gwIpAddrPom1) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
                                }
                                
                                //len += putString(txt) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                // GATEWAY address 2
                                len += putConstString("var G2=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(gwIpAddrPom2) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
                                }
                                
                                //len += putString(txt) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                // GATEWAY address 3
                                len += putConstString("var G3=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(gwIpAddrPom3) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
                                }
                                
                                //len += putString(txt) ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                }
                                // izabrana opcija za podesavanje DNS-a
                                if (s_ip == 4) {
                                // DNS address 0
                                len += putConstString("var D0=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(dnsIpAddrPom0) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
                                }
                               
                   
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                // DNS address 1
                                len += putConstString("var D1=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(dnsIpAddrPom1) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
                                }
                              
                                
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                // DNS address 2
                                len += putConstString("var D2=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(dnsIpAddrPom2) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
                                }
                                
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                // DNS address 3
                                len += putConstString("var D3=\"") ;
                                if (conf.dhcpen == 1) {
                                   len += putConstString("<input placeholder=") ;
                                   len += putString(dnsIpAddrPom3) ;
                                   len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
                                }
                               
                                if (conf.dhcpen == 1) {
                                   len += putConstString("\\\">\" ;") ;
                                } else {
                                  len += putConstString("\";") ;
                                }
                                }
                                
                                }

                                }
                        else
                                {
                                // parse path to find parameters
                                switch(getRequest[sizeof(path_private)])
                                        {
                                        case '1' :
                                                // DHCP Enable selection
                                                conf.dhcpen = getRequest[sizeof(path_private) + 2] - '0' ;
                                                EEPROM_Write(103, conf.dhcpen);
                                                delay_ms(100);
                                                Rst_Eth();
                                                saveConf() ;
                                                break ;
                                        
                                        case 'r':
                                                // force to renew SNTP request  ////////////////////// ovo je za update now
                                                if (conf.dhcpen == 1) {
                                                        // upisivanje nove mrezne konfiguracije u eeprom ukoliko je zadovoljen format za adrese
                                                   ///////////////////////////////////////////////////////////////////////////////////////////////////

                                                        // provera i upis nove IP adrese
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
                                                   ///////////////////////////////////////////////////////////////////////////////////////////////////
                                              
                                                   // provera i upis novog Gatewaya
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
                                                   ///////////////////////////////////////////////////////////////////////////////////////////////////
                                                   
                                                   // provera i upis nove maske
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
                                                   ///////////////////////////////////////////////////////////////////////////////////////////////////
                                                   
                                                   //provera i upis novog DNS-a
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
                                                /////////////////////////////////////////////// ovo je izgleda da uzme iz polja
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
                                                ////////////////////////////////////////////// ovo je izgleda da uzme iz polja
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
                                                ////////////////////////////////////////////// ovo je izgleda da uzme iz polja
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
                                                ////////////////////////////////////////////// ovo je izgleda da uzme iz polja
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
                                                //////////////////////\\////////////////////// ovo je izgleda da uzme iz polja
                                               
                                                pomocnaSifra[0] = getRequest[sizeof(path_private) + 2] ;
                                                pomocnaSifra[1] = getRequest[sizeof(path_private) + 3] ;
                                                pomocnaSifra[2] = getRequest[sizeof(path_private) + 4] ;
                                                pomocnaSifra[3] = getRequest[sizeof(path_private) + 5] ;
                                                pomocnaSifra[4] = getRequest[sizeof(path_private) + 6] ;
                                                pomocnaSifra[5] = getRequest[sizeof(path_private) + 7] ;
                                                pomocnaSifra[6] = getRequest[sizeof(path_private) + 8] ;
                                                pomocnaSifra[7] = getRequest[sizeof(path_private) + 9] ;
                                                pomocnaSifra[8] = 0;

                                                // uspesno ulogovanje na admin stranicu
                                                if (strcmp(sifra,pomocnaSifra) == 0) {
                                                   tmr_rst_en = 1;
                                                   admin = 1;
                                                   len = 0;
                                                   len += putConstString(HTMLheader) ;
                                                   len += putConstString(HTMLredirect) ;
                                                   len += putConstString(HTMLfooter) ;
                                                   goto ZAVRSI;
                                                   
                                                }
                                                break ;
                                        case 'x':
                                                /////////////////////////////////////////////////////// ovo je izgleda da uzme iz polja
                                                
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
                                                /////////////////////////////////////////////////////// ovo je izgleda da uzme iz polja
                                                
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
                                      
                                        case 'w' :
                                                        // upis nove sifre uz proveru da li je uslov zadovoljen za promenu
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
                                       
                                        case 't':
                                                // time zone
                                                conf.tz = atoi(&getRequest[sizeof(path_private) + 2]) ;
                                                conf.tz -= 11 ;
                                                Eeprom_Write(102, conf.tz);
                                                delay_ms(100);
                                                break ;
                                        }
                                // reply to browser with admin HTML pages
                                   len += putConstString(HTMLheader) ;
                                   if (admin == 0) {
                                      len += putConstString(HTMLadmin0);
                                   } else {
                                      if (s_ip == 1) {
                                         len += putConstString(HTMLadmin1) ;
                                      }
                                      if (s_ip == 2) {
                                         len += putConstString(HTMLadmin2) ;
                                      }
                                      if (s_ip == 3) {
                                         len += putConstString(HTMLadmin3) ;
                                      }
                                      if (s_ip == 4) {
                                         len += putConstString(HTMLadmin4) ;
                                      }
                                   }
                                   len += putConstString(HTMLfooter) ;
                                }
                        //}
                }
        else switch(getRequest[1])
                {
                // not in private zone, parse request path
                case 's':
                        // reply with stylesheet
                        if(lastSync == 0)
                                {
                                len = putConstString(CSSred) ;          // not sync
                                }
                        else
                                {
                                len = putConstString(CSSgreen) ;        // sync
                                }
                        break ;
                case 'a':
                        
                        // reply with clock info javascript variables
                        len = putConstString(httpHeader) ;
                        len += putConstString(httpMimeTypeScript) ;

                        // add date to reply
                        ts2str(dyna, &ts, TS2STR_ALL | TS2STR_TZ) ;
                        len += putConstString("var NOW=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        // add epoch to reply
                        int2str(epoch, dyna) ;
                        len += putConstString("var EPOCH=") ;
                        len += putString(dyna) ;
                        len += putConstString(";") ;

                        // add last sync date
                        if(lastSync == 0)
                                {
                                strcpy(dyna, "???") ;
                                }
                        else
                                {
                                Time_epochToDate(lastSync + tmzn * 3600, &ls) ;
                                DNSavings();
                                ts2str(dyna, &ls, TS2STR_ALL | TS2STR_TZ) ;
                                }
                        len += putConstString("var LAST=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        break ;

                case 'b':
                        
                        // reply with sntp info javascript variables
                        len = putConstString(httpHeader) ;
                        len += putConstString(httpMimeTypeScript) ;

                        // reply is made of the IP MASK in human readable format
                        ip2str(dyna, conf.sntpIP) ;
                        len += putConstString("var SNTP=\"") ;
                        len += putString(conf.sntpServer) ;
                        len += putConstString(" (") ;
                        len += putString(dyna) ;
                        len += putConstString(")") ;
                        len += putConstString("\";") ;

                        // add sntp stratum to reply
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
                        len += putConstString("var STRATUM=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        // add sntp flags to reply
                        switch(serverFlags & 0b11000000)
                                {
                                case 0b00000000: strcpy(dyna, "No warning") ; break ;
                                case 0b01000000: strcpy(dyna, "Last minute has 61 seconds") ; break ;
                                case 0b10000000: strcpy(dyna, "Last minute has 59 seconds") ; break ;
                                case 0b11000000: strcpy(dyna, "SNTP server not synchronized") ; break ;
                                }
                        len += putConstString("var LEAP=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        int2str(serverPrecision, dyna) ;
                        len += putConstString("var PRECISION=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        switch(serverFlags & 0b00111000)
                                {
                                case 0b00011000: strcpy(dyna, "IPv4 only") ; break ;
                                case 0b00110000: strcpy(dyna, "IPv4, IPv6 and OSI") ; break ;
                                default: strcpy(dyna, "Undefined") ; break ;
                                }
                        len += putConstString("var VN=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

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
                        len += putConstString("var MODE=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        break ;

                case 'c':
                        
                        // reply with network info javascript variables
                        len = putConstString(httpHeader) ;              // HTTP header
                        len += putConstString(httpMimeTypeScript) ;     // with text MIME type

                        // reply is made of the remote host IP address in human readable format
                        ip2str(dyna, ipAddr) ;
                        len += putConstString("var IP=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        byte2hex(dyna, macAddr[0]) ;
                        byte2hex(dyna + 3, macAddr[1]) ;
                        byte2hex(dyna + 6, macAddr[2]) ;
                        byte2hex(dyna + 9, macAddr[3]) ;
                        byte2hex(dyna + 12, macAddr[4]) ;
                        byte2hex(dyna + 15, macAddr[5]) ;
                        *(dyna + 17) = 0 ;
                        len += putConstString("var MAC=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        // reply is made of the remote host IP address in human readable format
                        ip2str(dyna, remoteHost) ;
                        len += putConstString("var CLIENT=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        // reply is made of the ROUTER address in human readable format
                        ip2str(dyna, gwIpAddr) ;
                        len += putConstString("var GW=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        // reply is made of the IP MASK in human readable format
                        ip2str(dyna, ipMask) ;
                        len += putConstString("var MASK=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        // reply is made of the IP MASK in human readable format
                        ip2str(dyna, dnsIpAddr) ;
                        len += putConstString("var DNS=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        break ;

                case 'd':
                        {
                        // reply with system info javascript variables
                        TimeStruct t ;
                        //admin = 0;
                        len = putConstString(httpHeader) ;              // HTTP header
                        len += putConstString(httpMimeTypeScript) ;     // with text MIME type

                        len += putConstString("var SYSTEM=\"ENC28J60\";") ;

                        int2str(Clock_kHz(), dyna) ;
                        len += putConstString("var CLK=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;

                        // add HTTP requests counter to reply
                        int2str(httpCounter, dyna) ;
                        len += putConstString("var REQ=") ;
                        len += putString(dyna) ;
                        len += putConstString(";") ;
                        // obrada vremena 
                        Time_epochToDate(epoch - SPI_Ethernet_UserTimerSec + tmzn * 3600, &t) ;
                        DNSavings();
                        ts2str(dyna, &t, TS2STR_ALL | TS2STR_TZ) ;
                        len += putConstString("var UP=\"") ;
                        len += putString(dyna) ;
                        len += putConstString("\";") ;


                        break ;
                        }

                case '4':
                        admin = 0;
                        strcpy(oldSifra, "OLD     ");
                        strcpy(newSifra, "NEW     ");
                        // reply with system info HTML page
                        len += putConstString(HTMLheader) ;
                        len += putConstString(HTMLsystem) ;
                        len += putConstString(HTMLfooter) ;
                        break ;

                case '3':
                        admin = 0;
                        strcpy(oldSifra, "OLD     ");
                        strcpy(newSifra, "NEW     ");
                        // reply with network info HTML page
                        len += putConstString(HTMLheader) ;
                        len += putConstString(HTMLnetwork) ;
                        len += putConstString(HTMLfooter) ;
                        break ;

                case '2':
                        admin = 0;
                        strcpy(oldSifra, "OLD     ");
                        strcpy(newSifra, "NEW     ");
                        // reply with sntp info HTML page
                        len += putConstString(HTMLheader) ;
                        len += putConstString(HTMLsntp) ;
                        len += putConstString(HTMLfooter) ;
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
                        // reply with clock info HTML page
                        len += putConstString(HTMLheader) ;
                        len += putConstString(HTMLtime) ;
                        len += putConstString(HTMLfooter) ;
                }

        httpCounter++ ;                             // one more request done
        

        ZAVRSI:

        return(len) ;                               // return to the library with the number of bytes to transmit
        }

// sekvenca bitova koja se salje shift registru za prikaz na displeju
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
//funkcija koja iz shift registra salje odgovarajucu sekvencu za displej
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
// funkcija za prikazivanje vremena i datuma na displeju
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

// funkcija za prikaz IP adrese na displeju
void Print_IP() {
     char cif1;
     char cif2;
     char cif3;
     cif1 =  ipAddr[3] / 100;
     cif2 = (ipAddr[3] - cif1 * 100) / 10;
     cif3 =  ipAddr[3] - cif1 * 100 - cif2 * 10;
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

/*
 * incoming UDP request
 */
unsigned int  SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags)
        {
        unsigned char   i ;
        char broadcmd[20];
        // udp terminal za otkrivanje ip adrese 
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
        // udp terminal za obradu sntp zahteva
        if(destPort == 123)             // check SNTP port number
                {
                if (reqLength == 48) {
                
                  unsigned long    tts ;

                  serverFlags = SPI_Ethernet_getByte() ;
                  serverStratum = SPI_Ethernet_getByte() ;
                  SPI_Ethernet_getByte() ;        // skip poll
                  serverPrecision = SPI_Ethernet_getByte() ;

                  for(i = 0 ; i < 36 ; i++)
                          {
                          SPI_Ethernet_getByte() ; // skip all unused fileds
                          }

                  // store transmit timestamp
                  Highest(tts) = SPI_Ethernet_getByte() ;
                  Higher(tts) = SPI_Ethernet_getByte() ;
                  Hi(tts) = SPI_Ethernet_getByte() ;
                  Lo(tts) = SPI_Ethernet_getByte() ;

                  // convert sntp timestamp to unix epoch
                  epoch = tts - 2208988800 ;

                  // save last synchronization timestamp
                  lastSync = epoch ;

                  // update display
                  marquee = bufInfo ;
                  
                  notime = 0;
                  notime_ovf = 0;

                  Time_epochToDate(epoch + tmzn * 3600l, &ts) ;
                  presTmr = 0;
                  DNSavings();
                  if (lcdEvent) {
                     mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
                     mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
                     lcdEvent = 0 ;             // clear lcd update flag
                     marquee++ ;                // set marquee pointer
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
// funkcije prekida
void interrupt() {
        //prekid UARTA
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
     // prekid timer0
     if (INTCON.TMR0IF) {
        presTmr++ ;
        lcdTmr++ ;
        if (presTmr == 15625) {

           ////////// ADMIN RELOAD ///////////////////////////////
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
           ////////// ADMIN RELOAD ///////////////////////////////

           ////////// NO TIME ////////////////////////////////////
           notime++;
           if (notime == 32) {
              notime = 0;
              notime_ovf = 1;
           }
           ////////// NO TIME ////////////////////////////////////
        
           ////////// LEASE TIME /////////////////////////////////
           if ( (lease_tmr == 1) && (lease_time < 250) ) {
              lease_time++;
           } else {
              lease_time = 0;
           }
           ////////// LEASE TIME /////////////////////////////////

           ////////// ETH TIME ///////////////////////////////////
           SPI_Ethernet_UserTimerSec++ ;
           epoch++ ;
           presTmr = 0 ;
           ////////// ETH TIME ///////////////////////////////////

           ////////// TIMER ZA RESET ENC28J60 ////////////////////
           if (timer_flag < 2555) {
              timer_flag++;
           } else {
              timer_flag = 0;
           }
           ////////// TIMER ZA RESET ENC28J60 ////////////////////

           ////////// AUTO SNTP SEND REQUEST /////////////////////
           ////////// 1 hr
           req_tmr_1++;
           if (req_tmr_1 == 60) {
              req_tmr_1 = 0;
              req_tmr_2++;
           }
           if (req_tmr_2 == 60) {
              req_tmr_2 = 0;
              req_tmr_3++;
           }
           ////////// AUTO SNTP SEND REQUEST /////////////////////

           ////////// MANUAL DAY/NIGHT SAVINGS OVERFLOW //////////
           if (rst_flag == 1) {
              rst_flag_1++;
           }
           ////////// MANUAL DAY/NIGHT SAVINGS OVERFLOW //////////

           ////////// RESET NA FABRICKA //////////////////////////
           if ( (rst_fab_tmr == 1) && (rst_fab_flag < 200) ) {
              rst_fab_flag++;
           }
           ////////// RESET NA FABRICKA //////////////////////////

        }

        if (lcdTmr == 3125) {
           lcdEvent = 1;
           lcdTmr = 0;
        }
        INTCON.TMR0IF = 0 ;              // clear timer0 overflow flag
     }
}

// Funkcija za gasenje displeja
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
// funkcija koja ispisuje redom 0-9 na displeju  
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

// funkcija za prikaz PME na displeju
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

// funkcija za PWM modulaciju, kontrola svetla preko fotosenzora
void Print_Light() {
    ADCON0 = 0b00000001;
    light_res = ADC_Read(0);
    result = light_res * 0.00322265625;  // scale adc result by 100000 (3.22mV/lsb => 3.3V / 1024 = 0.00322265625...V)

    if (result <= 1.3) {                            // 1.1
       PWM1_Set_Duty(max_light);
    }
    if ( (result > 1.3) && (result <= 2.3) ) {      // 1.1 - 2.2
       PWM1_Set_Duty((max_light*2)/3);
    }
    if (result > 2.3) {
       PWM1_Set_Duty(max_light/3);                  // 2.2
    }
    //PWM1_Set_Duty(max_light);
    Eth_Obrada();
}

// funkcija za citanje inicijalizaciju i2c memorije i citanje MAC adrese
void Mem_Read() {
  char membr;
  MSSPEN  = 1;
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
  MSSPEN  = 0;
  asm nop;
  asm nop;
  asm nop;
  //SPI1_Init();
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
}

/*
 * main entry
 */
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
     SPI_Ethernet_CS_Direction  = 0;
     SPI_Ethernet_CS  = 0;

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
     PWM1_Set_Duty(max_light);      // 90
     //BCKL = 1;

     UART1_Init(9600);
     PIE1.RCIE = 1;
     GIE_bit = 1;
     PEIE_bit = 1;

     T0CON = 0b11000000 ;
     INTCON.TMR0IF = 0 ;
     INTCON.TMR0IE = 1 ;

     // beskonacna petlja
     while(1) {

          pom_time_pom = EEPROM_Read(0);
          // ukoliko je sat resetovan na fabricka podesavanja
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

             // postavljanje pocetnih mreznih parametra
             ipAddr[0]    = 192;
             ipAddr[1]    = 168;
             ipAddr[2]    = 1;
             ipAddr[3]    = 99;
             gwIpAddr[0]  = 192;
             gwIpAddr[1]  = 168;
             gwIpAddr[2]  = 1;
             gwIpAddr[3]  = 1;
             ipMask[0]    = 255;
             ipMask[1]    = 255;
             ipMask[2]    = 255;
             ipMask[3]    = 0;
             dnsIpAddr[0] = 192;
             dnsIpAddr[1] = 168;
             dnsIpAddr[2] = 1;
             dnsIpAddr[3] = 1;

             // upisivanje mreznih parametra u memoriju
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
          // citanje sifre iz memorije
          sifra[0]    = EEPROM_Read(20);
          sifra[1]    = EEPROM_Read(21);
          sifra[2]    = EEPROM_Read(22);
          sifra[3]    = EEPROM_Read(23);
          sifra[4]    = EEPROM_Read(24);
          sifra[5]    = EEPROM_Read(25);
          sifra[6]    = EEPROM_Read(26);
          sifra[7]    = EEPROM_Read(27);
          sifra[8]    = EEPROM_Read(28);
          // citanje servera iz memorije
          for (j=0;j<=26;j++) {
             server1[j] = EEPROM_Read(j+29);
          }
          for (j=0;j<=26;j++) {
             server2[j] = EEPROM_Read(j+56);
          }
          for (j=0;j<=26;j++) {
             server3[j] = EEPROM_Read(j+110);
          }
          // citanje mrezne postavke iz memorije
          ipAddr[0]    = EEPROM_Read(1);
          ipAddr[1]    = EEPROM_Read(2);
          ipAddr[2]    = EEPROM_Read(3);
          ipAddr[3]    = EEPROM_Read(4);
          gwIpAddr[0]  = EEPROM_Read(5);
          gwIpAddr[1]  = EEPROM_Read(6);
          gwIpAddr[2]  = EEPROM_Read(7);
          gwIpAddr[3]  = EEPROM_Read(8);
          ipMask[0]    = EEPROM_Read(9);
          ipMask[1]    = EEPROM_Read(10);
          ipMask[2]    = EEPROM_Read(11);
          ipMask[3]    = EEPROM_Read(12);
          dnsIpAddr[0] = EEPROM_Read(13);
          dnsIpAddr[1] = EEPROM_Read(14);
          dnsIpAddr[2] = EEPROM_Read(15);
          dnsIpAddr[3] = EEPROM_Read(16);

          //prvo paljenje sata
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
              //SPI1_Init() ;
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

                 Spi_Ethernet_Init(macAddr, ipAddr, Spi_Ethernet_FULLDUPLEX) ;
                 
                 while (SPI_Ethernet_initDHCP(5) == 0) ; // try to get one from DHCP until it works
                 memcpy(ipAddr,    SPI_Ethernet_getIpAddress(),    4) ; // get assigned IP address
                 memcpy(ipMask,    SPI_Ethernet_getIpMask(),       4) ; // get assigned IP mask
                 memcpy(gwIpAddr,  SPI_Ethernet_getGwIpAddress(),  4) ; // get assigned gateway IP address
                 memcpy(dnsIpAddr, SPI_Ethernet_getDnsIpAddress(), 4) ; // get assigned dns IP address

                 lease_tmr = 1;
                 lease_time = 0;
                 // postavljanje novih mreznih parametara u memoriji
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
                 Spi_Ethernet_Init(macAddr, ipAddr, Spi_Ethernet_FULLDUPLEX) ;
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

           ////////////// ako je taj mode i to vreme ///////////////////////////
           if (req_tmr_3 == 12) {
              sntpSync = 0;
              req_tmr_1 = 0;
              req_tmr_2 = 0;
              req_tmr_3 = 0;
           }
           ////////////// ako je taj mode i to vreme ///////////////////////////

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
           // sinhornizacija vremena i ispisivanje na displeju
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
              mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
              mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
              lcdEvent = 0 ;             // clear lcd update flag
              marquee++ ;                // set marquee pointer
           }

           asm CLRWDT;
     }
}