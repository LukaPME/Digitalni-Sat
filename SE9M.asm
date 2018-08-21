
_Eth_Obrada:

;SE9M.c,504 :: 		void Eth_Obrada() {
;SE9M.c,505 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada0
;SE9M.c,507 :: 		if (lease_time >= 60) {
	MOVLW       60
	SUBWF       _lease_time+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Eth_Obrada1
;SE9M.c,508 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,509 :: 		while (!SPI_Ethernet_renewDHCP(5))   // try to renew until it works
L_Eth_Obrada2:
	MOVLW       5
	MOVWF       FARG_SPI_Ethernet_renewDHCP_tmax+0 
	CALL        _SPI_Ethernet_renewDHCP+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada3
;SE9M.c,510 :: 		;
	GOTO        L_Eth_Obrada2
L_Eth_Obrada3:
;SE9M.c,511 :: 		}
L_Eth_Obrada1:
;SE9M.c,512 :: 		}
L_Eth_Obrada0:
;SE9M.c,513 :: 		if (link == 1) {
	MOVF        _link+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada4
;SE9M.c,515 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,516 :: 		Spi_Ethernet_doPacket() ;
	CALL        _SPI_Ethernet_doPacket+0, 0
;SE9M.c,518 :: 		}
L_Eth_Obrada4:
;SE9M.c,519 :: 		}
L_end_Eth_Obrada:
	RETURN      0
; end of _Eth_Obrada

_saveConf:

;SE9M.c,524 :: 		void    saveConf()
;SE9M.c,537 :: 		}
L_end_saveConf:
	RETURN      0
; end of _saveConf

_mkMarquee:

;SE9M.c,542 :: 		void    mkMarquee(unsigned char l)
;SE9M.c,547 :: 		if((*marquee == 0) || (marquee == 0))
	MOVFF       _marquee+0, FSR0
	MOVFF       _marquee+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee515
	MOVLW       0
	XORWF       _marquee+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkMarquee581
	MOVLW       0
	XORWF       _marquee+0, 0 
L__mkMarquee581:
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee515
	GOTO        L_mkMarquee7
L__mkMarquee515:
;SE9M.c,549 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,550 :: 		}
L_mkMarquee7:
;SE9M.c,551 :: 		if((len=strlen(marquee)) < 16) {
	MOVF        _marquee+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        _marquee+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       mkMarquee_len_L0+0 
	MOVLW       16
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mkMarquee8
;SE9M.c,552 :: 		memcpy(marqeeBuff, marquee, len) ;
	MOVLW       mkMarquee_marqeeBuff_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(mkMarquee_marqeeBuff_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        _marquee+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        _marquee+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVF        mkMarquee_len_L0+0, 0 
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,553 :: 		memcpy(marqeeBuff+len, bufInfo, 16-len) ;
	MOVLW       mkMarquee_marqeeBuff_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(mkMarquee_marqeeBuff_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        mkMarquee_len_L0+0, 0 
	ADDWF       FARG_memcpy_d1+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_memcpy_d1+1, 1 
	MOVLW       _bufInfo+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVF        mkMarquee_len_L0+0, 0 
	SUBLW       16
	MOVWF       FARG_memcpy_n+0 
	CLRF        FARG_memcpy_n+1 
	MOVLW       0
	SUBWFB      FARG_memcpy_n+1, 1 
	CALL        _memcpy+0, 0
;SE9M.c,554 :: 		}
	GOTO        L_mkMarquee9
L_mkMarquee8:
;SE9M.c,556 :: 		memcpy(marqeeBuff, marquee, 16) ;
	MOVLW       mkMarquee_marqeeBuff_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(mkMarquee_marqeeBuff_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        _marquee+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        _marquee+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_mkMarquee9:
;SE9M.c,557 :: 		marqeeBuff[16] = 0 ;
	CLRF        mkMarquee_marqeeBuff_L0+16 
;SE9M.c,560 :: 		}
L_end_mkMarquee:
	RETURN      0
; end of _mkMarquee

_DNSavings:

;SE9M.c,611 :: 		void DNSavings() {
;SE9M.c,612 :: 		tmzn = 2;
	MOVLW       2
	MOVWF       _tmzn+0 
;SE9M.c,653 :: 		}
L_end_DNSavings:
	RETURN      0
; end of _DNSavings

_int2str:

;SE9M.c,658 :: 		void    int2str(long l, unsigned char *s)
;SE9M.c,662 :: 		if(l == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_int2str_l+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str584
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str584
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str584
	MOVF        FARG_int2str_l+0, 0 
	XORLW       0
L__int2str584:
	BTFSS       STATUS+0, 2 
	GOTO        L_int2str10
;SE9M.c,664 :: 		s[0] = '0' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	MOVWF       POSTINC1+0 
;SE9M.c,665 :: 		s[1] = 0 ;
	MOVLW       1
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,666 :: 		}
	GOTO        L_int2str11
L_int2str10:
;SE9M.c,669 :: 		if(l < 0)
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str585
	MOVLW       0
	SUBWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str585
	MOVLW       0
	SUBWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str585
	MOVLW       0
	SUBWF       FARG_int2str_l+0, 0 
L__int2str585:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str12
;SE9M.c,671 :: 		l *= -1 ;
	MOVF        FARG_int2str_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_int2str_l+1, 0 
	MOVWF       R1 
	MOVF        FARG_int2str_l+2, 0 
	MOVWF       R2 
	MOVF        FARG_int2str_l+3, 0 
	MOVWF       R3 
	MOVLW       255
	MOVWF       R4 
	MOVLW       255
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        R1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVF        R2, 0 
	MOVWF       FARG_int2str_l+2 
	MOVF        R3, 0 
	MOVWF       FARG_int2str_l+3 
;SE9M.c,672 :: 		n = 1 ;
	MOVLW       1
	MOVWF       int2str_n_L0+0 
;SE9M.c,673 :: 		}
	GOTO        L_int2str13
L_int2str12:
;SE9M.c,676 :: 		n = 0 ;
	CLRF        int2str_n_L0+0 
;SE9M.c,677 :: 		}
L_int2str13:
;SE9M.c,678 :: 		s[0] = 0 ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,679 :: 		i = 0 ;
	CLRF        int2str_i_L0+0 
;SE9M.c,680 :: 		while(l > 0)
L_int2str14:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str586
	MOVF        FARG_int2str_l+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str586
	MOVF        FARG_int2str_l+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str586
	MOVF        FARG_int2str_l+0, 0 
	SUBLW       0
L__int2str586:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str15
;SE9M.c,682 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str16:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str17
;SE9M.c,684 :: 		s[j] = s[j - 1] ;
	MOVF        int2str_j_L0+0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	DECF        int2str_j_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,682 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,685 :: 		}
	GOTO        L_int2str16
L_int2str17:
;SE9M.c,686 :: 		s[0] = l % 10 ;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_int2str_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_int2str_l+1, 0 
	MOVWF       R1 
	MOVF        FARG_int2str_l+2, 0 
	MOVWF       R2 
	MOVF        FARG_int2str_l+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,687 :: 		s[0] += '0' ;
	MOVFF       FARG_int2str_s+0, FSR0
	MOVFF       FARG_int2str_s+1, FSR0H
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	ADDWF       POSTINC0+0, 1 
;SE9M.c,688 :: 		i++ ;
	INCF        int2str_i_L0+0, 1 
;SE9M.c,689 :: 		l /= 10 ;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_int2str_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_int2str_l+1, 0 
	MOVWF       R1 
	MOVF        FARG_int2str_l+2, 0 
	MOVWF       R2 
	MOVF        FARG_int2str_l+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        R1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVF        R2, 0 
	MOVWF       FARG_int2str_l+2 
	MOVF        R3, 0 
	MOVWF       FARG_int2str_l+3 
;SE9M.c,690 :: 		}
	GOTO        L_int2str14
L_int2str15:
;SE9M.c,691 :: 		if(n)
	MOVF        int2str_n_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_int2str19
;SE9M.c,693 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str20:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str21
;SE9M.c,695 :: 		s[j] = s[j - 1] ;
	MOVF        int2str_j_L0+0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	DECF        int2str_j_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,693 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,696 :: 		}
	GOTO        L_int2str20
L_int2str21:
;SE9M.c,697 :: 		s[0] = '-' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       45
	MOVWF       POSTINC1+0 
;SE9M.c,698 :: 		}
L_int2str19:
;SE9M.c,699 :: 		}
L_int2str11:
;SE9M.c,700 :: 		}
L_end_int2str:
	RETURN      0
; end of _int2str

_ip2str:

;SE9M.c,705 :: 		void    ip2str(unsigned char *s, unsigned char *ip)
;SE9M.c,710 :: 		*s = 0 ;
	MOVFF       FARG_ip2str_s+0, FSR1
	MOVFF       FARG_ip2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,711 :: 		for(i = 0 ; i < 4 ; i++)
	CLRF        ip2str_i_L0+0 
L_ip2str23:
	MOVLW       4
	SUBWF       ip2str_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ip2str24
;SE9M.c,713 :: 		int2str(ip[i], buf) ;
	MOVF        ip2str_i_L0+0, 0 
	ADDWF       FARG_ip2str_ip+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ip2str_ip+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       ip2str_buf_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(ip2str_buf_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,714 :: 		strcat(s, buf) ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ip2str_buf_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ip2str_buf_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,715 :: 		if(i != 3)
	MOVF        ip2str_i_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ip2str26
;SE9M.c,716 :: 		strcat(s, ".") ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr45_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr45_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
L_ip2str26:
;SE9M.c,711 :: 		for(i = 0 ; i < 4 ; i++)
	INCF        ip2str_i_L0+0, 1 
;SE9M.c,717 :: 		}
	GOTO        L_ip2str23
L_ip2str24:
;SE9M.c,718 :: 		}
L_end_ip2str:
	RETURN      0
; end of _ip2str

_ts2str:

;SE9M.c,724 :: 		void    ts2str(unsigned char *s, TimeStruct *t, unsigned char m)
;SE9M.c,731 :: 		if(m & TS2STR_DATE)
	BTFSS       FARG_ts2str_m+0, 0 
	GOTO        L_ts2str27
;SE9M.c,733 :: 		strcpy(s, wday[t->wd]) ;        // week day
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcpy_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcpy_to+1 
	MOVLW       4
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _wday+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_wday+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,734 :: 		danuned = t->wd;
	MOVLW       4
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _danuned+0 
;SE9M.c,735 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr46_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr46_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,736 :: 		ByteToStr(t->md, tmp) ;         // day num
	MOVLW       3
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,737 :: 		dan = t->md;
	MOVLW       3
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _dan+0 
;SE9M.c,738 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,739 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr47_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr47_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,740 :: 		strcat(s, mon[t->mo]) ;        // month
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       5
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _mon+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_mon+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcat_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,741 :: 		mesec = t->mo;
	MOVLW       5
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _mesec+0 
;SE9M.c,742 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr48_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr48_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,743 :: 		WordToStr(t->yy, tmp) ;         // year
	MOVLW       6
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;SE9M.c,744 :: 		godina = t->yy;
	MOVLW       6
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ts2str+4 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ts2str+5 
	MOVF        FLOC__ts2str+4, 0 
	MOVWF       _godina+0 
	MOVF        FLOC__ts2str+5, 0 
	MOVWF       _godina+1 
;SE9M.c,745 :: 		godyear1 = godina / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FLOC__ts2str+4, 0 
	MOVWF       R0 
	MOVF        FLOC__ts2str+5, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _godyear1+0 
;SE9M.c,746 :: 		godyear2 = (godina - godyear1 * 1000) / 100;
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ts2str+2 
	MOVF        R1, 0 
	MOVWF       FLOC__ts2str+3 
	MOVF        FLOC__ts2str+2, 0 
	SUBWF       FLOC__ts2str+4, 0 
	MOVWF       R0 
	MOVF        FLOC__ts2str+3, 0 
	SUBWFB      FLOC__ts2str+5, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _godyear2+0 
;SE9M.c,747 :: 		godyear3 = (godina - godyear1 * 1000 - godyear2 * 100) / 10;
	MOVF        FLOC__ts2str+2, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R2, 0 
	SUBWF       FLOC__ts2str+4, 0 
	MOVWF       R2 
	MOVF        R3, 0 
	SUBWFB      FLOC__ts2str+5, 0 
	MOVWF       R3 
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       FLOC__ts2str+0 
	MOVF        PRODH+0, 0 
	MOVWF       FLOC__ts2str+1 
	MOVF        FLOC__ts2str+0, 0 
	SUBWF       R2, 0 
	MOVWF       R0 
	MOVF        FLOC__ts2str+1, 0 
	SUBWFB      R3, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _godyear3+0 
;SE9M.c,748 :: 		godyear4 = godina - godyear1 * 1000 - godyear2 * 100 - godyear3 * 10;
	MOVF        FLOC__ts2str+2, 0 
	SUBWF       FLOC__ts2str+4, 0 
	MOVWF       R2 
	MOVF        FLOC__ts2str+0, 0 
	SUBWF       R2, 1 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBWF       R2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _godyear4+0 
;SE9M.c,749 :: 		fingodina = godyear3 * 10 + godyear4;
	MOVF        R1, 0 
	MOVWF       _fingodina+0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       _fingodina+0 
;SE9M.c,750 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,751 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr49_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr49_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,752 :: 		}
	GOTO        L_ts2str28
L_ts2str27:
;SE9M.c,755 :: 		*s = 0 ;
	MOVFF       FARG_ts2str_s+0, FSR1
	MOVFF       FARG_ts2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,756 :: 		}
L_ts2str28:
;SE9M.c,761 :: 		if(m & TS2STR_TIME)
	BTFSS       FARG_ts2str_m+0, 1 
	GOTO        L_ts2str29
;SE9M.c,763 :: 		ByteToStr(t->hh, tmp) ;         // hour
	MOVLW       2
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,764 :: 		sati = t->hh;
	MOVLW       2
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _sati+0 
;SE9M.c,765 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,766 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr50_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr50_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,767 :: 		ByteToStr(t->mn, tmp) ;         // minute
	MOVLW       1
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,768 :: 		minuti = (t->mn);
	MOVLW       1
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _minuti+0 
;SE9M.c,769 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str30
;SE9M.c,771 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,772 :: 		}
L_ts2str30:
;SE9M.c,773 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,774 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr51_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr51_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,775 :: 		ByteToStr(t->ss, tmp) ;         // second
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,776 :: 		sekundi = t->ss;
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _sekundi+0 
;SE9M.c,777 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str31
;SE9M.c,779 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,780 :: 		}
L_ts2str31:
;SE9M.c,781 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,782 :: 		}
L_ts2str29:
;SE9M.c,787 :: 		if(m & TS2STR_TZ)
	BTFSS       FARG_ts2str_m+0, 2 
	GOTO        L_ts2str32
;SE9M.c,789 :: 		strcat(s, " GMT") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr52_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr52_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,790 :: 		if(conf.tz > 0)
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _conf+2, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ts2str33
;SE9M.c,792 :: 		strcat(s, "+") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr53_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr53_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,793 :: 		}
L_ts2str33:
;SE9M.c,794 :: 		int2str(conf.tz, s + strlen(s)) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_ts2str_s+0, 0 
	MOVWF       FARG_int2str_s+0 
	MOVF        R1, 0 
	ADDWFC      FARG_ts2str_s+1, 0 
	MOVWF       FARG_int2str_s+1 
	MOVF        _conf+2, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	BTFSC       _conf+2, 7 
	MOVLW       255
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	CALL        _int2str+0, 0
;SE9M.c,795 :: 		}
L_ts2str32:
;SE9M.c,796 :: 		}
L_end_ts2str:
	RETURN      0
; end of _ts2str

_nibble2hex:

;SE9M.c,801 :: 		unsigned char nibble2hex(unsigned char n)
;SE9M.c,803 :: 		n &= 0x0f ;
	MOVLW       15
	ANDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_nibble2hex_n+0 
;SE9M.c,804 :: 		if(n >= 0x0a)
	MOVLW       10
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_nibble2hex34
;SE9M.c,806 :: 		return(n + '7') ;
	MOVLW       55
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
	GOTO        L_end_nibble2hex
;SE9M.c,807 :: 		}
L_nibble2hex34:
;SE9M.c,808 :: 		return(n + '0') ;
	MOVLW       48
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
;SE9M.c,809 :: 		}
L_end_nibble2hex:
	RETURN      0
; end of _nibble2hex

_byte2hex:

;SE9M.c,814 :: 		void    byte2hex(unsigned char *s, unsigned char v)
;SE9M.c,816 :: 		*s++ = nibble2hex(v >> 4) ;
	MOVF        FARG_byte2hex_v+0, 0 
	MOVWF       FARG_nibble2hex_n+0 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	CALL        _nibble2hex+0, 0
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_byte2hex_s+0, 1 
	INCF        FARG_byte2hex_s+1, 1 
;SE9M.c,817 :: 		*s++ = nibble2hex(v) ;
	MOVF        FARG_byte2hex_v+0, 0 
	MOVWF       FARG_nibble2hex_n+0 
	CALL        _nibble2hex+0, 0
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_byte2hex_s+0, 1 
	INCF        FARG_byte2hex_s+1, 1 
;SE9M.c,818 :: 		*s = '.' ;
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVLW       46
	MOVWF       POSTINC1+0 
;SE9M.c,819 :: 		}
L_end_byte2hex:
	RETURN      0
; end of _byte2hex

_mkLCDselect:

;SE9M.c,824 :: 		unsigned int    mkLCDselect(unsigned char l, unsigned char m)
;SE9M.c,829 :: 		len = putConstString("<select onChange=\\\"document.location.href = '/admin/") ;
	MOVLW       ?lstr_54_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_54_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_54_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       mkLCDselect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       mkLCDselect_len_L0+1 
;SE9M.c,830 :: 		SPI_Ethernet_putByte('0' + l) ; len++ ;
	MOVF        FARG_mkLCDselect_l+0, 0 
	ADDLW       48
	MOVWF       FARG_SPI_Ethernet_putByte_v+0 
	CALL        _SPI_Ethernet_putByte+0, 0
	INFSNZ      mkLCDselect_len_L0+0, 1 
	INCF        mkLCDselect_len_L0+1, 1 
;SE9M.c,831 :: 		len += putConstString("/' + this.selectedIndex\\\">") ;
	MOVLW       ?lstr_55_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_55_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_55_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,832 :: 		for(i = 0 ; i < 2 ; i++)
	CLRF        mkLCDselect_i_L0+0 
L_mkLCDselect35:
	MOVLW       2
	SUBWF       mkLCDselect_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mkLCDselect36
;SE9M.c,834 :: 		len += putConstString("<option ") ;
	MOVLW       ?lstr_56_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_56_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_56_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,835 :: 		if(i == m)
	MOVF        mkLCDselect_i_L0+0, 0 
	XORWF       FARG_mkLCDselect_m+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkLCDselect38
;SE9M.c,837 :: 		len += putConstString(" selected") ;
	MOVLW       ?lstr_57_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_57_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_57_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,838 :: 		}
L_mkLCDselect38:
;SE9M.c,839 :: 		len += putConstString(">") ;
	MOVLW       ?lstr_58_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_58_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_58_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,840 :: 		len += putConstString(LCDoption[i]) ;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        mkLCDselect_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _LCDoption+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_LCDoption+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,832 :: 		for(i = 0 ; i < 2 ; i++)
	INCF        mkLCDselect_i_L0+0, 1 
;SE9M.c,841 :: 		}
	GOTO        L_mkLCDselect35
L_mkLCDselect36:
;SE9M.c,842 :: 		len += putConstString("</select>\";") ;
	MOVLW       ?lstr_59_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_59_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_59_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        mkLCDselect_len_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        mkLCDselect_len_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       mkLCDselect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       mkLCDselect_len_L0+1 
;SE9M.c,843 :: 		return(len) ;
;SE9M.c,844 :: 		}
L_end_mkLCDselect:
	RETURN      0
; end of _mkLCDselect

_mkLCDLine:

;SE9M.c,849 :: 		void mkLCDLine(unsigned char l, unsigned char m)
;SE9M.c,851 :: 		switch(m)
	GOTO        L_mkLCDLine39
;SE9M.c,853 :: 		case 0:
L_mkLCDLine41:
;SE9M.c,855 :: 		memset(bufInfo, 0, sizeof(bufInfo)) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       200
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SE9M.c,856 :: 		if(lastSync)
	MOVF        _lastSync+0, 0 
	IORWF       _lastSync+1, 0 
	IORWF       _lastSync+2, 0 
	IORWF       _lastSync+3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine42
;SE9M.c,859 :: 		strcpy(bufInfo, "Today is ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr60_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr60_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,860 :: 		ts2str(bufInfo + strlen(bufInfo), &ts, TS2STR_DATE) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       _bufInfo+0
	ADDWF       R0, 0 
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       1
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,861 :: 		strcat(bufInfo, ". Please visit www.micro-examples.com for more details about the Ethernal Clock. You can browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr61_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr61_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,862 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       _bufInfo+0
	ADDWF       R0, 0 
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,863 :: 		strcat(bufInfo, " to set the clock preferences.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr62_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr62_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,864 :: 		}
	GOTO        L_mkLCDLine43
L_mkLCDLine42:
;SE9M.c,868 :: 		strcpy(bufInfo, "The SNTP server did not respond, please browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr63_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr63_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,869 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       _bufInfo+0
	ADDWF       R0, 0 
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,870 :: 		strcat(bufInfo, " to check clock settings.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr64_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr64_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,871 :: 		}
L_mkLCDLine43:
;SE9M.c,872 :: 		mkMarquee(l) ;           // display marquee
	MOVF        FARG_mkLCDLine_l+0, 0 
	MOVWF       FARG_mkMarquee_l+0 
	CALL        _mkMarquee+0, 0
;SE9M.c,873 :: 		break ;
	GOTO        L_mkLCDLine40
;SE9M.c,874 :: 		case 1:
L_mkLCDLine44:
;SE9M.c,878 :: 		ts2str(bufInfo, &ts, TS2STR_DATE) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       1
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,884 :: 		break ;
	GOTO        L_mkLCDLine40
;SE9M.c,885 :: 		case 2:
L_mkLCDLine45:
;SE9M.c,889 :: 		ts2str(bufInfo, &ts, TS2STR_TIME) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       2
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,895 :: 		break ;
	GOTO        L_mkLCDLine40
;SE9M.c,896 :: 		}
L_mkLCDLine39:
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine41
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine44
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine45
L_mkLCDLine40:
;SE9M.c,897 :: 		}
L_end_mkLCDLine:
	RETURN      0
; end of _mkLCDLine

_mkSNTPrequest:

;SE9M.c,902 :: 		void    mkSNTPrequest()
;SE9M.c,907 :: 		if (sntpSync)
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest46
;SE9M.c,908 :: 		if (SPI_Ethernet_UserTimerSec >= sntpTimer)
	MOVF        _sntpTimer+3, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest594
	MOVF        _sntpTimer+2, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest594
	MOVF        _sntpTimer+1, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest594
	MOVF        _sntpTimer+0, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+0, 0 
L__mkSNTPrequest594:
	BTFSS       STATUS+0, 0 
	GOTO        L_mkSNTPrequest47
;SE9M.c,909 :: 		if (!lastSync) {
	MOVF        _lastSync+0, 0 
	IORWF       _lastSync+1, 0 
	IORWF       _lastSync+2, 0 
	IORWF       _lastSync+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkSNTPrequest48
;SE9M.c,910 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,911 :: 		if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
	MOVLW       _conf+3
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr65_SE9M+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr65_SE9M+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       4
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkSNTPrequest49
;SE9M.c,912 :: 		reloadDNS = 1 ; // force to solve DNS
	MOVLW       1
	MOVWF       _reloadDNS+0 
L_mkSNTPrequest49:
;SE9M.c,913 :: 		}
L_mkSNTPrequest48:
L_mkSNTPrequest47:
L_mkSNTPrequest46:
;SE9M.c,915 :: 		if(reloadDNS)   // is SNTP ip address to be reloaded from DNS ?
	MOVF        _reloadDNS+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest50
;SE9M.c,920 :: 		if(isalpha(*conf.sntpServer))   // doest host name start with an alphabetic character ?
	MOVF        _conf+7, 0 
	MOVWF       FARG_isalpha_character+0 
	CALL        _isalpha+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest51
;SE9M.c,923 :: 		memset(conf.sntpIP, 0, 4);
	MOVLW       _conf+3
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SE9M.c,924 :: 		if(remoteIpAddr = SPI_Ethernet_dnsResolve(conf.sntpServer, 5))
	MOVLW       _conf+7
	MOVWF       FARG_SPI_Ethernet_dnsResolve_host+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       FARG_SPI_Ethernet_dnsResolve_host+1 
	MOVLW       5
	MOVWF       FARG_SPI_Ethernet_dnsResolve_tmax+0 
	CALL        _SPI_Ethernet_dnsResolve+0, 0
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_remoteIpAddr_L0+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_remoteIpAddr_L0+1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest52
;SE9M.c,927 :: 		memcpy(conf.sntpIP, remoteIpAddr, 4) ;
	MOVLW       _conf+3
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        mkSNTPrequest_remoteIpAddr_L0+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        mkSNTPrequest_remoteIpAddr_L0+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,928 :: 		}
L_mkSNTPrequest52:
;SE9M.c,929 :: 		}
	GOTO        L_mkSNTPrequest53
L_mkSNTPrequest51:
;SE9M.c,933 :: 		unsigned char *ptr = conf.sntpServer ;
	MOVLW       _conf+7
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,935 :: 		conf.sntpIP[0] = atoi(ptr) ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+3 
;SE9M.c,936 :: 		ptr = strchr(ptr, '.') + 1 ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVLW       46
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,937 :: 		conf.sntpIP[1] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+4 
;SE9M.c,938 :: 		ptr = strchr(ptr, '.') + 1 ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVLW       46
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,939 :: 		conf.sntpIP[2] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+5 
;SE9M.c,940 :: 		ptr = strchr(ptr, '.') + 1 ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVLW       46
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,941 :: 		conf.sntpIP[3] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+6 
;SE9M.c,942 :: 		}
L_mkSNTPrequest53:
;SE9M.c,944 :: 		saveConf() ;            // store to EEPROM
	CALL        _saveConf+0, 0
;SE9M.c,946 :: 		reloadDNS = 0 ;         // no further call to DNS
	CLRF        _reloadDNS+0 
;SE9M.c,948 :: 		sntpSync = 0 ;          // clock is not sync for now
	CLRF        _sntpSync+0 
;SE9M.c,949 :: 		}
L_mkSNTPrequest50:
;SE9M.c,951 :: 		if(sntpSync)                    // is clock already synchronized from sntp ?
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest54
;SE9M.c,953 :: 		return ;                // yes, no need to request time
	GOTO        L_end_mkSNTPrequest
;SE9M.c,954 :: 		}
L_mkSNTPrequest54:
;SE9M.c,959 :: 		memset(sntpPkt, 0, 48) ;        // clear sntp packet
	MOVLW       mkSNTPrequest_sntpPkt_L0+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(mkSNTPrequest_sntpPkt_L0+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       48
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SE9M.c,962 :: 		sntpPkt[0] = 0b00011001 ;       // LI = 0 ; VN = 3 ; MODE = 1
	MOVLW       25
	MOVWF       mkSNTPrequest_sntpPkt_L0+0 
;SE9M.c,967 :: 		sntpPkt[2] = 0x0a ;             // 1024 sec (arbitrary value)
	MOVLW       10
	MOVWF       mkSNTPrequest_sntpPkt_L0+2 
;SE9M.c,970 :: 		sntpPkt[3] = 0xfa ;             // 0.015625 sec (arbitrary value)
	MOVLW       250
	MOVWF       mkSNTPrequest_sntpPkt_L0+3 
;SE9M.c,973 :: 		sntpPkt[6] = 0x44 ;
	MOVLW       68
	MOVWF       mkSNTPrequest_sntpPkt_L0+6 
;SE9M.c,976 :: 		sntpPkt[9] = 0x10 ;
	MOVLW       16
	MOVWF       mkSNTPrequest_sntpPkt_L0+9 
;SE9M.c,988 :: 		SPI_Ethernet_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48) ; // transmit UDP packet
	MOVLW       _conf+3
	MOVWF       FARG_SPI_Ethernet_sendUDP_destIP+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_SPI_Ethernet_sendUDP_destIP+1 
	MOVLW       123
	MOVWF       FARG_SPI_Ethernet_sendUDP_sourcePort+0 
	MOVLW       0
	MOVWF       FARG_SPI_Ethernet_sendUDP_sourcePort+1 
	MOVLW       123
	MOVWF       FARG_SPI_Ethernet_sendUDP_destPort+0 
	MOVLW       0
	MOVWF       FARG_SPI_Ethernet_sendUDP_destPort+1 
	MOVLW       mkSNTPrequest_sntpPkt_L0+0
	MOVWF       FARG_SPI_Ethernet_sendUDP_pkt+0 
	MOVLW       hi_addr(mkSNTPrequest_sntpPkt_L0+0)
	MOVWF       FARG_SPI_Ethernet_sendUDP_pkt+1 
	MOVLW       48
	MOVWF       FARG_SPI_Ethernet_sendUDP_pktLen+0 
	MOVLW       0
	MOVWF       FARG_SPI_Ethernet_sendUDP_pktLen+1 
	CALL        _SPI_Ethernet_sendUDP+0, 0
;SE9M.c,990 :: 		sntpSync = 1 ;  // done
	MOVLW       1
	MOVWF       _sntpSync+0 
;SE9M.c,991 :: 		lastSync = 0 ;
	CLRF        _lastSync+0 
	CLRF        _lastSync+1 
	CLRF        _lastSync+2 
	CLRF        _lastSync+3 
;SE9M.c,992 :: 		sntpTimer = SPI_Ethernet_UserTimerSec + 2;
	MOVLW       2
	ADDWF       _SPI_Ethernet_UserTimerSec+0, 0 
	MOVWF       _sntpTimer+0 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+1, 0 
	MOVWF       _sntpTimer+1 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+2, 0 
	MOVWF       _sntpTimer+2 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+3, 0 
	MOVWF       _sntpTimer+3 
;SE9M.c,993 :: 		}
L_end_mkSNTPrequest:
	RETURN      0
; end of _mkSNTPrequest

_Rst_Eth:

;SE9M.c,995 :: 		void Rst_Eth() {
;SE9M.c,996 :: 		SPI_Ethernet_Rst = 0;
	BCF         RA5_bit+0, BitPos(RA5_bit+0) 
;SE9M.c,997 :: 		reset_eth = 1;
	MOVLW       1
	MOVWF       _reset_eth+0 
;SE9M.c,999 :: 		}
L_end_Rst_Eth:
	RETURN      0
; end of _Rst_Eth

_SPI_Ethernet_UserTCP:

;SE9M.c,1004 :: 		unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
;SE9M.c,1009 :: 		unsigned int    len = 0 ;
	CLRF        SPI_Ethernet_UserTCP_len_L0+0 
	CLRF        SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1019 :: 		if (localPort != 80)                    // I listen only to web request on port 80
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP597
	MOVLW       80
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+0, 0 
L__SPI_Ethernet_UserTCP597:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP55
;SE9M.c,1021 :: 		return(0) ;                     // return without reply
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;SE9M.c,1022 :: 		}
L_SPI_Ethernet_UserTCP55:
;SE9M.c,1027 :: 		if (HTTP_getRequest(getRequest, &reqLength, HTTP_REQUEST_SIZE) == 0)
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+0
	MOVWF       FARG_HTTP_getRequest_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+0)
	MOVWF       FARG_HTTP_getRequest_ptr+1 
	MOVLW       FARG_SPI_Ethernet_UserTCP_reqLength+0
	MOVWF       FARG_HTTP_getRequest_len+0 
	MOVLW       hi_addr(FARG_SPI_Ethernet_UserTCP_reqLength+0)
	MOVWF       FARG_HTTP_getRequest_len+1 
	MOVLW       128
	MOVWF       FARG_HTTP_getRequest_max+0 
	MOVLW       0
	MOVWF       FARG_HTTP_getRequest_max+1 
	CALL        _HTTP_getRequest+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP56
;SE9M.c,1029 :: 		return(0) ;                     // no reply if no GET request
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;SE9M.c,1030 :: 		}
L_SPI_Ethernet_UserTCP56:
;SE9M.c,1036 :: 		if(memcmp(getRequest, path_private, sizeof(path_private) - 1) == 0)   // is path under private section ?
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _path_private+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_path_private+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       6
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP598
	MOVLW       0
	XORWF       R0, 0 
L__SPI_Ethernet_UserTCP598:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP57
;SE9M.c,1053 :: 		if(getRequest[sizeof(path_private)] == 's')
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       115
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP58
;SE9M.c,1057 :: 		len = putConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1058 :: 		len += putConstString(httpMimeTypeScript) ;     // with script MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1060 :: 		if (admin == 0) {
	MOVF        _admin+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP59
;SE9M.c,1063 :: 		len += putConstString("var PASS=\"") ;
	MOVLW       ?lstr_66_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_66_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_66_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1064 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_67_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_67_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_67_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1065 :: 		len += putString("password") ;
	MOVLW       ?lstr68_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(?lstr68_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1066 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/v/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_69_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_69_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_69_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1067 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_70_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_70_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_70_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1069 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP60
L_SPI_Ethernet_UserTCP59:
;SE9M.c,1071 :: 		uzobyte = 1;
	MOVLW       1
	MOVWF       _uzobyte+0 
;SE9M.c,1073 :: 		len += putConstString("var DHCPEN=\"") ;
	MOVLW       ?lstr_71_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_71_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_71_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1074 :: 		len += mkLCDselect(1, conf.dhcpen) ;
	MOVLW       1
	MOVWF       FARG_mkLCDselect_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDselect_m+0 
	CALL        _mkLCDselect+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1087 :: 		len += putConstString("var PASS0=\"") ;
	MOVLW       ?lstr_72_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_72_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_72_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1088 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_73_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_73_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_73_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1089 :: 		len += putString(oldSifra) ;
	MOVLW       _oldSifra+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1090 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/x/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_74_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_74_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_74_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1091 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_75_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_75_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_75_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1094 :: 		len += putConstString("var PASS1=\"") ;
	MOVLW       ?lstr_76_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_76_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_76_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1095 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_77_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_77_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_77_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1096 :: 		len += putString(newSifra) ;
	MOVLW       _newSifra+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1097 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/y/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_78_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_78_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_78_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1098 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_79_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_79_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_79_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1152 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP61
;SE9M.c,1154 :: 		len += putConstString("var SIP=\"") ;
	MOVLW       ?lstr_80_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_80_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_80_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1155 :: 		len += putConstString("<select onChange=\\\"document.location.href = '/admin/u/' + this.selectedIndex\\\">") ;
	MOVLW       ?lstr_81_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_81_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_81_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1156 :: 		for(i = 1 ; i < 5 ; i++)
	MOVLW       1
	MOVWF       SPI_Ethernet_UserTCP_i_L0+0 
	MOVLW       0
	MOVWF       SPI_Ethernet_UserTCP_i_L0+1 
L_SPI_Ethernet_UserTCP62:
	MOVLW       128
	XORWF       SPI_Ethernet_UserTCP_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP599
	MOVLW       5
	SUBWF       SPI_Ethernet_UserTCP_i_L0+0, 0 
L__SPI_Ethernet_UserTCP599:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP63
;SE9M.c,1158 :: 		len += putConstString("<option ") ;
	MOVLW       ?lstr_82_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_82_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_82_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1159 :: 		if(i == s_ip)
	MOVLW       0
	XORWF       SPI_Ethernet_UserTCP_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP600
	MOVF        _s_ip+0, 0 
	XORWF       SPI_Ethernet_UserTCP_i_L0+0, 0 
L__SPI_Ethernet_UserTCP600:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP65
;SE9M.c,1161 :: 		len += putConstString(" selected") ;
	MOVLW       ?lstr_83_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_83_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_83_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1162 :: 		}
L_SPI_Ethernet_UserTCP65:
;SE9M.c,1163 :: 		len += putConstString(">") ;
	MOVLW       ?lstr_84_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_84_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_84_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1164 :: 		len += putConstString(IPoption[i-1]) ;
	MOVLW       1
	SUBWF       SPI_Ethernet_UserTCP_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      SPI_Ethernet_UserTCP_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _IPoption+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_IPoption+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1156 :: 		for(i = 1 ; i < 5 ; i++)
	INFSNZ      SPI_Ethernet_UserTCP_i_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_i_L0+1, 1 
;SE9M.c,1167 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP62
L_SPI_Ethernet_UserTCP63:
;SE9M.c,1168 :: 		len += putConstString("</select>\";") ;
	MOVLW       ?lstr_85_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_85_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_85_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1169 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP66
L_SPI_Ethernet_UserTCP61:
;SE9M.c,1170 :: 		s_ip = 1;
	MOVLW       1
	MOVWF       _s_ip+0 
;SE9M.c,1171 :: 		}
L_SPI_Ethernet_UserTCP66:
;SE9M.c,1173 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP67
;SE9M.c,1175 :: 		len += putConstString("var IP0=\"") ;
	MOVLW       ?lstr_86_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_86_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_86_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1176 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_87_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_87_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_87_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1177 :: 		len += putString(ipAddrPom0) ;
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1178 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP68
;SE9M.c,1179 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_88_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_88_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_88_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1180 :: 		}
L_SPI_Ethernet_UserTCP68:
;SE9M.c,1181 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP69
;SE9M.c,1182 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_89_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_89_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_89_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1183 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP70
L_SPI_Ethernet_UserTCP69:
;SE9M.c,1184 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_90_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_90_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_90_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1185 :: 		}
L_SPI_Ethernet_UserTCP70:
;SE9M.c,1187 :: 		len += putConstString("var IP1=\"") ;
	MOVLW       ?lstr_91_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_91_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_91_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1188 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_92_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_92_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_92_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1189 :: 		len += putString(ipAddrPom1) ;
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1190 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP71
;SE9M.c,1191 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_93_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_93_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_93_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1192 :: 		}
L_SPI_Ethernet_UserTCP71:
;SE9M.c,1193 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP72
;SE9M.c,1194 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_94_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_94_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_94_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1195 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP73
L_SPI_Ethernet_UserTCP72:
;SE9M.c,1196 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_95_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_95_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_95_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1197 :: 		}
L_SPI_Ethernet_UserTCP73:
;SE9M.c,1199 :: 		len += putConstString("var IP2=\"") ;
	MOVLW       ?lstr_96_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_96_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_96_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1200 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_97_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_97_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_97_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1201 :: 		len += putString(ipAddrPom2) ;
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1202 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP74
;SE9M.c,1203 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_98_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_98_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_98_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1204 :: 		}
L_SPI_Ethernet_UserTCP74:
;SE9M.c,1205 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP75
;SE9M.c,1206 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_99_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_99_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_99_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1207 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP76
L_SPI_Ethernet_UserTCP75:
;SE9M.c,1208 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_100_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_100_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_100_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1209 :: 		}
L_SPI_Ethernet_UserTCP76:
;SE9M.c,1211 :: 		len += putConstString("var IP3=\"") ;
	MOVLW       ?lstr_101_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_101_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_101_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1212 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_102_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_102_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_102_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1213 :: 		len += putString(ipAddrPom3) ;
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1214 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP77
;SE9M.c,1215 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_103_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_103_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_103_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1216 :: 		}
L_SPI_Ethernet_UserTCP77:
;SE9M.c,1217 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP78
;SE9M.c,1218 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_104_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_104_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_104_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1219 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP79
L_SPI_Ethernet_UserTCP78:
;SE9M.c,1220 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_105_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_105_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_105_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1221 :: 		}
L_SPI_Ethernet_UserTCP79:
;SE9M.c,1222 :: 		}
L_SPI_Ethernet_UserTCP67:
;SE9M.c,1224 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP80
;SE9M.c,1226 :: 		len += putConstString("var M0=\"") ;
	MOVLW       ?lstr_106_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_106_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_106_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1227 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP81
;SE9M.c,1228 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_107_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_107_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_107_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1229 :: 		len += putString(ipMaskPom0) ;
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1230 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_108_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_108_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_108_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1231 :: 		}
L_SPI_Ethernet_UserTCP81:
;SE9M.c,1234 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP82
;SE9M.c,1235 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_109_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_109_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_109_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1236 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP83
L_SPI_Ethernet_UserTCP82:
;SE9M.c,1237 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_110_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_110_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_110_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1238 :: 		}
L_SPI_Ethernet_UserTCP83:
;SE9M.c,1240 :: 		len += putConstString("var M1=\"") ;
	MOVLW       ?lstr_111_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_111_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_111_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1241 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP84
;SE9M.c,1242 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_112_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_112_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_112_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1243 :: 		len += putString(ipMaskPom1) ;
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1244 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_113_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_113_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_113_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1245 :: 		}
L_SPI_Ethernet_UserTCP84:
;SE9M.c,1248 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP85
;SE9M.c,1249 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_114_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_114_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_114_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1250 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP86
L_SPI_Ethernet_UserTCP85:
;SE9M.c,1251 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_115_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_115_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_115_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1252 :: 		}
L_SPI_Ethernet_UserTCP86:
;SE9M.c,1254 :: 		len += putConstString("var M2=\"") ;
	MOVLW       ?lstr_116_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_116_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_116_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1255 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP87
;SE9M.c,1256 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_117_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_117_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_117_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1257 :: 		len += putString(ipMaskPom2) ;
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1258 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_118_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_118_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_118_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1259 :: 		}
L_SPI_Ethernet_UserTCP87:
;SE9M.c,1262 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP88
;SE9M.c,1263 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_119_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_119_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_119_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1264 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP89
L_SPI_Ethernet_UserTCP88:
;SE9M.c,1265 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_120_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_120_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_120_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1266 :: 		}
L_SPI_Ethernet_UserTCP89:
;SE9M.c,1268 :: 		len += putConstString("var M3=\"") ;
	MOVLW       ?lstr_121_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_121_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_121_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1269 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP90
;SE9M.c,1270 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_122_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_122_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_122_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1271 :: 		len += putString(ipMaskPom3) ;
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1272 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_123_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_123_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_123_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1273 :: 		}
L_SPI_Ethernet_UserTCP90:
;SE9M.c,1276 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP91
;SE9M.c,1277 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_124_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_124_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_124_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1278 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP92
L_SPI_Ethernet_UserTCP91:
;SE9M.c,1279 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_125_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_125_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_125_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1280 :: 		}
L_SPI_Ethernet_UserTCP92:
;SE9M.c,1281 :: 		}
L_SPI_Ethernet_UserTCP80:
;SE9M.c,1283 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP93
;SE9M.c,1285 :: 		len += putConstString("var G0=\"") ;
	MOVLW       ?lstr_126_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_126_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_126_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1286 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP94
;SE9M.c,1287 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_127_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_127_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_127_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1288 :: 		len += putString(gwIpAddrPom0) ;
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1289 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_128_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_128_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_128_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1290 :: 		}
L_SPI_Ethernet_UserTCP94:
;SE9M.c,1293 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP95
;SE9M.c,1294 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_129_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_129_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_129_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1295 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP96
L_SPI_Ethernet_UserTCP95:
;SE9M.c,1296 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_130_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_130_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_130_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1297 :: 		}
L_SPI_Ethernet_UserTCP96:
;SE9M.c,1299 :: 		len += putConstString("var G1=\"") ;
	MOVLW       ?lstr_131_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_131_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_131_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1300 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP97
;SE9M.c,1301 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_132_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_132_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_132_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1302 :: 		len += putString(gwIpAddrPom1) ;
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1303 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_133_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_133_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_133_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1304 :: 		}
L_SPI_Ethernet_UserTCP97:
;SE9M.c,1307 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP98
;SE9M.c,1308 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_134_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_134_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_134_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1309 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP99
L_SPI_Ethernet_UserTCP98:
;SE9M.c,1310 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_135_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_135_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_135_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1311 :: 		}
L_SPI_Ethernet_UserTCP99:
;SE9M.c,1313 :: 		len += putConstString("var G2=\"") ;
	MOVLW       ?lstr_136_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_136_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_136_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1314 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP100
;SE9M.c,1315 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_137_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_137_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_137_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1316 :: 		len += putString(gwIpAddrPom2) ;
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1317 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_138_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_138_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_138_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1318 :: 		}
L_SPI_Ethernet_UserTCP100:
;SE9M.c,1321 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP101
;SE9M.c,1322 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_139_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_139_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_139_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1323 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP102
L_SPI_Ethernet_UserTCP101:
;SE9M.c,1324 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_140_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_140_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_140_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1325 :: 		}
L_SPI_Ethernet_UserTCP102:
;SE9M.c,1327 :: 		len += putConstString("var G3=\"") ;
	MOVLW       ?lstr_141_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_141_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_141_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1328 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP103
;SE9M.c,1329 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_142_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_142_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_142_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1330 :: 		len += putString(gwIpAddrPom3) ;
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1331 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_143_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_143_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_143_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1332 :: 		}
L_SPI_Ethernet_UserTCP103:
;SE9M.c,1335 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP104
;SE9M.c,1336 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_144_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_144_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_144_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1337 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP105
L_SPI_Ethernet_UserTCP104:
;SE9M.c,1338 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_145_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_145_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_145_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1339 :: 		}
L_SPI_Ethernet_UserTCP105:
;SE9M.c,1340 :: 		}
L_SPI_Ethernet_UserTCP93:
;SE9M.c,1342 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP106
;SE9M.c,1344 :: 		len += putConstString("var D0=\"") ;
	MOVLW       ?lstr_146_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_146_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_146_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1345 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP107
;SE9M.c,1346 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_147_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_147_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_147_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1347 :: 		len += putString(dnsIpAddrPom0) ;
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1348 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_148_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_148_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_148_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1349 :: 		}
L_SPI_Ethernet_UserTCP107:
;SE9M.c,1352 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP108
;SE9M.c,1353 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_149_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_149_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_149_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1354 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP109
L_SPI_Ethernet_UserTCP108:
;SE9M.c,1355 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_150_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_150_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_150_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1356 :: 		}
L_SPI_Ethernet_UserTCP109:
;SE9M.c,1358 :: 		len += putConstString("var D1=\"") ;
	MOVLW       ?lstr_151_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_151_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_151_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1359 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP110
;SE9M.c,1360 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_152_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_152_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_152_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1361 :: 		len += putString(dnsIpAddrPom1) ;
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1362 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_153_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_153_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_153_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1363 :: 		}
L_SPI_Ethernet_UserTCP110:
;SE9M.c,1366 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP111
;SE9M.c,1367 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_154_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_154_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_154_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1368 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP112
L_SPI_Ethernet_UserTCP111:
;SE9M.c,1369 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_155_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_155_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_155_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1370 :: 		}
L_SPI_Ethernet_UserTCP112:
;SE9M.c,1372 :: 		len += putConstString("var D2=\"") ;
	MOVLW       ?lstr_156_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_156_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_156_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1373 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP113
;SE9M.c,1374 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_157_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_157_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_157_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1375 :: 		len += putString(dnsIpAddrPom2) ;
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1376 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_158_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_158_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_158_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1377 :: 		}
L_SPI_Ethernet_UserTCP113:
;SE9M.c,1380 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP114
;SE9M.c,1381 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_159_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_159_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_159_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1382 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP115
L_SPI_Ethernet_UserTCP114:
;SE9M.c,1383 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_160_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_160_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_160_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1384 :: 		}
L_SPI_Ethernet_UserTCP115:
;SE9M.c,1386 :: 		len += putConstString("var D3=\"") ;
	MOVLW       ?lstr_161_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_161_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_161_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1387 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP116
;SE9M.c,1388 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_162_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_162_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_162_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1389 :: 		len += putString(dnsIpAddrPom3) ;
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1390 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_163_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_163_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_163_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1391 :: 		}
L_SPI_Ethernet_UserTCP116:
;SE9M.c,1394 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP117
;SE9M.c,1395 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_164_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_164_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_164_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1396 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP118
L_SPI_Ethernet_UserTCP117:
;SE9M.c,1397 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_165_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_165_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_165_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1398 :: 		}
L_SPI_Ethernet_UserTCP118:
;SE9M.c,1399 :: 		}
L_SPI_Ethernet_UserTCP106:
;SE9M.c,1401 :: 		}
L_SPI_Ethernet_UserTCP60:
;SE9M.c,1403 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP119
L_SPI_Ethernet_UserTCP58:
;SE9M.c,1407 :: 		switch(getRequest[sizeof(path_private)])
	GOTO        L_SPI_Ethernet_UserTCP120
;SE9M.c,1409 :: 		case '1' :
L_SPI_Ethernet_UserTCP122:
;SE9M.c,1411 :: 		conf.dhcpen = getRequest[sizeof(path_private) + 2] - '0' ;
	MOVLW       48
	SUBWF       SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _conf+0 
;SE9M.c,1412 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1413 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP123:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP123
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP123
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP123
;SE9M.c,1414 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,1415 :: 		saveConf() ;
	CALL        _saveConf+0, 0
;SE9M.c,1416 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1421 :: 		case 'r':
L_SPI_Ethernet_UserTCP124:
;SE9M.c,1423 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP125
;SE9M.c,1426 :: 		if ( (ipAddrPom0[0] >= '1') && (ipAddrPom0[0] <= '9') && (ipAddrPom0[1] >= '0') && (ipAddrPom0[1] <= '9') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVF        _ipAddrPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVLW       48
	SUBWF       _ipAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVF        _ipAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVF        _ipAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
L__SPI_Ethernet_UserTCP563:
;SE9M.c,1427 :: 		EEPROM_Write(1, (ipAddrPom0[0]-48)*100 + (ipAddrPom0[1]-48)*10 + (ipAddrPom0[2]-48));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1428 :: 		}
L_SPI_Ethernet_UserTCP128:
;SE9M.c,1429 :: 		if ( (ipAddrPom0[0] < '1') && (ipAddrPom0[1] >= '1') && (ipAddrPom0[1] <= '9') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
	MOVLW       49
	SUBWF       _ipAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
	MOVF        _ipAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
	MOVF        _ipAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
L__SPI_Ethernet_UserTCP562:
;SE9M.c,1430 :: 		EEPROM_Write(1, (ipAddrPom0[1]-48)*10 + (ipAddrPom0[2]-48));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1431 :: 		}
L_SPI_Ethernet_UserTCP131:
;SE9M.c,1432 :: 		if ( (ipAddrPom0[0] < '1') && (ipAddrPom0[1] < '1') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP134
	MOVLW       49
	SUBWF       _ipAddrPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP134
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP134
	MOVF        _ipAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP134
L__SPI_Ethernet_UserTCP561:
;SE9M.c,1433 :: 		EEPROM_Write(1, (ipAddrPom0[2]-48));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1434 :: 		}
L_SPI_Ethernet_UserTCP134:
;SE9M.c,1436 :: 		if ( (ipAddrPom1[0] >= '1') && (ipAddrPom1[0] <= '9') && (ipAddrPom1[1] >= '0') && (ipAddrPom1[1] <= '9') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVF        _ipAddrPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVLW       48
	SUBWF       _ipAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVF        _ipAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVF        _ipAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
L__SPI_Ethernet_UserTCP560:
;SE9M.c,1437 :: 		EEPROM_Write(2, (ipAddrPom1[0]-48)*100 + (ipAddrPom1[1]-48)*10 + (ipAddrPom1[2]-48));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1438 :: 		}
L_SPI_Ethernet_UserTCP137:
;SE9M.c,1439 :: 		if ( (ipAddrPom1[0] < '1') && (ipAddrPom1[1] >= '1') && (ipAddrPom1[1] <= '9') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
	MOVLW       49
	SUBWF       _ipAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
	MOVF        _ipAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
	MOVF        _ipAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
L__SPI_Ethernet_UserTCP559:
;SE9M.c,1440 :: 		EEPROM_Write(2, (ipAddrPom1[1]-48)*10 + (ipAddrPom1[2]-48));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1441 :: 		}
L_SPI_Ethernet_UserTCP140:
;SE9M.c,1442 :: 		if ( (ipAddrPom1[0] < '1') && (ipAddrPom1[1] < '1') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP143
	MOVLW       49
	SUBWF       _ipAddrPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP143
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP143
	MOVF        _ipAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP143
L__SPI_Ethernet_UserTCP558:
;SE9M.c,1443 :: 		EEPROM_Write(2, (ipAddrPom1[2]-48));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1444 :: 		}
L_SPI_Ethernet_UserTCP143:
;SE9M.c,1446 :: 		if ( (ipAddrPom2[0] >= '1') && (ipAddrPom2[0] <= '9') && (ipAddrPom2[1] >= '0') && (ipAddrPom2[1] <= '9') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVF        _ipAddrPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVLW       48
	SUBWF       _ipAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVF        _ipAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVF        _ipAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
L__SPI_Ethernet_UserTCP557:
;SE9M.c,1447 :: 		EEPROM_Write(3, (ipAddrPom2[0]-48)*100 + (ipAddrPom2[1]-48)*10 + (ipAddrPom2[2]-48));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1448 :: 		}
L_SPI_Ethernet_UserTCP146:
;SE9M.c,1449 :: 		if ( (ipAddrPom2[0] < '1') && (ipAddrPom2[1] >= '1') && (ipAddrPom2[1] <= '9') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
	MOVLW       49
	SUBWF       _ipAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
	MOVF        _ipAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
	MOVF        _ipAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
L__SPI_Ethernet_UserTCP556:
;SE9M.c,1450 :: 		EEPROM_Write(3, (ipAddrPom2[1]-48)*10 + (ipAddrPom2[2]-48));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1451 :: 		}
L_SPI_Ethernet_UserTCP149:
;SE9M.c,1452 :: 		if ( (ipAddrPom2[0] < '1') && (ipAddrPom2[1] < '1') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP152
	MOVLW       49
	SUBWF       _ipAddrPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP152
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP152
	MOVF        _ipAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP152
L__SPI_Ethernet_UserTCP555:
;SE9M.c,1453 :: 		EEPROM_Write(3, (ipAddrPom2[2]-48));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1454 :: 		}
L_SPI_Ethernet_UserTCP152:
;SE9M.c,1456 :: 		if ( (ipAddrPom3[0] >= '1') && (ipAddrPom3[0] <= '9') && (ipAddrPom3[1] >= '0') && (ipAddrPom3[1] <= '9') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVF        _ipAddrPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVLW       48
	SUBWF       _ipAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVF        _ipAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVF        _ipAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
L__SPI_Ethernet_UserTCP554:
;SE9M.c,1457 :: 		EEPROM_Write(4, (ipAddrPom3[0]-48)*100 + (ipAddrPom3[1]-48)*10 + (ipAddrPom3[2]-48));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1458 :: 		}
L_SPI_Ethernet_UserTCP155:
;SE9M.c,1459 :: 		if ( (ipAddrPom3[0] < '1') && (ipAddrPom3[1] >= '1') && (ipAddrPom3[1] <= '9') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
	MOVLW       49
	SUBWF       _ipAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
	MOVF        _ipAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
	MOVF        _ipAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
L__SPI_Ethernet_UserTCP553:
;SE9M.c,1460 :: 		EEPROM_Write(4, (ipAddrPom3[1]-48)*10 + (ipAddrPom3[2]-48));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1461 :: 		}
L_SPI_Ethernet_UserTCP158:
;SE9M.c,1462 :: 		if ( (ipAddrPom3[0] < '1') && (ipAddrPom3[1] < '1') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP161
	MOVLW       49
	SUBWF       _ipAddrPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP161
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP161
	MOVF        _ipAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP161
L__SPI_Ethernet_UserTCP552:
;SE9M.c,1463 :: 		EEPROM_Write(4, (ipAddrPom3[2]-48));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1464 :: 		}
L_SPI_Ethernet_UserTCP161:
;SE9M.c,1467 :: 		if ( (gwIpAddrPom0[0] >= '1') && (gwIpAddrPom0[0] <= '9') && (gwIpAddrPom0[1] >= '0') && (gwIpAddrPom0[1] <= '9') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVF        _gwIpAddrPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVLW       48
	SUBWF       _gwIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVF        _gwIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVF        _gwIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
L__SPI_Ethernet_UserTCP551:
;SE9M.c,1468 :: 		EEPROM_Write(5, (gwIpAddrPom0[0]-48)*100 + (gwIpAddrPom0[1]-48)*10 + (gwIpAddrPom0[2]-48));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1469 :: 		}
L_SPI_Ethernet_UserTCP164:
;SE9M.c,1470 :: 		if ( (gwIpAddrPom0[0] < '1') && (gwIpAddrPom0[1] >= '1') && (gwIpAddrPom0[1] <= '9') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
	MOVLW       49
	SUBWF       _gwIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
	MOVF        _gwIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
	MOVF        _gwIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
L__SPI_Ethernet_UserTCP550:
;SE9M.c,1471 :: 		EEPROM_Write(5, (gwIpAddrPom0[1]-48)*10 + (gwIpAddrPom0[2]-48));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1472 :: 		}
L_SPI_Ethernet_UserTCP167:
;SE9M.c,1473 :: 		if ( (gwIpAddrPom0[0] < '1') && (gwIpAddrPom0[1] < '1') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP170
	MOVLW       49
	SUBWF       _gwIpAddrPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP170
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP170
	MOVF        _gwIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP170
L__SPI_Ethernet_UserTCP549:
;SE9M.c,1474 :: 		EEPROM_Write(5, (gwIpAddrPom0[2]-48));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1475 :: 		}
L_SPI_Ethernet_UserTCP170:
;SE9M.c,1477 :: 		if ( (gwIpAddrPom1[0] >= '1') && (gwIpAddrPom1[0] <= '9') && (gwIpAddrPom1[1] >= '0') && (gwIpAddrPom1[1] <= '9') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVF        _gwIpAddrPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVLW       48
	SUBWF       _gwIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVF        _gwIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVF        _gwIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
L__SPI_Ethernet_UserTCP548:
;SE9M.c,1478 :: 		EEPROM_Write(6, (gwIpAddrPom1[0]-48)*100 + (gwIpAddrPom1[1]-48)*10 + (gwIpAddrPom1[2]-48));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1479 :: 		}
L_SPI_Ethernet_UserTCP173:
;SE9M.c,1480 :: 		if ( (gwIpAddrPom1[0] < '1') && (gwIpAddrPom1[1] >= '1') && (gwIpAddrPom1[1] <= '9') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
	MOVLW       49
	SUBWF       _gwIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
	MOVF        _gwIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
	MOVF        _gwIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
L__SPI_Ethernet_UserTCP547:
;SE9M.c,1481 :: 		EEPROM_Write(6, (gwIpAddrPom1[1]-48)*10 + (gwIpAddrPom1[2]-48));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1482 :: 		}
L_SPI_Ethernet_UserTCP176:
;SE9M.c,1483 :: 		if ( (gwIpAddrPom1[0] < '1') && (gwIpAddrPom1[1] < '1') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP179
	MOVLW       49
	SUBWF       _gwIpAddrPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP179
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP179
	MOVF        _gwIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP179
L__SPI_Ethernet_UserTCP546:
;SE9M.c,1484 :: 		EEPROM_Write(6, (gwIpAddrPom1[2]-48));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1485 :: 		}
L_SPI_Ethernet_UserTCP179:
;SE9M.c,1487 :: 		if ( (gwIpAddrPom2[0] >= '1') && (gwIpAddrPom2[0] <= '9') && (gwIpAddrPom2[1] >= '0') && (gwIpAddrPom2[1] <= '9') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVF        _gwIpAddrPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVLW       48
	SUBWF       _gwIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVF        _gwIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVF        _gwIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
L__SPI_Ethernet_UserTCP545:
;SE9M.c,1488 :: 		EEPROM_Write(7, (gwIpAddrPom2[0]-48)*100 + (gwIpAddrPom2[1]-48)*10 + (gwIpAddrPom2[2]-48));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1489 :: 		}
L_SPI_Ethernet_UserTCP182:
;SE9M.c,1490 :: 		if ( (gwIpAddrPom2[0] < '1') && (gwIpAddrPom2[1] >= '1') && (gwIpAddrPom2[1] <= '9') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
	MOVLW       49
	SUBWF       _gwIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
	MOVF        _gwIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
	MOVF        _gwIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
L__SPI_Ethernet_UserTCP544:
;SE9M.c,1491 :: 		EEPROM_Write(7, (gwIpAddrPom2[1]-48)*10 + (gwIpAddrPom2[2]-48));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1492 :: 		}
L_SPI_Ethernet_UserTCP185:
;SE9M.c,1493 :: 		if ( (gwIpAddrPom2[0] < '1') && (gwIpAddrPom2[1] < '1') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP188
	MOVLW       49
	SUBWF       _gwIpAddrPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP188
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP188
	MOVF        _gwIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP188
L__SPI_Ethernet_UserTCP543:
;SE9M.c,1494 :: 		EEPROM_Write(7, (gwIpAddrPom2[2]-48));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1495 :: 		}
L_SPI_Ethernet_UserTCP188:
;SE9M.c,1497 :: 		if ( (gwIpAddrPom3[0] >= '1') && (gwIpAddrPom3[0] <= '9') && (gwIpAddrPom3[1] >= '0') && (gwIpAddrPom3[1] <= '9') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVF        _gwIpAddrPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVLW       48
	SUBWF       _gwIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVF        _gwIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVF        _gwIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
L__SPI_Ethernet_UserTCP542:
;SE9M.c,1498 :: 		EEPROM_Write(8, (gwIpAddrPom3[0]-48)*100 + (gwIpAddrPom3[1]-48)*10 + (gwIpAddrPom3[2]-48));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1499 :: 		}
L_SPI_Ethernet_UserTCP191:
;SE9M.c,1500 :: 		if ( (gwIpAddrPom3[0] < '1') && (gwIpAddrPom3[1] >= '1') && (gwIpAddrPom3[1] <= '9') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
	MOVLW       49
	SUBWF       _gwIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
	MOVF        _gwIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
	MOVF        _gwIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
L__SPI_Ethernet_UserTCP541:
;SE9M.c,1501 :: 		EEPROM_Write(8, (gwIpAddrPom3[1]-48)*10 + (gwIpAddrPom3[2]-48));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1502 :: 		}
L_SPI_Ethernet_UserTCP194:
;SE9M.c,1503 :: 		if ( (gwIpAddrPom3[0] < '1') && (gwIpAddrPom3[1] < '1') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP197
	MOVLW       49
	SUBWF       _gwIpAddrPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP197
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP197
	MOVF        _gwIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP197
L__SPI_Ethernet_UserTCP540:
;SE9M.c,1504 :: 		EEPROM_Write(8, (gwIpAddrPom3[2]-48));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1505 :: 		}
L_SPI_Ethernet_UserTCP197:
;SE9M.c,1508 :: 		if ( (ipMaskPom0[0] >= '1') && (ipMaskPom0[0] <= '9') && (ipMaskPom0[1] >= '0') && (ipMaskPom0[1] <= '9') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVF        _ipMaskPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVLW       48
	SUBWF       _ipMaskPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVF        _ipMaskPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVF        _ipMaskPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
L__SPI_Ethernet_UserTCP539:
;SE9M.c,1509 :: 		EEPROM_Write(9, (ipMaskPom0[0]-48)*100 + (ipMaskPom0[1]-48)*10 + (ipMaskPom0[2]-48));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1510 :: 		}
L_SPI_Ethernet_UserTCP200:
;SE9M.c,1511 :: 		if ( (ipMaskPom0[0] < '1') && (ipMaskPom0[1] >= '1') && (ipMaskPom0[1] <= '9') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
	MOVLW       49
	SUBWF       _ipMaskPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
	MOVF        _ipMaskPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
	MOVF        _ipMaskPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
L__SPI_Ethernet_UserTCP538:
;SE9M.c,1512 :: 		EEPROM_Write(9, (ipMaskPom0[1]-48)*10 + (ipMaskPom0[2]-48));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1513 :: 		}
L_SPI_Ethernet_UserTCP203:
;SE9M.c,1514 :: 		if ( (ipMaskPom0[0] < '1') && (ipMaskPom0[1] < '1') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP206
	MOVLW       49
	SUBWF       _ipMaskPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP206
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP206
	MOVF        _ipMaskPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP206
L__SPI_Ethernet_UserTCP537:
;SE9M.c,1515 :: 		EEPROM_Write(9, (ipMaskPom0[2]-48));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1516 :: 		}
L_SPI_Ethernet_UserTCP206:
;SE9M.c,1518 :: 		if ( (ipMaskPom1[0] >= '1') && (ipMaskPom1[0] <= '9') && (ipMaskPom1[1] >= '0') && (ipMaskPom1[1] <= '9') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVF        _ipMaskPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVLW       48
	SUBWF       _ipMaskPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVF        _ipMaskPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVF        _ipMaskPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
L__SPI_Ethernet_UserTCP536:
;SE9M.c,1519 :: 		EEPROM_Write(10, (ipMaskPom1[0]-48)*100 + (ipMaskPom1[1]-48)*10 + (ipMaskPom1[2]-48));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1520 :: 		}
L_SPI_Ethernet_UserTCP209:
;SE9M.c,1521 :: 		if ( (ipMaskPom1[0] < '1') && (ipMaskPom1[1] >= '1') && (ipMaskPom1[1] <= '9') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
	MOVLW       49
	SUBWF       _ipMaskPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
	MOVF        _ipMaskPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
	MOVF        _ipMaskPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
L__SPI_Ethernet_UserTCP535:
;SE9M.c,1522 :: 		EEPROM_Write(10, (ipMaskPom1[1]-48)*10 + (ipMaskPom1[2]-48));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1523 :: 		}
L_SPI_Ethernet_UserTCP212:
;SE9M.c,1524 :: 		if ( (ipMaskPom1[0] < '1') && (ipMaskPom1[1] < '1') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP215
	MOVLW       49
	SUBWF       _ipMaskPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP215
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP215
	MOVF        _ipMaskPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP215
L__SPI_Ethernet_UserTCP534:
;SE9M.c,1525 :: 		EEPROM_Write(10, (ipMaskPom1[2]-48));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1526 :: 		}
L_SPI_Ethernet_UserTCP215:
;SE9M.c,1528 :: 		if ( (ipMaskPom2[0] >= '1') && (ipMaskPom2[0] <= '9') && (ipMaskPom2[1] >= '0') && (ipMaskPom2[1] <= '9') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVF        _ipMaskPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVLW       48
	SUBWF       _ipMaskPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVF        _ipMaskPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVF        _ipMaskPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
L__SPI_Ethernet_UserTCP533:
;SE9M.c,1529 :: 		EEPROM_Write(11, (ipMaskPom2[0]-48)*100 + (ipMaskPom2[1]-48)*10 + (ipMaskPom2[2]-48));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1530 :: 		}
L_SPI_Ethernet_UserTCP218:
;SE9M.c,1531 :: 		if ( (ipMaskPom2[0] < '1') && (ipMaskPom2[1] >= '1') && (ipMaskPom2[1] <= '9') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
	MOVLW       49
	SUBWF       _ipMaskPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
	MOVF        _ipMaskPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
	MOVF        _ipMaskPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
L__SPI_Ethernet_UserTCP532:
;SE9M.c,1532 :: 		EEPROM_Write(11, (ipMaskPom2[1]-48)*10 + (ipMaskPom2[2]-48));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1533 :: 		}
L_SPI_Ethernet_UserTCP221:
;SE9M.c,1534 :: 		if ( (ipMaskPom2[0] < '1') && (ipMaskPom2[1] < '1') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP224
	MOVLW       49
	SUBWF       _ipMaskPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP224
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP224
	MOVF        _ipMaskPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP224
L__SPI_Ethernet_UserTCP531:
;SE9M.c,1535 :: 		EEPROM_Write(11, (ipMaskPom2[2]-48));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1536 :: 		}
L_SPI_Ethernet_UserTCP224:
;SE9M.c,1538 :: 		if ( (ipMaskPom3[0] >= '1') && (ipMaskPom3[0] <= '9') && (ipMaskPom3[1] >= '0') && (ipMaskPom3[1] <= '9') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVF        _ipMaskPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVLW       48
	SUBWF       _ipMaskPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVF        _ipMaskPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVF        _ipMaskPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
L__SPI_Ethernet_UserTCP530:
;SE9M.c,1539 :: 		EEPROM_Write(12, (ipMaskPom3[0]-48)*100 + (ipMaskPom3[1]-48)*10 + (ipMaskPom3[2]-48));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1540 :: 		}
L_SPI_Ethernet_UserTCP227:
;SE9M.c,1541 :: 		if ( (ipMaskPom3[0] < '1') && (ipMaskPom3[1] >= '1') && (ipMaskPom3[1] <= '9') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
	MOVLW       49
	SUBWF       _ipMaskPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
	MOVF        _ipMaskPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
	MOVF        _ipMaskPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
L__SPI_Ethernet_UserTCP529:
;SE9M.c,1542 :: 		EEPROM_Write(12, (ipMaskPom3[1]-48)*10 + (ipMaskPom3[2]-48));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1543 :: 		}
L_SPI_Ethernet_UserTCP230:
;SE9M.c,1544 :: 		if ( (ipMaskPom3[0] < '1') && (ipMaskPom3[1] < '1') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP233
	MOVLW       49
	SUBWF       _ipMaskPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP233
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP233
	MOVF        _ipMaskPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP233
L__SPI_Ethernet_UserTCP528:
;SE9M.c,1545 :: 		EEPROM_Write(12, (ipMaskPom3[2]-48));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1546 :: 		}
L_SPI_Ethernet_UserTCP233:
;SE9M.c,1549 :: 		if ( (dnsIpAddrPom0[0] >= '1') && (dnsIpAddrPom0[0] <= '9') && (dnsIpAddrPom0[1] >= '0') && (dnsIpAddrPom0[1] <= '9') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVF        _dnsIpAddrPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVF        _dnsIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVF        _dnsIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
L__SPI_Ethernet_UserTCP527:
;SE9M.c,1550 :: 		EEPROM_Write(13, (dnsIpAddrPom0[0]-48)*100 + (dnsIpAddrPom0[1]-48)*10 + (dnsIpAddrPom0[2]-48));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1551 :: 		}
L_SPI_Ethernet_UserTCP236:
;SE9M.c,1552 :: 		if ( (dnsIpAddrPom0[0] < '1') && (dnsIpAddrPom0[1] >= '1') && (dnsIpAddrPom0[1] <= '9') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
	MOVF        _dnsIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
	MOVF        _dnsIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
L__SPI_Ethernet_UserTCP526:
;SE9M.c,1553 :: 		EEPROM_Write(13, (dnsIpAddrPom0[1]-48)*10 + (dnsIpAddrPom0[2]-48));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1554 :: 		}
L_SPI_Ethernet_UserTCP239:
;SE9M.c,1555 :: 		if ( (dnsIpAddrPom0[0] < '1') && (dnsIpAddrPom0[1] < '1') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP242
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP242
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP242
	MOVF        _dnsIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP242
L__SPI_Ethernet_UserTCP525:
;SE9M.c,1556 :: 		EEPROM_Write(13, (dnsIpAddrPom0[2]-48));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1557 :: 		}
L_SPI_Ethernet_UserTCP242:
;SE9M.c,1559 :: 		if ( (dnsIpAddrPom1[0] >= '1') && (dnsIpAddrPom1[0] <= '9') && (dnsIpAddrPom1[1] >= '0') && (dnsIpAddrPom1[1] <= '9') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVF        _dnsIpAddrPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVF        _dnsIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVF        _dnsIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
L__SPI_Ethernet_UserTCP524:
;SE9M.c,1560 :: 		EEPROM_Write(14, (dnsIpAddrPom1[0]-48)*100 + (dnsIpAddrPom1[1]-48)*10 + (dnsIpAddrPom1[2]-48));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1561 :: 		}
L_SPI_Ethernet_UserTCP245:
;SE9M.c,1562 :: 		if ( (dnsIpAddrPom1[0] < '1') && (dnsIpAddrPom1[1] >= '1') && (dnsIpAddrPom1[1] <= '9') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
	MOVF        _dnsIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
	MOVF        _dnsIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
L__SPI_Ethernet_UserTCP523:
;SE9M.c,1563 :: 		EEPROM_Write(14, (dnsIpAddrPom1[1]-48)*10 + (dnsIpAddrPom1[2]-48));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1564 :: 		}
L_SPI_Ethernet_UserTCP248:
;SE9M.c,1565 :: 		if ( (dnsIpAddrPom1[0] < '1') && (dnsIpAddrPom1[1] < '1') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP251
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP251
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP251
	MOVF        _dnsIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP251
L__SPI_Ethernet_UserTCP522:
;SE9M.c,1566 :: 		EEPROM_Write(14, (dnsIpAddrPom1[2]-48));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1567 :: 		}
L_SPI_Ethernet_UserTCP251:
;SE9M.c,1569 :: 		if ( (dnsIpAddrPom2[0] >= '1') && (dnsIpAddrPom2[0] <= '9') && (dnsIpAddrPom2[1] >= '0') && (dnsIpAddrPom2[1] <= '9') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVF        _dnsIpAddrPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVF        _dnsIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVF        _dnsIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
L__SPI_Ethernet_UserTCP521:
;SE9M.c,1570 :: 		EEPROM_Write(15, (dnsIpAddrPom2[0]-48)*100 + (dnsIpAddrPom2[1]-48)*10 + (dnsIpAddrPom2[2]-48));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1571 :: 		}
L_SPI_Ethernet_UserTCP254:
;SE9M.c,1572 :: 		if ( (dnsIpAddrPom2[0] < '1') && (dnsIpAddrPom2[1] >= '1') && (dnsIpAddrPom2[1] <= '9') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
	MOVF        _dnsIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
	MOVF        _dnsIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
L__SPI_Ethernet_UserTCP520:
;SE9M.c,1573 :: 		EEPROM_Write(15, (dnsIpAddrPom2[1]-48)*10 + (dnsIpAddrPom2[2]-48));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1574 :: 		}
L_SPI_Ethernet_UserTCP257:
;SE9M.c,1575 :: 		if ( (dnsIpAddrPom2[0] < '1') && (dnsIpAddrPom2[1] < '1') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP260
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP260
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP260
	MOVF        _dnsIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP260
L__SPI_Ethernet_UserTCP519:
;SE9M.c,1576 :: 		EEPROM_Write(15, (dnsIpAddrPom2[2]-48));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1577 :: 		}
L_SPI_Ethernet_UserTCP260:
;SE9M.c,1579 :: 		if ( (dnsIpAddrPom3[0] >= '1') && (dnsIpAddrPom3[0] <= '9') && (dnsIpAddrPom3[1] >= '0') && (dnsIpAddrPom3[1] <= '9') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVF        _dnsIpAddrPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVF        _dnsIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVF        _dnsIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
L__SPI_Ethernet_UserTCP518:
;SE9M.c,1580 :: 		EEPROM_Write(16, (dnsIpAddrPom3[0]-48)*100 + (dnsIpAddrPom3[1]-48)*10 + (dnsIpAddrPom3[2]-48));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1581 :: 		}
L_SPI_Ethernet_UserTCP263:
;SE9M.c,1582 :: 		if ( (dnsIpAddrPom3[0] < '1') && (dnsIpAddrPom3[1] >= '1') && (dnsIpAddrPom3[1] <= '9') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
	MOVF        _dnsIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
	MOVF        _dnsIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
L__SPI_Ethernet_UserTCP517:
;SE9M.c,1583 :: 		EEPROM_Write(16, (dnsIpAddrPom3[1]-48)*10 + (dnsIpAddrPom3[2]-48));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1584 :: 		}
L_SPI_Ethernet_UserTCP266:
;SE9M.c,1585 :: 		if ( (dnsIpAddrPom3[0] < '1') && (dnsIpAddrPom3[1] < '1') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP269
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP269
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP269
	MOVF        _dnsIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP269
L__SPI_Ethernet_UserTCP516:
;SE9M.c,1586 :: 		EEPROM_Write(16, (dnsIpAddrPom3[2]-48));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1587 :: 		}
L_SPI_Ethernet_UserTCP269:
;SE9M.c,1588 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP270:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP270
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP270
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP270
;SE9M.c,1589 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,1590 :: 		}
L_SPI_Ethernet_UserTCP125:
;SE9M.c,1591 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1592 :: 		case 'n':
L_SPI_Ethernet_UserTCP271:
;SE9M.c,1594 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP272
;SE9M.c,1595 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP273
;SE9M.c,1596 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1597 :: 		ByteToStr(pomocni,IpAddrPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1598 :: 		}
L_SPI_Ethernet_UserTCP273:
;SE9M.c,1599 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP274
;SE9M.c,1600 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1601 :: 		ByteToStr(pomocni,ipMaskPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1602 :: 		}
L_SPI_Ethernet_UserTCP274:
;SE9M.c,1603 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP275
;SE9M.c,1604 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1605 :: 		ByteToStr(pomocni,gwIpAddrPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1606 :: 		}
L_SPI_Ethernet_UserTCP275:
;SE9M.c,1607 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP276
;SE9M.c,1608 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1609 :: 		ByteToStr(pomocni,dnsIpAddrPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1610 :: 		}
L_SPI_Ethernet_UserTCP276:
;SE9M.c,1611 :: 		}
L_SPI_Ethernet_UserTCP272:
;SE9M.c,1612 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1613 :: 		case 'o':
L_SPI_Ethernet_UserTCP277:
;SE9M.c,1615 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP278
;SE9M.c,1616 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP279
;SE9M.c,1617 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1618 :: 		ByteToStr(pomocni,IpAddrPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1619 :: 		}
L_SPI_Ethernet_UserTCP279:
;SE9M.c,1620 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP280
;SE9M.c,1621 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1622 :: 		ByteToStr(pomocni,ipMaskPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1623 :: 		}
L_SPI_Ethernet_UserTCP280:
;SE9M.c,1624 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP281
;SE9M.c,1625 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1626 :: 		ByteToStr(pomocni,gwIpAddrPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1627 :: 		}
L_SPI_Ethernet_UserTCP281:
;SE9M.c,1628 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP282
;SE9M.c,1629 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1630 :: 		ByteToStr(pomocni,dnsIpAddrPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1631 :: 		}
L_SPI_Ethernet_UserTCP282:
;SE9M.c,1632 :: 		}
L_SPI_Ethernet_UserTCP278:
;SE9M.c,1633 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1634 :: 		case 'p':
L_SPI_Ethernet_UserTCP283:
;SE9M.c,1636 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP284
;SE9M.c,1637 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP285
;SE9M.c,1638 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1639 :: 		ByteToStr(pomocni,IpAddrPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1640 :: 		}
L_SPI_Ethernet_UserTCP285:
;SE9M.c,1641 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP286
;SE9M.c,1642 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1643 :: 		ByteToStr(pomocni,ipMaskPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1644 :: 		}
L_SPI_Ethernet_UserTCP286:
;SE9M.c,1645 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP287
;SE9M.c,1646 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1647 :: 		ByteToStr(pomocni,gwIpAddrPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1648 :: 		}
L_SPI_Ethernet_UserTCP287:
;SE9M.c,1649 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP288
;SE9M.c,1650 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1651 :: 		ByteToStr(pomocni,dnsIpAddrPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1652 :: 		}
L_SPI_Ethernet_UserTCP288:
;SE9M.c,1653 :: 		}
L_SPI_Ethernet_UserTCP284:
;SE9M.c,1654 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1655 :: 		case 'q':
L_SPI_Ethernet_UserTCP289:
;SE9M.c,1657 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP290
;SE9M.c,1658 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP291
;SE9M.c,1659 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1660 :: 		ByteToStr(pomocni,IpAddrPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1661 :: 		}
L_SPI_Ethernet_UserTCP291:
;SE9M.c,1662 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP292
;SE9M.c,1663 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1664 :: 		ByteToStr(pomocni,ipMaskPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1665 :: 		}
L_SPI_Ethernet_UserTCP292:
;SE9M.c,1666 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP293
;SE9M.c,1667 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1668 :: 		ByteToStr(pomocni,gwIpAddrPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1669 :: 		}
L_SPI_Ethernet_UserTCP293:
;SE9M.c,1670 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP294
;SE9M.c,1671 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1672 :: 		ByteToStr(pomocni,dnsIpAddrPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1673 :: 		}
L_SPI_Ethernet_UserTCP294:
;SE9M.c,1674 :: 		}
L_SPI_Ethernet_UserTCP290:
;SE9M.c,1675 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1676 :: 		case 'v':
L_SPI_Ethernet_UserTCP295:
;SE9M.c,1679 :: 		pomocnaSifra[0] = getRequest[sizeof(path_private) + 2] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       _pomocnaSifra+0 
;SE9M.c,1680 :: 		pomocnaSifra[1] = getRequest[sizeof(path_private) + 3] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+10, 0 
	MOVWF       _pomocnaSifra+1 
;SE9M.c,1681 :: 		pomocnaSifra[2] = getRequest[sizeof(path_private) + 4] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+11, 0 
	MOVWF       _pomocnaSifra+2 
;SE9M.c,1682 :: 		pomocnaSifra[3] = getRequest[sizeof(path_private) + 5] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+12, 0 
	MOVWF       _pomocnaSifra+3 
;SE9M.c,1683 :: 		pomocnaSifra[4] = getRequest[sizeof(path_private) + 6] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+13, 0 
	MOVWF       _pomocnaSifra+4 
;SE9M.c,1684 :: 		pomocnaSifra[5] = getRequest[sizeof(path_private) + 7] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+14, 0 
	MOVWF       _pomocnaSifra+5 
;SE9M.c,1685 :: 		pomocnaSifra[6] = getRequest[sizeof(path_private) + 8] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+15, 0 
	MOVWF       _pomocnaSifra+6 
;SE9M.c,1686 :: 		pomocnaSifra[7] = getRequest[sizeof(path_private) + 9] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+16, 0 
	MOVWF       _pomocnaSifra+7 
;SE9M.c,1687 :: 		pomocnaSifra[8] = 0;
	CLRF        _pomocnaSifra+8 
;SE9M.c,1688 :: 		if (strcmp(sifra,pomocnaSifra) == 0) {
	MOVLW       _sifra+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _pomocnaSifra+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_pomocnaSifra+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP601
	MOVLW       0
	XORWF       R0, 0 
L__SPI_Ethernet_UserTCP601:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP296
;SE9M.c,1689 :: 		tmr_rst_en = 1;
	MOVLW       1
	MOVWF       _tmr_rst_en+0 
;SE9M.c,1690 :: 		admin = 1;
	MOVLW       1
	MOVWF       _admin+0 
;SE9M.c,1691 :: 		len = 0;
	CLRF        SPI_Ethernet_UserTCP_len_L0+0 
	CLRF        SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1692 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1693 :: 		len += putConstString(HTMLredirect) ;
	MOVF        _HTMLredirect+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLredirect+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLredirect+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1694 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1695 :: 		goto ZAVRSI;
	GOTO        ___SPI_Ethernet_UserTCP_ZAVRSI
;SE9M.c,1697 :: 		}
L_SPI_Ethernet_UserTCP296:
;SE9M.c,1698 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1699 :: 		case 'x':
L_SPI_Ethernet_UserTCP297:
;SE9M.c,1702 :: 		oldSifra[0] = getRequest[sizeof(path_private) + 2] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       _oldSifra+0 
;SE9M.c,1703 :: 		oldSifra[1] = getRequest[sizeof(path_private) + 3] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+10, 0 
	MOVWF       _oldSifra+1 
;SE9M.c,1704 :: 		oldSifra[2] = getRequest[sizeof(path_private) + 4] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+11, 0 
	MOVWF       _oldSifra+2 
;SE9M.c,1705 :: 		oldSifra[3] = getRequest[sizeof(path_private) + 5] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+12, 0 
	MOVWF       _oldSifra+3 
;SE9M.c,1706 :: 		oldSifra[4] = getRequest[sizeof(path_private) + 6] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+13, 0 
	MOVWF       _oldSifra+4 
;SE9M.c,1707 :: 		oldSifra[5] = getRequest[sizeof(path_private) + 7] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+14, 0 
	MOVWF       _oldSifra+5 
;SE9M.c,1708 :: 		oldSifra[6] = getRequest[sizeof(path_private) + 8] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+15, 0 
	MOVWF       _oldSifra+6 
;SE9M.c,1709 :: 		oldSifra[7] = getRequest[sizeof(path_private) + 9] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+16, 0 
	MOVWF       _oldSifra+7 
;SE9M.c,1710 :: 		oldSifra[8] = 0;
	CLRF        _oldSifra+8 
;SE9M.c,1711 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1712 :: 		case 'y':
L_SPI_Ethernet_UserTCP298:
;SE9M.c,1715 :: 		newSifra[0] = getRequest[sizeof(path_private) + 2] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       _newSifra+0 
;SE9M.c,1716 :: 		newSifra[1] = getRequest[sizeof(path_private) + 3] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+10, 0 
	MOVWF       _newSifra+1 
;SE9M.c,1717 :: 		newSifra[2] = getRequest[sizeof(path_private) + 4] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+11, 0 
	MOVWF       _newSifra+2 
;SE9M.c,1718 :: 		newSifra[3] = getRequest[sizeof(path_private) + 5] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+12, 0 
	MOVWF       _newSifra+3 
;SE9M.c,1719 :: 		newSifra[4] = getRequest[sizeof(path_private) + 6] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+13, 0 
	MOVWF       _newSifra+4 
;SE9M.c,1720 :: 		newSifra[5] = getRequest[sizeof(path_private) + 7] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+14, 0 
	MOVWF       _newSifra+5 
;SE9M.c,1721 :: 		newSifra[6] = getRequest[sizeof(path_private) + 8] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+15, 0 
	MOVWF       _newSifra+6 
;SE9M.c,1722 :: 		newSifra[7] = getRequest[sizeof(path_private) + 9] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+16, 0 
	MOVWF       _newSifra+7 
;SE9M.c,1723 :: 		newSifra[8] = 0;
	CLRF        _newSifra+8 
;SE9M.c,1724 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1747 :: 		case 'w' :
L_SPI_Ethernet_UserTCP299:
;SE9M.c,1748 :: 		if (strcmp(sifra, oldSifra) == 0) {
	MOVLW       _sifra+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP602
	MOVLW       0
	XORWF       R0, 0 
L__SPI_Ethernet_UserTCP602:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP300
;SE9M.c,1749 :: 		rest = strcpy(sifra, newSifra);
	MOVLW       _sifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	MOVF        R0, 0 
	MOVWF       _rest+0 
	MOVF        R1, 0 
	MOVWF       _rest+1 
;SE9M.c,1750 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1751 :: 		}
L_SPI_Ethernet_UserTCP300:
;SE9M.c,1752 :: 		EEPROM_Write(20, sifra[0]);
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1753 :: 		EEPROM_Write(21, sifra[1]);
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1754 :: 		EEPROM_Write(22, sifra[2]);
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1755 :: 		EEPROM_Write(23, sifra[3]);
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1756 :: 		EEPROM_Write(24, sifra[4]);
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1757 :: 		EEPROM_Write(25, sifra[5]);
	MOVLW       25
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1758 :: 		EEPROM_Write(26, sifra[6]);
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1759 :: 		EEPROM_Write(27, sifra[7]);
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1760 :: 		EEPROM_Write(28, sifra[8]);
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1761 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr166_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr166_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1762 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr167_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr167_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1763 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP301:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP301
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP301
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP301
;SE9M.c,1764 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1765 :: 		case 'u':
L_SPI_Ethernet_UserTCP302:
;SE9M.c,1766 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP303
;SE9M.c,1767 :: 		s_ip = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _s_ip+0 
;SE9M.c,1768 :: 		s_ip += 1 ;
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       _s_ip+0 
;SE9M.c,1769 :: 		}
L_SPI_Ethernet_UserTCP303:
;SE9M.c,1770 :: 		saveConf() ;
	CALL        _saveConf+0, 0
;SE9M.c,1771 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1778 :: 		case 't':
L_SPI_Ethernet_UserTCP304:
;SE9M.c,1780 :: 		conf.tz = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,1781 :: 		conf.tz -= 11 ;
	MOVLW       11
	SUBWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,1782 :: 		Eeprom_Write(102, conf.tz);
	MOVLW       102
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1783 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP305:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP305
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP305
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP305
;SE9M.c,1784 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1785 :: 		}
L_SPI_Ethernet_UserTCP120:
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP122
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       114
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP124
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       110
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP271
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       111
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP277
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       112
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP283
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       113
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP289
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       118
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP295
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       120
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP297
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       121
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP298
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       119
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP299
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       117
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP302
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       116
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP304
L_SPI_Ethernet_UserTCP121:
;SE9M.c,1787 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1788 :: 		if (admin == 0) {
	MOVF        _admin+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP306
;SE9M.c,1789 :: 		len += putConstString(HTMLadmin0);
	MOVF        _HTMLadmin0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin0+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin0+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1790 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP307
L_SPI_Ethernet_UserTCP306:
;SE9M.c,1791 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP308
;SE9M.c,1792 :: 		len += putConstString(HTMLadmin1) ;
	MOVF        _HTMLadmin1+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin1+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin1+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1793 :: 		}
L_SPI_Ethernet_UserTCP308:
;SE9M.c,1794 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP309
;SE9M.c,1795 :: 		len += putConstString(HTMLadmin2) ;
	MOVF        _HTMLadmin2+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin2+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin2+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1796 :: 		}
L_SPI_Ethernet_UserTCP309:
;SE9M.c,1797 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP310
;SE9M.c,1798 :: 		len += putConstString(HTMLadmin3) ;
	MOVF        _HTMLadmin3+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin3+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin3+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1799 :: 		}
L_SPI_Ethernet_UserTCP310:
;SE9M.c,1800 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP311
;SE9M.c,1801 :: 		len += putConstString(HTMLadmin4) ;
	MOVF        _HTMLadmin4+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin4+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin4+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1802 :: 		}
L_SPI_Ethernet_UserTCP311:
;SE9M.c,1803 :: 		}
L_SPI_Ethernet_UserTCP307:
;SE9M.c,1804 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1805 :: 		}
L_SPI_Ethernet_UserTCP119:
;SE9M.c,1807 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP312
L_SPI_Ethernet_UserTCP57:
;SE9M.c,1808 :: 		else switch(getRequest[1])
	GOTO        L_SPI_Ethernet_UserTCP313
;SE9M.c,1811 :: 		case 's':
L_SPI_Ethernet_UserTCP315:
;SE9M.c,1813 :: 		if(lastSync == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       _lastSync+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP603
	MOVF        R0, 0 
	XORWF       _lastSync+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP603
	MOVF        R0, 0 
	XORWF       _lastSync+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP603
	MOVF        _lastSync+0, 0 
	XORLW       0
L__SPI_Ethernet_UserTCP603:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP316
;SE9M.c,1815 :: 		len = putConstString(CSSred) ;          // not sync
	MOVF        _CSSred+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _CSSred+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _CSSred+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1816 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP317
L_SPI_Ethernet_UserTCP316:
;SE9M.c,1819 :: 		len = putConstString(CSSgreen) ;        // sync
	MOVF        _CSSgreen+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _CSSgreen+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _CSSgreen+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1820 :: 		}
L_SPI_Ethernet_UserTCP317:
;SE9M.c,1821 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1822 :: 		case 'a':
L_SPI_Ethernet_UserTCP318:
;SE9M.c,1825 :: 		len = putConstString(httpHeader) ;
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1826 :: 		len += putConstString(httpMimeTypeScript) ;
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1829 :: 		ts2str(dyna, &ts, TS2STR_ALL | TS2STR_TZ) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       7
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,1830 :: 		len += putConstString("var NOW=\"") ;
	MOVLW       ?lstr_168_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_168_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_168_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1831 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1832 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_169_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_169_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_169_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1835 :: 		int2str(epoch, dyna) ;
	MOVF        _epoch+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        _epoch+1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVF        _epoch+2, 0 
	MOVWF       FARG_int2str_l+2 
	MOVF        _epoch+3, 0 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1836 :: 		len += putConstString("var EPOCH=") ;
	MOVLW       ?lstr_170_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_170_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_170_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1837 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1838 :: 		len += putConstString(";") ;
	MOVLW       ?lstr_171_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_171_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_171_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1841 :: 		if(lastSync == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       _lastSync+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP604
	MOVF        R0, 0 
	XORWF       _lastSync+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP604
	MOVF        R0, 0 
	XORWF       _lastSync+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP604
	MOVF        _lastSync+0, 0 
	XORLW       0
L__SPI_Ethernet_UserTCP604:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP319
;SE9M.c,1843 :: 		strcpy(dyna, "???") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr172_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr172_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1844 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP320
L_SPI_Ethernet_UserTCP319:
;SE9M.c,1847 :: 		Time_epochToDate(lastSync + tmzn * 3600, &ls) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _lastSync+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _lastSync+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _lastSync+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _lastSync+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ls+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ls+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,1848 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,1849 :: 		ts2str(dyna, &ls, TS2STR_ALL | TS2STR_TZ) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ls+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ls+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       7
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,1850 :: 		}
L_SPI_Ethernet_UserTCP320:
;SE9M.c,1851 :: 		len += putConstString("var LAST=\"") ;
	MOVLW       ?lstr_173_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_173_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_173_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1852 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1853 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_174_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_174_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_174_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1855 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1857 :: 		case 'b':
L_SPI_Ethernet_UserTCP321:
;SE9M.c,1860 :: 		len = putConstString(httpHeader) ;
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1861 :: 		len += putConstString(httpMimeTypeScript) ;
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1864 :: 		ip2str(dyna, conf.sntpIP) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _conf+3
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1865 :: 		len += putConstString("var SNTP=\"") ;
	MOVLW       ?lstr_175_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_175_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_175_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1866 :: 		len += putString(conf.sntpServer) ;
	MOVLW       _conf+7
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1867 :: 		len += putConstString(" (") ;
	MOVLW       ?lstr_176_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_176_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_176_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1868 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1869 :: 		len += putConstString(")") ;
	MOVLW       ?lstr_177_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_177_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_177_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1870 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_178_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_178_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_178_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1873 :: 		if(serverStratum == 0)
	MOVF        _serverStratum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP322
;SE9M.c,1875 :: 		strcpy(dyna, "Unspecified") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr179_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr179_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1876 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP323
L_SPI_Ethernet_UserTCP322:
;SE9M.c,1877 :: 		else if(serverStratum == 1)
	MOVF        _serverStratum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP324
;SE9M.c,1879 :: 		strcpy(dyna, "1 (primary)") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr180_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr180_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1880 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP325
L_SPI_Ethernet_UserTCP324:
;SE9M.c,1881 :: 		else if(serverStratum < 16)
	MOVLW       16
	SUBWF       _serverStratum+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP326
;SE9M.c,1883 :: 		int2str(serverStratum, dyna) ;
	MOVF        _serverStratum+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1884 :: 		strcat(dyna, "(secondary)") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr181_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr181_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,1885 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP327
L_SPI_Ethernet_UserTCP326:
;SE9M.c,1888 :: 		int2str(serverStratum, dyna) ;
	MOVF        _serverStratum+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1889 :: 		strcat(dyna, " (reserved)") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr182_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr182_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,1890 :: 		}
L_SPI_Ethernet_UserTCP327:
L_SPI_Ethernet_UserTCP325:
L_SPI_Ethernet_UserTCP323:
;SE9M.c,1891 :: 		len += putConstString("var STRATUM=\"") ;
	MOVLW       ?lstr_183_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_183_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_183_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1892 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1893 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_184_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_184_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_184_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1896 :: 		switch(serverFlags & 0b11000000)
	MOVLW       192
	ANDWF       _serverFlags+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	GOTO        L_SPI_Ethernet_UserTCP328
;SE9M.c,1898 :: 		case 0b00000000: strcpy(dyna, "No warning") ; break ;
L_SPI_Ethernet_UserTCP330:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr185_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr185_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP329
;SE9M.c,1899 :: 		case 0b01000000: strcpy(dyna, "Last minute has 61 seconds") ; break ;
L_SPI_Ethernet_UserTCP331:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr186_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr186_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP329
;SE9M.c,1900 :: 		case 0b10000000: strcpy(dyna, "Last minute has 59 seconds") ; break ;
L_SPI_Ethernet_UserTCP332:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr187_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr187_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP329
;SE9M.c,1901 :: 		case 0b11000000: strcpy(dyna, "SNTP server not synchronized") ; break ;
L_SPI_Ethernet_UserTCP333:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr188_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr188_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP329
;SE9M.c,1902 :: 		}
L_SPI_Ethernet_UserTCP328:
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP330
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       64
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP331
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       128
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP332
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       192
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP333
L_SPI_Ethernet_UserTCP329:
;SE9M.c,1903 :: 		len += putConstString("var LEAP=\"") ;
	MOVLW       ?lstr_189_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_189_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_189_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1904 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1905 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_190_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_190_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_190_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1907 :: 		int2str(serverPrecision, dyna) ;
	MOVF        _serverPrecision+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1908 :: 		len += putConstString("var PRECISION=\"") ;
	MOVLW       ?lstr_191_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_191_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_191_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1909 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1910 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_192_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_192_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_192_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1912 :: 		switch(serverFlags & 0b00111000)
	MOVLW       56
	ANDWF       _serverFlags+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	GOTO        L_SPI_Ethernet_UserTCP334
;SE9M.c,1914 :: 		case 0b00011000: strcpy(dyna, "IPv4 only") ; break ;
L_SPI_Ethernet_UserTCP336:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr193_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr193_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP335
;SE9M.c,1915 :: 		case 0b00110000: strcpy(dyna, "IPv4, IPv6 and OSI") ; break ;
L_SPI_Ethernet_UserTCP337:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr194_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr194_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP335
;SE9M.c,1916 :: 		default: strcpy(dyna, "Undefined") ; break ;
L_SPI_Ethernet_UserTCP338:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr195_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr195_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP335
;SE9M.c,1917 :: 		}
L_SPI_Ethernet_UserTCP334:
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       24
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP336
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP337
	GOTO        L_SPI_Ethernet_UserTCP338
L_SPI_Ethernet_UserTCP335:
;SE9M.c,1918 :: 		len += putConstString("var VN=\"") ;
	MOVLW       ?lstr_196_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_196_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_196_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1919 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1920 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_197_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_197_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_197_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1922 :: 		switch(serverFlags & 0b00000111)
	MOVLW       7
	ANDWF       _serverFlags+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	GOTO        L_SPI_Ethernet_UserTCP339
;SE9M.c,1924 :: 		case 0b00000000: strcpy(dyna, "Reserved") ; break ;
L_SPI_Ethernet_UserTCP341:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr198_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr198_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1925 :: 		case 0b00000001: strcpy(dyna, "Symmetric active") ; break ;
L_SPI_Ethernet_UserTCP342:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr199_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr199_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1926 :: 		case 0b00000010: strcpy(dyna, "Symmetric passive") ; break ;
L_SPI_Ethernet_UserTCP343:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr200_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr200_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1927 :: 		case 0b00000011: strcpy(dyna, "Client") ; break ;
L_SPI_Ethernet_UserTCP344:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr201_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr201_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1928 :: 		case 0b00000100: strcpy(dyna, "Server") ; break ;
L_SPI_Ethernet_UserTCP345:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr202_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr202_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1929 :: 		case 0b00000101: strcpy(dyna, "Broadcast") ; break ;
L_SPI_Ethernet_UserTCP346:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr203_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr203_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1930 :: 		case 0b00000110: strcpy(dyna, "Reserved for NTP control message") ; break ;
L_SPI_Ethernet_UserTCP347:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr204_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr204_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1931 :: 		case 0b00000111: strcpy(dyna, "Reserved for private use") ; break ;
L_SPI_Ethernet_UserTCP348:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr205_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr205_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1932 :: 		}
L_SPI_Ethernet_UserTCP339:
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP341
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP342
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP343
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP344
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP345
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP346
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP347
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP348
L_SPI_Ethernet_UserTCP340:
;SE9M.c,1933 :: 		len += putConstString("var MODE=\"") ;
	MOVLW       ?lstr_206_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_206_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_206_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1934 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1935 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_207_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_207_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_207_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1937 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1939 :: 		case 'c':
L_SPI_Ethernet_UserTCP349:
;SE9M.c,1942 :: 		len = putConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1943 :: 		len += putConstString(httpMimeTypeScript) ;     // with text MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1946 :: 		ip2str(dyna, ipAddr) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1947 :: 		len += putConstString("var IP=\"") ;
	MOVLW       ?lstr_208_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_208_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_208_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1948 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1949 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_209_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_209_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_209_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1951 :: 		byte2hex(dyna, macAddr[0]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+0, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1952 :: 		byte2hex(dyna + 3, macAddr[1]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+3
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+3)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+1, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1953 :: 		byte2hex(dyna + 6, macAddr[2]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+6
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+6)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+2, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1954 :: 		byte2hex(dyna + 9, macAddr[3]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+9
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+9)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+3, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1955 :: 		byte2hex(dyna + 12, macAddr[4]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+12
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+12)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+4, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1956 :: 		byte2hex(dyna + 15, macAddr[5]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+15
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+15)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+5, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1957 :: 		*(dyna + 17) = 0 ;
	CLRF        SPI_Ethernet_UserTCP_dyna_L0+17 
;SE9M.c,1958 :: 		len += putConstString("var MAC=\"") ;
	MOVLW       ?lstr_210_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_210_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_210_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1959 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1960 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_211_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_211_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_211_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1963 :: 		ip2str(dyna, remoteHost) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVF        FARG_SPI_Ethernet_UserTCP_remoteHost+0, 0 
	MOVWF       FARG_ip2str_ip+0 
	MOVF        FARG_SPI_Ethernet_UserTCP_remoteHost+1, 0 
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1964 :: 		len += putConstString("var CLIENT=\"") ;
	MOVLW       ?lstr_212_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_212_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_212_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1965 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1966 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_213_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_213_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_213_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1969 :: 		ip2str(dyna, gwIpAddr) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1970 :: 		len += putConstString("var GW=\"") ;
	MOVLW       ?lstr_214_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_214_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_214_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1971 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1972 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_215_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_215_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_215_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1975 :: 		ip2str(dyna, ipMask) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipMask+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1976 :: 		len += putConstString("var MASK=\"") ;
	MOVLW       ?lstr_216_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_216_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_216_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1977 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1978 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_217_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_217_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_217_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1981 :: 		ip2str(dyna, dnsIpAddr) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1982 :: 		len += putConstString("var DNS=\"") ;
	MOVLW       ?lstr_218_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_218_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_218_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1983 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1984 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_219_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_219_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_219_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1986 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1988 :: 		case 'd':
L_SPI_Ethernet_UserTCP350:
;SE9M.c,1993 :: 		len = putConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1994 :: 		len += putConstString(httpMimeTypeScript) ;     // with text MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1996 :: 		len += putConstString("var SYSTEM=\"ENC28J60\";") ;
	MOVLW       ?lstr_220_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_220_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_220_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1998 :: 		int2str(Clock_kHz(), dyna) ;
	MOVLW       0
	MOVWF       FARG_int2str_l+0 
	MOVLW       125
	MOVWF       FARG_int2str_l+1 
	MOVLW       0
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1999 :: 		len += putConstString("var CLK=\"") ;
	MOVLW       ?lstr_221_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_221_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_221_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2000 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2001 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_222_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_222_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_222_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2004 :: 		int2str(httpCounter, dyna) ;
	MOVF        _httpCounter+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        _httpCounter+1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVLW       0
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,2005 :: 		len += putConstString("var REQ=") ;
	MOVLW       ?lstr_223_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_223_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_223_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2006 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2007 :: 		len += putConstString(";") ;
	MOVLW       ?lstr_224_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_224_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_224_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2009 :: 		Time_epochToDate(epoch - SPI_Ethernet_UserTimerSec + tmzn * 3600, &t) ;
	MOVF        _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVF        _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVF        _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVF        _SPI_Ethernet_UserTimerSec+0, 0 
	SUBWF       FARG_Time_epochToDate_e+0, 1 
	MOVF        _SPI_Ethernet_UserTimerSec+1, 0 
	SUBWFB      FARG_Time_epochToDate_e+1, 1 
	MOVF        _SPI_Ethernet_UserTimerSec+2, 0 
	SUBWFB      FARG_Time_epochToDate_e+2, 1 
	MOVF        _SPI_Ethernet_UserTimerSec+3, 0 
	SUBWFB      FARG_Time_epochToDate_e+3, 1 
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_Time_epochToDate_e+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_Time_epochToDate_e+1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      FARG_Time_epochToDate_e+2, 1 
	ADDWFC      FARG_Time_epochToDate_e+3, 1 
	MOVLW       SPI_Ethernet_UserTCP_t_L2+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_t_L2+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2010 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2011 :: 		ts2str(dyna, &t, TS2STR_ALL | TS2STR_TZ) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       SPI_Ethernet_UserTCP_t_L2+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_t_L2+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       7
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,2012 :: 		len += putConstString("var UP=\"") ;
	MOVLW       ?lstr_225_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_225_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_225_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2013 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2014 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_226_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_226_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_226_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2017 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,2020 :: 		case '4':
L_SPI_Ethernet_UserTCP351:
;SE9M.c,2021 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,2022 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr227_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr227_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2023 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr228_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr228_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2025 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2026 :: 		len += putConstString(HTMLsystem) ;
	MOVF        _HTMLsystem+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLsystem+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLsystem+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2027 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2028 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,2030 :: 		case '3':
L_SPI_Ethernet_UserTCP352:
;SE9M.c,2031 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,2032 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr229_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr229_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2033 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr230_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr230_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2035 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2036 :: 		len += putConstString(HTMLnetwork) ;
	MOVF        _HTMLnetwork+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLnetwork+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLnetwork+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2037 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2038 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,2040 :: 		case '2':
L_SPI_Ethernet_UserTCP353:
;SE9M.c,2041 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,2042 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr231_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr231_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2043 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr232_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr232_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2045 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2046 :: 		len += putConstString(HTMLsntp) ;
	MOVF        _HTMLsntp+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLsntp+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLsntp+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2047 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2048 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,2050 :: 		case '1':
L_SPI_Ethernet_UserTCP354:
;SE9M.c,2051 :: 		default:
L_SPI_Ethernet_UserTCP355:
;SE9M.c,2052 :: 		if (uzobyte == 1) {
	MOVF        _uzobyte+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP356
;SE9M.c,2053 :: 		uzobyte = 0;
	CLRF        _uzobyte+0 
;SE9M.c,2054 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP357
L_SPI_Ethernet_UserTCP356:
;SE9M.c,2055 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,2056 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr233_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr233_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2057 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr234_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr234_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2058 :: 		}
L_SPI_Ethernet_UserTCP357:
;SE9M.c,2060 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2061 :: 		len += putConstString(HTMLtime) ;
	MOVF        _HTMLtime+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLtime+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLtime+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2062 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,2063 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP314
L_SPI_Ethernet_UserTCP313:
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       115
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP315
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       97
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP318
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       98
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP321
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP349
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       100
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP350
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       52
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP351
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP352
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP353
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP354
	GOTO        L_SPI_Ethernet_UserTCP355
L_SPI_Ethernet_UserTCP314:
L_SPI_Ethernet_UserTCP312:
;SE9M.c,2065 :: 		httpCounter++ ;                             // one more request done
	INFSNZ      _httpCounter+0, 1 
	INCF        _httpCounter+1, 1 
;SE9M.c,2070 :: 		ZAVRSI:
___SPI_Ethernet_UserTCP_ZAVRSI:
;SE9M.c,2072 :: 		return(len) ;                               // return to the library with the number of bytes to transmit
	MOVF        SPI_Ethernet_UserTCP_len_L0+0, 0 
	MOVWF       R0 
	MOVF        SPI_Ethernet_UserTCP_len_L0+1, 0 
	MOVWF       R1 
;SE9M.c,2073 :: 		}
L_end_SPI_Ethernet_UserTCP:
	RETURN      0
; end of _SPI_Ethernet_UserTCP

_Print_Seg:

;SE9M.c,2075 :: 		char Print_Seg(char segm, char tacka) {
;SE9M.c,2077 :: 		if (segm == 0) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg358
;SE9M.c,2078 :: 		napolje = 0b01111110 | tacka;
	MOVLW       126
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2079 :: 		}
L_Print_Seg358:
;SE9M.c,2080 :: 		if (segm == 1) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg359
;SE9M.c,2081 :: 		napolje = 0b00011000 | tacka;
	MOVLW       24
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2082 :: 		}
L_Print_Seg359:
;SE9M.c,2083 :: 		if (segm == 2) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg360
;SE9M.c,2084 :: 		napolje = 0b10110110 | tacka;
	MOVLW       182
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2085 :: 		}
L_Print_Seg360:
;SE9M.c,2086 :: 		if (segm == 3) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg361
;SE9M.c,2087 :: 		napolje = 0b10111100 | tacka;
	MOVLW       188
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2088 :: 		}
L_Print_Seg361:
;SE9M.c,2089 :: 		if (segm == 4) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg362
;SE9M.c,2090 :: 		napolje = 0b11011000 | tacka;
	MOVLW       216
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2091 :: 		}
L_Print_Seg362:
;SE9M.c,2092 :: 		if (segm == 5) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg363
;SE9M.c,2093 :: 		napolje = 0b11101100 | tacka;
	MOVLW       236
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2094 :: 		}
L_Print_Seg363:
;SE9M.c,2095 :: 		if (segm == 6) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg364
;SE9M.c,2096 :: 		napolje = 0b11101110 | tacka;
	MOVLW       238
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2097 :: 		}
L_Print_Seg364:
;SE9M.c,2098 :: 		if (segm == 7) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg365
;SE9M.c,2099 :: 		napolje = 0b00111000 | tacka;
	MOVLW       56
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2100 :: 		}
L_Print_Seg365:
;SE9M.c,2101 :: 		if (segm == 8) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg366
;SE9M.c,2102 :: 		napolje = 0b11111110 | tacka;
	MOVLW       254
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2103 :: 		}
L_Print_Seg366:
;SE9M.c,2104 :: 		if (segm == 9) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg367
;SE9M.c,2105 :: 		napolje = 0b11111100 | tacka;
	MOVLW       252
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2106 :: 		}
L_Print_Seg367:
;SE9M.c,2108 :: 		if (segm == 10) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg368
;SE9M.c,2109 :: 		napolje = 0b11110010 | tacka;
	MOVLW       242
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2110 :: 		}
L_Print_Seg368:
;SE9M.c,2111 :: 		if (segm == 11) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg369
;SE9M.c,2112 :: 		napolje = 0b01110010 | tacka;
	MOVLW       114
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2113 :: 		}
L_Print_Seg369:
;SE9M.c,2114 :: 		if (segm == 12) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg370
;SE9M.c,2115 :: 		napolje = 0b01111000 | tacka;
	MOVLW       120
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2116 :: 		}
L_Print_Seg370:
;SE9M.c,2117 :: 		if (segm == 13) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg371
;SE9M.c,2118 :: 		napolje = 0b11100110 | tacka;
	MOVLW       230
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2119 :: 		}
L_Print_Seg371:
;SE9M.c,2120 :: 		if (segm == 14) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg372
;SE9M.c,2121 :: 		napolje = 0b00000100 | tacka;
	MOVLW       4
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,2122 :: 		}
L_Print_Seg372:
;SE9M.c,2124 :: 		if (segm == 15) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg373
;SE9M.c,2125 :: 		napolje = 0b00000000;
	CLRF        R1 
;SE9M.c,2126 :: 		}
L_Print_Seg373:
;SE9M.c,2128 :: 		if (segm == 16) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg374
;SE9M.c,2129 :: 		napolje = 0b00000001;
	MOVLW       1
	MOVWF       R1 
;SE9M.c,2130 :: 		}
L_Print_Seg374:
;SE9M.c,2132 :: 		if (segm == 17) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg375
;SE9M.c,2133 :: 		napolje = 0b10000000;
	MOVLW       128
	MOVWF       R1 
;SE9M.c,2134 :: 		}
L_Print_Seg375:
;SE9M.c,2136 :: 		return napolje;
	MOVF        R1, 0 
	MOVWF       R0 
;SE9M.c,2137 :: 		}
L_end_Print_Seg:
	RETURN      0
; end of _Print_Seg

_PRINT_S:

;SE9M.c,2139 :: 		void PRINT_S(char ledovi) {
;SE9M.c,2141 :: 		pom = 0;
	CLRF        R3 
;SE9M.c,2142 :: 		for ( ir = 0; ir < 8; ir++ ) {
	CLRF        R4 
L_PRINT_S376:
	MOVLW       8
	SUBWF       R4, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_PRINT_S377
;SE9M.c,2143 :: 		pom1 = (ledovi << pom) & 0b10000000;
	MOVF        R3, 0 
	MOVWF       R1 
	MOVF        FARG_PRINT_S_ledovi+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__PRINT_S607:
	BZ          L__PRINT_S608
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__PRINT_S607
L__PRINT_S608:
	MOVLW       128
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R2 
;SE9M.c,2144 :: 		if (pom1 == 0b10000000) {
	MOVF        R1, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S379
;SE9M.c,2145 :: 		SV_DATA = 1;
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,2146 :: 		}
L_PRINT_S379:
;SE9M.c,2147 :: 		if (pom1 == 0b00000000) {
	MOVF        R2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S380
;SE9M.c,2148 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,2149 :: 		}
L_PRINT_S380:
;SE9M.c,2150 :: 		asm nop;
	NOP
;SE9M.c,2151 :: 		asm nop;
	NOP
;SE9M.c,2152 :: 		asm nop;
	NOP
;SE9M.c,2153 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,2154 :: 		asm nop;
	NOP
;SE9M.c,2155 :: 		asm nop;
	NOP
;SE9M.c,2156 :: 		asm nop;
	NOP
;SE9M.c,2157 :: 		SV_CLK = 1;
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,2158 :: 		pom++;
	INCF        R3, 1 
;SE9M.c,2142 :: 		for ( ir = 0; ir < 8; ir++ ) {
	INCF        R4, 1 
;SE9M.c,2159 :: 		}
	GOTO        L_PRINT_S376
L_PRINT_S377:
;SE9M.c,2160 :: 		}
L_end_PRINT_S:
	RETURN      0
; end of _PRINT_S

_Display_Time:

;SE9M.c,2162 :: 		void Display_Time() {
;SE9M.c,2164 :: 		sec1 = sekundi / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sekundi+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _sec1+0 
;SE9M.c,2165 :: 		sec2 = sekundi - sec1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sekundi+0, 0 
	MOVWF       _sec2+0 
;SE9M.c,2166 :: 		min1 = minuti / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _minuti+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _min1+0 
;SE9M.c,2167 :: 		min2 = minuti - min1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _minuti+0, 0 
	MOVWF       _min2+0 
;SE9M.c,2168 :: 		hr1 = sati / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sati+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _hr1+0 
;SE9M.c,2169 :: 		hr2 = sati - hr1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sati+0, 0 
	MOVWF       _hr2+0 
;SE9M.c,2170 :: 		day1 = dan / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _dan+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _day1+0 
;SE9M.c,2171 :: 		day2 = dan - day1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _dan+0, 0 
	MOVWF       _day2+0 
;SE9M.c,2172 :: 		mn1 = mesec / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _mesec+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _mn1+0 
;SE9M.c,2173 :: 		mn2 = mesec - mn1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _mesec+0, 0 
	MOVWF       _mn2+0 
;SE9M.c,2174 :: 		year1 = fingodina / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _fingodina+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _year1+0 
;SE9M.c,2175 :: 		year2 = fingodina - year1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _fingodina+0, 0 
	MOVWF       _year2+0 
;SE9M.c,2177 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time381
;SE9M.c,2178 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2179 :: 		asm nop;
	NOP
;SE9M.c,2180 :: 		asm nop;
	NOP
;SE9M.c,2181 :: 		asm nop;
	NOP
;SE9M.c,2182 :: 		PRINT_S(Print_Seg(sec2, 0));
	MOVF        _sec2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2183 :: 		PRINT_S(Print_Seg(sec1, 0));
	MOVF        _sec1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2184 :: 		PRINT_S(Print_Seg(min2, 0));
	MOVF        _min2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2185 :: 		PRINT_S(Print_Seg(min1, 0));
	MOVF        _min1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2186 :: 		PRINT_S(Print_Seg(hr2, tacka1));
	MOVF        _hr2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka1+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2187 :: 		PRINT_S(Print_Seg(hr1, tacka2));
	MOVF        _hr1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka2+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2188 :: 		asm nop;
	NOP
;SE9M.c,2189 :: 		asm nop;
	NOP
;SE9M.c,2190 :: 		asm nop;
	NOP
;SE9M.c,2191 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2192 :: 		}
L_Display_Time381:
;SE9M.c,2193 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time382
;SE9M.c,2194 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2195 :: 		asm nop;
	NOP
;SE9M.c,2196 :: 		asm nop;
	NOP
;SE9M.c,2197 :: 		asm nop;
	NOP
;SE9M.c,2198 :: 		PRINT_S(Print_Seg(year2, 0));
	MOVF        _year2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2199 :: 		PRINT_S(Print_Seg(year1, 0));
	MOVF        _year1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2200 :: 		PRINT_S(Print_Seg(mn2, 0));
	MOVF        _mn2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2201 :: 		PRINT_S(Print_Seg(mn1, 0));
	MOVF        _mn1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2202 :: 		PRINT_S(Print_Seg(day2, tacka1));
	MOVF        _day2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka1+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2203 :: 		PRINT_S(Print_Seg(day1, tacka2));
	MOVF        _day1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka2+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2204 :: 		asm nop;
	NOP
;SE9M.c,2205 :: 		asm nop;
	NOP
;SE9M.c,2206 :: 		asm nop;
	NOP
;SE9M.c,2207 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2208 :: 		}
L_Display_Time382:
;SE9M.c,2210 :: 		}
L_end_Display_Time:
	RETURN      0
; end of _Display_Time

_Print_IP:

;SE9M.c,2212 :: 		void Print_IP() {
;SE9M.c,2216 :: 		cif1 =  ipAddr[3] / 100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _ipAddr+3, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       Print_IP_cif1_L0+0 
;SE9M.c,2217 :: 		cif2 = (ipAddr[3] - cif1 * 100) / 10;
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	SUBWF       _ipAddr+3, 0 
	MOVWF       FLOC__Print_IP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Print_IP+1 
	MOVLW       0
	SUBFWB      FLOC__Print_IP+1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__Print_IP+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Print_IP+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       Print_IP_cif2_L0+0 
;SE9M.c,2218 :: 		cif3 =  ipAddr[3] - cif1 * 100 - cif2 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FLOC__Print_IP+0, 0 
	MOVWF       Print_IP_cif3_L0+0 
;SE9M.c,2219 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2220 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2221 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2222 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2223 :: 		PRINT_S(Print_Seg(cif3, 0));
	MOVF        Print_IP_cif3_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2224 :: 		PRINT_S(Print_Seg(cif2, 0));
	MOVF        Print_IP_cif2_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2225 :: 		PRINT_S(Print_Seg(cif1, 0));
	MOVF        Print_IP_cif1_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2226 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2227 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2228 :: 		delay_ms(2000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_Print_IP383:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP383
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP383
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP383
	NOP
;SE9M.c,2229 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2230 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2231 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2232 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2233 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2234 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2235 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2236 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2237 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2238 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2239 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_IP384:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP384
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP384
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP384
	NOP
;SE9M.c,2240 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2241 :: 		}
L_end_Print_IP:
	RETURN      0
; end of _Print_IP

_SPI_Ethernet_UserUDP:

;SE9M.c,2246 :: 		unsigned int  SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags)
;SE9M.c,2251 :: 		if (destPort == 10001) {
	MOVF        FARG_SPI_Ethernet_UserUDP_destPort+1, 0 
	XORLW       39
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP612
	MOVLW       17
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+0, 0 
L__SPI_Ethernet_UserUDP612:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP385
;SE9M.c,2252 :: 		if (reqLength == 9) {
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP613
	MOVLW       9
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+0, 0 
L__SPI_Ethernet_UserUDP613:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP386
;SE9M.c,2253 :: 		for (i = 0 ; i < 9 ; i++) {
	CLRF        SPI_Ethernet_UserUDP_i_L0+0 
L_SPI_Ethernet_UserUDP387:
	MOVLW       9
	SUBWF       SPI_Ethernet_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserUDP388
;SE9M.c,2254 :: 		broadcmd[i] = SPI_Ethernet_getByte() ;
	MOVLW       SPI_Ethernet_UserUDP_broadcmd_L0+0
	MOVWF       FLOC__SPI_Ethernet_UserUDP+0 
	MOVLW       hi_addr(SPI_Ethernet_UserUDP_broadcmd_L0+0)
	MOVWF       FLOC__SPI_Ethernet_UserUDP+1 
	MOVF        SPI_Ethernet_UserUDP_i_L0+0, 0 
	ADDWF       FLOC__SPI_Ethernet_UserUDP+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__SPI_Ethernet_UserUDP+1, 1 
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVFF       FLOC__SPI_Ethernet_UserUDP+0, FSR1
	MOVFF       FLOC__SPI_Ethernet_UserUDP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2253 :: 		for (i = 0 ; i < 9 ; i++) {
	INCF        SPI_Ethernet_UserUDP_i_L0+0, 1 
;SE9M.c,2255 :: 		}
	GOTO        L_SPI_Ethernet_UserUDP387
L_SPI_Ethernet_UserUDP388:
;SE9M.c,2256 :: 		if ( (broadcmd[0] == 'I') && (broadcmd[1] == 'D') && (broadcmd[2] == 'E') && (broadcmd[3] == 'N') && (broadcmd[4] == 'T') && (broadcmd[5] == 'I') && (broadcmd[6] == 'F') && (broadcmd[7] == 'Y') && (broadcmd[8] == '!') ) {
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+0, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+1, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+2, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+3, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+4, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+5, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+6, 0 
	XORLW       70
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+7, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+8, 0 
	XORLW       33
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
L__SPI_Ethernet_UserUDP564:
;SE9M.c,2257 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2258 :: 		}
L_SPI_Ethernet_UserUDP392:
;SE9M.c,2259 :: 		}
L_SPI_Ethernet_UserUDP386:
;SE9M.c,2260 :: 		}
L_SPI_Ethernet_UserUDP385:
;SE9M.c,2262 :: 		if(destPort == 123)             // check SNTP port number
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP614
	MOVLW       123
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+0, 0 
L__SPI_Ethernet_UserUDP614:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP393
;SE9M.c,2264 :: 		if (reqLength == 48) {
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP615
	MOVLW       48
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+0, 0 
L__SPI_Ethernet_UserUDP615:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
;SE9M.c,2268 :: 		serverFlags = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverFlags+0 
;SE9M.c,2269 :: 		serverStratum = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverStratum+0 
;SE9M.c,2270 :: 		SPI_Ethernet_getByte() ;        // skip poll
	CALL        _SPI_Ethernet_getByte+0, 0
;SE9M.c,2271 :: 		serverPrecision = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverPrecision+0 
;SE9M.c,2273 :: 		for(i = 0 ; i < 36 ; i++)
	CLRF        SPI_Ethernet_UserUDP_i_L0+0 
L_SPI_Ethernet_UserUDP395:
	MOVLW       36
	SUBWF       SPI_Ethernet_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserUDP396
;SE9M.c,2275 :: 		SPI_Ethernet_getByte() ; // skip all unused fileds
	CALL        _SPI_Ethernet_getByte+0, 0
;SE9M.c,2273 :: 		for(i = 0 ; i < 36 ; i++)
	INCF        SPI_Ethernet_UserUDP_i_L0+0, 1 
;SE9M.c,2276 :: 		}
	GOTO        L_SPI_Ethernet_UserUDP395
L_SPI_Ethernet_UserUDP396:
;SE9M.c,2279 :: 		Highest(tts) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_tts_L2+3 
;SE9M.c,2280 :: 		Higher(tts) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_tts_L2+2 
;SE9M.c,2281 :: 		Hi(tts) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_tts_L2+1 
;SE9M.c,2282 :: 		Lo(tts) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_tts_L2+0 
;SE9M.c,2285 :: 		epoch = tts - 2208988800 ;
	MOVF        SPI_Ethernet_UserUDP_tts_L2+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+0 
	MOVF        SPI_Ethernet_UserUDP_tts_L2+1, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+1 
	MOVF        SPI_Ethernet_UserUDP_tts_L2+2, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+2 
	MOVF        SPI_Ethernet_UserUDP_tts_L2+3, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+3 
	MOVLW       128
	SUBWF       FLOC__SPI_Ethernet_UserUDP+0, 1 
	MOVLW       126
	SUBWFB      FLOC__SPI_Ethernet_UserUDP+1, 1 
	MOVLW       170
	SUBWFB      FLOC__SPI_Ethernet_UserUDP+2, 1 
	MOVLW       131
	SUBWFB      FLOC__SPI_Ethernet_UserUDP+3, 1 
	MOVF        FLOC__SPI_Ethernet_UserUDP+0, 0 
	MOVWF       _epoch+0 
	MOVF        FLOC__SPI_Ethernet_UserUDP+1, 0 
	MOVWF       _epoch+1 
	MOVF        FLOC__SPI_Ethernet_UserUDP+2, 0 
	MOVWF       _epoch+2 
	MOVF        FLOC__SPI_Ethernet_UserUDP+3, 0 
	MOVWF       _epoch+3 
;SE9M.c,2288 :: 		lastSync = epoch ;
	MOVF        FLOC__SPI_Ethernet_UserUDP+0, 0 
	MOVWF       _lastSync+0 
	MOVF        FLOC__SPI_Ethernet_UserUDP+1, 0 
	MOVWF       _lastSync+1 
	MOVF        FLOC__SPI_Ethernet_UserUDP+2, 0 
	MOVWF       _lastSync+2 
	MOVF        FLOC__SPI_Ethernet_UserUDP+3, 0 
	MOVWF       _lastSync+3 
;SE9M.c,2291 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,2293 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2294 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,2296 :: 		Time_epochToDate(epoch + tmzn * 3600l, &ts) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       0
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__SPI_Ethernet_UserUDP+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__SPI_Ethernet_UserUDP+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVF        R2, 0 
	ADDWFC      FLOC__SPI_Ethernet_UserUDP+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVF        R3, 0 
	ADDWFC      FLOC__SPI_Ethernet_UserUDP+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ts+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2297 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2298 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2299 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP398
;SE9M.c,2300 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2301 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2302 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,2303 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,2304 :: 		}
L_SPI_Ethernet_UserUDP398:
;SE9M.c,2306 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2307 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,2308 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,2309 :: 		} else {
	GOTO        L_SPI_Ethernet_UserUDP399
L_SPI_Ethernet_UserUDP394:
;SE9M.c,2310 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserUDP
;SE9M.c,2311 :: 		}
L_SPI_Ethernet_UserUDP399:
;SE9M.c,2312 :: 		} else {
	GOTO        L_SPI_Ethernet_UserUDP400
L_SPI_Ethernet_UserUDP393:
;SE9M.c,2313 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserUDP
;SE9M.c,2314 :: 		}
L_SPI_Ethernet_UserUDP400:
;SE9M.c,2315 :: 		}
L_end_SPI_Ethernet_UserUDP:
	RETURN      0
; end of _SPI_Ethernet_UserUDP

_interrupt:

;SE9M.c,2317 :: 		void interrupt() {
;SE9M.c,2318 :: 		if (PIR1.RCIF == 1) {
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt401
;SE9M.c,2319 :: 		prkomanda = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _prkomanda+0 
;SE9M.c,2320 :: 		if ( ( (ipt == 0) && (prkomanda == 0xAA) ) || (ipt != 0) ) {
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt568
	MOVF        _prkomanda+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt568
	GOTO        L__interrupt567
L__interrupt568:
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt567
	GOTO        L_interrupt406
L__interrupt567:
;SE9M.c,2321 :: 		comand[ipt] = prkomanda;
	MOVLW       _comand+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_comand+0)
	MOVWF       FSR1H 
	MOVF        _ipt+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _prkomanda+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2322 :: 		ipt++;
	INCF        _ipt+0, 1 
;SE9M.c,2323 :: 		}
L_interrupt406:
;SE9M.c,2324 :: 		if (prkomanda == 0xBB) {
	MOVF        _prkomanda+0, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt407
;SE9M.c,2325 :: 		komgotovo = 1;
	MOVLW       1
	MOVWF       _komgotovo+0 
;SE9M.c,2326 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,2327 :: 		}
L_interrupt407:
;SE9M.c,2328 :: 		if (ipt > 18) {
	MOVF        _ipt+0, 0 
	SUBLW       18
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt408
;SE9M.c,2329 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,2330 :: 		}
L_interrupt408:
;SE9M.c,2331 :: 		}
L_interrupt401:
;SE9M.c,2333 :: 		if (INTCON.TMR0IF) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt409
;SE9M.c,2334 :: 		presTmr++ ;
	INFSNZ      _presTmr+0, 1 
	INCF        _presTmr+1, 1 
;SE9M.c,2335 :: 		lcdTmr++ ;
	INFSNZ      _lcdTmr+0, 1 
	INCF        _lcdTmr+1, 1 
;SE9M.c,2336 :: 		if (presTmr == 15625) {
	MOVF        _presTmr+1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt618
	MOVLW       9
	XORWF       _presTmr+0, 0 
L__interrupt618:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt410
;SE9M.c,2339 :: 		if (tmr_rst_en == 1) {
	MOVF        _tmr_rst_en+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt411
;SE9M.c,2340 :: 		tmr_rst++;
	INCF        _tmr_rst+0, 1 
;SE9M.c,2341 :: 		if (tmr_rst == 178) {
	MOVF        _tmr_rst+0, 0 
	XORLW       178
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt412
;SE9M.c,2342 :: 		tmr_rst = 0;
	CLRF        _tmr_rst+0 
;SE9M.c,2343 :: 		tmr_rst_en = 0;
	CLRF        _tmr_rst_en+0 
;SE9M.c,2344 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,2345 :: 		}
L_interrupt412:
;SE9M.c,2346 :: 		} else {
	GOTO        L_interrupt413
L_interrupt411:
;SE9M.c,2347 :: 		tmr_rst = 0;
	CLRF        _tmr_rst+0 
;SE9M.c,2348 :: 		}
L_interrupt413:
;SE9M.c,2352 :: 		notime++;
	INCF        _notime+0, 1 
;SE9M.c,2353 :: 		if (notime == 32) {
	MOVF        _notime+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt414
;SE9M.c,2354 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2355 :: 		notime_ovf = 1;
	MOVLW       1
	MOVWF       _notime_ovf+0 
;SE9M.c,2356 :: 		}
L_interrupt414:
;SE9M.c,2360 :: 		if ( (lease_tmr == 1) && (lease_time < 250) ) {
	MOVF        _lease_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt417
	MOVLW       250
	SUBWF       _lease_time+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt417
L__interrupt566:
;SE9M.c,2361 :: 		lease_time++;
	INCF        _lease_time+0, 1 
;SE9M.c,2362 :: 		} else {
	GOTO        L_interrupt418
L_interrupt417:
;SE9M.c,2363 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,2364 :: 		}
L_interrupt418:
;SE9M.c,2368 :: 		SPI_Ethernet_UserTimerSec++ ;
	MOVLW       1
	ADDWF       _SPI_Ethernet_UserTimerSec+0, 1 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+1, 1 
	ADDWFC      _SPI_Ethernet_UserTimerSec+2, 1 
	ADDWFC      _SPI_Ethernet_UserTimerSec+3, 1 
;SE9M.c,2369 :: 		epoch++ ;
	MOVLW       1
	ADDWF       _epoch+0, 1 
	MOVLW       0
	ADDWFC      _epoch+1, 1 
	ADDWFC      _epoch+2, 1 
	ADDWFC      _epoch+3, 1 
;SE9M.c,2370 :: 		presTmr = 0 ;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2374 :: 		if (timer_flag < 2555) {
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       9
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt619
	MOVLW       251
	SUBWF       _timer_flag+0, 0 
L__interrupt619:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt419
;SE9M.c,2375 :: 		timer_flag++;
	INCF        _timer_flag+0, 1 
;SE9M.c,2376 :: 		} else {
	GOTO        L_interrupt420
L_interrupt419:
;SE9M.c,2377 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2378 :: 		}
L_interrupt420:
;SE9M.c,2383 :: 		req_tmr_1++;
	INCF        _req_tmr_1+0, 1 
;SE9M.c,2384 :: 		if (req_tmr_1 == 60) {
	MOVF        _req_tmr_1+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt421
;SE9M.c,2385 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,2386 :: 		req_tmr_2++;
	INCF        _req_tmr_2+0, 1 
;SE9M.c,2387 :: 		}
L_interrupt421:
;SE9M.c,2388 :: 		if (req_tmr_2 == 60) {
	MOVF        _req_tmr_2+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt422
;SE9M.c,2389 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,2390 :: 		req_tmr_3++;
	INCF        _req_tmr_3+0, 1 
;SE9M.c,2391 :: 		}
L_interrupt422:
;SE9M.c,2395 :: 		if (rst_flag == 1) {
	MOVF        _rst_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt423
;SE9M.c,2396 :: 		rst_flag_1++;
	INCF        _rst_flag_1+0, 1 
;SE9M.c,2397 :: 		}
L_interrupt423:
;SE9M.c,2401 :: 		if ( (rst_fab_tmr == 1) && (rst_fab_flag < 200) ) {
	MOVF        _rst_fab_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt426
	MOVLW       200
	SUBWF       _rst_fab_flag+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt426
L__interrupt565:
;SE9M.c,2402 :: 		rst_fab_flag++;
	INCF        _rst_fab_flag+0, 1 
;SE9M.c,2403 :: 		}
L_interrupt426:
;SE9M.c,2406 :: 		}
L_interrupt410:
;SE9M.c,2408 :: 		if (lcdTmr == 3125) {
	MOVF        _lcdTmr+1, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt620
	MOVLW       53
	XORWF       _lcdTmr+0, 0 
L__interrupt620:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt427
;SE9M.c,2409 :: 		lcdEvent = 1;
	MOVLW       1
	MOVWF       _lcdEvent+0 
;SE9M.c,2410 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,2411 :: 		}
L_interrupt427:
;SE9M.c,2412 :: 		INTCON.TMR0IF = 0 ;              // clear timer0 overflow flag
	BCF         INTCON+0, 2 
;SE9M.c,2413 :: 		}
L_interrupt409:
;SE9M.c,2414 :: 		}
L_end_interrupt:
L__interrupt617:
	RETFIE      1
; end of _interrupt

_Print_Blank:

;SE9M.c,2416 :: 		void Print_Blank() {
;SE9M.c,2417 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2418 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2419 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2420 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2421 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2422 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2423 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2424 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2425 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2426 :: 		delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_Print_Blank428:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank428
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank428
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank428
;SE9M.c,2427 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2428 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2429 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2430 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2431 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2432 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2433 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2434 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2435 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2436 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2437 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_Blank429:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank429
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank429
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank429
	NOP
;SE9M.c,2438 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2439 :: 		}
L_end_Print_Blank:
	RETURN      0
; end of _Print_Blank

_Print_All:

;SE9M.c,2441 :: 		void Print_All() {
;SE9M.c,2445 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2446 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2447 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2448 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2449 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2450 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2451 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2452 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2453 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2454 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All430:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All430
	DECFSZ      R12, 1, 1
	BRA         L_Print_All430
	DECFSZ      R11, 1, 1
	BRA         L_Print_All430
	NOP
;SE9M.c,2455 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2456 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	CLRF        Print_All_pebr_L0+0 
L_Print_All431:
	MOVF        Print_All_pebr_L0+0, 0 
	SUBLW       9
	BTFSS       STATUS+0, 0 
	GOTO        L_Print_All432
;SE9M.c,2457 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2458 :: 		if ( (pebr == 1) || (pebr == 3) || (pebr == 5) || (pebr == 7) || (pebr == 9) ) {
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	GOTO        L_Print_All436
L__Print_All569:
;SE9M.c,2459 :: 		tck1 = 1;
	MOVLW       1
	MOVWF       Print_All_tck1_L0+0 
;SE9M.c,2460 :: 		tck2 = 0;
	CLRF        Print_All_tck2_L0+0 
;SE9M.c,2461 :: 		} else {
	GOTO        L_Print_All437
L_Print_All436:
;SE9M.c,2462 :: 		tck1 = 0;
	CLRF        Print_All_tck1_L0+0 
;SE9M.c,2463 :: 		tck2 = 1;
	MOVLW       1
	MOVWF       Print_All_tck2_L0+0 
;SE9M.c,2464 :: 		}
L_Print_All437:
;SE9M.c,2465 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2466 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2467 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2468 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2469 :: 		PRINT_S(Print_Seg(pebr, tck1));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck1_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2470 :: 		PRINT_S(Print_Seg(pebr, tck2));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck2_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2471 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2472 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2473 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All438:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All438
	DECFSZ      R12, 1, 1
	BRA         L_Print_All438
	DECFSZ      R11, 1, 1
	BRA         L_Print_All438
	NOP
;SE9M.c,2474 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2456 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	INCF        Print_All_pebr_L0+0, 1 
;SE9M.c,2475 :: 		}
	GOTO        L_Print_All431
L_Print_All432:
;SE9M.c,2476 :: 		}
L_end_Print_All:
	RETURN      0
; end of _Print_All

_Print_Pme:

;SE9M.c,2478 :: 		void Print_Pme() {
;SE9M.c,2479 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2480 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2481 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2482 :: 		PRINT_S(Print_Seg(13, 0));
	MOVLW       13
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2483 :: 		PRINT_S(Print_Seg(12, 0));
	MOVLW       12
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2484 :: 		PRINT_S(Print_Seg(11, 0));
	MOVLW       11
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2485 :: 		PRINT_S(Print_Seg(10, 0));
	MOVLW       10
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2486 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2487 :: 		}
L_end_Print_Pme:
	RETURN      0
; end of _Print_Pme

_Print_Light:

;SE9M.c,2489 :: 		void Print_Light() {
;SE9M.c,2490 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,2491 :: 		light_res = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _light_res+0 
	MOVF        R1, 0 
	MOVWF       _light_res+1 
;SE9M.c,2492 :: 		result = light_res * 0.00322265625;  // scale adc result by 100000 (3.22mV/lsb => 3.3V / 1024 = 0.00322265625...V)
	CALL        _word2double+0, 0
	MOVLW       51
	MOVWF       R4 
	MOVLW       51
	MOVWF       R5 
	MOVLW       83
	MOVWF       R6 
	MOVLW       118
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _result+0 
	MOVF        R1, 0 
	MOVWF       _result+1 
	MOVF        R2, 0 
	MOVWF       _result+2 
	MOVF        R3, 0 
	MOVWF       _result+3 
;SE9M.c,2494 :: 		if (result <= 1.3) {                            // 1.1
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       102
	MOVWF       R0 
	MOVLW       102
	MOVWF       R1 
	MOVLW       38
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light439
;SE9M.c,2495 :: 		PWM1_Set_Duty(max_light);
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2496 :: 		}
L_Print_Light439:
;SE9M.c,2497 :: 		if ( (result > 1.3) && (result <= 2.3) ) {      // 1.1 - 2.2
	MOVF        _result+0, 0 
	MOVWF       R4 
	MOVF        _result+1, 0 
	MOVWF       R5 
	MOVF        _result+2, 0 
	MOVWF       R6 
	MOVF        _result+3, 0 
	MOVWF       R7 
	MOVLW       102
	MOVWF       R0 
	MOVLW       102
	MOVWF       R1 
	MOVLW       38
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light442
	MOVF        _result+0, 0 
	MOVWF       R4 
	MOVF        _result+1, 0 
	MOVWF       R5 
	MOVF        _result+2, 0 
	MOVWF       R6 
	MOVF        _result+3, 0 
	MOVWF       R7 
	MOVLW       51
	MOVWF       R0 
	MOVLW       51
	MOVWF       R1 
	MOVLW       19
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light442
L__Print_Light570:
;SE9M.c,2498 :: 		PWM1_Set_Duty((max_light*2)/3);
	MOVF        _max_light+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2499 :: 		}
L_Print_Light442:
;SE9M.c,2500 :: 		if (result > 2.3) {
	MOVF        _result+0, 0 
	MOVWF       R4 
	MOVF        _result+1, 0 
	MOVWF       R5 
	MOVF        _result+2, 0 
	MOVWF       R6 
	MOVF        _result+3, 0 
	MOVWF       R7 
	MOVLW       51
	MOVWF       R0 
	MOVLW       51
	MOVWF       R1 
	MOVLW       19
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light443
;SE9M.c,2501 :: 		PWM1_Set_Duty(max_light/3);                  // 2.2
	MOVLW       3
	MOVWF       R4 
	MOVF        _max_light+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2502 :: 		}
L_Print_Light443:
;SE9M.c,2504 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2505 :: 		}
L_end_Print_Light:
	RETURN      0
; end of _Print_Light

_Mem_Read:

;SE9M.c,2507 :: 		void Mem_Read() {
;SE9M.c,2509 :: 		MSSPEN  = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2510 :: 		asm nop;
	NOP
;SE9M.c,2511 :: 		asm nop;
	NOP
;SE9M.c,2512 :: 		asm nop;
	NOP
;SE9M.c,2513 :: 		I2C1_Init(100000);
	MOVLW       80
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;SE9M.c,2514 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SE9M.c,2515 :: 		I2C1_Wr(0xA2);
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2516 :: 		I2C1_Wr(0xFA);
	MOVLW       250
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2517 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;SE9M.c,2518 :: 		I2C1_Wr(0xA3);
	MOVLW       163
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2519 :: 		for(membr=0 ; membr<=4 ; membr++) {
	CLRF        Mem_Read_membr_L0+0 
L_Mem_Read444:
	MOVF        Mem_Read_membr_L0+0, 0 
	SUBLW       4
	BTFSS       STATUS+0, 0 
	GOTO        L_Mem_Read445
;SE9M.c,2520 :: 		macAddr[membr] = I2C1_Rd(1);
	MOVLW       _macAddr+0
	MOVWF       FLOC__Mem_Read+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FLOC__Mem_Read+1 
	MOVF        Mem_Read_membr_L0+0, 0 
	ADDWF       FLOC__Mem_Read+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__Mem_Read+1, 1 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVFF       FLOC__Mem_Read+0, FSR1
	MOVFF       FLOC__Mem_Read+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2519 :: 		for(membr=0 ; membr<=4 ; membr++) {
	INCF        Mem_Read_membr_L0+0, 1 
;SE9M.c,2521 :: 		}
	GOTO        L_Mem_Read444
L_Mem_Read445:
;SE9M.c,2522 :: 		macAddr[5] = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _macAddr+5 
;SE9M.c,2523 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SE9M.c,2524 :: 		MSSPEN  = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2525 :: 		asm nop;
	NOP
;SE9M.c,2526 :: 		asm nop;
	NOP
;SE9M.c,2527 :: 		asm nop;
	NOP
;SE9M.c,2529 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,2530 :: 		}
L_end_Mem_Read:
	RETURN      0
; end of _Mem_Read

_main:

;SE9M.c,2535 :: 		void main() {
;SE9M.c,2537 :: 		TRISA = 0b00000001;
	MOVLW       1
	MOVWF       TRISA+0 
;SE9M.c,2538 :: 		PORTA = 0;
	CLRF        PORTA+0 
;SE9M.c,2539 :: 		TRISB = 0;
	CLRF        TRISB+0 
;SE9M.c,2540 :: 		PORTB = 0;
	CLRF        PORTB+0 
;SE9M.c,2541 :: 		TRISC = 0;
	CLRF        TRISC+0 
;SE9M.c,2542 :: 		PORTC = 0;
	CLRF        PORTC+0 
;SE9M.c,2544 :: 		Com_En_Direction = 0;
	BCF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;SE9M.c,2545 :: 		Com_En = 0;
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
;SE9M.c,2547 :: 		Kom_En_1_Direction = 0;
	BCF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;SE9M.c,2548 :: 		Kom_En_1 = 1;
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
;SE9M.c,2550 :: 		Kom_En_2_Direction = 0;
	BCF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;SE9M.c,2551 :: 		Kom_En_2 = 0;
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
;SE9M.c,2553 :: 		Eth1_Link_Direction = 1;
	BSF         TRISB5_bit+0, BitPos(TRISB5_bit+0) 
;SE9M.c,2555 :: 		SPI_Ethernet_Rst_Direction = 0;
	BCF         TRISA5_bit+0, BitPos(TRISA5_bit+0) 
;SE9M.c,2556 :: 		SPI_Ethernet_Rst = 0;
	BCF         RA5_bit+0, BitPos(RA5_bit+0) 
;SE9M.c,2557 :: 		SPI_Ethernet_CS_Direction  = 0;
	BCF         TRISA4_bit+0, BitPos(TRISA4_bit+0) 
;SE9M.c,2558 :: 		SPI_Ethernet_CS  = 0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
;SE9M.c,2560 :: 		RSTPIN_Direction = 1;
	BSF         TRISD4_bit+0, BitPos(TRISD4_bit+0) 
;SE9M.c,2562 :: 		DISPEN_Direction = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;SE9M.c,2563 :: 		DISPEN = 0;
	BCF         RE2_bit+0, BitPos(RE2_bit+0) 
;SE9M.c,2565 :: 		MSSPEN_Direction = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;SE9M.c,2566 :: 		MSSPEN = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2568 :: 		SV_DATA_Direction = 0;
	BCF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;SE9M.c,2569 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,2570 :: 		SV_CLK_Direction = 0;
	BCF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;SE9M.c,2571 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,2572 :: 		STROBE_Direction = 0;
	BCF         TRISA3_bit+0, BitPos(TRISA3_bit+0) 
;SE9M.c,2573 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2575 :: 		BCKL_Direction = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;SE9M.c,2576 :: 		BCKL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SE9M.c,2578 :: 		ANSEL = 0;
	CLRF        ANSEL+0 
;SE9M.c,2579 :: 		ANSELH = 0;
	CLRF        ANSELH+0 
;SE9M.c,2581 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,2582 :: 		ADCON1 = 0b00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;SE9M.c,2584 :: 		max_light = 180;
	MOVLW       180
	MOVWF       _max_light+0 
;SE9M.c,2585 :: 		min_light = 30;
	MOVLW       30
	MOVWF       _min_light+0 
;SE9M.c,2587 :: 		PWM1_Init(2000);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;SE9M.c,2588 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;SE9M.c,2589 :: 		PWM1_Set_Duty(max_light);      // 90
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2592 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       3
	MOVWF       SPBRGH+0 
	MOVLW       64
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;SE9M.c,2593 :: 		PIE1.RCIE = 1;
	BSF         PIE1+0, 5 
;SE9M.c,2594 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;SE9M.c,2595 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;SE9M.c,2597 :: 		T0CON = 0b11000000 ;
	MOVLW       192
	MOVWF       T0CON+0 
;SE9M.c,2598 :: 		INTCON.TMR0IF = 0 ;
	BCF         INTCON+0, 2 
;SE9M.c,2599 :: 		INTCON.TMR0IE = 1 ;
	BSF         INTCON+0, 5 
;SE9M.c,2601 :: 		while(1) {
L_main447:
;SE9M.c,2603 :: 		pom_time_pom = EEPROM_Read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pom_time_pom+0 
;SE9M.c,2604 :: 		if ( (pom_time_pom != 0xAA) || (rst_fab == 1) ) {
	MOVF        R0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__main577
	MOVF        _rst_fab+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__main577
	GOTO        L_main451
L__main577:
;SE9M.c,2613 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,2614 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2615 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
;SE9M.c,2616 :: 		EEPROM_Write(104, mode);
	MOVLW       104
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2617 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2618 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2620 :: 		strcpy(sifra, "adminpme");
	MOVLW       _sifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr235_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr235_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2621 :: 		for (j=0;j<=8;j++) {
	CLRF        _j+0 
L_main452:
	MOVF        _j+0, 0 
	SUBLW       8
	BTFSS       STATUS+0, 0 
	GOTO        L_main453
;SE9M.c,2622 :: 		EEPROM_Write(j+20, sifra[j]);
	MOVLW       20
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _sifra+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2621 :: 		for (j=0;j<=8;j++) {
	INCF        _j+0, 1 
;SE9M.c,2623 :: 		}
	GOTO        L_main452
L_main453:
;SE9M.c,2625 :: 		strcpy(server1, "swisstime.ethz.ch");
	MOVLW       _server1+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr236_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr236_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2626 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main455:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main456
;SE9M.c,2627 :: 		EEPROM_Write(j+29, server1[j]);
	MOVLW       29
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _server1+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2626 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2628 :: 		}
	GOTO        L_main455
L_main456:
;SE9M.c,2629 :: 		strcpy(server2, "0.rs.pool.ntp.org");
	MOVLW       _server2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr237_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr237_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2630 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main458:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main459
;SE9M.c,2631 :: 		EEPROM_Write(j+56, server2[j]);
	MOVLW       56
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _server2+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2630 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2632 :: 		}
	GOTO        L_main458
L_main459:
;SE9M.c,2633 :: 		strcpy(server3, "pool.ntp.org");
	MOVLW       _server3+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr238_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr238_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2634 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main461:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main462
;SE9M.c,2635 :: 		EEPROM_Write(j+110, server3[j]);
	MOVLW       110
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _server3+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2634 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2636 :: 		}
	GOTO        L_main461
L_main462:
;SE9M.c,2638 :: 		ipAddr[0]    = 192;
	MOVLW       192
	MOVWF       _ipAddr+0 
;SE9M.c,2639 :: 		ipAddr[1]    = 168;
	MOVLW       168
	MOVWF       _ipAddr+1 
;SE9M.c,2640 :: 		ipAddr[2]    = 1;
	MOVLW       1
	MOVWF       _ipAddr+2 
;SE9M.c,2641 :: 		ipAddr[3]    = 99;
	MOVLW       99
	MOVWF       _ipAddr+3 
;SE9M.c,2642 :: 		gwIpAddr[0]  = 192;
	MOVLW       192
	MOVWF       _gwIpAddr+0 
;SE9M.c,2643 :: 		gwIpAddr[1]  = 168;
	MOVLW       168
	MOVWF       _gwIpAddr+1 
;SE9M.c,2644 :: 		gwIpAddr[2]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+2 
;SE9M.c,2645 :: 		gwIpAddr[3]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+3 
;SE9M.c,2646 :: 		ipMask[0]    = 255;
	MOVLW       255
	MOVWF       _ipMask+0 
;SE9M.c,2647 :: 		ipMask[1]    = 255;
	MOVLW       255
	MOVWF       _ipMask+1 
;SE9M.c,2648 :: 		ipMask[2]    = 255;
	MOVLW       255
	MOVWF       _ipMask+2 
;SE9M.c,2649 :: 		ipMask[3]    = 0;
	CLRF        _ipMask+3 
;SE9M.c,2650 :: 		dnsIpAddr[0] = 192;
	MOVLW       192
	MOVWF       _dnsIpAddr+0 
;SE9M.c,2651 :: 		dnsIpAddr[1] = 168;
	MOVLW       168
	MOVWF       _dnsIpAddr+1 
;SE9M.c,2652 :: 		dnsIpAddr[2] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+2 
;SE9M.c,2653 :: 		dnsIpAddr[3] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+3 
;SE9M.c,2655 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2656 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2657 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2658 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2659 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2660 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2661 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2662 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2663 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2664 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2665 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2666 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2667 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2668 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2669 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2670 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2672 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2673 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2674 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2675 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2677 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2678 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2679 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2680 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2682 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2683 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2684 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2685 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2687 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2688 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2689 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2690 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2692 :: 		rst_fab = 0;
	CLRF        _rst_fab+0 
;SE9M.c,2693 :: 		pom_time_pom = 0xAA;
	MOVLW       170
	MOVWF       _pom_time_pom+0 
;SE9M.c,2694 :: 		EEPROM_Write(0, pom_time_pom);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       170
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2695 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main464:
	DECFSZ      R13, 1, 1
	BRA         L_main464
	DECFSZ      R12, 1, 1
	BRA         L_main464
	DECFSZ      R11, 1, 1
	BRA         L_main464
;SE9M.c,2696 :: 		}
L_main451:
;SE9M.c,2698 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2700 :: 		sifra[0]    = EEPROM_Read(20);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+0 
;SE9M.c,2701 :: 		sifra[1]    = EEPROM_Read(21);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+1 
;SE9M.c,2702 :: 		sifra[2]    = EEPROM_Read(22);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+2 
;SE9M.c,2703 :: 		sifra[3]    = EEPROM_Read(23);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+3 
;SE9M.c,2704 :: 		sifra[4]    = EEPROM_Read(24);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+4 
;SE9M.c,2705 :: 		sifra[5]    = EEPROM_Read(25);
	MOVLW       25
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+5 
;SE9M.c,2706 :: 		sifra[6]    = EEPROM_Read(26);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+6 
;SE9M.c,2707 :: 		sifra[7]    = EEPROM_Read(27);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+7 
;SE9M.c,2708 :: 		sifra[8]    = EEPROM_Read(28);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+8 
;SE9M.c,2710 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main465:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main466
;SE9M.c,2711 :: 		server1[j] = EEPROM_Read(j+29);
	MOVLW       _server1+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FLOC__main+1 
	MOVF        _j+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVLW       29
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Read_address+1, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2710 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2712 :: 		}
	GOTO        L_main465
L_main466:
;SE9M.c,2713 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main468:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main469
;SE9M.c,2714 :: 		server2[j] = EEPROM_Read(j+56);
	MOVLW       _server2+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FLOC__main+1 
	MOVF        _j+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVLW       56
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Read_address+1, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2713 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2715 :: 		}
	GOTO        L_main468
L_main469:
;SE9M.c,2716 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main471:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main472
;SE9M.c,2717 :: 		server3[j] = EEPROM_Read(j+110);
	MOVLW       _server3+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FLOC__main+1 
	MOVF        _j+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVLW       110
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Read_address+1, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2716 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2718 :: 		}
	GOTO        L_main471
L_main472:
;SE9M.c,2720 :: 		ipAddr[0]    = EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+0 
;SE9M.c,2721 :: 		ipAddr[1]    = EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+1 
;SE9M.c,2722 :: 		ipAddr[2]    = EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+2 
;SE9M.c,2723 :: 		ipAddr[3]    = EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+3 
;SE9M.c,2724 :: 		gwIpAddr[0]  = EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+0 
;SE9M.c,2725 :: 		gwIpAddr[1]  = EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+1 
;SE9M.c,2726 :: 		gwIpAddr[2]  = EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+2 
;SE9M.c,2727 :: 		gwIpAddr[3]  = EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+3 
;SE9M.c,2728 :: 		ipMask[0]    = EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+0 
;SE9M.c,2729 :: 		ipMask[1]    = EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+1 
;SE9M.c,2730 :: 		ipMask[2]    = EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+2 
;SE9M.c,2731 :: 		ipMask[3]    = EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+3 
;SE9M.c,2732 :: 		dnsIpAddr[0] = EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+0 
;SE9M.c,2733 :: 		dnsIpAddr[1] = EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+1 
;SE9M.c,2734 :: 		dnsIpAddr[2] = EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+2 
;SE9M.c,2735 :: 		dnsIpAddr[3] = EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+3 
;SE9M.c,2736 :: 		if (prolaz == 1) {
	MOVF        _prolaz+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main474
;SE9M.c,2737 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2738 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2739 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2740 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2742 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2743 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2744 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2745 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2747 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2748 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2749 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2750 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2752 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2753 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2754 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2755 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2757 :: 		prolaz = 0;
	CLRF        _prolaz+0 
;SE9M.c,2758 :: 		Print_All();
	CALL        _Print_All+0, 0
;SE9M.c,2759 :: 		}
L_main474:
;SE9M.c,2761 :: 		conf.tz = EEPROM_Read(102);
	MOVLW       102
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,2762 :: 		conf.dhcpen = EEPROM_Read(103);
	MOVLW       103
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+0 
;SE9M.c,2763 :: 		mode = EEPROM_Read(104);
	MOVLW       104
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _mode+0 
;SE9M.c,2764 :: 		dhcp_flag = EEPROM_Read(105);
	MOVLW       105
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dhcp_flag+0 
;SE9M.c,2766 :: 		if ( (conf.dhcpen == 0) && (dhcp_flag == 1) ) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main477
	MOVF        _dhcp_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main477
L__main576:
;SE9M.c,2767 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,2768 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2769 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2770 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2771 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main478:
	DECFSZ      R13, 1, 1
	BRA         L_main478
	DECFSZ      R12, 1, 1
	BRA         L_main478
	DECFSZ      R11, 1, 1
	BRA         L_main478
;SE9M.c,2772 :: 		}
L_main477:
;SE9M.c,2774 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2778 :: 		if (reset_eth == 1) {
	MOVF        _reset_eth+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main479
;SE9M.c,2779 :: 		reset_eth = 0;
	CLRF        _reset_eth+0 
;SE9M.c,2780 :: 		prvi_timer = 1;
	MOVLW       1
	MOVWF       _prvi_timer+0 
;SE9M.c,2781 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,2782 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2783 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2784 :: 		}
L_main479:
;SE9M.c,2785 :: 		if ( (prvi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _prvi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main482
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main482
L__main575:
;SE9M.c,2786 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,2787 :: 		drugi_timer = 1;
	MOVLW       1
	MOVWF       _drugi_timer+0 
;SE9M.c,2788 :: 		SPI_Ethernet_Rst = 1;
	BSF         RA5_bit+0, BitPos(RA5_bit+0) 
;SE9M.c,2789 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2790 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2791 :: 		}
L_main482:
;SE9M.c,2792 :: 		if ( (drugi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _drugi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main485
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main485
L__main574:
;SE9M.c,2793 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,2794 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,2795 :: 		link_enable = 1;
	MOVLW       1
	MOVWF       _link_enable+0 
;SE9M.c,2796 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2797 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2798 :: 		}
L_main485:
;SE9M.c,2799 :: 		if ( (Eth1_Link == 0) && (link == 0) && (link_enable == 1) ) {
	BTFSC       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main488
	MOVF        _link+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main488
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main488
L__main573:
;SE9M.c,2800 :: 		link = 1;
	MOVLW       1
	MOVWF       _link+0 
;SE9M.c,2801 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2802 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2804 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,2805 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2806 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main489
;SE9M.c,2807 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,2808 :: 		ipAddr[0] = 0;
	CLRF        _ipAddr+0 
;SE9M.c,2809 :: 		ipAddr[1] = 0;
	CLRF        _ipAddr+1 
;SE9M.c,2810 :: 		ipAddr[2] = 0;
	CLRF        _ipAddr+2 
;SE9M.c,2811 :: 		ipAddr[3] = 0;
	CLRF        _ipAddr+3 
;SE9M.c,2813 :: 		dhcp_flag = 1;
	MOVLW       1
	MOVWF       _dhcp_flag+0 
;SE9M.c,2814 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2816 :: 		Spi_Ethernet_Init(macAddr, ipAddr, Spi_Ethernet_FULLDUPLEX) ;
	MOVLW       _macAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_mac+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_mac+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_SPI_Ethernet_Init_fullDuplex+0 
	CALL        _SPI_Ethernet_Init+0, 0
;SE9M.c,2818 :: 		while (SPI_Ethernet_initDHCP(5) == 0) ; // try to get one from DHCP until it works
L_main490:
	MOVLW       5
	MOVWF       FARG_SPI_Ethernet_initDHCP_tmax+0 
	CALL        _SPI_Ethernet_initDHCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main491
	GOTO        L_main490
L_main491:
;SE9M.c,2819 :: 		memcpy(ipAddr,    SPI_Ethernet_getIpAddress(),    4) ; // get assigned IP address
	CALL        _SPI_Ethernet_getIpAddress+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,2820 :: 		memcpy(ipMask,    SPI_Ethernet_getIpMask(),       4) ; // get assigned IP mask
	CALL        _SPI_Ethernet_getIpMask+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _ipMask+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,2821 :: 		memcpy(gwIpAddr,  SPI_Ethernet_getGwIpAddress(),  4) ; // get assigned gateway IP address
	CALL        _SPI_Ethernet_getGwIpAddress+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,2822 :: 		memcpy(dnsIpAddr, SPI_Ethernet_getDnsIpAddress(), 4) ; // get assigned dns IP address
	CALL        _SPI_Ethernet_getDnsIpAddress+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,2824 :: 		lease_tmr = 1;
	MOVLW       1
	MOVWF       _lease_tmr+0 
;SE9M.c,2825 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,2827 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2828 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2829 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2830 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2831 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2832 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2833 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2834 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2835 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2836 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2837 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2838 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2839 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2840 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2841 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2842 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2844 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2845 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2846 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2847 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2849 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2850 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2851 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2852 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2854 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2855 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2856 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2857 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2859 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2860 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2861 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2862 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2864 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2865 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2867 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main492:
	DECFSZ      R13, 1, 1
	BRA         L_main492
	DECFSZ      R12, 1, 1
	BRA         L_main492
	DECFSZ      R11, 1, 1
	BRA         L_main492
;SE9M.c,2868 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2869 :: 		}
L_main489:
;SE9M.c,2870 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main493
;SE9M.c,2871 :: 		lease_tmr = 0;
	CLRF        _lease_tmr+0 
;SE9M.c,2872 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,2873 :: 		Spi_Ethernet_Init(macAddr, ipAddr, Spi_Ethernet_FULLDUPLEX) ;
	MOVLW       _macAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_mac+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_mac+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_SPI_Ethernet_Init_fullDuplex+0 
	CALL        _SPI_Ethernet_Init+0, 0
;SE9M.c,2874 :: 		SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr) ;
	MOVLW       _ipMask+0
	MOVWF       FARG_SPI_Ethernet_confNetwork_ipMask+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_SPI_Ethernet_confNetwork_ipMask+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_SPI_Ethernet_confNetwork_gwIpAddr+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_SPI_Ethernet_confNetwork_gwIpAddr+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_SPI_Ethernet_confNetwork_dnsIpAddr+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_SPI_Ethernet_confNetwork_dnsIpAddr+1 
	CALL        _SPI_Ethernet_confNetwork+0, 0
;SE9M.c,2875 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2876 :: 		}
L_main493:
;SE9M.c,2877 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2878 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2880 :: 		}
L_main488:
;SE9M.c,2884 :: 		if (Eth1_Link == 1) {
	BTFSS       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main494
;SE9M.c,2886 :: 		link = 0;
	CLRF        _link+0 
;SE9M.c,2887 :: 		lastSync = 0;
	CLRF        _lastSync+0 
	CLRF        _lastSync+1 
	CLRF        _lastSync+2 
	CLRF        _lastSync+3 
;SE9M.c,2888 :: 		}
L_main494:
;SE9M.c,2890 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2895 :: 		if (req_tmr_3 == 12) {
	MOVF        _req_tmr_3+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_main495
;SE9M.c,2896 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,2897 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,2898 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,2899 :: 		req_tmr_3 = 0;
	CLRF        _req_tmr_3+0 
;SE9M.c,2900 :: 		}
L_main495:
;SE9M.c,2903 :: 		if (RSTPIN == 0) {
	BTFSC       RD4_bit+0, BitPos(RD4_bit+0) 
	GOTO        L_main496
;SE9M.c,2904 :: 		rst_fab_tmr = 1;
	MOVLW       1
	MOVWF       _rst_fab_tmr+0 
;SE9M.c,2905 :: 		} else {
	GOTO        L_main497
L_main496:
;SE9M.c,2906 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2907 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2908 :: 		}
L_main497:
;SE9M.c,2909 :: 		if (rst_fab_flag >= 5) {
	MOVLW       5
	SUBWF       _rst_fab_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main498
;SE9M.c,2910 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2911 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2912 :: 		rst_fab = 1;
	MOVLW       1
	MOVWF       _rst_fab+0 
;SE9M.c,2913 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,2914 :: 		}
L_main498:
;SE9M.c,2916 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2932 :: 		if (komgotovo == 1) {
	MOVF        _komgotovo+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main499
;SE9M.c,2933 :: 		komgotovo = 0;
	CLRF        _komgotovo+0 
;SE9M.c,2934 :: 		chksum = (comand[3] ^ comand[4] ^ comand[5] ^ comand[6] ^ comand[7] ^comand[8] ^ comand[9] ^ comand[10] ^ comand[11]) & 0x7F;
	MOVF        _comand+4, 0 
	XORWF       _comand+3, 0 
	MOVWF       _chksum+0 
	MOVF        _comand+5, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+6, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+7, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+8, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+9, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+10, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+11, 0 
	XORWF       _chksum+0, 1 
	MOVLW       127
	ANDWF       _chksum+0, 1 
;SE9M.c,2935 :: 		if ((comand[0] == 0xAA) && (comand[1] == 0xAA) && (comand[2] == 0xAA) && (comand[12] == chksum) && (comand[13] == 0xBB) && (link_enable == 1)) {
	MOVF        _comand+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _comand+1, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _comand+2, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _comand+12, 0 
	XORWF       _chksum+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _comand+13, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
L__main572:
;SE9M.c,2936 :: 		sati = comand[3];
	MOVF        _comand+3, 0 
	MOVWF       _sati+0 
;SE9M.c,2937 :: 		minuti = comand[4];
	MOVF        _comand+4, 0 
	MOVWF       _minuti+0 
;SE9M.c,2938 :: 		sekundi = comand[5];
	MOVF        _comand+5, 0 
	MOVWF       _sekundi+0 
;SE9M.c,2939 :: 		dan = comand[6];
	MOVF        _comand+6, 0 
	MOVWF       _dan+0 
;SE9M.c,2940 :: 		mesec = comand[7];
	MOVF        _comand+7, 0 
	MOVWF       _mesec+0 
;SE9M.c,2941 :: 		fingodina = comand[8];
	MOVF        _comand+8, 0 
	MOVWF       _fingodina+0 
;SE9M.c,2942 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2943 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,2944 :: 		}
L_main502:
;SE9M.c,2945 :: 		}
L_main499:
;SE9M.c,2947 :: 		if (pom_mat_sek != sekundi) {
	MOVF        _pom_mat_sek+0, 0 
	XORWF       _sekundi+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main503
;SE9M.c,2948 :: 		pom_mat_sek = sekundi;
	MOVF        _sekundi+0, 0 
	MOVWF       _pom_mat_sek+0 
;SE9M.c,2949 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2956 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main504
;SE9M.c,2957 :: 		tacka2 = 0;
	CLRF        _tacka2+0 
;SE9M.c,2958 :: 		if (tacka1 == 0) {
	MOVF        _tacka1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main505
;SE9M.c,2959 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2960 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2961 :: 		}
L_main505:
;SE9M.c,2962 :: 		if (tacka1 == 1) {
	MOVF        _tacka1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main506
;SE9M.c,2963 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2964 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2965 :: 		}
L_main506:
;SE9M.c,2966 :: 		DALJE2:
___main_DALJE2:
;SE9M.c,2967 :: 		bljump = 0;
	CLRF        _bljump+0 
;SE9M.c,2968 :: 		}
L_main504:
;SE9M.c,2969 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main507
;SE9M.c,2970 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2971 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2972 :: 		}
L_main507:
;SE9M.c,2973 :: 		if (notime_ovf == 1) {
	MOVF        _notime_ovf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main508
;SE9M.c,2974 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2975 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2976 :: 		}
L_main508:
;SE9M.c,2977 :: 		if (notime_ovf == 0) {
	MOVF        _notime_ovf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main509
;SE9M.c,2978 :: 		if ( (sekundi == 0) || (sekundi == 10) || (sekundi == 20) || (sekundi == 30) || (sekundi == 40) || (sekundi == 50) ) {
	MOVF        _sekundi+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       30
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	GOTO        L_main512
L__main571:
;SE9M.c,2979 :: 		Print_Light();
	CALL        _Print_Light+0, 0
;SE9M.c,2980 :: 		}
L_main512:
;SE9M.c,2981 :: 		} else {
	GOTO        L_main513
L_main509:
;SE9M.c,2982 :: 		PWM1_Set_Duty(min_light);
	MOVF        _min_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2983 :: 		}
L_main513:
;SE9M.c,2984 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,2985 :: 		}
L_main503:
;SE9M.c,2987 :: 		Time_epochToDate(epoch + tmzn * 3600l, &ts) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       0
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	ADDWF       _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVF        R2, 0 
	ADDWFC      _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVF        R3, 0 
	ADDWFC      _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ts+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2988 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2989 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2990 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main514
;SE9M.c,2991 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2992 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2993 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,2994 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,2995 :: 		}
L_main514:
;SE9M.c,2998 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2999 :: 		}
	GOTO        L_main447
;SE9M.c,3000 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
