/*******************************************************************************
PROTOTYPE       : unsigned char Net_Ethernet_Intern_readPacket()
PARAMETERS      : none
RETURNS         : nothing
DESCRIPTION     : process next packet available in ENC RAM buffer
REQUIRES        : Net_Ethernet_Intern_init must have been called before
                  ERDPT must be correctly set either by Net_Ethernet_Intern_init, or previous call to readPacket()
EXAMPLE         : Net_Ethernet_Intern_readPacket()
*******************************************************************************/
unsigned char    Net_Ethernet_Intern_readPacket();


/*******************************************************************************
PROTOTYPE       : void    Net_Ethernet_Intern_doTCP(unsigned int start, unsigned int ipHeaderLen, unsigned int payloadAddr)
PARAMETERS      :
        start           : address of incoming packet in ENC receive buffer
        idHeaderLen     : size of IP header
        payLoadAddr     : address of payload in ENC transmit buffer
RETURNS         : nothing
DESCRIPTION     : handles an unframented, single-packet TCP/IP request
REQUIRES        : this function must be called only from Net_Ethernet_Intern_readPacket()
EXAMPLE         :
*******************************************************************************/
char    Net_Ethernet_Intern_doTCP(unsigned int start, unsigned int ipHeaderLen, unsigned int payloadAddr);


/*******************************************************************************
PROTOTYPE       : void Net_Ethernet_Intern_doUDP(unsigned int start, unsigned char ipHeaderLen, unsigned int payloadAddr)
PARAMETERS      :
        start           : address of incoming packet in ENC receive buffer
        idHeaderLen     : size of IP header
        payLoadAddr     : address of payload in ENC transmit buffer
RETURNS         : nothing
DESCRIPTION     : reply to an UDP/IP request
REQUIRES        : this function must be called only from Net_Ethernet_Intern_readPacket()
EXAMPLE         :
*******************************************************************************/
void Net_Ethernet_Intern_doUDP(unsigned int start, unsigned char ipHeaderLen, unsigned int payloadAddr);
unsigned int Net_Ethernet_Intern_flushUDP(unsigned char *destMAC, unsigned char *destIP, unsigned int sourcePort, unsigned int destPort, unsigned int pktLen);

/*******************************************************************************
PROTOTYPE       : void Net_Ethernet_Intern_doDHCP()
PARAMETERS      : none
RETURNS         : nothing
DESCRIPTION     : services dhcp
REQUIRES        : this function must be called only from Net_Ethernet_Intern_readPacket()
EXAMPLE         :
*******************************************************************************/
void Net_Ethernet_Intern_doDHCP();
unsigned char Net_Ethernet_Intern_DHCPReceive(void);
unsigned char Net_Ethernet_Intern_DHCPmsg(unsigned char  messageType, unsigned char renewFlag);


/*******************************************************************************
PROTOTYPE       : void Net_Ethernet_Intern_doDNS()
PARAMETERS      : none
RETURNS         : nothing
DESCRIPTION     : services DNS
REQUIRES        : this function must be called only from Net_Ethernet_Intern_readPacket()
EXAMPLE         :
*******************************************************************************/
void Net_Ethernet_Intern_doDNS();

/*******************************************************************************
PROTOTYPE       : void Net_Ethernet_Intern_doARP()
PARAMETERS      : none
RETURNS         : nothing
DESCRIPTION     : services ARP
REQUIRES        : this function must be called only from Net_Ethernet_Intern_readPacket()
EXAMPLE         :
*******************************************************************************/
void Net_Ethernet_Intern_doARP();

/*******************************************************************************
PROTOTYPE       : Net_Ethernet_Intern_checksum(unsigned int start, unsigned int l)
PARAMETERS      :
        start           address of first byte in ENC memory
        l               number of bytes to include in checksum calculation
RETURNS         : nothing (result is in ENC EDMACS[H:L] registers)
DESCRIPTION     : ENC performs DMA checksum of l bytes starting from start addr
REQUIRES        : Net_Ethernet_Intern_init must have been called
EXAMPLE         : Net_Ethernet_Intern_checksum(0x1000, 60)
*******************************************************************************/
void    Net_Ethernet_Intern_checksum(unsigned int start, unsigned int l);


/*******************************************************************************
PROTOTYPE       : Net_Ethernet_Intern_RAMcopy(unsigned int start, unsigned int stop, unsigned int dest, unsigned char w)
PARAMETERS      :
        start           address of first source byte (included) in ENC memory to copy
        stop            address of last source byte (not included) in ENC memory to copy
        dest            address of first destination byte in ENC memroy
        v               mode : 0 = no wrap (copy from transmit buffer), 1 = wrap (copy from receive buffer)
RETURNS         : nothing
DESCRIPTION     : ENC performs DMA memory copy from start to dest.
                  if wrap is allowed, performs correct operation to avoid ENC hang on circular buffer
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_RAMcopy(0x500, 0x600, 0x1400, 1)
*******************************************************************************/
void    Net_Ethernet_Intern_RAMcopy(unsigned int start, unsigned int stop, unsigned int dest, unsigned char w);



/*******************************************************************************
PROTOTYPE       : Net_Ethernet_Intern_MACswap()
PARAMETERS      : none
RETURNS         : nothing
DESCRIPTION     : swap MAC addresses in ETH transmit buffer
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_MACswap()
*******************************************************************************/
void    Net_Ethernet_Intern_MACswap();


/*******************************************************************************
PROTOTYPE       : Net_Ethernet_Intern_IPswap()
PARAMETERS      : none
RETURNS         : nothing
DESCRIPTION     : swap IP addresses in IP transmit buffer
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_IPswap()
*******************************************************************************/
void    Net_Ethernet_Intern_IPswap(void);


/*******************************************************************************
PROTOTYPE       : Net_Ethernet_Intern_TXpacket(unsigned int l)
PARAMETERS      : length in bytes of packet to transmit
RETURNS         : 0 on error, 1 otherwise
DESCRIPTION     : send packet over wires
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_txPacket(60)
*******************************************************************************/
unsigned char Net_Ethernet_Intern_TXpacket(unsigned int l);


/*******************************************************************************
PROTOTYPE       : unsigned char   Net_Ethernet_Intern_memcmp(unsigned int addr, unsigned char *s, unsigned char l)
PARAMETERS      :
        addr    : address of first byte in ENC RAM to compare
        s       : pointer to first byte of PIC RAM to compare
        l       : length in bytes of memory to compare
RETURNS         : 0 if compare matches, > 0 otherwise
DESCRIPTION     : compares ENC RAM to PIC RAM
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_memcmp(0x0600, "TEST", 4)
*******************************************************************************/
unsigned char   Net_Ethernet_Intern_memcmp(unsigned int addr, unsigned char *s, unsigned char l);


/*******************************************************************************
PROTOTYPE       : void Net_Ethernet_Intern_memcpy(unsigned int addr, unsigned char *s, unsigned int l)
PARAMETERS      :
        addr    : destination address of first byte in ENC RAM
        s       : pointer to first byte of PIC RAM to copy to ENC
        l       : length in bytes of memory to copy
RETURNS         : nothing
DESCRIPTION     : copy PIC memory to ENC RAM.
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_memcpy(0x0600, "TEST", 4)
*******************************************************************************/
void Net_Ethernet_Intern_memcpy(unsigned int addr, unsigned char *s, unsigned int l);


/*******************************************************************************
PROTOTYPE       : void Net_Ethernet_Intern_writeMemory(unsigned int addr, unsigned char v1, unsigned char v2, unsigned char bis)
PARAMETERS      :
        addr    : destination address of first byte in ENC RAM
        v1      : value to store @ addr
        v2      : value to store @ addr + 1 if bis is set
        bis     : if 0, store only v1, otherwise store also v2
RETURNS         : nothing
DESCRIPTION     : store one or two chars to ENC RAM
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_writeMemory(0x100, 12, 0, 0)
*******************************************************************************/
void Net_Ethernet_Intern_writeMemory(unsigned int addr, unsigned char v1, unsigned char v2);


/*******************************************************************************
PROTOTYPE       : void Net_Ethernet_Intern_writeMemory2(unsigned int v)
PARAMETERS      :
        v       : two byte value to be stored @ enc memory locations pointed to by
                  current/current+1 write pointer (WRPTL). High byte is written
                  to lower address (high byte first).
RETURNS         : nothing
DESCRIPTION     : store two chars to ENC RAM
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_writeMemory2(0x100)
*******************************************************************************/
void Net_Ethernet_Intern_writeMemory2(unsigned int v);


/*******************************************************************************
PROTOTYPE       : void Net_Ethernet_Intern_writeMem(unsigned int addr, unsigned char v1);
PARAMETERS      :
        addr    : destination address in ENC RAM
        v1      : value to store @ addr
RETURNS         : nothing
DESCRIPTION     : store one char to ENC RAM
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_writeMem(0x100, 12)
*******************************************************************************/
void Net_Ethernet_Intern_writeMem(unsigned int addr, unsigned char v1);


/*******************************************************************************
PROTOTYPE       : unsigned char   Net_Ethernet_Intern_readMem(unsigned int addr)
PARAMETERS      :
        addr    : address of first byte to read
RETURNS         : value of byte @ addr
DESCRIPTION     : read one byte from ENC RAM
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : b = Net_Ethernet_Intern_readMem(0x0250);
*******************************************************************************/
unsigned char   Net_Ethernet_Intern_readMem(unsigned int addr);


void    Net_Ethernet_Intern_writeAddr2(unsigned char *addr, unsigned int v);
unsigned char Net_Ethernet_Intern_readReg2(unsigned char *addr);


/*******************************************************************************
PROTOTYPE       : void Net_Ethernet_Intern_setRxReadAddress(unsigned addr)
PARAMETERS      :
        addr    : absolute address (not taking care of wrapping) in enc receive buffer
RETURNS         : nothing
DESCRIPTION     : adjusts given enc buffer address taking care of receive buffer wrapping and
                  writes it into rx buffer read pointer (ERDPT)
REQUIRES        : Net_Ethernet_Intern_init must have been called before
                  bank selection is supposed to be already made
EXAMPLE         : Net_Ethernet_Intern_setRxReadAddress(0x1000);
*******************************************************************************/
void Net_Ethernet_Intern_setRxReadAddress(unsigned addr);


/*******************************************************************************
PROTOTYPE       : void    Net_Ethernet_Intern_writePHY(unsigned char reg, unsigned short h, unsigned short l)
PARAMETERS      :
        reg     : address of ENC PHY
        h       : high byte to write to register
        l       : low byte to write to register
RETURNS         : nothing
DESCRIPTION     : writes high and low bytes to PHY register
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_writePHY(3, 0, 0)
*******************************************************************************/
void    Net_Ethernet_Intern_writePHY(unsigned char reg, unsigned short h, unsigned short l);


/*******************************************************************************
PROTOTYPE       : void    Net_Ethernet_Intern_readPHY(unsigned char reg, unsigned char *h, unsigned char *l)
PARAMETERS      :
        reg     : address of ENC PHY
        h       : pointer to high byte storage location
        l       : pointer to low byte storage location
RETURNS         : nothing
DESCRIPTION     : reads high and low bytes from PHY register
REQUIRES        : Net_Ethernet_Intern_init must have been called before
EXAMPLE         : Net_Ethernet_Intern_readPHY(3, &h, &l);
*******************************************************************************/
void    Net_Ethernet_Intern_readPHY(unsigned char reg, unsigned char *h, unsigned char *l);


/*******************************************************************************
PROTOTYPE       : void    Net_Ethernet_Intern_delay()
PARAMETERS      : None
RETURNS         : nothing
DESCRIPTION     : 200ms delay; used here for accessing enc PHY level registers
                               while initializing enc module
REQUIRES        : nothing
EXAMPLE         : Net_Ethernet_Intern_delay();
*******************************************************************************/
void    Net_Ethernet_Intern_delay();

/*******************************************************************************
PROTOTYPE       : Net_Ethernet_Intern_Init2(unsigned char fullDuplex)
PARAMETERS      :
    fullDuplex  : full/half duplex switch
RETURNS         : nothing
DESCRIPTION     : this is part of Net_Ethernet_Intern_Init routine. For better linkage
                  due to pic16 flash paging, initialization routine was splited
                  into two smaller routines. This routine handles initialization
                  phases 2-10 as described in enc datasheet.
REQUIRES        : nothing
EXAMPLE         : Net_Ethernet_Intern_delay();
*******************************************************************************/
void    Net_Ethernet_Intern_Init2(unsigned char fullDuplex);
void Net_Ethernet_Intern_socketInitTCP(char id);
void Net_Ethernet_Intern_timerTCP();

extern  unsigned int    Net_Ethernet_Intern_pktLen;               // size of last packet received (CRC non included)

extern char Net_Ethernet_Intern_bufferTCP(char c, char tx, char curr_sock);
extern char Net_Ethernet_Intern_txTCP (char flag, char curr_sock);
