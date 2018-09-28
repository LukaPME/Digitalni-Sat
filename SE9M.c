#include "built_in.h"
#include "timelib.h"
#include "__NetEthEnc28j60.h"
#include "__NetEthEnc28j60Private.h"
#include "html.h"

#define Net_Ethernet_28j60_HALFDUPLEX     0
#define Net_Ethernet_28j60_FULLDUPLEX     1

///////////////////////// ETHERNET /////////////////////////////////////////////
sbit Eth1_Link at RB5_bit;
sbit Net_Ethernet_28j60_Rst at LATA5_bit;
sbit Net_Ethernet_28j60_CS  at LATA4_bit;
sbit Eth1_Link_Direction at TRISB5_bit;
sbit Net_Ethernet_28j60_Rst_Direction at TRISA5_bit;
sbit Net_Ethernet_28j60_CS_Direction  at TRISA4_bit;
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

#define TS2STR_DATE     1
#define TS2STR_TIME     2
#define TS2STR_TZ       4
#define TS2STR_ALL      (TS2STR_DATE | TS2STR_TIME)
/***********************************
 * RAM variables
 */
unsigned char   macAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f} ;   // my MAC address

//postavljanje pocetnih parametara mreze
unsigned char ipAddr[4]    = {192, 168, 1, 99} ;  // my ip addr
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
char uzobyte = 0;
char mode;
char server1[27];
char server2[27];
char server3[27];


TimeStruct    ts, ls ,t1_s;                // timestruct for now and last update
long    epoch = 0 , epoch_fract = 0;
long    t_ref,t_org,t_rec, t_xmt, t_dst ;                  // unix time now
long    t_ref_fract,t_org_fract,t_rec_fract,t_xmt_fract,t_dst_fract;
long    lastSync = 0 ;                  // unix time of last sntp update
unsigned long   sntpTimer = 0;         // sntp response timer
unsigned int    presTmr = 0 ;             // timer prescaler
//char rez[68];
//char res[68];
//char fract[34];
char modeChange;
char cnt;
char modeCnt;

unsigned char   bufInfo[200] ;          // LCD buffer
unsigned char   *marquee = 0;           // marquee pointer
unsigned char   lcdEvent = 0;           // marquee event flag
unsigned int    lcdTmr   = 0;           // marquee timer

unsigned char   sntpSync = 1 ;          // sntp sync flag
unsigned char   sync_flag = 0;
unsigned char   reloadDNS = 1 ;         // dns up to date flag
unsigned char   serverStratum = 0 , poll = 0 ;     // sntp server stratum
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

const code unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-Length: 1417\nConnection: close\nContent-type: ";  // HTTP header
const code unsigned char httpMimeTypeHTML[] = "text/html\n\n";              // HTML MIME type
const unsigned char httpMimeTypeScript[] = "text/plain\n\n" ;           // TEXT MIME type
const const code unsigned char httpImage[] = "HTTP/1.1 200 OK\nConnection: keep-alive\nContent-type:image/jpg\n\n";      // Image  type
unsigned char httpGetMethod[] = "GET /";
unsigned char httpGetImage[] = "GET /p1";
unsigned char httpGetRequ[] = "GET / HTTP/1.1";
unsigned char httpPostMethod[] = "POST /";
unsigned char httpPostRequ[] = "POST / HTTP/1.1";

unsigned char   htmlRequest[602];                                        // HTTP request buffer
unsigned char   dyna[31] ;

char username[15] = "admin";
char usercheck[15] ="" ;
char password[9] = "12345678";
char passcheck[9] = "";
unsigned int pos[10];
char i;
//unsigned long   httpCounter = 0 ;                                       // counter of HTTP requests
////////////////html change vars/////////////////////

int ij, ik;
int index_br = 0;
char buff_slanje;
char promena1[] = " Times New Roman";
int pg_size = 0 ;
int login_size = 1371;
int p1_size = 9156;
int timePage_size = 1860;
int ntpPage_size =1156;
char sendHTML_mark = 0, sendTimeMark = 0, sendLoginMark = 0, sendNTPMark = 0, sendIMG_mark = 0;
char admin = 0;
int session = 0;
char end_petlja = 0;
char post_prolaz = 0;

/*
 * configuration structure
 */
struct{
        unsigned char   dhcpen ;                 // LCD line 1 message type
        unsigned char   lcdL2 ;                 // LCD line 2 message type
        short           tz ;                    // time zone (diff in hours to GMT)
        unsigned char   sntpIP[4] ;             // SNTP ip address
        unsigned char   sntpServer[128] ;       // SNTP host name
}       conf = {
                0,
                2,
                0,
                {0, 0, 0, 0},
                "pool.ntp.org"             // Zurich, Switzerland: Integrated Systems Lab, Swiss Fed. Inst. of Technology             // Zurich, Switzerland: Integrated Systems Lab, Swiss Fed. Inst. of Technology
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

/*
 * save conf struct to EEPROM
 */

int my_strstr(int index, char *s1)
{
  int i, j, k;
  int flag = 0;

  //if ((s2 == 0 || s1 == 0)) return 0;

  for( i = index; login_code[i] != '\0'; i++)
  {
    if (login_code[i] == s1[0])
    {
      for (j = i; ; j++)
      {
        if (s1[j-i] == '\0'){ flag = 1;
        break;}
        if (login_code[j] == s1[j-i])
        continue;
        else
        break;
      }
    }
    if (flag == 1)
    break;
  }

   /*k=0;
   for ( i = j ; i < (j + strlen(s3)) ; i++) {
       html_code[i] = s3[k];
       k++;
   }*/
   return j;
}
int strstr1(int index,char *s2, char *s1)
{
  int i, j, k;
  int flag = 0;

  //if ((s2 == 0 || s1 == 0)) return 0;

  for( i = index; s2[i] != '\0'; i++)
  {
    if (s2[i] == s1[0])
    {
      for (j = i; ; j++)
      {
        if (s1[j-i] == '\0'){ flag = 1;
        break;}
        if (s2[j] == s1[j-i])
        continue;
        else
        break;
      }
    }
    if (flag == 1)
    break;
  }

   /*k=0;
   for ( i = j ; i < (j + strlen(s3)) ; i++) {
       html_code[i] = s3[k];
       k++;
   }*/
   return j;
}

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
void    ts2str (unsigned char *s, TimeStruct *t, unsigned char m){
        unsigned char  tmp[6] ;

        /*
         * convert date members
         */
        if(m & TS2STR_DATE){
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
        else {
                *s = 0 ;
        }

        /*
         * convert time members
         */
        if(m & TS2STR_TIME){
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
        if(m & TS2STR_TZ){
                strcat(s, " GMT") ;
                if(conf.tz > 0)
                        {
                        strcat(s, "+") ;
                        }
                int2str(conf.tz, s + strlen(s)) ;
        }
}
/*
 * make SNTP request (ne koristi se u broadcast rezimu)
 */
void    mkSNTPrequest(){
        unsigned char sntpPkt[50];
        unsigned char* remoteIpAddr;
        Timestruct t1_c;
        epoch_fract = presTmr * 274877.906944 ;// zbog tajmera i 2^32
        if (sntpSync)
          if (Net_Ethernet_28j60_UserTimerSec >= sntpTimer)
            if (!sync_flag) {
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
                              if(remoteIpAddr = Net_Ethernet_28j60_dnsResolve(conf.sntpServer, 5))
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

                //saveConf() ;            // store to EEPROM

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
        sntpPkt[16] = Highest(lastSync);
        sntpPkt[17] = Higher(lastSync);
        sntpPkt[18] = Hi(lastSync);
        sntpPkt[19] = Lo(lastSync);
        // ORIGINATE TIMESTAMP : bytes 24 to 31 (unspecified)

        
        // RECEIVE TIMESTAMP : bytes 32 to 39 (unspecified)

        // TRANSMIT TIMESTAMP : bytes 40 to 47 (unspecified)
        sntpPkt[40] = Highest(epoch);
        sntpPkt[41] = Higher(epoch);
        sntpPkt[42] = Hi(epoch);
        sntpPkt[43] = Lo(epoch);
        sntpPkt[44] = Highest(epoch_fract);
        sntpPkt[45] = Higher(epoch_fract);
        sntpPkt[46] = Hi(epoch_fract);
        sntpPkt[47] = Lo(epoch_fract);
        
        //
         /*LongtoStr(lastSync,rez);
         UART_Write_Text("Ovo je T_ref:");
         UART_Write_Text(rez);
         UART_Write(0x0D);
         UART_Write(0x0A);

         Time_EpochtoDate(epoch + 3600 *tmzn , &t1_c);
         ts2str(res,&t1_c,TS2STR_TIME);
         strcat (res, ".");
         LongtoStr(epoch_fract,fract);
         strcat(res,fract);
         UART_Write_Text("Ovo je T1 sa klijenta:");
         UART_Write_Text(res);
         UART_Write(0x0D);
         UART_Write(0x0A);*/


        Net_Ethernet_28j60_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48) ; // transmit UDP packet

        sntpSync = 1 ;  // done
        sync_flag = 0 ;
        sntpTimer = Net_Ethernet_28j60_UserTimerSec + 2;
}

/*******************************************
 * functions
 */

char lease_tmr = 0;
char lease_time = 0;

//inicijalizacija i obrada ethernet paketa ukoliko je SPI omogucen link == 1
void Eth_Obrada() {

    if (conf.dhcpen == 0) {
       
       if (lease_time >= 60) {
          lease_time = 0;
          while (!Net_Ethernet_28j60_renewDHCP(5));  // try to renew until it works
       }
    }
    if (link == 1) {
       if (sync_flag == 1) {
          sync_flag = 0;
          mkSNTPrequest();
       }
       SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
       Net_Ethernet_28j60_doPacket() ;
        for(i = 0; i < NUM_OF_SOCKET_28j60; i++) {
        if(socket_28j60[i].open == 0)
       pos[i] = 0;
       }
    }
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

#define putConstString  Net_Ethernet_28j60_putConstStringTCP
#define putString  Net_Ethernet_28j60_putStringTCP

void DNSavings() {
     tmzn = 0;
  
}

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

        len = Net_Ethernet_28j60_putConstString("<select onChange=\\\"document.location.href = '/admin/") ;
        Net_Ethernet_28j60_putByte('0' + l) ; 
        len++ ;
        len += Net_Ethernet_28j60_putConstString("/' + this.selectedIndex\\\">") ;
        for(i = 0 ; i < 2 ; i++)
                {
                len += Net_Ethernet_28j60_putConstString("<option ") ;
                if(i == m)
                        {
                        len += Net_Ethernet_28j60_putConstString(" selected") ;
                        }
                len += Net_Ethernet_28j60_putConstString(">") ;
                len += Net_Ethernet_28j60_putConstString(LCDoption[i]) ;
                }
        len += Net_Ethernet_28j60_putConstString("</select>\";") ;
        return(len) ;
        }

/*
 * display line
 */
void mkLCDLine(unsigned char l, unsigned char m){
        switch(m)
                {
                case 0:
                        // build marquee string
                        memset(bufInfo, 0, sizeof(bufInfo)) ;
                        if(sync_flag)
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

void Rst_Eth() {
     Net_Ethernet_28j60_Rst = 0;
     reset_eth = 1;
     //connect_eth = 1;
}

/*
 * incoming TCP request
 */
//unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
void Net_Ethernet_28j60_UserTCP(SOCKET_28j60_Dsc *socket)
        {
        unsigned char   dyna[64] ;
        unsigned int    len = 0 ;
        int    i ;
        int res = 0;
        char fbr;
        
        
        // should we close tcp socket after response is sent?
        // library closes tcp socket by default if canCloseTCP flag is not reset here
        // flags->canCloseTCP = 0; // 0 - do not close socket
                          // otherwise - close socket

        if (socket->destPort != 80)                    // I listen only to web request on port 80
                {
                return ;                     // return without reply
                }

        /*
         * parse TCP frame and check for a GET request
         */
       for (i = 0; i < 10 ; i++) {
       htmlRequest[i] = Net_Ethernet_28j60_getByte();
       }
        /*
         * parse TCP frame and try to find basic realm authorization
         */
        if(memcmp(htmlRequest, httpGetImage, 6) == 0){
         sendIMG_mark = 1;
         post_prolaz = 2;
         //UART_Write_Text("Jeste Slika");
        } else
        // Check if it is get or post
        if(memcmp(htmlRequest, httpGetMethod, 5) == 0){
          if (admin == 0) {
           sendHTML_mark = 1;
           post_prolaz = 2;
           //UART_Write_Text("Jeste Get");
          }
          else  if ( (htmlRequest[5] == 't') && (admin == 1) ){
             sendNTPMark = 0;
             sendTimeMark = 1;
             post_prolaz = 2;
             //UART_Write_Text("Jeste TIME Get");
          }
          else  if ( (htmlRequest[5] == 'n') && (admin == 1) ){
               sendTimeMark = 0;
               sendNTPMark = 1;
               post_prolaz = 2;
               //UART_Write_Text("Jeste NTP Get");
           }
     else  if ( (htmlRequest[5] == 'l') && (admin == 1) ){
     sendHTML_mark = 1;
     session = 0;
     admin = 0;
     post_prolaz = 2;
     //UART_Write_Text("Jeste NTP Get");
     }
  }
  else if(memcmp(htmlRequest, httpPostMethod, 6) == 0) {
     //if (admin == 0) {
        post_prolaz = 0;
        sendLoginMark = 1;

    /*} else {
        sendNTPMark = 0;
        sendTimeMark = 1;
        prolaz = 2;
     }*/
     //UART_Write_Text("Jeste Post");
     }

  // POST and GET method are supported here
  if( ((memcmp(htmlRequest, httpGetMethod, 5) && (socket->state != 3))) || ( memcmp(htmlRequest, httpPostMethod, 6) &&( socket->state != 3) )){
    return;
    }
     while( post_prolaz < 2 ){
       for (len = (MY_MSS_28j60 * post_prolaz); len < (MY_MSS_28j60 * (post_prolaz + 1)); len++){
       htmlRequest[len] = Net_Ethernet_28j60_getByte();
       }
       post_prolaz++;
       break;
     }

     if (post_prolaz == 2) {

        if (sendLoginMark == 1) {

          res = 0;
          res = strstr1(res, htmlRequest,"usr");

          for ( i = 0 ; i < 15 ; i++){
               if (htmlRequest[(res + 1) + i] == '&')
               break;
               else
               usercheck[i] = htmlRequest[i+(res + 1)];

          }
          res = strstr1(res, htmlRequest,"psw");

          for ( i = 0 ; i < 8 ; i++){
               passcheck[i] =  htmlRequest[i+(res + 1)];
          }
          sendLoginMark = 0;
          if ( ((strcmp(usercheck,username) == 0) && (strcmp(passcheck,password) == 0))||(admin == 1) ) {
               admin = 1;
               sendTimeMark = 1;

          } else {
               admin = 0;
               sendHTML_mark = 1;
               for (i = 0; i < 15 ; i++)
               usercheck[i] = 0;
               for (i = 0; i < 8; i++)
               passcheck[i] = 0;

          }

       }

     if (sendTimeMark == 1){
        while(pos[socket->ID] < timePage_size) {
            if(Net_Ethernet_28j60_putByteTCP(time_code[pos[socket->ID]++], socket) == 0) {
               pos[socket->ID]--;
               break;
            }
         }
         if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= timePage_size) ) {
             Net_Ethernet_28j60_disconnectTCP(socket);
             socket_28j60[socket->ID].state = 0;
             pos[socket->ID] = 0;
             sendTimeMark = 0;
             post_prolaz = 0;
          }

      }
     if (sendNTPMark == 1){
        while(pos[socket->ID] < ntpPage_size) {
            if(Net_Ethernet_28j60_putByteTCP(ntp_code[pos[socket->ID]++], socket) == 0) {
               pos[socket->ID]--;
               break;
            }
         }
         if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= ntpPage_size) ) {
             Net_Ethernet_28j60_disconnectTCP(socket);
             socket_28j60[socket->ID].state = 0;
             pos[socket->ID] = 0;
             sendNTPMark = 0;
             post_prolaz = 0;
          }

      }

    if (sendHTML_mark == 1)  {

     /*while (pos[socket->ID] < login_size) {
         // zamena
        if ( (pos[socket->ID] == prva_promena) || (end_petlja == 1) ) {
          if (end_petlja == 1) end_petlja = 0;
          Html_Change(prva_promena, socket, promena1);
          if (end_petlja == 1) break;
        }

        else {
          buff_slanje = login_code[pos[socket->ID]++];
          if (Net_Ethernet_28j60_putByteTCP(buff_slanje, socket) == 0) {
             pos[socket->ID]--;
             break;
          }
        }
      }*/
         while(pos[socket->ID] < login_size) {
            if(Net_Ethernet_28j60_putByteTCP(login_code[pos[socket->ID]++], socket) == 0) {
               pos[socket->ID]--;
               break;
            }
         }
         if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= login_size) ) {
             Net_Ethernet_28j60_disconnectTCP(socket);
             socket_28j60[socket->ID].state = 0;
             pos[socket->ID] = 0;
             sendHTML_mark = 0;
             post_prolaz = 0;
          }

      }

      if (sendIMG_mark == 1) {

       if (pos[socket->ID] == 0) {
        Net_Ethernet_28j60_putConstStringTCP(httpImage, socket);
       }
       while(pos[socket->ID] < p1_size){
           if(Net_Ethernet_28j60_putByteTCP(p1[pos[socket->ID]++], socket) == 0) {
              pos[socket->ID]--;
              break;
           }
        }
        if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= p1_size) ) {
             Net_Ethernet_28j60_disconnectTCP(socket);
             socket_28j60[socket->ID].state = 0;
             pos[socket->ID] = 0;
             sendIMG_mark = 0;
             post_prolaz = 0;
        }

      }


    }
      /*case 'a':

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

                        break ;*/
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
/*unsigned int  SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags)
        {*/
        
unsigned int Net_Ethernet_28j60_UserUDP(UDP_28j60_Dsc *udpDsc) {

        unsigned char   i ;
        long delta;

        char broadcmd[20];
        //char dyna[31];
        

        // udp terminal za otkrivanje ip adrese 
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

        // udp terminal za obradu sntp zahteva
        if(udpDsc->destPort == 123)             // check SNTP port number
                {
                if (udpDsc->remoteIP[3] == 10 && modeChange == 0){
                  return (0);
                }

                 else if (udpDsc->dataLength == 48) {
                  epoch_fract = presTmr * 274877.906944 ;
                  t_dst = epoch;
                  t_dst_fract = epoch_fract ;
                  serverFlags = Net_Ethernet_28j60_getByte() ;
                  serverStratum = Net_Ethernet_28j60_getByte() ;
                  poll = Net_Ethernet_28j60_getByte() ;        // skip poll
                  serverPrecision = Net_Ethernet_28j60_getByte() ;

                  for(i = 0 ; i < 20 ; i++){
                    Net_Ethernet_28j60_getByte() ;// skip all unused fileds
                  }
                  //t1

                  Highest(t_org) = Net_Ethernet_28j60_getByte() ;
                  Higher(t_org) = Net_Ethernet_28j60_getByte() ;
                  Hi(t_org) = Net_Ethernet_28j60_getByte() ;
                  Lo(t_org) = Net_Ethernet_28j60_getByte() ;
                  Highest(t_org_fract) = Net_Ethernet_28j60_getByte() ;
                  Higher(t_org_fract) = Net_Ethernet_28j60_getByte() ;
                  Hi(t_org_fract) = Net_Ethernet_28j60_getByte() ;
                  Lo(t_org_fract) = Net_Ethernet_28j60_getByte() ;

                  //t2
                  Highest(t_rec) = Net_Ethernet_28j60_getByte() ;
                  Higher(t_rec) = Net_Ethernet_28j60_getByte() ;
                  Hi(t_rec) = Net_Ethernet_28j60_getByte() ;
                  Lo(t_rec) = Net_Ethernet_28j60_getByte() ;
                  Highest(t_rec_fract) = Net_Ethernet_28j60_getByte() ;
                  Higher(t_rec_fract) = Net_Ethernet_28j60_getByte() ;
                  Hi(t_rec_fract) = Net_Ethernet_28j60_getByte() ;
                  Lo(t_rec_fract) = Net_Ethernet_28j60_getByte() ;
                  //t3
                  Highest(t_xmt) = Net_Ethernet_28j60_getByte() ;
                  Higher(t_xmt) = Net_Ethernet_28j60_getByte() ;
                  Hi(t_xmt) = Net_Ethernet_28j60_getByte() ;
                  Lo(t_xmt) = Net_Ethernet_28j60_getByte() ;
                  Highest(t_xmt_fract) = Net_Ethernet_28j60_getByte() ;
                  Higher(t_xmt_fract) = Net_Ethernet_28j60_getByte() ;
                  Hi(t_xmt_fract) = Net_Ethernet_28j60_getByte() ;
                  Lo(t_xmt_fract) = Net_Ethernet_28j60_getByte() ;

                  //uart print times
                 /*LongtoStr(t_org,rez);
                  Time_EpochtoDate(t_org + 3600 *tmzn , &t1_s);
                  ts2str(rez,&t1_s,TS2STR_TIME);
                  strcat (rez, ".");
                  LongtoStr(t_org_fract,fract);
                  strcat(rez,fract);
                  UART_Write_Text("Ovo je t1 sa servera:");
                  UART_Write_Text(rez);
                  UART_Write(0x0D);
                  UART_Write(0x0A);*/

                  t_rec = t_rec - 2208988800;
                  /*LongtoStr(t_rec,rez);
                  strcat (rez, ".");
                  LongtoStr(t_rec_fract,fract);
                  strcat(rez,fract);
                  UART_Write_Text("Ovo je t2:");
                  UART_Write_Text(rez);
                  UART_Write(0x0D);
                  UART_Write(0x0A);*/

                  t_xmt =  t_xmt - 2208988800;

                /*LongtoStr(t_xmt,rez);
                  strcat (rez, ".");
                  LongtoStr(t_xmt_fract,fract);
                  strcat(rez,fract);
                  UART_Write_Text("Ovo je t3:");
                  UART_Write_Text(rez);
                  UART_Write(0x0D);
                  UART_Write(0x0A);

                  LongtoStr(t_dst,rez);
                  strcat (rez, ".");
                  LongtoStr(t_dst_fract,fract);
                  strcat(rez,fract);
                  UART_Write_Text("Ovo je t4 na klijentu:");
                  UART_Write_Text(rez);
                  UART_Write(0x0D);
                  UART_Write(0x0A);*/


                  if (t_dst == t_org){
                  delta = ( t_dst_fract - t_org_fract) - (t_xmt_fract - t_rec_fract );
                  /*LongtoStr(delta, rez);
                  UART_Write_Text("Ovo je t4 = t1:");
                  UART_Write_Text(rez);
                  UART_Write(0x0D);
                  UART_Write(0x0A);*/
                  }
                  else if (t_dst != t_org){
                  delta = (4294967295 -  t_org_fract + t_dst_fract) - (t_xmt_fract - t_rec_fract );
                  /*LongtoStr(delta, rez);
                  UART_Write_Text("Ovo NIJE! t4 = t1:");
                  UART_Write_Text(rez);
                  UART_Write(0x0D);
                  UART_Write(0x0A);*/
                  }
                  // convert sntp timestamp to unix epoch
                  if ( (presTmr + delta /(2 * 274877.906944))  > 15625 ){
                  epoch  = t_xmt + 1;
                  presTmr = (presTmr + delta / (2 * 274877.906944)) - 15625;
                  epoch_fract = presTmr * 274877.906944 ;
                  //lastSync = epoch;
                  }
                  else {
                  epoch = t_xmt;
                  epoch_fract += delta / 2;

                  }
                  // save last synchronization timestamp
                  lastSync =  epoch;
                  // update display
                  marquee = bufInfo ;
                  
                  notime = 0;
                  notime_ovf = 0;

                  Time_epochToDate(epoch + tmzn * 3600, &ts) ;

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
void InitTimer1(){
  T1CON         = 0x01;
  TMR1IF_bit    = 0;
  TMR1H         = 0x63;
  TMR1L         = 0xC0;
  TMR1IE_bit    = 1;
  INTCON        = 0xC0;
}
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
        
        if (presTmr == 15625) {

           ////////// ETH TIME ///////////////////////////////////
           Net_Ethernet_28j60_UserTimerSec++ ;
           epoch++ ;
           presTmr = 0 ;
           ////////// ETH TIME ///////////////////////////////////
        }
        INTCON.TMR0IF = 0 ;              // clear timer0 overflow flag

     }
     if (TMR1IF_bit){

         lcdTmr++;
         cnt++;
         if (modeChange == 0){
             modeCnt++;
            if (modeCnt == ipAddr[3]){
               sntpSync = 0;
               sync_flag = 1;
               modeChange = 1;
               modeCnt = 0;
               }

         }
         if (cnt == 200){

            if (admin == 1){
            session++;
            }


           ////////// TIMER ZA RESET ENC28J60 ////////////////////
           if (timer_flag < 2555) {
              timer_flag++;
           } else {
              timer_flag = 0;
           }
           ////////// TIMER ZA RESET ENC28J60 ////////////////////
           
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
          cnt = 0;
         }
         ////////// ADMIN RELOAD ///////////////////////////////
         if (session == 120){
         admin = 0;
         session = 0;
         sendHTML_mark = 1;
         }
          ////////// ADMIN RELOAD ///////////////////////////////
         if (lcdTmr == 40) {
         lcdEvent = 1;
         lcdTmr = 0;
         }

           TMR1H         = 0x63;
           TMR1L         = 0xC0;
           TMR1IF_bit = 0;
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
     Com_En = 1;

     Kom_En_1_Direction = 0;
     Kom_En_1 = 1;

     Kom_En_2_Direction = 0;
     Kom_En_2 = 0;

     Eth1_Link_Direction = 1;

     Net_Ethernet_28j60_Rst_Direction = 0;
     Net_Ethernet_28j60_Rst = 0;
     Net_Ethernet_28j60_CS_Direction  = 0;
     Net_Ethernet_28j60_CS  = 0;

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
     InitTimer1();

     T0CON = 0b11000000 ;
     INTCON.TMR0IF = 0 ;
     INTCON.TMR0IE = 1 ;
     Net_Ethernet_28j60_stackInitTCP();
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
             /*ipAddr[0]    = 172;
             ipAddr[1]    = 24;
             ipAddr[2]    = 171;*/
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
             
             modeChange = 0;
             
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

                 Net_Ethernet_28j60_Init(macAddr, ipAddr, Net_Ethernet_28j60_FULLDUPLEX) ;
                 
                 while (Net_Ethernet_28j60_initDHCP(5) == 0) ; // try to get one from DHCP until it works
                 memcpy(ipAddr,    Net_Ethernet_28j60_getIpAddress(),    4) ; // get assigned IP address
                 memcpy(ipMask,    Net_Ethernet_28j60_getIpMask(),       4) ; // get assigned IP mask
                 memcpy(gwIpAddr,  Net_Ethernet_28j60_getGwIpAddress(),  4) ; // get assigned gateway IP address
                 memcpy(dnsIpAddr, Net_Ethernet_28j60_getDnsIpAddress(), 4) ; // get assigned dns IP address

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
                 
                 modeChange = 0;


              }
              if (conf.dhcpen == 1) {
                 lease_tmr = 0;
                 Mem_Read();
                 Net_Ethernet_28j60_Init(macAddr, ipAddr, Net_Ethernet_28j60_FULLDUPLEX) ;
                 Net_Ethernet_28j60_confNetwork(ipMask, gwIpAddr, dnsIpAddr) ;
                 Print_IP();
                 
                 modeChange = 0;


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

           Time_epochToDate(epoch + tmzn * 3600, &ts) ;

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