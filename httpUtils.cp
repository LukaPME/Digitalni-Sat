#line 1 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
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
#line 34 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
const unsigned char HTTP_NotFound[] = "HTTP/1.1 404 Not Found\n\n" ;
const unsigned char HTTP_HeaderGif[] = "HTTP/1.1 200 OK\nContent-type: image/gif\n\n" ;
const unsigned char HTTP_HeaderHtml[] = "HTTP/1.1 200 OK\nContent-type: text/html\n\n" ;
const unsigned char HTTP_Denied[] = "HTTP/1.1 401 Authorization Required\nWWW-Authenticate: Basic realm=\"" ;
const unsigned char HTTP_Redir[] = "HTTP/1.1 301 Moved Permanently\nLocation: " ;
#line 80 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
const char HTTP_b64_reverse[] = "|$$$}rstuvwxyz{$$$$$$$>?@ABCDEFGHIJKLMNOPQRSTUVW$$$$$$XYZ[\\]^_`abcdefghijklmnopq" ;
#line 89 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
void HTTP_b64_decode4(unsigned char in[4], unsigned char out[3])
 {
 out[0] = (in[0] << 2) | (in[1] >> 4) ;
 out[1] = (in[1] << 4) | (in[2] >> 2) ;
 out[2] = ((in[2] << 6) & 0xc0) | in[3] ;
 }
#line 99 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
void HTTP_b64_unencode(char *src, char *dst)
 {
 unsigned char in[4], out[3], v;
 int i, len;

 while(*src)
 {
 for(len = 0, i = 0 ; i < 4 && *src ; i++)
 {
 v = 0;
 while(*src && (v == 0))
 {
 v = *src++ ;
 v = ((v < 43 || v > 122) ? 0 : HTTP_b64_reverse[v - 43]) ;
 if(v)
 {
 v = ((v == '$') ? 0 : v - 61) ;
 }
 }
 if(*src)
 {
 len++;
 if(v)
 {
 in[i] = (v - 1) ;
 }
 }
 else
 {
 in[i] = 0 ;
 }
 }

 if(len)
 {
 HTTP_b64_decode4(in, out) ;
 for(i = 0 ; i < len - 1 ; i++)
 {
 *dst = out[i] ;
 dst++ ;
 }
 }
 }

 *dst = 0 ;
 }
#line 159 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
unsigned char HTTP_basicRealm(unsigned int l, unsigned char *passwd)
 {
 unsigned int len = 0 ;
 unsigned int i ;
 unsigned char auth[ 128 ] ;
 unsigned char login[ 30  + 1] ;
 unsigned char found ;

 i = 0 ;
 found = 0 ;
 while(l--)
 {
 auth[i] = SPI_Ethernet_getByte() ;
 if((auth[i] < 32) || (i ==  128  - 1))
 {
 if(memcmp(auth,  "Authorization: Basic " , sizeof( "Authorization: Basic " ) - 1) == 0)
 {
 auth[i] = 0 ;
 HTTP_b64_unencode(auth + sizeof( "Authorization: Basic " ) - 1, login) ;
 if(strcmp(login, passwd) == 0)
 {
 found = 1 ;
 }
 break ;
 }
 i = 0 ;
 }
 else
 {
 i++ ;
 }
 }

 return(found) ;
 }
#line 202 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
unsigned char HTTP_getRequest(unsigned char *buf, unsigned int *len, unsigned int max)
 {
 unsigned int i ;
#line 209 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
 if((SPI_Ethernet_getByte() != 'G')
 || (SPI_Ethernet_getByte() != 'E')
 || (SPI_Ethernet_getByte() != 'T')
 || (SPI_Ethernet_getByte() != ' ')
 )
 {
 return(0) ;
 }
#line 221 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
 for(i = 0 ; (i < max) && *len ; i++, buf++)
 {
 *buf = SPI_Ethernet_getByte() ;
 (*len)-- ;
 if(*buf < 32) break ;
 }
 *(buf) = 0 ;

 return(1) ;
 }
#line 244 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
unsigned int HTTP_accessDenied(const unsigned char *zn, const unsigned char *m)
 {
 unsigned int len ;

 len = SPI_Ethernet_putConstString(HTTP_Denied) ;
 len += SPI_Ethernet_putConstString(zn) ;
 len += SPI_Ethernet_putConstString("\"\n\n") ;
 len += SPI_Ethernet_putConstString(m) ;

 return(len) ;
 }
#line 260 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
unsigned int HTTP_redirect(unsigned char *url)
 {
 unsigned int len ;

 len = SPI_Ethernet_putConstString(HTTP_Redir) ;
 len += SPI_Ethernet_putString(url) ;
 len += SPI_Ethernet_putConstString("\n\n") ;

 return(len) ;
 }
#line 275 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
unsigned int HTTP_html(const unsigned char *html)
 {
 unsigned int len ;

 len = SPI_Ethernet_putConstString(HTTP_HeaderHtml) ;
 len += SPI_Ethernet_putConstString(html) ;

 return(len) ;
 }
#line 289 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
unsigned int HTTP_imageGIF(const unsigned char *img, unsigned int l)
 {
 unsigned int len ;

 len = SPI_Ethernet_putConstString(HTTP_HeaderGif) ;
 SPI_Ethernet_putConstBytes(img, l) ;
 len += l;

 return(len) ;
 }
#line 304 "D:/Luka-Probe/Git/Digitalni-Sat/httpUtils.c"
unsigned int HTTP_error()
 {
 int len;

 len = SPI_Ethernet_putConstString(HTTP_NotFound) ;

 return(len) ;
 }
