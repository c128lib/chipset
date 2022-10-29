/*
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 */
#importonce
.filenamespace c128lib

// KERNAL
.label KERNAL_RESET = $e000 //	Reset Code

// .label = $e04b //MMU Set Up Bytes		DATA
.label KERNAL_RESTOR = $e056 // -restor-
.label KERNAL_VECTOR = $e05b	//-vector-
// .label = $e073	Vectors to $0314		WORD
.label KERNAL_RAMTAS = $e093 //-ramtas-
// .label = $e0cd	Move Code For High RAM Banks
// .label = $e105	RAM Bank Masks			DATA
.label KERNAL_IOINIT = $e109 //-init-
// .label = $e1dc	Set Up CRTC Registers
// .label = $e1f0	Check Special Reset
// .label = $e242	Reset to 64/128
.label KERNAL_C64_MODE = $e24b  // Switch to 64 Mode
// .label = $e263	Code to $02
// .label = $e26b	Scan All ROMs
// .label = $e2bc	ROM Addresses High		DATA
// .label = $e2c0	ROM Banks			DATA
// .label = $e2c4	Print 'cbm' Mask		DATA
// .label = $e2c7	VIC 8564 Set Up			DATA
// .label = $e2f8	CRTC 8563 Set Up Pairs		DATA
.label KERNAL_TALK = $e33b //-talk-
.label KERNAL_LISTEN = $e33e //-listen-
.label KERNAL_ACPTR = $e43e	//-acptr-
.label KERNAL_SECOND = $e4d2	//-second-
.label KERNAL_TKSA = $e4e0	//-tksa-
.label KERNAL_CIOUT = $e503	//-ciout-  Print Serial
.label KERNAL_UNTLK = $e515	//-untlk-
.label KERNAL_UNLSN = $e526	//-unlsn-
// .label = $e535	Reset ATN
// .label = $e545	Set Clock High
// .label = $e54e	Set Clock Low
// .label = $e557	Set Data High
// .label = $e560	Set Data Low
// .label = $e569	Read Serial Lines
// .label = $e573	Stabilize Timing
// .label = $e59f	Restore Timing
// .label = $e5bc	Prepare For Response
.label KERNAL_SPIN = $e5c3	//Fast Disk Off
.label KERNAL_SPOUT = $e5d6	//Fast Disk On
.label KERNAL_SPIN_SPOUT = $e5fb	//Fast Disk On/Off
// .label = $e5ff	(NMI) Transmit RS-232
// .label = $e64a	RS-232 Handshake
// .label = $e68e	Set RS-232 Bit Count
// .label = $e69d	(NMI) RS-232 Receive
// .label = $e75f	Send To RS-232
// .label = $e795	Connect RS-232 Input
// .label = $e7ce	Get From RS-232
// .label = $e7ec	Interlock RS-232/Serial
// .label = $e805	(NMI) RS-232 Control I/O
// .label = $e850	RS-232 Timings For NTSC		DATA
// .label = $e878	(NMI) RS-232 Receive Timing
// .label = $e8a9	(NMI) RS-232 Transmit Timing
// .label = $e8d0	Find Any Tape Header
// .label = $e919	Write Tape Header
// .label = $e980	Get Buffer Address
// .label = $e987	Get Tape Buffer Start & End Addrs
// .label = $e99a	Find Specific Header
// .label = $e9be	Bump Tape Pointer
// .label = $e9c8	Print 'press play on tape'
// .label = $e9df	Check Tape Status
// .label = $e9e9	Print 'press record ...'
// .label = $e9f2	Initiate Tape Read
// .label = $ea15	Initiate Tape Write
// .label = $ea26	Common Tape Code
// .label = $ea7d	Wait For Tape
// .label = $ea8f	Check Tape Stop
// .label = $eaa1	Set Read Timing
// .label = $eaeb	(IRQ) Read Tape Bits
// .label = $ec1f	Store Tape Chars
// .label = $ed51	Reset Pointer
// .label = $ed5a	New Char Set Up
// .label = $ed69	Write Transition to Tape
// .label = $ed8b	Write Data to Tape
// .label = $ed90	(IRQ) Tape Write
// .label = $ee2e	(IRQ) Tape Leader
// .label = $ee57	Wind Up Tape I/O
// .label = $ee9b	Switch IRQ Vector
// .label = $eea8	IRQ Vectors			WORD
// .label = $eeb0	Kill Tape Motor
// .label = $eeb7	Check End Address
// .label = $eec1	Bump Address
// .label = $eec8	(IRQ) Clear Break
// .label = $eed0	Control Tape Motor
.label KERNAL_GETIN = $eeeb	//-getin-
.label KERNAL_BASIN = $ef06	//-chrin-
// .label = $ef48	Get Char From Tape
.label KERNAL_BSOUT = $ef79	//-chrout-
.label KERNAL_OPEN = $efbd	//-open-
// .label = $f0b0	Set CIA to RS-232
// .label = $f0cb	Check Serial Open
.label KERNAL_CHKIN = $f106	//-chkin-
.label KERNAL_CKOUT = $f14c	//-chkout-
.label KERNAL_CLOSE = $f188	//-close-
// .label = $f1e4	Delete File
// .label = $f202	Search For File
// .label = $f212	Set File Parameters
.label KERNAL_CLALL = $f222	//-clall-
.label KERNAL_CLRCH = $f226	//-clrchn-
.label KERNAL_CLOSE_ALL = $f23d	//Clear I/O Path
.label KERNAL_LOAD = $f265	//-load-
// .label = $f27b	Serial Load
// .label = $f32a	Tape Load
// .label = $f3a1	Disk Load
// .label = $f3ea	Burst Load
// .label = $f48c	Close Off Serial
// .label = $f4ba	Get Serial Byte
// .label = $f4c5	Receive Serial Byte
// .label = $f503	Toggle Clock Line
// .label = $f50c	Print 'u0' Disk Reset		DATA
// .label = $f50f	Print 'searching'
// .label = $f521	Send File Name
// .label = $f533	Print 'loading'
.label KERNAL_SAVE = $f53e	//-save-
// .label = $f5b5	Terminate Serial Input
// .label = $f5bc	Print 'saving'
// .label = $f5c8	Save to Tape
.label KERNAL_UDTIM = $f5f8	//-udtim-
// .label = $f63d	Watch For RUN or Shift
.label KERNAL_RDTIM = $f65e	//-rdtim-
.label KERNAL_SETTIM = $f665	//-settim-
.label KERNAL_STOP = $f66e	//-stop-
// .label = $f67c	Print 'too many files'
// .label = $f67f	Print 'file open'
// .label = $f682	Print 'file not open'
// .label = $f685	Print 'file not found'
// .label = $f688	Print 'device not present'
// .label = $f68b	Print 'not input file'
// .label = $f68e	Print 'not output file'
// .label = $f691	Print 'missing file name'
// .label = $f694	Print 'illegal device no'
// .label = $f697	Error #0
// .label = $f6b0	Messages			DATA
// .label = $f71e	Print If Direct
// .label = $f722	Print I/O Message
.label KERNAL_SETNAM = $f731	//-setnam-
.label KERNAL_SETLFS = $f738	//-setlfs-
.label KERNAL_SETBNK = $f73f	//Set Load/Save Bank
.label KERNAL_READSS = $f744	//-rdst-
// .label = $f757	Set Status Bit
.label KERNAL_SETMSG = $f75c	//-setmsg-
.label KERNAL_SETTMO = $f75f	//Set Serial Timeout
.label KERNAL_MEMTOP = $f763	//-memtop-
.label KERNAL_MEMBOT = $f772	//-membot-
.label KERNAL_IOBASE = $f781	//-iobase-
.label KERNAL_LKUPSA = $f786	//Search For SA
.label KERNAL_LKUPLA = $f79d	//Search & Set Up File
.label KERNAL_DMA_CALL = $f7a5	//Trigger DMA
// .label = $f7ae	Get Char From Memory
// .label = $f7bc	Store Loaded Byte
// .label = $f7c9	Read Byte to be Saved
.label KERNAL_INDFET = $f7d0	//Get Char From Memory Bank
.label KERNAL_INDSTA = $f7da	//Store Char to Memory Bank
.label KERNAL_INDCMP = $f7e3	//Compare Char With Memory Bank
.label KERNAL_GETCFG = $f7ec	//Load Memory Control Mask
// .label = $f800	Subroutines to $02a2-$02fb
// .label = $f85a	DMA Code to $03f0
.label KERNAL_PHOENIX = $f867	//Check Auto Start ROM
.label KERNAL_BOOT_CALL = $f890	//Check For Boot Disk
// .label = $f908	Print 'booting'
// .label = $f92c	Print '...'
// .label = $f98b	Wind Up Disk Boot
// .label = $f9b3	Read Next Boot Block
// .label = $f9fb	To 2-Digit Decimal
// .label = $fa08	Block Read Command String	DATA
// .label = $fa15	Print '#i'
.label KERNAL_PRIMM = $fa17	//Print a Message
.label KERNAL_NMI = $fa40	//NMI Sequence
.label KERNAL_IRQ = $fa65	//(IRQ) Normal Entry
// .label = $fa80	Keyboard Matrix Un-Shifted	DATA
// .label = $fad9	Keyboard Matrix Shifted		DATA
// .label = $fb32	Keyboard Matrix C-Key		DATA
// .label = $fb8b	Keyboard Matrix Control		DATA
// .label = $fbe4	Keyboard Matrix Caps-Lock	DATA

// Patch for the C128 D
// fc62	Patch for Set Up CRTC Registers

//
// fc6f	Unused				EMPTY
// fd29	DIN Keyboard Matrix Un-Shifted	DATA
// fd81	DIN Keyboard Matrix Shifted	DATA
// fdd8	DIN Keyboard Matrix C-Key	DATA
// fe34	DIN Keyboard Matrix Control	DATA
// ;fe8?	DIN Keyboard Matrix Caps-Lock	DATA
// feff	Patch byte

// ff00	MMU Configuration Register	CHIP
// ff01	MMU LCR: Bank 0			CHIP
// ff02	MMU LCR: Bank 1			CHIP
// ff03	MMU LCR: Bank 14		CHIP
// ff04	MMU LCR: Bank 14 Over RAM 1	CHIP

.label KERNAL_JNMI = $FF05 //	NMI Transfer Entry
.label KERNAL_JIRQ = $FF17	//IRQ Transfer Entry
.label KERNAL_CRTI = $FF33	//Return From Interrupt
.label KERNAL_JRESET = $FF3D	//Reset Transfer Entry
.label KERNAL_JSPIN_SPOUT = $FF47	//Jumbo Jump Table

// C128 Kernal Jump Table

// ff47	jmp $e5fb	spinspout	(fast serial)
.label KERNAL_JCLOSE_ALL = $FF4A	//jmp $f23d	close all
.label KERNAL_JC64_MODE = $FF4D	//jmp $e24b	64mode
.label KERNAL_JDMA_CALL = $FF50 //jmp $f7a5	dma call
.label KERNAL_JBOOT_CALL = $FF53	//jmp $f890	boot call
.label KERNAL_JPHOENIX = $FF56	//jmp $f867	foenix
.label KERNAL_JLKUPLA = $FF59	//jmp $f79d	lkupla		(logical addr)
.label KERNAL_JLKUPSA = $FF5C //	jmp $f786	lkupsa		(second addr)
.label KERNAL_JSWAPPER = $FF5F	//jmp $c02a	swapper		40/80 swap
.label KERNAL_JDLCHR = $FF62	//jmp $c027	dlchr		Init 80col charam
.label KERNAL_JPFKEY = $FF65	//mp $c021	pfkey		Prog Function Key
.label KERNAL_JSETBKN = $FF68	//jmp $f73f	setbnk
.label KERNAL_JGETCFG = $FF6B	//jmp $f7ec	setcfg
.label KERNAL_JJSRFAR = $FF6E	//jmp $02cd	jsrfar
.label KERNAL_JJMPFAR = $FF71	//jmp $02e3	jmpfar
.label KERNAL_JINDFET = $FF74	//jmp $f7d0	indfet		Bank LDA (fetchvec),y
.label KERNAL_JINDSTA = $FF77	//jmp $f7da	indsta		Bank STA (stavec),y
.label KERNAL_JINDCMP = $FF7A	//jmp $f7e3	indcmp		Bank CMP (cmpvec),y
.label KERNAL_JPRIMM = $FF7D	//jmp $fa17	primm		Print Immediate
// ff80	[01]				Kernal Version Number		DATA
.label KERNAL_JCINT = $FF81	//jmp $c000	cint		Init Editor & Video Chips
.label KERNAL_JIOINIT = $FF84	//jmp $e109	ioinit		Init I/O Devices, Ports & Timers
.label KERNAL_JRAMTAS = $FF87 //	jmp $e093	ramtas		Init Ram & Buffers
.label KERNAL_JRESTOR = $ff8a	//jmp $e056	restor		Restore Vectors
.label KERNAL_JVECTOR = $ff8d	//jmp $e05b	vector		Change Vectors For User
.label KERNAL_JSETMSG = $ff90	//jmp $f75c	setmsg		Control OS Messages
.label KERNAL_JSECOND = $ff93	//jmp $e4d2	secnd		Send SA After Listen
.label KERNAL_JTKSA = $ff96	//jmp $e4e0	tksa		Send SA After Talk
.label KERNAL_JMEMTOP = $ff99	//jmp $f763	memtop		Set/Read System RAM Top
.label KERNAL_JMEMBOT = $ff9c	//jmp $f772	membot		Set/Read System RAM Bottom
.label KERNAL_JKEY = $ff9f	//jmp $c012	key		Scan Keyboard
.label KERNAL_JSETTMO = $ffa2	//jmp $f75f	settmo		Set Timeout In IEEE
.label KERNAL_JACPTR = $ffa5	//jmp $e43e	acptr		Handshake Serial Byte In
.label KERNAL_JCIOUT = $ffa8	//jmp $e503	ciout		Handshake Serial Byte Out
.label KERNAL_JUNTLK = $ffab	//jmp $e515	untlk		Command Serial Bus UNTALK
.label KERNAL_JUNLSN = $ffae	//jmp $e526	unlsn		Command Serial Bus UNLISTEN
.label KERNAL_JLISTN = $ffb1	//jmp $e33e	listn		Command Serial Bus LISTEK
.label KERNAL_JTALK = $ffb4	//jmp $e33b	talk		Command Serial Bus TALK
.label KERNAL_JREADSS = $ffb7	//jmp $f744	readss		Read I/O Status Word
.label KERNAL_JSETLFS = $ffba	//jmp $f738	setlfs		Set Logical File Parameters
.label KERNAL_JSETNAM = $ffbd	//jmp $f731	setnam		Set Filename
.label KERNAL_JOPEN = $ffc0	//jmp ($031a)	(iopen)		Open Vector [efbd]
.label KERNAL_JCLOSE = $ffc3	//jmp ($031c)	(iclose)	Close Vector [f188]
.label KERNAL_JCHKIN = $ffc6	//jmp ($031e)	(ichkin)	Set Input [f106]
.label KERNAL_JCKOUT = $ffc9	//jmp ($0320)	(ichkout)	Set Output [f14c]
.label KERNAL_JCLRCH = $ffcc	//jmp ($0322)	(iclrch)	Restore I/O Vector [f226]
.label KERNAL_JBASIN = $ffcf	//jmp ($0324)	(ibasin)	Input Vector, chrin [ef06]
.label KERNAL_JBSOUT = $ffd2	//jmp ($0326)	(ibsout)	Output Vector, chrout [ef79]
.label KERNAL_JLOAD = $ffd5	//jmp $f265	loadsp		Load RAM From Device
.label KERNAL_JSAVE = $ffd8	//jmp $f53e	savesp		Save RAM To Device
.label KERNAL_JSETTIM = $ffdb	//jmp $f665	settim		Set Real-Time Clock
.label KERNAL_JRDTIM = $ffde	//jmp $f65e	rdtim		Read Real-Time Clock
.label KERNAL_JSTOP = $ffe1	//jmp ($0328)	(istop)		Test-Stop Vector [f66e]
.label KERNAL_JGETIN = $ffe4	//jmp ($032a)	(igetin)	Get Vector [eeeb]
.label KERNAL_JCLALL = $ffe7	//jmp ($032c)	(iclall)	Close All Channels And Files [f222]
.label KERNAL_JUDTIM = $ffea	//jmp $f5f8	udtim		Increment Real-Time Clock
.label KERNAL_JSCRORG = $ffed	//jmp $c00f	scrorg		Return Screen Organization
.label KERNAL_JPLOT = $fff0	//jmp $c018	plot		Read / Set Cursor X/Y Position
.label KERNAL_JIOBASE = $fff3	//jmp $f781	iobase		Return I/O Base Address

// fff6	System Vectors
// fff6	[ffff]					WORD
// fff8	[e224]		SYSTEM			WORD

// fffa	Transfer Vectors
// fffa	[ff05]		NMI			WORD
// fffc	[ff3d]		RESET			WORD
// fffe	[ff17]		IRQ			WORD
