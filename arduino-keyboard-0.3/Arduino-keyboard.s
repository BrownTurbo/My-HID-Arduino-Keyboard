	.file	"Arduino-keyboard.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	.text.MediaQueue_Push,"ax",@progbits
	.type	MediaQueue_Push, @function
MediaQueue_Push:
.LFB94:
	.file 1 "Arduino-keyboard.c"
	.loc 1 254 0
	.cfi_startproc
.LVL0:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 255 0
	lds r18,MediaTail
	ldi r19,0
	subi r18,-1
	sbci r19,-1
	andi r18,15
	clr r19
.LVL1:
	.loc 1 256 0
	lds r20,MediaHead
	cp r20,r18
	breq .L3
	.loc 1 257 0
	lds r30,MediaTail
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(MediaQueue))
	sbci r31,hi8(-(MediaQueue))
	std Z+1,r25
	st Z,r24
	.loc 1 258 0
	sts MediaTail,r18
	.loc 1 259 0
	ldi r24,lo8(1)
.LVL2:
	ret
.LVL3:
.L3:
	.loc 1 256 0
	ldi r24,0
.LVL4:
/* epilogue start */
	.loc 1 260 0
	ret
	.cfi_endproc
.LFE94:
	.size	MediaQueue_Push, .-MediaQueue_Push
	.section	.text.ProcessIncomingSerialData,"ax",@progbits
.global	ProcessIncomingSerialData
	.type	ProcessIncomingSerialData, @function
ProcessIncomingSerialData:
.LFB97:
	.loc 1 282 0
	.cfi_startproc
	push r28
.LCFI0:
	.cfi_def_cfa_offset 3
	.cfi_offset 28, -2
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	.loc 1 284 0
	in r24,0x1e
.LBB43:
	.loc 1 301 0
	ldi r28,lo8(1)
.LBE43:
	.loc 1 284 0
	cpi r24,lo8(4)
	breq .L5
.L4:
/* epilogue start */
	.loc 1 334 0
	pop r28
	ret
.LVL5:
.L7:
.LBB56:
	.loc 1 298 0
	ldi r24,lo8(-1)
	add r24,r18
	cpi r24,lo8(2)
	brsh .L5
	.loc 1 299 0
	sts ActivePacketType,r18
	.loc 1 300 0
	sts PayloadByteIndex,__zero_reg__
	.loc 1 301 0
	sts CurrentParserState,r28
.LVL6:
.L5:
.LBE56:
.LBB57:
.LBB58:
.LBB59:
	.loc 1 272 0
	in r25,__SREG__
.LVL7:
.LBB60:
.LBB61:
	.file 2 "/usr/lib/avr/include/util/atomic.h"
	.loc 2 50 0
/* #APP */
 ;  50 "/usr/lib/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
.LVL8:
/* #NOAPP */
.LBE61:
.LBE60:
	.loc 1 273 0
	lds r24,parserCount
.LVL9:
.LBB62:
.LBB63:
	.loc 2 70 0
	out __SREG__,r25
	.loc 2 71 0
.LVL10:
.LBE63:
.LBE62:
.LBE59:
.LBE58:
.LBE57:
	.loc 1 286 0
	tst r24
	breq .L4
.LBB64:
.LBB44:
	.loc 1 290 0
	in r19,__SREG__
.LVL11:
.LBB45:
.LBB46:
	.loc 2 50 0
/* #APP */
 ;  50 "/usr/lib/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
.LVL12:
/* #NOAPP */
.LBE46:
.LBE45:
	.loc 1 291 0
	lds r30,parserTail
	ldi r31,0
	subi r30,lo8(-(parserBuffer))
	sbci r31,hi8(-(parserBuffer))
	ld r18,Z
.LVL13:
	.loc 1 292 0
	lds r24,parserTail
	ldi r25,0
	adiw r24,1
	andi r24,63
	clr r25
	sts parserTail,r24
	.loc 1 293 0
	lds r24,parserCount
	subi r24,lo8(-(-1))
	sts parserCount,r24
.LVL14:
.LBB47:
.LBB48:
	.loc 2 70 0
	out __SREG__,r19
	.loc 2 71 0
.LVL15:
.LBE48:
.LBE47:
.LBE44:
	.loc 1 296 0
	lds r24,CurrentParserState
	tst r24
	breq .L7
	cpi r24,lo8(1)
	breq .L8
	.loc 1 330 0
	sts CurrentParserState,__zero_reg__
	.loc 1 331 0
	rjmp .L5
.L8:
	.loc 1 307 0
	lds r30,PayloadByteIndex
	ldi r24,lo8(1)
	add r24,r30
	sts PayloadByteIndex,r24
	ldi r31,0
	subi r30,lo8(-(CurrentFrameContext))
	sbci r31,hi8(-(CurrentFrameContext))
	st Z,r18
	.loc 1 309 0
	cpi r24,lo8(8)
	brlo .L5
	.loc 1 310 0
	lds r24,ActivePacketType
	cpi r24,lo8(1)
	brne .L12
.LVL16:
.LBB49:
.LBB50:
	.loc 1 240 0
	lds r24,KeyboardTail
	ldi r25,0
	adiw r24,1
	andi r24,7
	clr r25
.LVL17:
	.loc 1 241 0
	lds r18,KeyboardHead
.LVL18:
	cp r18,r24
	breq .L13
	.loc 1 242 0
	lds r26,KeyboardTail
	ldi r27,0
	ldi r25,3
	1:
	lsl r26
	rol r27
	dec r25
	brne 1b
	subi r26,lo8(-(KeyboardQueue))
	sbci r27,hi8(-(KeyboardQueue))
	ldi r25,lo8(8)
	ldi r30,lo8(CurrentFrameContext)
	ldi r31,hi8(CurrentFrameContext)
.LVL19:
	0:
	ld r0,Z+
	st X+,r0
	dec r25
	brne 0b
	.loc 1 243 0
	sts KeyboardTail,r24
.LVL20:
.L13:
.LBE50:
.LBE49:
	.loc 1 323 0
	sts CurrentParserState,__zero_reg__
	.loc 1 324 0
	sts ActivePacketType,__zero_reg__
	.loc 1 325 0
	sts PayloadByteIndex,__zero_reg__
	rjmp .L5
.LVL21:
.L12:
	.loc 1 313 0
	cpi r24,lo8(2)
	brne .L13
.LBB51:
	.loc 1 315 0
	lds r30,CurrentFrameContext
.LVL22:
.LBB52:
.LBB53:
	.loc 1 215 0
	ldi r24,lo8(23)
	add r24,r30
	.loc 1 220 0
	cpi r24,lo8(2)
	brlo .L21
	.loc 1 216 0
	cpi r30,lo8(-30)
	breq .L21
	.loc 1 220 0
	ldi r24,lo8(1)
	.loc 1 217 0
	cpi r30,lo8(-51)
	breq .L14
	.loc 1 218 0
	ldi r25,lo8(75)
	add r25,r30
	cpi r25,lo8(3)
	brlo .L14
	ldi r24,0
.L14:
.LVL23:
.LBE53:
.LBE52:
	.loc 1 316 0
	sbrs r24,0
	rjmp .L16
.LVL24:
	subi r30,lo8(-(75))
.LVL25:
	cpi r30,lo8(54)
	brsh .L27
	ldi r31,0
	subi r30,lo8(-(CSWTCH.44))
	sbci r31,hi8(-(CSWTCH.44))
	ld r24,Z
	ldi r25,0
.LVL26:
.L26:
	.loc 1 319 0
	call MediaQueue_Push
.LVL27:
	rjmp .L13
.LVL28:
.L21:
.LBB55:
.LBB54:
	.loc 1 220 0
	ldi r24,lo8(1)
	rjmp .L14
.LVL29:
.L16:
.LBE54:
.LBE55:
	.loc 1 318 0
	cpse r30,__zero_reg__
	rjmp .L13
.LVL30:
.L27:
	.loc 1 319 0
	ldi r25,0
	ldi r24,0
	rjmp .L26
.LBE51:
.LBE64:
	.cfi_endproc
.LFE97:
	.size	ProcessIncomingSerialData, .-ProcessIncomingSerialData
	.section	.text.SetupHardware,"ax",@progbits
.global	SetupHardware
	.type	SetupHardware, @function
SetupHardware:
.LFB99:
	.loc 1 355 0
	.cfi_startproc
	push r10
.LCFI1:
	.cfi_def_cfa_offset 3
	.cfi_offset 10, -2
	push r11
.LCFI2:
	.cfi_def_cfa_offset 4
	.cfi_offset 11, -3
	push r13
.LCFI3:
	.cfi_def_cfa_offset 5
	.cfi_offset 13, -4
	push r14
.LCFI4:
	.cfi_def_cfa_offset 6
	.cfi_offset 14, -5
	push r15
.LCFI5:
	.cfi_def_cfa_offset 7
	.cfi_offset 15, -6
	push r16
.LCFI6:
	.cfi_def_cfa_offset 8
	.cfi_offset 16, -7
	push r17
.LCFI7:
	.cfi_def_cfa_offset 9
	.cfi_offset 17, -8
	push r28
.LCFI8:
	.cfi_def_cfa_offset 10
	.cfi_offset 28, -9
	push r29
.LCFI9:
	.cfi_def_cfa_offset 11
	.cfi_offset 29, -10
/* prologue: function */
/* frame size = 0 */
/* stack size = 9 */
.L__stack_usage = 9
	.loc 1 357 0
	in r24,0x34
	andi r24,lo8(-9)
	out 0x34,r24
.LBB69:
.LBB70:
	.file 3 "/usr/lib/avr/include/avr/wdt.h"
	.loc 3 515 0
/* #APP */
 ;  515 "/usr/lib/avr/include/avr/wdt.h" 1
	in __tmp_reg__,__SREG__
	cli
	wdr
	lds r24,96
	ori r24,24
	sts 96,r24
	sts 96,__zero_reg__
	out __SREG__,__tmp_reg__
	
 ;  0 "" 2
.LVL31:
/* #NOAPP */
.LBE70:
.LBE69:
.LBB71:
.LBB72:
	.file 4 "./LUFA/Drivers/Peripheral/Serial.h"
	.loc 4 102 0
	ldi r24,lo8(-52)
	mov r10,r24
	mov r11,__zero_reg__
	ldi r24,lo8(103)
	ldi r25,0
	movw r30,r10
	std Z+1,r25
	st Z,r24
	.loc 4 104 0
	ldi r25,lo8(-54)
	mov r14,r25
	mov r15,__zero_reg__
	ldi r18,lo8(6)
	mov r13,r18
	movw r30,r14
	st Z,r13
	.loc 4 105 0
	ldi r16,lo8(-56)
	ldi r17,0
	movw r30,r16
	st Z,__zero_reg__
	.loc 4 106 0
	ldi r28,lo8(-55)
	ldi r29,0
	ldi r24,lo8(24)
	st Y,r24
	.loc 4 108 0
	sbi 0xa,3
	.loc 4 109 0
	sbi 0xb,2
.LVL32:
.LBE72:
.LBE71:
	.loc 1 362 0
	call USB_Init
.LVL33:
	.loc 1 365 0
	ldi r24,lo8(4)
	out 0x25,r24
	.loc 1 368 0
	sbi 0xb,7
	.loc 1 369 0
	sbi 0xa,7
	.loc 1 372 0
	st Y,__zero_reg__
	.loc 1 373 0
	movw r30,r16
	st Z,__zero_reg__
	.loc 1 374 0
	movw r30,r14
	st Z,__zero_reg__
	.loc 1 377 0
	ldi r24,lo8(-49)
	ldi r25,0
	movw r30,r10
	std Z+1,r25
	st Z,r24
	.loc 1 379 0
	movw r30,r14
	st Z,r13
	.loc 1 380 0
	ldi r24,lo8(2)
	movw r30,r16
	st Z,r24
	.loc 1 381 0
	ldi r24,lo8(-104)
	st Y,r24
/* epilogue start */
	.loc 1 382 0
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r11
	pop r10
	ret
	.cfi_endproc
.LFE99:
	.size	SetupHardware, .-SetupHardware
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
.LFB98:
	.loc 1 339 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 340 0
	call SetupHardware
.LVL34:
	.loc 1 341 0
/* #APP */
 ;  341 "Arduino-keyboard.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
.L30:
	.loc 1 345 0 discriminator 1
	call ProcessIncomingSerialData
.LVL35:
	.loc 1 348 0 discriminator 1
	ldi r24,lo8(HID_KeyboardInterface)
	ldi r25,hi8(HID_KeyboardInterface)
	call HID_Device_USBTask
.LVL36:
	.loc 1 349 0 discriminator 1
	ldi r24,lo8(HID_MediaInterface)
	ldi r25,hi8(HID_MediaInterface)
	call HID_Device_USBTask
.LVL37:
	.loc 1 350 0 discriminator 1
	call USB_USBTask
.LVL38:
	rjmp .L30
	.cfi_endproc
.LFE98:
	.size	main, .-main
	.section	.text.CALLBACK_HID_Device_CreateHIDReport,"ax",@progbits
.global	CALLBACK_HID_Device_CreateHIDReport
	.type	CALLBACK_HID_Device_CreateHIDReport, @function
CALLBACK_HID_Device_CreateHIDReport:
.LFB100:
	.loc 1 394 0
	.cfi_startproc
.LVL39:
	push r16
.LCFI10:
	.cfi_def_cfa_offset 3
	.cfi_offset 16, -2
	push r17
.LCFI11:
	.cfi_def_cfa_offset 4
	.cfi_offset 17, -3
	push r28
.LCFI12:
	.cfi_def_cfa_offset 5
	.cfi_offset 28, -4
	push r29
.LCFI13:
	.cfi_def_cfa_offset 6
	.cfi_offset 29, -5
	in r28,__SP_L__
	in r29,__SP_H__
.LCFI14:
	.cfi_def_cfa_register 28
	sbiw r28,8
.LCFI15:
	.cfi_def_cfa_offset 14
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 8 */
/* stack size = 12 */
.L__stack_usage = 12
	.loc 1 399 0
	ldi r20,hi8(HID_KeyboardInterface)
	cpi r24,lo8(HID_KeyboardInterface)
	cpc r25,r20
.LVL40:
	brne .L32
.LBB79:
.LBB80:
.LBB81:
	.loc 1 248 0
	lds r25,KeyboardHead
	lds r24,KeyboardTail
.LVL41:
	cpse r25,r24
	rjmp .L33
.L36:
.LBE81:
.LBE80:
.LBE79:
	.loc 1 435 0
	movw r30,r16
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	rjmp .L39
.L33:
.LBB84:
.LBB83:
.LBB82:
	.loc 1 249 0
	lds r30,KeyboardHead
	ldi r31,0
	ldi r25,3
	1:
	lsl r30
	rol r31
	dec r25
	brne 1b
	subi r30,lo8(-(KeyboardQueue))
	sbci r31,hi8(-(KeyboardQueue))
	ldi r24,lo8(8)
	movw r26,r28
	adiw r26,1
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	.loc 1 250 0
	lds r24,KeyboardHead
	ldi r25,0
	adiw r24,1
	andi r24,7
	clr r25
	sts KeyboardHead,r24
.LBE82:
.LBE83:
	.loc 1 403 0
	ldi r24,lo8(8)
	movw r30,r28
	adiw r30,1
	movw r26,r18
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	.loc 1 404 0
	ldi r24,lo8(8)
	ldi r25,0
.L41:
.LBE84:
.LBB85:
	.loc 1 426 0
	movw r30,r16
	std Z+1,r25
	st Z,r24
	.loc 1 427 0
	ldi r24,lo8(1)
.L31:
/* epilogue start */
.LBE85:
	.loc 1 437 0
	adiw r28,8
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
.LVL42:
	ret
.LVL43:
.L32:
	.loc 1 412 0
	subi r24,lo8(HID_MediaInterface)
	sbci r25,hi8(HID_MediaInterface)
	brne .L36
.LVL44:
.LBB88:
	.loc 1 415 0
	lds r24,MediaState
.LVL45:
	cpse r24,__zero_reg__
	rjmp .L37
.LVL46:
.LBB86:
.LBB87:
	.loc 1 263 0
	lds r25,MediaHead
	lds r24,MediaTail
	cp r25,r24
	breq .L38
	.loc 1 264 0
	lds r30,MediaHead
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(MediaQueue))
	sbci r31,hi8(-(MediaQueue))
	ld r20,Z
	ldd r21,Z+1
	sts currentMediaUsage+1,r21
	sts currentMediaUsage,r20
	.loc 1 265 0
	lds r24,MediaHead
	ldi r25,0
	adiw r24,1
	andi r24,15
	clr r25
	sts MediaHead,r24
.LVL47:
.LBE87:
.LBE86:
	.loc 1 417 0
	movw r30,r18
	std Z+1,r21
	st Z,r20
	.loc 1 418 0
	ldi r24,lo8(1)
	sts MediaState,r24
.L40:
	.loc 1 426 0
	ldi r24,lo8(2)
	ldi r25,0
	rjmp .L41
.L37:
	.loc 1 423 0
	cpi r24,lo8(1)
	brne .L38
	.loc 1 424 0
	movw r30,r18
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	.loc 1 425 0
	sts MediaState,__zero_reg__
	rjmp .L40
.L38:
	.loc 1 430 0
	movw r30,r18
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	.loc 1 431 0
	ldi r24,lo8(2)
	ldi r25,0
	movw r30,r16
	std Z+1,r25
	st Z,r24
.LVL48:
.L39:
.LBE88:
	.loc 1 436 0
	ldi r24,0
	rjmp .L31
	.cfi_endproc
.LFE100:
	.size	CALLBACK_HID_Device_CreateHIDReport, .-CALLBACK_HID_Device_CreateHIDReport
	.section	.text.CALLBACK_HID_Device_ProcessHIDReport,"ax",@progbits
.global	CALLBACK_HID_Device_ProcessHIDReport
	.type	CALLBACK_HID_Device_ProcessHIDReport, @function
CALLBACK_HID_Device_ProcessHIDReport:
.LFB101:
	.loc 1 444 0
	.cfi_startproc
.LVL49:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* epilogue start */
	.loc 1 444 0
	ret
	.cfi_endproc
.LFE101:
	.size	CALLBACK_HID_Device_ProcessHIDReport, .-CALLBACK_HID_Device_ProcessHIDReport
	.section	.text.EVENT_USB_Device_ConfigurationChanged,"ax",@progbits
.global	EVENT_USB_Device_ConfigurationChanged
	.type	EVENT_USB_Device_ConfigurationChanged, @function
EVENT_USB_Device_ConfigurationChanged:
.LFB102:
	.loc 1 446 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 447 0
	ldi r24,lo8(HID_KeyboardInterface)
	ldi r25,hi8(HID_KeyboardInterface)
	call HID_Device_ConfigureEndpoints
.LVL50:
	.loc 1 448 0
	ldi r24,lo8(HID_MediaInterface)
	ldi r25,hi8(HID_MediaInterface)
	call HID_Device_ConfigureEndpoints
.LVL51:
.LBB89:
.LBB90:
	.file 5 "./LUFA/Drivers/USB/HighLevel/../LowLevel/Device.h"
	.loc 5 150 0
	ldi r30,lo8(-30)
	ldi r31,0
	ld r24,Z
	ori r24,lo8(4)
	st Z,r24
/* epilogue start */
.LBE90:
.LBE89:
	.loc 1 450 0
	ret
	.cfi_endproc
.LFE102:
	.size	EVENT_USB_Device_ConfigurationChanged, .-EVENT_USB_Device_ConfigurationChanged
	.section	.text.EVENT_USB_Device_UnhandledControlRequest,"ax",@progbits
.global	EVENT_USB_Device_UnhandledControlRequest
	.type	EVENT_USB_Device_UnhandledControlRequest, @function
EVENT_USB_Device_UnhandledControlRequest:
.LFB103:
	.loc 1 452 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 453 0
	ldi r24,lo8(HID_KeyboardInterface)
	ldi r25,hi8(HID_KeyboardInterface)
	call HID_Device_ProcessControlRequest
.LVL52:
	.loc 1 454 0
	ldi r24,lo8(HID_MediaInterface)
	ldi r25,hi8(HID_MediaInterface)
	jmp HID_Device_ProcessControlRequest
.LVL53:
	.cfi_endproc
.LFE103:
	.size	EVENT_USB_Device_UnhandledControlRequest, .-EVENT_USB_Device_UnhandledControlRequest
	.section	.text.EVENT_USB_Device_StartOfFrame,"ax",@progbits
.global	EVENT_USB_Device_StartOfFrame
	.type	EVENT_USB_Device_StartOfFrame, @function
EVENT_USB_Device_StartOfFrame:
.LFB104:
	.loc 1 457 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.LVL54:
.LBB91:
.LBB92:
	.file 6 "./LUFA/Drivers/USB/Class/Device/HID.h"
	.loc 6 201 0
	lds r24,HID_KeyboardInterface+11
	lds r25,HID_KeyboardInterface+11+1
	sbiw r24,0
	breq .L46
	.loc 6 202 0
	sbiw r24,1
	sts HID_KeyboardInterface+11+1,r25
	sts HID_KeyboardInterface+11,r24
.L46:
.LVL55:
.LBE92:
.LBE91:
.LBB93:
.LBB94:
	.loc 6 201 0
	lds r24,HID_MediaInterface+11
	lds r25,HID_MediaInterface+11+1
	sbiw r24,0
	breq .L45
	.loc 6 202 0
	sbiw r24,1
	sts HID_MediaInterface+11+1,r25
	sts HID_MediaInterface+11,r24
.LVL56:
.L45:
/* epilogue start */
.LBE94:
.LBE93:
	.loc 1 460 0
	ret
	.cfi_endproc
.LFE104:
	.size	EVENT_USB_Device_StartOfFrame, .-EVENT_USB_Device_StartOfFrame
	.section	.text.EVENT_USB_Device_Connect,"ax",@progbits
.global	EVENT_USB_Device_Connect
	.type	EVENT_USB_Device_Connect, @function
EVENT_USB_Device_Connect:
.LFB105:
	.loc 1 462 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* epilogue start */
	.loc 1 462 0
	ret
	.cfi_endproc
.LFE105:
	.size	EVENT_USB_Device_Connect, .-EVENT_USB_Device_Connect
	.section	.text.EVENT_USB_Device_Disconnect,"ax",@progbits
.global	EVENT_USB_Device_Disconnect
	.type	EVENT_USB_Device_Disconnect, @function
EVENT_USB_Device_Disconnect:
.LFB110:
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* epilogue start */
	ret
	.cfi_endproc
.LFE110:
	.size	EVENT_USB_Device_Disconnect, .-EVENT_USB_Device_Disconnect
	.section	.text.__vector_23,"ax",@progbits
.global	__vector_23
	.type	__vector_23, @function
__vector_23:
.LFB107:
	.loc 1 469 0
	.cfi_startproc
	.loc 1 469 0
	push r1
.LCFI16:
	.cfi_def_cfa_offset 3
	.cfi_offset 1, -2
	push r0
.LCFI17:
	.cfi_def_cfa_offset 4
	.cfi_offset 0, -3
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r24
.LCFI18:
	.cfi_def_cfa_offset 5
	.cfi_offset 24, -4
	push r25
.LCFI19:
	.cfi_def_cfa_offset 6
	.cfi_offset 25, -5
	push r30
.LCFI20:
	.cfi_def_cfa_offset 7
	.cfi_offset 30, -6
	push r31
.LCFI21:
	.cfi_def_cfa_offset 8
	.cfi_offset 31, -7
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 7 */
.L__stack_usage = 7
	.loc 1 471 0
	lds r24,206
.LVL57:
	.loc 1 474 0
	lds r25,parserCount
	cpi r25,lo8(64)
	brsh .L56
	.loc 1 476 0
	lds r30,parserHead
	ldi r31,0
	subi r30,lo8(-(parserBuffer))
	sbci r31,hi8(-(parserBuffer))
	st Z,r24
	.loc 1 477 0
	lds r24,parserHead
.LVL58:
	ldi r25,0
	adiw r24,1
	andi r24,63
	clr r25
	sts parserHead,r24
.LVL59:
	.loc 1 478 0
	lds r24,parserCount
	subi r24,lo8(-(1))
	sts parserCount,r24
.L56:
/* epilogue start */
	.loc 1 480 0
	pop r31
	pop r30
	pop r25
	pop r24
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.cfi_endproc
.LFE107:
	.size	__vector_23, .-__vector_23
	.section	.rodata
	.type	CSWTCH.44, @object
	.size	CSWTCH.44, 54
CSWTCH.44:
	.byte	-75
	.byte	-74
	.byte	-73
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-51
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-30
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-23
	.byte	-22
	.local	CurrentFrameContext
	.comm	CurrentFrameContext,8,1
	.local	PayloadByteIndex
	.comm	PayloadByteIndex,1,1
	.local	ActivePacketType
	.comm	ActivePacketType,1,1
	.local	CurrentParserState
	.comm	CurrentParserState,1,1
	.local	parserCount
	.comm	parserCount,1,1
	.local	parserTail
	.comm	parserTail,1,1
	.local	parserHead
	.comm	parserHead,1,1
	.local	parserBuffer
	.comm	parserBuffer,64,1
.global	ledReport
	.section .bss
	.type	ledReport, @object
	.size	ledReport, 1
ledReport:
	.zero	1
	.local	currentMediaUsage
	.comm	currentMediaUsage,2,1
	.local	MediaState
	.comm	MediaState,1,1
	.local	MediaTail
	.comm	MediaTail,1,1
	.local	MediaHead
	.comm	MediaHead,1,1
	.local	MediaQueue
	.comm	MediaQueue,32,1
	.local	KeyboardTail
	.comm	KeyboardTail,1,1
	.local	KeyboardHead
	.comm	KeyboardHead,1,1
	.local	KeyboardQueue
	.comm	KeyboardQueue,64,1
.global	HID_MediaInterface
	.data
	.type	HID_MediaInterface, @object
	.size	HID_MediaInterface, 13
HID_MediaInterface:
	.byte	1
	.byte	2
	.word	8
	.byte	0
	.word	PrevMediaHIDReportBuffer
	.byte	2
	.zero	5
.global	HID_KeyboardInterface
	.type	HID_KeyboardInterface, @object
	.size	HID_KeyboardInterface, 13
HID_KeyboardInterface:
	.byte	0
	.byte	1
	.word	8
	.byte	0
	.word	PrevKeyboardHIDReportBuffer
	.byte	8
	.zero	5
	.comm	PrevMediaHIDReportBuffer,2,1
	.comm	PrevKeyboardHIDReportBuffer,8,1
	.text
.Letext0:
	.file 7 "/usr/lib/avr/include/stdint.h"
	.file 8 "./LUFA/Drivers/USB/HighLevel/../LowLevel/../HighLevel/StdRequestType.h"
	.file 9 "./LUFA/Drivers/USB/HighLevel/../LowLevel/../HighLevel/DeviceStandardReq.h"
	.file 10 "./LUFA/Drivers/USB/HighLevel/USBTask.h"
	.file 11 "./LUFA/Drivers/USB/Class/Device/../Common/HID.h"
	.file 12 "Descriptors.h"
	.file 13 "/usr/lib/avr/include/stdio.h"
	.file 14 "Arduino-keyboard.h"
	.file 15 "./LUFA/Drivers/USB/HighLevel/../LowLevel/USBController.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xcc3
	.word	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF124
	.byte	0xc
	.long	.LASF125
	.long	.LASF126
	.long	.Ldebug_ranges0+0x80
	.long	0
	.long	0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF0
	.uleb128 0x3
	.long	.LASF2
	.byte	0x7
	.byte	0x7e
	.long	0x45
	.uleb128 0x4
	.long	0x30
	.uleb128 0x5
	.long	0x30
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x6
	.byte	0x2
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.long	.LASF3
	.byte	0x7
	.byte	0x80
	.long	0x63
	.uleb128 0x5
	.long	0x53
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF4
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.long	.LASF5
	.uleb128 0x3
	.long	.LASF6
	.byte	0x7
	.byte	0x82
	.long	0x81
	.uleb128 0x5
	.long	0x71
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF7
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF9
	.uleb128 0x7
	.long	.LASF127
	.byte	0x7
	.byte	0x1
	.long	0x45
	.byte	0x5
	.byte	0x72
	.long	0xcc
	.uleb128 0x8
	.long	.LASF10
	.byte	0
	.uleb128 0x8
	.long	.LASF11
	.byte	0x1
	.uleb128 0x8
	.long	.LASF12
	.byte	0x2
	.uleb128 0x8
	.long	.LASF13
	.byte	0x3
	.uleb128 0x8
	.long	.LASF14
	.byte	0x4
	.uleb128 0x8
	.long	.LASF15
	.byte	0x5
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.byte	0x8
	.byte	0xa2
	.long	0x11b
	.uleb128 0xa
	.long	.LASF16
	.byte	0x8
	.byte	0xa4
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xa
	.long	.LASF17
	.byte	0x8
	.byte	0xa5
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0xa
	.long	.LASF18
	.byte	0x8
	.byte	0xa6
	.long	0x53
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xa
	.long	.LASF19
	.byte	0x8
	.byte	0xa7
	.long	0x53
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xa
	.long	.LASF20
	.byte	0x8
	.byte	0xa8
	.long	0x53
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.byte	0
	.uleb128 0x3
	.long	.LASF21
	.byte	0x8
	.byte	0xa9
	.long	0xcc
	.uleb128 0xb
	.long	.LASF22
	.byte	0x9
	.byte	0x64
	.long	0x30
	.byte	0x1
	.byte	0x1
	.uleb128 0xb
	.long	.LASF23
	.byte	0xa
	.byte	0x53
	.long	0x147
	.byte	0x1
	.byte	0x1
	.uleb128 0x2
	.byte	0x1
	.byte	0x2
	.long	.LASF24
	.uleb128 0x4
	.long	0x140
	.uleb128 0x5
	.long	0x140
	.uleb128 0xb
	.long	.LASF25
	.byte	0xa
	.byte	0x5b
	.long	0x11b
	.byte	0x1
	.byte	0x1
	.uleb128 0xc
	.byte	0x2
	.uleb128 0x9
	.byte	0x8
	.byte	0xb
	.byte	0xb5
	.long	0x193
	.uleb128 0xa
	.long	.LASF26
	.byte	0xb
	.byte	0xb7
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xa
	.long	.LASF27
	.byte	0xb
	.byte	0xba
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0xa
	.long	.LASF28
	.byte	0xb
	.byte	0xbb
	.long	0x193
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0
	.uleb128 0xd
	.long	0x30
	.long	0x1a3
	.uleb128 0xe
	.long	0x63
	.byte	0x5
	.byte	0
	.uleb128 0x3
	.long	.LASF29
	.byte	0xb
	.byte	0xbc
	.long	0x160
	.uleb128 0x5
	.long	0x1a3
	.uleb128 0x9
	.byte	0x8
	.byte	0x6
	.byte	0x56
	.long	0x210
	.uleb128 0xa
	.long	.LASF30
	.byte	0x6
	.byte	0x58
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xa
	.long	.LASF31
	.byte	0x6
	.byte	0x5a
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0xa
	.long	.LASF32
	.byte	0x6
	.byte	0x5b
	.long	0x53
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xa
	.long	.LASF33
	.byte	0x6
	.byte	0x5c
	.long	0x140
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xa
	.long	.LASF34
	.byte	0x6
	.byte	0x5e
	.long	0x15e
	.byte	0x2
	.byte	0x23
	.uleb128 0x5
	.uleb128 0xa
	.long	.LASF35
	.byte	0x6
	.byte	0x6a
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x7
	.byte	0
	.uleb128 0x5
	.long	0x1b3
	.uleb128 0x9
	.byte	0x5
	.byte	0x6
	.byte	0x73
	.long	0x248
	.uleb128 0xa
	.long	.LASF36
	.byte	0x6
	.byte	0x75
	.long	0x140
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xa
	.long	.LASF37
	.byte	0x6
	.byte	0x76
	.long	0x53
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0xa
	.long	.LASF38
	.byte	0x6
	.byte	0x77
	.long	0x53
	.byte	0x2
	.byte	0x23
	.uleb128 0x3
	.byte	0
	.uleb128 0x9
	.byte	0xd
	.byte	0x6
	.byte	0x54
	.long	0x26d
	.uleb128 0xa
	.long	.LASF39
	.byte	0x6
	.byte	0x70
	.long	0x210
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xa
	.long	.LASF40
	.byte	0x6
	.byte	0x79
	.long	0x215
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0
	.uleb128 0x3
	.long	.LASF41
	.byte	0x6
	.byte	0x7c
	.long	0x248
	.uleb128 0xf
	.long	.LASF44
	.byte	0x2
	.byte	0xc
	.byte	0x32
	.long	0x293
	.uleb128 0xa
	.long	.LASF42
	.byte	0xc
	.byte	0x34
	.long	0x53
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.byte	0
	.uleb128 0x3
	.long	.LASF43
	.byte	0xc
	.byte	0x35
	.long	0x278
	.uleb128 0x10
	.byte	0x2
	.long	0x30
	.uleb128 0x5
	.long	0x29e
	.uleb128 0xf
	.long	.LASF45
	.byte	0xe
	.byte	0xd
	.byte	0xf4
	.long	0x32b
	.uleb128 0x11
	.string	"buf"
	.byte	0xd
	.byte	0xf5
	.long	0x32b
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xa
	.long	.LASF46
	.byte	0xd
	.byte	0xf6
	.long	0x45
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xa
	.long	.LASF47
	.byte	0xd
	.byte	0xf7
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x3
	.uleb128 0x12
	.long	.LASF48
	.byte	0xd
	.word	0x107
	.long	0x4c
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x13
	.string	"len"
	.byte	0xd
	.word	0x108
	.long	0x4c
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0x13
	.string	"put"
	.byte	0xd
	.word	0x109
	.long	0x353
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x13
	.string	"get"
	.byte	0xd
	.word	0x10a
	.long	0x369
	.byte	0x2
	.byte	0x23
	.uleb128 0xa
	.uleb128 0x12
	.long	.LASF49
	.byte	0xd
	.word	0x10b
	.long	0x15e
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.byte	0
	.uleb128 0x10
	.byte	0x2
	.long	0x331
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF50
	.uleb128 0x14
	.byte	0x1
	.long	0x4c
	.long	0x34d
	.uleb128 0x15
	.long	0x331
	.uleb128 0x15
	.long	0x34d
	.byte	0
	.uleb128 0x10
	.byte	0x2
	.long	0x2a9
	.uleb128 0x10
	.byte	0x2
	.long	0x338
	.uleb128 0x14
	.byte	0x1
	.long	0x4c
	.long	0x369
	.uleb128 0x15
	.long	0x34d
	.byte	0
	.uleb128 0x10
	.byte	0x2
	.long	0x359
	.uleb128 0xd
	.long	0x34d
	.long	0x37a
	.uleb128 0x16
	.byte	0
	.uleb128 0x17
	.long	.LASF51
	.byte	0xd
	.word	0x197
	.long	0x36f
	.byte	0x1
	.byte	0x1
	.uleb128 0xb
	.long	.LASF52
	.byte	0xe
	.byte	0x5c
	.long	0x26d
	.byte	0x1
	.byte	0x1
	.uleb128 0xb
	.long	.LASF53
	.byte	0xe
	.byte	0x5d
	.long	0x26d
	.byte	0x1
	.byte	0x1
	.uleb128 0xd
	.long	0x30
	.long	0x3b2
	.uleb128 0xe
	.long	0x63
	.byte	0x7
	.byte	0
	.uleb128 0x18
	.long	.LASF54
	.byte	0x1
	.byte	0x8a
	.long	0x3a2
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	PrevKeyboardHIDReportBuffer
	.uleb128 0xd
	.long	0x30
	.long	0x3d4
	.uleb128 0xe
	.long	0x63
	.byte	0x1
	.byte	0
	.uleb128 0x18
	.long	.LASF55
	.byte	0x1
	.byte	0x8b
	.long	0x3c4
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	PrevMediaHIDReportBuffer
	.uleb128 0x19
	.long	0x388
	.byte	0x1
	.byte	0x8e
	.byte	0x5
	.byte	0x3
	.long	HID_KeyboardInterface
	.uleb128 0x19
	.long	0x395
	.byte	0x1
	.byte	0x99
	.byte	0x5
	.byte	0x3
	.long	HID_MediaInterface
	.uleb128 0xd
	.long	0x1a3
	.long	0x410
	.uleb128 0xe
	.long	0x63
	.byte	0x7
	.byte	0
	.uleb128 0x1a
	.long	.LASF56
	.byte	0x1
	.byte	0xa8
	.long	0x400
	.byte	0x5
	.byte	0x3
	.long	KeyboardQueue
	.uleb128 0x1a
	.long	.LASF57
	.byte	0x1
	.byte	0xa9
	.long	0x3b
	.byte	0x5
	.byte	0x3
	.long	KeyboardHead
	.uleb128 0x1a
	.long	.LASF58
	.byte	0x1
	.byte	0xaa
	.long	0x3b
	.byte	0x5
	.byte	0x3
	.long	KeyboardTail
	.uleb128 0xd
	.long	0x53
	.long	0x453
	.uleb128 0xe
	.long	0x63
	.byte	0xf
	.byte	0
	.uleb128 0x1a
	.long	.LASF59
	.byte	0x1
	.byte	0xad
	.long	0x443
	.byte	0x5
	.byte	0x3
	.long	MediaQueue
	.uleb128 0x1a
	.long	.LASF60
	.byte	0x1
	.byte	0xae
	.long	0x3b
	.byte	0x5
	.byte	0x3
	.long	MediaHead
	.uleb128 0x1a
	.long	.LASF61
	.byte	0x1
	.byte	0xaf
	.long	0x3b
	.byte	0x5
	.byte	0x3
	.long	MediaTail
	.uleb128 0x1b
	.byte	0x7
	.byte	0x1
	.long	0x45
	.byte	0x1
	.byte	0xb2
	.long	0x4a0
	.uleb128 0x8
	.long	.LASF62
	.byte	0
	.uleb128 0x8
	.long	.LASF63
	.byte	0x1
	.byte	0
	.uleb128 0x3
	.long	.LASF64
	.byte	0x1
	.byte	0xb5
	.long	0x486
	.uleb128 0x1a
	.long	.LASF65
	.byte	0x1
	.byte	0xb7
	.long	0x4a0
	.byte	0x5
	.byte	0x3
	.long	MediaState
	.uleb128 0x1a
	.long	.LASF66
	.byte	0x1
	.byte	0xb8
	.long	0x53
	.byte	0x5
	.byte	0x3
	.long	currentMediaUsage
	.uleb128 0x18
	.long	.LASF67
	.byte	0x1
	.byte	0xb9
	.long	0x30
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	ledReport
	.uleb128 0xd
	.long	0x3b
	.long	0x4ef
	.uleb128 0xe
	.long	0x63
	.byte	0x3f
	.byte	0
	.uleb128 0x4
	.long	0x4df
	.uleb128 0x1a
	.long	.LASF68
	.byte	0x1
	.byte	0xbd
	.long	0x4ef
	.byte	0x5
	.byte	0x3
	.long	parserBuffer
	.uleb128 0x1a
	.long	.LASF69
	.byte	0x1
	.byte	0xbe
	.long	0x3b
	.byte	0x5
	.byte	0x3
	.long	parserHead
	.uleb128 0x1a
	.long	.LASF70
	.byte	0x1
	.byte	0xbf
	.long	0x3b
	.byte	0x5
	.byte	0x3
	.long	parserTail
	.uleb128 0x1a
	.long	.LASF71
	.byte	0x1
	.byte	0xc0
	.long	0x3b
	.byte	0x5
	.byte	0x3
	.long	parserCount
	.uleb128 0x1b
	.byte	0x7
	.byte	0x1
	.long	0x45
	.byte	0x1
	.byte	0xc2
	.long	0x552
	.uleb128 0x8
	.long	.LASF72
	.byte	0
	.uleb128 0x8
	.long	.LASF73
	.byte	0x1
	.byte	0
	.uleb128 0x3
	.long	.LASF74
	.byte	0x1
	.byte	0xc5
	.long	0x538
	.uleb128 0x1a
	.long	.LASF75
	.byte	0x1
	.byte	0xc7
	.long	0x552
	.byte	0x5
	.byte	0x3
	.long	CurrentParserState
	.uleb128 0x1a
	.long	.LASF76
	.byte	0x1
	.byte	0xc8
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	ActivePacketType
	.uleb128 0x1a
	.long	.LASF77
	.byte	0x1
	.byte	0xc9
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	PayloadByteIndex
	.uleb128 0x1c
	.byte	0x8
	.byte	0x1
	.byte	0xcc
	.long	0x5af
	.uleb128 0x1d
	.long	.LASF78
	.byte	0x1
	.byte	0xcd
	.long	0x1a3
	.uleb128 0x1d
	.long	.LASF79
	.byte	0x1
	.byte	0xce
	.long	0x3a2
	.byte	0
	.uleb128 0x1a
	.long	.LASF80
	.byte	0x1
	.byte	0xcf
	.long	0x590
	.byte	0x5
	.byte	0x3
	.long	CurrentFrameContext
	.uleb128 0x1e
	.byte	0x1
	.long	.LASF82
	.byte	0x1
	.word	0x1d4
	.byte	0x1
	.long	.LFB107
	.long	.LFE107
	.long	.LLST21
	.byte	0x1
	.long	0x5ec
	.uleb128 0x1f
	.long	.LASF81
	.byte	0x1
	.word	0x1d7
	.long	0x30
	.long	.LLST22
	.byte	0
	.uleb128 0x20
	.byte	0x1
	.long	.LASF128
	.byte	0x1
	.word	0x1cf
	.byte	0x1
	.uleb128 0x21
	.byte	0x1
	.long	.LASF129
	.byte	0x1
	.word	0x1ce
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.byte	0x1
	.long	.LASF83
	.byte	0x1
	.word	0x1c9
	.byte	0x1
	.long	.LFB104
	.long	.LFE104
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x64d
	.uleb128 0x23
	.long	0xbf5
	.long	.LBB91
	.long	.LBE91
	.byte	0x1
	.word	0x1ca
	.long	0x636
	.uleb128 0x24
	.long	0xc02
	.byte	0
	.uleb128 0x25
	.long	0xbf5
	.long	.LBB93
	.long	.LBE93
	.byte	0x1
	.word	0x1cb
	.uleb128 0x24
	.long	0xc02
	.byte	0
	.byte	0
	.uleb128 0x22
	.byte	0x1
	.long	.LASF84
	.byte	0x1
	.word	0x1c4
	.byte	0x1
	.long	.LFB103
	.long	.LFE103
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x69e
	.uleb128 0x26
	.long	.LVL52
	.long	0xc84
	.long	0x684
	.uleb128 0x27
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x5
	.byte	0x3
	.long	HID_KeyboardInterface
	.byte	0
	.uleb128 0x28
	.long	.LVL53
	.byte	0x1
	.long	0xc84
	.uleb128 0x27
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x5
	.byte	0x3
	.long	HID_MediaInterface
	.byte	0
	.byte	0
	.uleb128 0x22
	.byte	0x1
	.long	.LASF85
	.byte	0x1
	.word	0x1be
	.byte	0x1
	.long	.LFB102
	.long	.LFE102
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x6fe
	.uleb128 0x29
	.long	0xc0e
	.long	.LBB89
	.long	.LBE89
	.byte	0x1
	.word	0x1c1
	.uleb128 0x26
	.long	.LVL50
	.long	0xc91
	.long	0x6e5
	.uleb128 0x27
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x5
	.byte	0x3
	.long	HID_KeyboardInterface
	.byte	0
	.uleb128 0x2a
	.long	.LVL51
	.long	0xc91
	.uleb128 0x27
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x5
	.byte	0x3
	.long	HID_MediaInterface
	.byte	0
	.byte	0
	.uleb128 0x22
	.byte	0x1
	.long	.LASF86
	.byte	0x1
	.word	0x1b7
	.byte	0x1
	.long	.LFB101
	.long	.LFE101
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x76f
	.uleb128 0x2b
	.long	.LASF87
	.byte	0x1
	.word	0x1b7
	.long	0x775
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.uleb128 0x2b
	.long	.LASF88
	.byte	0x1
	.word	0x1b8
	.long	0x40
	.byte	0x1
	.byte	0x66
	.uleb128 0x2b
	.long	.LASF89
	.byte	0x1
	.word	0x1b9
	.long	0x40
	.byte	0x1
	.byte	0x64
	.uleb128 0x2b
	.long	.LASF90
	.byte	0x1
	.word	0x1ba
	.long	0x77a
	.byte	0x6
	.byte	0x62
	.byte	0x93
	.uleb128 0x1
	.byte	0x63
	.byte	0x93
	.uleb128 0x1
	.uleb128 0x2b
	.long	.LASF91
	.byte	0x1
	.word	0x1bb
	.long	0x5e
	.byte	0x6
	.byte	0x60
	.byte	0x93
	.uleb128 0x1
	.byte	0x61
	.byte	0x93
	.uleb128 0x1
	.byte	0
	.uleb128 0x10
	.byte	0x2
	.long	0x26d
	.uleb128 0x5
	.long	0x76f
	.uleb128 0x10
	.byte	0x2
	.long	0x780
	.uleb128 0x2c
	.uleb128 0x2d
	.byte	0x1
	.long	.LASF95
	.byte	0x1
	.word	0x184
	.byte	0x1
	.long	0x140
	.long	.LFB100
	.long	.LFE100
	.long	.LLST16
	.byte	0x1
	.long	0x852
	.uleb128 0x2e
	.long	.LASF87
	.byte	0x1
	.word	0x185
	.long	0x775
	.long	.LLST17
	.uleb128 0x2b
	.long	.LASF88
	.byte	0x1
	.word	0x186
	.long	0x2a4
	.byte	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.uleb128 0x2e
	.long	.LASF89
	.byte	0x1
	.word	0x187
	.long	0x40
	.long	.LLST18
	.uleb128 0x2b
	.long	.LASF90
	.byte	0x1
	.word	0x188
	.long	0x15e
	.byte	0x6
	.byte	0x62
	.byte	0x93
	.uleb128 0x1
	.byte	0x63
	.byte	0x93
	.uleb128 0x1
	.uleb128 0x2e
	.long	.LASF91
	.byte	0x1
	.word	0x189
	.long	0x858
	.long	.LLST19
	.uleb128 0x2f
	.long	.Ldebug_ranges0+0x38
	.long	0x825
	.uleb128 0x30
	.long	.LASF92
	.byte	0x1
	.word	0x190
	.long	0x1a3
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x31
	.long	0xb46
	.long	.LBB80
	.long	.Ldebug_ranges0+0x50
	.byte	0x1
	.word	0x192
	.uleb128 0x24
	.long	0xb57
	.byte	0
	.byte	0
	.uleb128 0x32
	.long	.Ldebug_ranges0+0x68
	.uleb128 0x1f
	.long	.LASF93
	.byte	0x1
	.word	0x19d
	.long	0x85d
	.long	.LLST20
	.uleb128 0x25
	.long	0xaed
	.long	.LBB86
	.long	.LBE86
	.byte	0x1
	.word	0x1a0
	.uleb128 0x24
	.long	0xaff
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.byte	0x2
	.long	0x53
	.uleb128 0x5
	.long	0x852
	.uleb128 0x10
	.byte	0x2
	.long	0x293
	.uleb128 0x1e
	.byte	0x1
	.long	.LASF94
	.byte	0x1
	.word	0x162
	.byte	0x1
	.long	.LFB99
	.long	.LFE99
	.long	.LLST13
	.byte	0x1
	.long	0x8d7
	.uleb128 0x23
	.long	0xc43
	.long	.LBB69
	.long	.LBE69
	.byte	0x1
	.word	0x166
	.long	0x8a6
	.uleb128 0x33
	.long	0xc63
	.long	.LBB70
	.long	.LBE70
	.uleb128 0x34
	.long	0xc64
	.byte	0
	.byte	0
	.uleb128 0x23
	.long	0xbd1
	.long	.LBB71
	.long	.LBE71
	.byte	0x1
	.word	0x169
	.long	0x8cd
	.uleb128 0x35
	.long	0xbde
	.long	.LLST14
	.uleb128 0x35
	.long	0xbe9
	.long	.LLST15
	.byte	0
	.uleb128 0x36
	.long	.LVL33
	.long	0xc9e
	.byte	0
	.uleb128 0x37
	.byte	0x1
	.long	.LASF96
	.byte	0x1
	.word	0x153
	.byte	0x1
	.long	0x4c
	.long	.LFB98
	.long	.LFE98
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x94a
	.uleb128 0x36
	.long	.LVL34
	.long	0x863
	.uleb128 0x36
	.long	.LVL35
	.long	0x94a
	.uleb128 0x26
	.long	.LVL36
	.long	0xcac
	.long	0x924
	.uleb128 0x27
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x5
	.byte	0x3
	.long	HID_KeyboardInterface
	.byte	0
	.uleb128 0x26
	.long	.LVL37
	.long	0xcac
	.long	0x940
	.uleb128 0x27
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x5
	.byte	0x3
	.long	HID_MediaInterface
	.byte	0
	.uleb128 0x36
	.long	.LVL38
	.long	0xcb9
	.byte	0
	.uleb128 0x1e
	.byte	0x1
	.long	.LASF97
	.byte	0x1
	.word	0x11a
	.byte	0x1
	.long	.LFB97
	.long	.LFE97
	.long	.LLST1
	.byte	0x1
	.long	0xab4
	.uleb128 0x2f
	.long	.Ldebug_ranges0+0
	.long	0xa45
	.uleb128 0x1f
	.long	.LASF98
	.byte	0x1
	.word	0x11f
	.long	0x30
	.long	.LLST2
	.uleb128 0x38
	.long	.LBB44
	.long	.LBE44
	.long	0x9d6
	.uleb128 0x1f
	.long	.LASF99
	.byte	0x1
	.word	0x122
	.long	0x30
	.long	.LLST3
	.uleb128 0x1f
	.long	.LASF100
	.byte	0x1
	.word	0x122
	.long	0x30
	.long	.LLST4
	.uleb128 0x29
	.long	0xc36
	.long	.LBB45
	.long	.LBE45
	.byte	0x1
	.word	0x122
	.uleb128 0x25
	.long	0xc17
	.long	.LBB47
	.long	.LBE47
	.byte	0x1
	.word	0x122
	.uleb128 0x35
	.long	0xc24
	.long	.LLST5
	.byte	0
	.byte	0
	.uleb128 0x38
	.long	.LBB51
	.long	.LBE51
	.long	0xa1b
	.uleb128 0x1f
	.long	.LASF101
	.byte	0x1
	.word	0x13b
	.long	0x30
	.long	.LLST7
	.uleb128 0x39
	.long	0xbb4
	.long	.LBB52
	.long	.Ldebug_ranges0+0x20
	.byte	0x1
	.word	0x13c
	.long	0xa11
	.uleb128 0x35
	.long	0xbc5
	.long	.LLST8
	.byte	0
	.uleb128 0x36
	.long	.LVL27
	.long	0xb0c
	.byte	0
	.uleb128 0x25
	.long	0xb69
	.long	.LBB49
	.long	.LBE49
	.byte	0x1
	.word	0x137
	.uleb128 0x24
	.long	0xb7a
	.uleb128 0x3a
	.long	.LBB50
	.long	.LBE50
	.uleb128 0x3b
	.long	0xb85
	.long	.LLST6
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x25
	.long	0xab4
	.long	.LBB57
	.long	.LBE57
	.byte	0x1
	.word	0x11e
	.uleb128 0x3a
	.long	.LBB58
	.long	.LBE58
	.uleb128 0x3b
	.long	0xac6
	.long	.LLST9
	.uleb128 0x33
	.long	0xad2
	.long	.LBB59
	.long	.LBE59
	.uleb128 0x3b
	.long	0xad3
	.long	.LLST10
	.uleb128 0x3b
	.long	0xadf
	.long	.LLST11
	.uleb128 0x29
	.long	0xc36
	.long	.LBB60
	.long	.LBE60
	.byte	0x1
	.word	0x110
	.uleb128 0x25
	.long	0xc17
	.long	.LBB62
	.long	.LBE62
	.byte	0x1
	.word	0x110
	.uleb128 0x35
	.long	0xc24
	.long	.LLST12
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x3c
	.long	.LASF103
	.byte	0x1
	.word	0x10e
	.byte	0x1
	.long	0x30
	.byte	0x3
	.long	0xaed
	.uleb128 0x3d
	.long	.LASF102
	.byte	0x1
	.word	0x10f
	.long	0x30
	.uleb128 0x3e
	.uleb128 0x3d
	.long	.LASF99
	.byte	0x1
	.word	0x110
	.long	0x30
	.uleb128 0x3d
	.long	.LASF100
	.byte	0x1
	.word	0x110
	.long	0x30
	.byte	0
	.byte	0
	.uleb128 0x3c
	.long	.LASF104
	.byte	0x1
	.word	0x106
	.byte	0x1
	.long	0x140
	.byte	0x1
	.long	0xb0c
	.uleb128 0x3f
	.long	.LASF42
	.byte	0x1
	.word	0x106
	.long	0x852
	.byte	0
	.uleb128 0x40
	.long	.LASF130
	.byte	0x1
	.byte	0xfe
	.byte	0x1
	.long	0x140
	.long	.LFB94
	.long	.LFE94
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0xb46
	.uleb128 0x41
	.long	.LASF42
	.byte	0x1
	.byte	0xfe
	.long	0x53
	.long	.LLST0
	.uleb128 0x1a
	.long	.LASF105
	.byte	0x1
	.byte	0xff
	.long	0x30
	.byte	0x1
	.byte	0x62
	.byte	0
	.uleb128 0x42
	.long	.LASF106
	.byte	0x1
	.byte	0xf7
	.byte	0x1
	.long	0x140
	.byte	0x1
	.long	0xb63
	.uleb128 0x43
	.long	.LASF107
	.byte	0x1
	.byte	0xf7
	.long	0xb63
	.byte	0
	.uleb128 0x10
	.byte	0x2
	.long	0x1a3
	.uleb128 0x42
	.long	.LASF108
	.byte	0x1
	.byte	0xef
	.byte	0x1
	.long	0x140
	.byte	0x1
	.long	0xb91
	.uleb128 0x43
	.long	.LASF107
	.byte	0x1
	.byte	0xef
	.long	0xb91
	.uleb128 0x44
	.long	.LASF105
	.byte	0x1
	.byte	0xf0
	.long	0x30
	.byte	0
	.uleb128 0x10
	.byte	0x2
	.long	0x1ae
	.uleb128 0x42
	.long	.LASF109
	.byte	0x1
	.byte	0xe0
	.byte	0x1
	.long	0x53
	.byte	0x3
	.long	0xbb4
	.uleb128 0x43
	.long	.LASF110
	.byte	0x1
	.byte	0xe0
	.long	0x30
	.byte	0
	.uleb128 0x42
	.long	.LASF111
	.byte	0x1
	.byte	0xd5
	.byte	0x1
	.long	0x140
	.byte	0x3
	.long	0xbd1
	.uleb128 0x43
	.long	.LASF110
	.byte	0x1
	.byte	0xd5
	.long	0x30
	.byte	0
	.uleb128 0x45
	.long	.LASF114
	.byte	0x4
	.byte	0x63
	.byte	0x1
	.byte	0x3
	.long	0xbf5
	.uleb128 0x43
	.long	.LASF112
	.byte	0x4
	.byte	0x63
	.long	0x7c
	.uleb128 0x43
	.long	.LASF113
	.byte	0x4
	.byte	0x64
	.long	0x14c
	.byte	0
	.uleb128 0x45
	.long	.LASF115
	.byte	0x6
	.byte	0xc7
	.byte	0x1
	.byte	0x3
	.long	0xc0e
	.uleb128 0x43
	.long	.LASF87
	.byte	0x6
	.byte	0xc7
	.long	0x775
	.byte	0
	.uleb128 0x46
	.long	.LASF131
	.byte	0x5
	.byte	0x94
	.byte	0x1
	.byte	0x3
	.uleb128 0x45
	.long	.LASF116
	.byte	0x2
	.byte	0x44
	.byte	0x1
	.byte	0x3
	.long	0xc30
	.uleb128 0x47
	.string	"__s"
	.byte	0x2
	.byte	0x44
	.long	0xc30
	.byte	0
	.uleb128 0x10
	.byte	0x2
	.long	0x40
	.uleb128 0x48
	.long	.LASF132
	.byte	0x2
	.byte	0x30
	.byte	0x1
	.long	0x30
	.byte	0x3
	.uleb128 0x49
	.long	.LASF117
	.byte	0x3
	.word	0x1ec
	.byte	0x1
	.byte	0x3
	.long	0xc72
	.uleb128 0x4a
	.long	0xc63
	.uleb128 0x3d
	.long	.LASF118
	.byte	0x3
	.word	0x1f0
	.long	0x30
	.byte	0
	.uleb128 0x3e
	.uleb128 0x3d
	.long	.LASF118
	.byte	0x3
	.word	0x202
	.long	0x30
	.byte	0
	.byte	0
	.uleb128 0x4b
	.long	0x5f6
	.long	.LFB105
	.long	.LFE105
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.uleb128 0x4c
	.byte	0x1
	.byte	0x1
	.long	.LASF119
	.long	.LASF119
	.byte	0x6
	.byte	0x8e
	.uleb128 0x4c
	.byte	0x1
	.byte	0x1
	.long	.LASF120
	.long	.LASF120
	.byte	0x6
	.byte	0x87
	.uleb128 0x4d
	.byte	0x1
	.byte	0x1
	.long	.LASF121
	.long	.LASF121
	.byte	0xf
	.word	0x123
	.uleb128 0x4c
	.byte	0x1
	.byte	0x1
	.long	.LASF122
	.long	.LASF122
	.byte	0x6
	.byte	0x95
	.uleb128 0x4c
	.byte	0x1
	.byte	0x1
	.long	.LASF123
	.long	.LASF123
	.byte	0xa
	.byte	0xb2
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x47
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0xc
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x1d
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x30
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x33
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x34
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x35
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x36
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x37
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x38
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x39
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3a
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x3b
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x3c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x1
	.byte	0
	.byte	0
	.uleb128 0x3f
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x40
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x41
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x42
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x43
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x44
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x45
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x46
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x47
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x48
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x49
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4a
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4b
	.uleb128 0x2e
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x4c
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.uleb128 0x2007
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x4d
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.uleb128 0x2007
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST21:
	.long	.LFB107
	.long	.LCFI16
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI16
	.long	.LCFI17
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI17
	.long	.LCFI18
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI18
	.long	.LCFI19
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI19
	.long	.LCFI20
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI20
	.long	.LCFI21
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI21
	.long	.LFE107
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 8
	.long	0
	.long	0
.LLST22:
	.long	.LVL57
	.long	.LVL58
	.word	0x1
	.byte	0x68
	.long	.LVL58
	.long	.LVL59
	.word	0x2
	.byte	0x8e
	.sleb128 0
	.long	0
	.long	0
.LLST16:
	.long	.LFB100
	.long	.LCFI10
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI10
	.long	.LCFI11
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI11
	.long	.LCFI12
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI12
	.long	.LCFI13
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI13
	.long	.LCFI14
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI14
	.long	.LCFI15
	.word	0x2
	.byte	0x8c
	.sleb128 6
	.long	.LCFI15
	.long	.LFE100
	.word	0x2
	.byte	0x8c
	.sleb128 14
	.long	0
	.long	0
.LLST17:
	.long	.LVL39
	.long	.LVL41
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL41
	.long	.LVL43
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	.LVL43
	.long	.LVL45
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL45
	.long	.LFE100
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST18:
	.long	.LVL39
	.long	.LVL40
	.word	0x1
	.byte	0x64
	.long	.LVL40
	.long	.LFE100
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x64
	.byte	0x9f
	.long	0
	.long	0
.LLST19:
	.long	.LVL39
	.long	.LVL42
	.word	0x6
	.byte	0x60
	.byte	0x93
	.uleb128 0x1
	.byte	0x61
	.byte	0x93
	.uleb128 0x1
	.long	.LVL42
	.long	.LVL43
	.word	0x6
	.byte	0x6e
	.byte	0x93
	.uleb128 0x1
	.byte	0x6f
	.byte	0x93
	.uleb128 0x1
	.long	.LVL43
	.long	.LFE100
	.word	0x6
	.byte	0x60
	.byte	0x93
	.uleb128 0x1
	.byte	0x61
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST20:
	.long	.LVL44
	.long	.LVL48
	.word	0x6
	.byte	0x62
	.byte	0x93
	.uleb128 0x1
	.byte	0x63
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST13:
	.long	.LFB99
	.long	.LCFI1
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI1
	.long	.LCFI2
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI2
	.long	.LCFI3
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI3
	.long	.LCFI4
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI4
	.long	.LCFI5
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI5
	.long	.LCFI6
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI6
	.long	.LCFI7
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 8
	.long	.LCFI7
	.long	.LCFI8
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 9
	.long	.LCFI8
	.long	.LCFI9
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 10
	.long	.LCFI9
	.long	.LFE99
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 11
	.long	0
	.long	0
.LLST14:
	.long	.LVL31
	.long	.LVL32
	.word	0x4
	.byte	0xa
	.word	0x2580
	.byte	0x9f
	.long	0
	.long	0
.LLST15:
	.long	.LVL31
	.long	.LVL32
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST1:
	.long	.LFB97
	.long	.LCFI0
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI0
	.long	.LFE97
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	0
	.long	0
.LLST2:
	.long	.LVL5
	.long	.LVL6
	.word	0x1
	.byte	0x62
	.long	.LVL13
	.long	.LVL18
	.word	0x1
	.byte	0x62
	.long	.LVL18
	.long	.LVL19
	.word	0x2
	.byte	0x8e
	.sleb128 0
	.long	.LVL21
	.long	.LVL27-1
	.word	0x1
	.byte	0x62
	.long	.LVL28
	.long	.LFE97
	.word	0x1
	.byte	0x62
	.long	0
	.long	0
.LLST3:
	.long	.LVL11
	.long	.LVL15
	.word	0x1
	.byte	0x63
	.long	0
	.long	0
.LLST4:
	.long	.LVL5
	.long	.LVL6
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL12
	.long	.LVL14
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.long	.LVL14
	.long	.LFE97
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST5:
	.long	.LVL5
	.long	.LVL6
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2443
	.sleb128 0
	.long	.LVL14
	.long	.LFE97
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2443
	.sleb128 0
	.long	0
	.long	0
.LLST7:
	.long	.LVL22
	.long	.LVL25
	.word	0x1
	.byte	0x6e
	.long	.LVL25
	.long	.LVL27-1
	.word	0x5
	.byte	0x3
	.long	CurrentFrameContext
	.long	.LVL28
	.long	.LVL30
	.word	0x1
	.byte	0x6e
	.long	.LVL30
	.long	.LFE97
	.word	0x5
	.byte	0x3
	.long	CurrentFrameContext
	.long	0
	.long	0
.LLST8:
	.long	.LVL22
	.long	.LVL23
	.word	0x1
	.byte	0x6e
	.long	.LVL28
	.long	.LVL29
	.word	0x1
	.byte	0x6e
	.long	0
	.long	0
.LLST6:
	.long	.LVL17
	.long	.LVL20
	.word	0x1
	.byte	0x68
	.long	0
	.long	0
.LLST9:
	.long	.LVL9
	.long	.LVL10
	.word	0x1
	.byte	0x68
	.long	0
	.long	0
.LLST10:
	.long	.LVL7
	.long	.LVL10
	.word	0x1
	.byte	0x69
	.long	0
	.long	0
.LLST11:
	.long	.LVL5
	.long	.LVL6
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL8
	.long	.LVL9
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.long	.LVL9
	.long	.LFE97
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST12:
	.long	.LVL5
	.long	.LVL6
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2443
	.sleb128 0
	.long	.LVL9
	.long	.LVL14
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2676
	.sleb128 0
	.long	.LVL14
	.long	.LFE97
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2443
	.sleb128 0
	.long	0
	.long	0
.LLST0:
	.long	.LVL0
	.long	.LVL2
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL2
	.long	.LVL3
	.word	0x2
	.byte	0x8e
	.sleb128 0
	.long	.LVL3
	.long	.LVL4
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL4
	.long	.LFE94
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
	.section	.debug_aranges,"",@progbits
	.long	0x6c
	.word	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.word	0
	.word	0
	.long	.LFB94
	.long	.LFE94-.LFB94
	.long	.LFB97
	.long	.LFE97-.LFB97
	.long	.LFB99
	.long	.LFE99-.LFB99
	.long	.LFB98
	.long	.LFE98-.LFB98
	.long	.LFB100
	.long	.LFE100-.LFB100
	.long	.LFB101
	.long	.LFE101-.LFB101
	.long	.LFB102
	.long	.LFE102-.LFB102
	.long	.LFB103
	.long	.LFE103-.LFB103
	.long	.LFB104
	.long	.LFE104-.LFB104
	.long	.LFB105
	.long	.LFE105-.LFB105
	.long	.LFB107
	.long	.LFE107-.LFB107
	.long	0
	.long	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.LBB43
	.long	.LBE43
	.long	.LBB56
	.long	.LBE56
	.long	.LBB64
	.long	.LBE64
	.long	0
	.long	0
	.long	.LBB52
	.long	.LBE52
	.long	.LBB55
	.long	.LBE55
	.long	0
	.long	0
	.long	.LBB79
	.long	.LBE79
	.long	.LBB84
	.long	.LBE84
	.long	0
	.long	0
	.long	.LBB80
	.long	.LBE80
	.long	.LBB83
	.long	.LBE83
	.long	0
	.long	0
	.long	.LBB85
	.long	.LBE85
	.long	.LBB88
	.long	.LBE88
	.long	0
	.long	0
	.long	.LFB94
	.long	.LFE94
	.long	.LFB97
	.long	.LFE97
	.long	.LFB99
	.long	.LFE99
	.long	.LFB98
	.long	.LFE98
	.long	.LFB100
	.long	.LFE100
	.long	.LFB101
	.long	.LFE101
	.long	.LFB102
	.long	.LFE102
	.long	.LFB103
	.long	.LFE103
	.long	.LFB104
	.long	.LFE104
	.long	.LFB105
	.long	.LFE105
	.long	.LFB107
	.long	.LFE107
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF75:
	.string	"CurrentParserState"
.LASF19:
	.string	"wIndex"
.LASF93:
	.string	"MediaReport"
.LASF79:
	.string	"RawBytes"
.LASF42:
	.string	"Usage"
.LASF112:
	.string	"BaudRate"
.LASF85:
	.string	"EVENT_USB_Device_ConfigurationChanged"
.LASF41:
	.string	"USB_ClassInfo_HID_Device_t"
.LASF54:
	.string	"PrevKeyboardHIDReportBuffer"
.LASF47:
	.string	"flags"
.LASF14:
	.string	"DEVICE_STATE_Configured"
.LASF66:
	.string	"currentMediaUsage"
.LASF37:
	.string	"IdleCount"
.LASF87:
	.string	"HIDInterfaceInfo"
.LASF4:
	.string	"unsigned int"
.LASF16:
	.string	"bmRequestType"
.LASF62:
	.string	"MEDIA_IDLE"
.LASF33:
	.string	"ReportINEndpointDoubleBank"
.LASF106:
	.string	"KeyboardQueue_Pop"
.LASF68:
	.string	"parserBuffer"
.LASF29:
	.string	"USB_KeyboardReport_Data_t"
.LASF125:
	.string	"Arduino-keyboard.c"
.LASF46:
	.string	"unget"
.LASF40:
	.string	"State"
.LASF107:
	.string	"Report"
.LASF97:
	.string	"ProcessIncomingSerialData"
.LASF124:
	.string	"GNU C99 7.3.0 -mn-flash=1 -mno-skip-bug -mmcu=avr35 -gdwarf-2 -Os -std=gnu99 -funsigned-char -funsigned-bitfields -ffunction-sections -fno-inline-small-functions -fpack-struct -fshort-enums -fno-strict-aliasing"
.LASF44:
	.string	"ATTR_PACKED"
.LASF18:
	.string	"wValue"
.LASF13:
	.string	"DEVICE_STATE_Addressed"
.LASF78:
	.string	"Keyboard"
.LASF131:
	.string	"USB_Device_EnableSOFEvents"
.LASF67:
	.string	"ledReport"
.LASF6:
	.string	"uint32_t"
.LASF108:
	.string	"KeyboardQueue_Push"
.LASF84:
	.string	"EVENT_USB_Device_UnhandledControlRequest"
.LASF126:
	.string	"/sdb1/My Job/Bluetooth-HID-Keyboard-ArduinoUnoR3/My-HID-Arduino-Keyboard/arduino-keyboard-0.3"
.LASF61:
	.string	"MediaTail"
.LASF73:
	.string	"STATE_PARSE_PAYLOAD"
.LASF9:
	.string	"long long unsigned int"
.LASF12:
	.string	"DEVICE_STATE_Default"
.LASF59:
	.string	"MediaQueue"
.LASF76:
	.string	"ActivePacketType"
.LASF90:
	.string	"ReportData"
.LASF121:
	.string	"USB_Init"
.LASF58:
	.string	"KeyboardTail"
.LASF39:
	.string	"Config"
.LASF101:
	.string	"mediaRaw"
.LASF88:
	.string	"ReportID"
.LASF120:
	.string	"HID_Device_ConfigureEndpoints"
.LASF63:
	.string	"MEDIA_SEND_RELEASE"
.LASF65:
	.string	"MediaState"
.LASF114:
	.string	"Serial_Init"
.LASF22:
	.string	"USB_ConfigurationNumber"
.LASF24:
	.string	"_Bool"
.LASF104:
	.string	"MediaQueue_Pop"
.LASF95:
	.string	"CALLBACK_HID_Device_CreateHIDReport"
.LASF60:
	.string	"MediaHead"
.LASF113:
	.string	"DoubleSpeed"
.LASF72:
	.string	"STATE_PARSE_HEADER"
.LASF102:
	.string	"count"
.LASF127:
	.string	"USB_Device_States_t"
.LASF57:
	.string	"KeyboardHead"
.LASF50:
	.string	"char"
.LASF35:
	.string	"PrevReportINBufferSize"
.LASF64:
	.string	"media_state_t"
.LASF2:
	.string	"uint8_t"
.LASF110:
	.string	"usage"
.LASF23:
	.string	"USB_IsInitialized"
.LASF74:
	.string	"parser_state_t"
.LASF91:
	.string	"ReportSize"
.LASF70:
	.string	"parserTail"
.LASF123:
	.string	"USB_USBTask"
.LASF8:
	.string	"long long int"
.LASF128:
	.string	"EVENT_USB_Device_Disconnect"
.LASF26:
	.string	"Modifier"
.LASF56:
	.string	"KeyboardQueue"
.LASF77:
	.string	"PayloadByteIndex"
.LASF86:
	.string	"CALLBACK_HID_Device_ProcessHIDReport"
.LASF116:
	.string	"__iRestore"
.LASF38:
	.string	"IdleMSRemaining"
.LASF119:
	.string	"HID_Device_ProcessControlRequest"
.LASF10:
	.string	"DEVICE_STATE_Unattached"
.LASF129:
	.string	"EVENT_USB_Device_Connect"
.LASF45:
	.string	"__file"
.LASF48:
	.string	"size"
.LASF122:
	.string	"HID_Device_USBTask"
.LASF118:
	.string	"temp_reg"
.LASF43:
	.string	"USB_MediaReport_Data_t"
.LASF99:
	.string	"sreg_save"
.LASF69:
	.string	"parserHead"
.LASF3:
	.string	"uint16_t"
.LASF28:
	.string	"KeyCode"
.LASF52:
	.string	"HID_KeyboardInterface"
.LASF98:
	.string	"IncomingByte"
.LASF51:
	.string	"__iob"
.LASF5:
	.string	"long int"
.LASF71:
	.string	"parserCount"
.LASF115:
	.string	"HID_Device_MillisecondElapsed"
.LASF11:
	.string	"DEVICE_STATE_Powered"
.LASF20:
	.string	"wLength"
.LASF80:
	.string	"CurrentFrameContext"
.LASF36:
	.string	"UsingReportProtocol"
.LASF53:
	.string	"HID_MediaInterface"
.LASF17:
	.string	"bRequest"
.LASF92:
	.string	"activeBufferFrame"
.LASF89:
	.string	"ReportType"
.LASF94:
	.string	"SetupHardware"
.LASF83:
	.string	"EVENT_USB_Device_StartOfFrame"
.LASF7:
	.string	"long unsigned int"
.LASF111:
	.string	"IsMediaUsage"
.LASF31:
	.string	"ReportINEndpointNumber"
.LASF25:
	.string	"USB_ControlRequest"
.LASF32:
	.string	"ReportINEndpointSize"
.LASF105:
	.string	"nextTail"
.LASF1:
	.string	"unsigned char"
.LASF15:
	.string	"DEVICE_STATE_Suspended"
.LASF30:
	.string	"InterfaceNumber"
.LASF55:
	.string	"PrevMediaHIDReportBuffer"
.LASF81:
	.string	"ReceivedByte"
.LASF0:
	.string	"signed char"
.LASF96:
	.string	"main"
.LASF21:
	.string	"USB_Request_Header_t"
.LASF27:
	.string	"Reserved"
.LASF34:
	.string	"PrevReportINBuffer"
.LASF132:
	.string	"__iCliRetVal"
.LASF100:
	.string	"__ToDo"
.LASF49:
	.string	"udata"
.LASF109:
	.string	"MapMediaUsage"
.LASF103:
	.string	"SafeGetParserCount"
.LASF117:
	.string	"wdt_disable"
.LASF82:
	.string	"__vector_23"
.LASF130:
	.string	"MediaQueue_Push"
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
