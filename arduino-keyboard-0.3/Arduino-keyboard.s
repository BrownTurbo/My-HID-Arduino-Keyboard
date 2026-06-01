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
.LFB98:
	.file 1 "Arduino-keyboard.c"
	.loc 1 216 0
	.cfi_startproc
.LVL0:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.LBB48:
.LBB49:
	.loc 1 212 0
	lds r18,MediaTail
	ldi r19,0
	movw r20,r18
	subi r20,-1
	sbci r21,-1
	andi r20,15
	clr r21
	lds r22,MediaHead
.LBE49:
.LBE48:
	.loc 1 217 0
	cp r22,r20
	cpc __zero_reg__,r21
	breq .L3
	.loc 1 220 0
	lsl r18
	rol r19
	movw r30,r18
	subi r30,lo8(-(MediaQueue))
	sbci r31,hi8(-(MediaQueue))
	std Z+1,r25
	st Z,r24
	.loc 1 221 0
	sts MediaTail,r20
	.loc 1 223 0
	ldi r24,lo8(1)
.LVL1:
	ret
.LVL2:
.L3:
	.loc 1 218 0
	ldi r24,0
.LVL3:
/* epilogue start */
	.loc 1 224 0
	ret
	.cfi_endproc
.LFE98:
	.size	MediaQueue_Push, .-MediaQueue_Push
	.section	.text.MediaQueue_Pop,"ax",@progbits
	.type	MediaQueue_Pop, @function
MediaQueue_Pop:
.LFB99:
	.loc 1 227 0
	.cfi_startproc
.LVL4:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.LBB52:
.LBB53:
	.loc 1 207 0
	lds r18,MediaHead
.LBE53:
.LBE52:
	.loc 1 228 0
	lds r19,MediaTail
	cp r18,r19
	breq .L6
	.loc 1 231 0
	ldi r19,0
	movw r30,r18
	lsl r30
	rol r31
	subi r30,lo8(-(MediaQueue))
	sbci r31,hi8(-(MediaQueue))
	ld r20,Z
	ldd r21,Z+1
	movw r30,r24
	std Z+1,r21
	st Z,r20
	.loc 1 233 0
	subi r18,-1
	sbci r19,-1
	andi r18,15
	clr r19
	sts MediaHead,r18
	.loc 1 235 0
	ldi r24,lo8(1)
.LVL5:
	ret
.LVL6:
.L6:
	.loc 1 229 0
	ldi r24,0
.LVL7:
/* epilogue start */
	.loc 1 236 0
	ret
	.cfi_endproc
.LFE99:
	.size	MediaQueue_Pop, .-MediaQueue_Pop
	.section	.text.RingBuffer_Remove.constprop.3,"ax",@progbits
	.type	RingBuffer_Remove.constprop.3, @function
RingBuffer_Remove.constprop.3:
.LFB117:
	.file 2 "Lib/LightweightRingBuff.h"
	.loc 2 182 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.LVL8:
	.loc 2 184 0
	lds r30,USARTtoUSB_Buffer+130
	lds r31,USARTtoUSB_Buffer+130+1
	ld r24,Z+
.LVL9:
	.loc 2 186 0
	ldi r25,hi8(USARTtoUSB_Buffer+128)
	cpi r30,lo8(USARTtoUSB_Buffer+128)
	cpc r31,r25
	breq .L8
	sts USARTtoUSB_Buffer+130+1,r31
	sts USARTtoUSB_Buffer+130,r30
.L9:
.LBB54:
	.loc 2 189 0
	in r18,__SREG__
.LVL10:
.LBB55:
.LBB56:
	.file 3 "/usr/lib/avr/include/util/atomic.h"
	.loc 3 50 0
/* #APP */
 ;  50 "/usr/lib/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
.LVL11:
/* #NOAPP */
.LBE56:
.LBE55:
	.loc 2 191 0
	lds r25,USARTtoUSB_Buffer+132
	subi r25,lo8(-(-1))
	sts USARTtoUSB_Buffer+132,r25
.LVL12:
.LBB57:
.LBB58:
	.loc 3 70 0
	out __SREG__,r18
	.loc 3 71 0
.LVL13:
/* epilogue start */
.LBE58:
.LBE57:
.LBE54:
	.loc 2 195 0
	ret
.LVL14:
.L8:
	.loc 2 187 0
	ldi r18,lo8(USARTtoUSB_Buffer)
	ldi r19,hi8(USARTtoUSB_Buffer)
	sts USARTtoUSB_Buffer+130+1,r19
	sts USARTtoUSB_Buffer+130,r18
	rjmp .L9
	.cfi_endproc
.LFE117:
	.size	RingBuffer_Remove.constprop.3, .-RingBuffer_Remove.constprop.3
	.section	.text.SetupHardware,"ax",@progbits
.global	SetupHardware
	.type	SetupHardware, @function
SetupHardware:
.LFB102:
	.loc 1 297 0
	.cfi_startproc
	push r10
.LCFI0:
	.cfi_def_cfa_offset 3
	.cfi_offset 10, -2
	push r11
.LCFI1:
	.cfi_def_cfa_offset 4
	.cfi_offset 11, -3
	push r13
.LCFI2:
	.cfi_def_cfa_offset 5
	.cfi_offset 13, -4
	push r14
.LCFI3:
	.cfi_def_cfa_offset 6
	.cfi_offset 14, -5
	push r15
.LCFI4:
	.cfi_def_cfa_offset 7
	.cfi_offset 15, -6
	push r16
.LCFI5:
	.cfi_def_cfa_offset 8
	.cfi_offset 16, -7
	push r17
.LCFI6:
	.cfi_def_cfa_offset 9
	.cfi_offset 17, -8
	push r28
.LCFI7:
	.cfi_def_cfa_offset 10
	.cfi_offset 28, -9
	push r29
.LCFI8:
	.cfi_def_cfa_offset 11
	.cfi_offset 29, -10
/* prologue: function */
/* frame size = 0 */
/* stack size = 9 */
.L__stack_usage = 9
	.loc 1 299 0
	in r24,0x34
	andi r24,lo8(-9)
	out 0x34,r24
.LBB63:
.LBB64:
	.file 4 "/usr/lib/avr/include/avr/wdt.h"
	.loc 4 515 0
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
.LVL15:
/* #NOAPP */
.LBE64:
.LBE63:
.LBB65:
.LBB66:
	.file 5 "./LUFA/Drivers/Peripheral/Serial.h"
	.loc 5 102 0
	ldi r24,lo8(-52)
	mov r10,r24
	mov r11,__zero_reg__
	ldi r24,lo8(103)
	ldi r25,0
	movw r30,r10
	std Z+1,r25
	st Z,r24
	.loc 5 104 0
	ldi r25,lo8(-54)
	mov r14,r25
	mov r15,__zero_reg__
	ldi r18,lo8(6)
	mov r13,r18
	movw r30,r14
	st Z,r13
	.loc 5 105 0
	ldi r16,lo8(-56)
	ldi r17,0
	movw r30,r16
	st Z,__zero_reg__
	.loc 5 106 0
	ldi r28,lo8(-55)
	ldi r29,0
	ldi r24,lo8(24)
	st Y,r24
	.loc 5 108 0
	sbi 0xa,3
	.loc 5 109 0
	sbi 0xb,2
.LVL16:
.LBE66:
.LBE65:
	.loc 1 304 0
	call USB_Init
.LVL17:
	.loc 1 307 0
	ldi r24,lo8(4)
	out 0x25,r24
	.loc 1 310 0
	sbi 0xb,7
	.loc 1 311 0
	sbi 0xa,7
	.loc 1 314 0
	st Y,__zero_reg__
	.loc 1 315 0
	movw r30,r16
	st Z,__zero_reg__
	.loc 1 316 0
	movw r30,r14
	st Z,__zero_reg__
	.loc 1 319 0
	ldi r24,lo8(-49)
	ldi r25,0
	movw r30,r10
	std Z+1,r25
	st Z,r24
	.loc 1 321 0
	movw r30,r14
	st Z,r13
	.loc 1 322 0
	ldi r24,lo8(2)
	movw r30,r16
	st Z,r24
	.loc 1 323 0
	ldi r24,lo8(-104)
	st Y,r24
/* epilogue start */
	.loc 1 324 0
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
.LFE102:
	.size	SetupHardware, .-SetupHardware
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
.LFB101:
	.loc 1 276 0
	.cfi_startproc
	push r28
.LCFI9:
	.cfi_def_cfa_offset 3
	.cfi_offset 28, -2
	push r29
.LCFI10:
	.cfi_def_cfa_offset 4
	.cfi_offset 29, -3
	rcall .
.LCFI11:
	.cfi_def_cfa_offset 6
	in r28,__SP_L__
	in r29,__SP_H__
.LCFI12:
	.cfi_def_cfa_register 28
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	.loc 1 277 0
	call SetupHardware
.LVL18:
.LBB98:
.LBB99:
	.loc 2 87 0
	in r18,__SREG__
.LVL19:
.LBB100:
.LBB101:
	.loc 3 50 0
/* #APP */
 ;  50 "/usr/lib/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
.LVL20:
/* #NOAPP */
.LBE101:
.LBE100:
	.loc 2 89 0
	ldi r24,lo8(USARTtoUSB_Buffer)
	ldi r25,hi8(USARTtoUSB_Buffer)
	sts USARTtoUSB_Buffer+128+1,r25
	sts USARTtoUSB_Buffer+128,r24
	.loc 2 90 0
	sts USARTtoUSB_Buffer+130+1,r25
	sts USARTtoUSB_Buffer+130,r24
.LVL21:
.LBB102:
.LBB103:
	.loc 3 70 0
	out __SREG__,r18
	.loc 3 71 0
.LVL22:
.LBE103:
.LBE102:
.LBE99:
.LBE98:
	.loc 1 281 0
/* #APP */
 ;  281 "Arduino-keyboard.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
.LBB104:
.LBB105:
	.loc 1 268 0
	ldi r16,lo8(keyboardData)
	ldi r17,hi8(keyboardData)
	ldi r25,lo8(8)
	mov r15,r25
.LVL23:
.L22:
.LBB106:
.LBB107:
.LBB108:
	.loc 2 111 0 discriminator 1
	in r25,__SREG__
.LVL24:
.LBB109:
.LBB110:
	.loc 3 50 0 discriminator 1
/* #APP */
 ;  50 "/usr/lib/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
.LVL25:
/* #NOAPP */
.LBE110:
.LBE109:
	.loc 2 113 0 discriminator 1
	lds r24,USARTtoUSB_Buffer+132
.LVL26:
.LBB111:
.LBB112:
	.loc 3 70 0 discriminator 1
	out __SREG__,r25
	.loc 3 71 0 discriminator 1
.LVL27:
.LBE112:
.LBE111:
.LBE108:
.LBE107:
.LBE106:
	.loc 1 242 0 discriminator 1
	cpi r24,lo8(8)
	brsh .L12
	.loc 1 243 0
	lds r24,partial_wait.3143
	subi r24,lo8(-(1))
	sts partial_wait.3143,r24
	.loc 1 244 0
	cpi r24,lo8(-55)
	brsh .L13
.LVL28:
.L14:
.LBE105:
.LBE104:
	.loc 1 288 0 discriminator 1
	ldi r24,lo8(HID_KeyboardInterface)
	ldi r25,hi8(HID_KeyboardInterface)
	call HID_Device_USBTask
.LVL29:
	.loc 1 289 0 discriminator 1
	ldi r24,lo8(HID_MediaInterface)
	ldi r25,hi8(HID_MediaInterface)
	call HID_Device_USBTask
.LVL30:
	.loc 1 291 0 discriminator 1
	call USB_USBTask
.LVL31:
	rjmp .L22
.LVL32:
.L15:
.LBB129:
.LBB128:
	.loc 1 247 0
	call RingBuffer_Remove.constprop.3
.LVL33:
.L13:
.LBB113:
.LBB114:
.LBB115:
	.loc 2 111 0
	in r25,__SREG__
.LVL34:
.LBB116:
.LBB117:
	.loc 3 50 0
/* #APP */
 ;  50 "/usr/lib/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
.LVL35:
/* #NOAPP */
.LBE117:
.LBE116:
	.loc 2 113 0
	lds r24,USARTtoUSB_Buffer+132
.LVL36:
.LBB118:
.LBB119:
	.loc 3 70 0
	out __SREG__,r25
	.loc 3 71 0
.LVL37:
.LBE119:
.LBE118:
.LBE115:
.LBE114:
.LBE113:
	.loc 1 246 0
	cpse r24,__zero_reg__
	rjmp .L15
	.loc 1 248 0
	sts partial_wait.3143,__zero_reg__
	rjmp .L14
.LVL38:
.L12:
	.loc 1 252 0
	sts partial_wait.3143,__zero_reg__
.LVL39:
	ldi r24,lo8(keyboardData)
	mov r12,r24
	ldi r24,hi8(keyboardData)
	mov r13,r24
.LVL40:
.L16:
.LBB120:
	.loc 1 255 0
	call RingBuffer_Remove.constprop.3
.LVL41:
	movw r30,r12
	st Z+,r24
	movw r12,r30
.LVL42:
	.loc 1 254 0
	ldi r31,lo8(keyboardData+8)
	cp r12,r31
	ldi r31,hi8(keyboardData+8)
	cpc r13,r31
	brne .L16
.LBE120:
	.loc 1 259 0
	lds r24,keyboardData+2
.LVL43:
.LBB121:
.LBB122:
	.loc 1 148 0
	ldi r25,lo8(23)
	add r25,r24
	.loc 1 153 0
	cpi r25,lo8(2)
	brlo .L25
	.loc 1 149 0
	cpi r24,lo8(-30)
	breq .L25
	.loc 1 150 0
	cpi r24,lo8(-51)
	breq .L25
	.loc 1 151 0
	ldi r25,lo8(75)
	add r25,r24
	ldi r24,lo8(1)
.LVL44:
	cpi r25,lo8(3)
	brlo .L17
	ldi r24,0
.L17:
.LVL45:
.LBE122:
.LBE121:
	.loc 1 259 0
	sbrs r24,0
	rjmp .L14
.LBB124:
.LBB125:
	.loc 1 212 0
	lds r24,MediaTail
	ldi r25,0
	adiw r24,1
	andi r24,15
	clr r25
	lds r18,MediaHead
.LBE125:
.LBE124:
	.loc 1 261 0
	cp r18,r24
	cpc __zero_reg__,r25
	brne .L20
.LBB126:
	.loc 1 264 0
	movw r24,r28
	adiw r24,1
	call MediaQueue_Pop
.LVL46:
.L20:
	lds r30,keyboardData+2
	subi r30,lo8(-(75))
.LBE126:
	.loc 1 266 0
	ldi r25,0
	ldi r24,0
	cpi r30,lo8(54)
	brsh .L21
	ldi r31,0
	subi r30,lo8(-(CSWTCH.79))
	sbci r31,hi8(-(CSWTCH.79))
	ld r24,Z
	ldi r25,0
.L21:
.LVL47:
	call MediaQueue_Push
.LVL48:
	.loc 1 268 0
	movw r30,r16
	mov r24,r15
	0:
	st Z+,__zero_reg__
	dec r24
	brne 0b
	rjmp .L14
.LVL49:
.L25:
.LBB127:
.LBB123:
	.loc 1 153 0
	ldi r24,lo8(1)
.LVL50:
	rjmp .L17
.LBE123:
.LBE127:
.LBE128:
.LBE129:
	.cfi_endproc
.LFE101:
	.size	main, .-main
	.section	.text.EVENT_USB_Device_Connect,"ax",@progbits
.global	EVENT_USB_Device_Connect
	.type	EVENT_USB_Device_Connect, @function
EVENT_USB_Device_Connect:
.LFB103:
	.loc 1 328 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* epilogue start */
	.loc 1 330 0
	ret
	.cfi_endproc
.LFE103:
	.size	EVENT_USB_Device_Connect, .-EVENT_USB_Device_Connect
	.section	.text.EVENT_USB_Device_Disconnect,"ax",@progbits
.global	EVENT_USB_Device_Disconnect
	.type	EVENT_USB_Device_Disconnect, @function
EVENT_USB_Device_Disconnect:
.LFB114:
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* epilogue start */
	ret
	.cfi_endproc
.LFE114:
	.size	EVENT_USB_Device_Disconnect, .-EVENT_USB_Device_Disconnect
	.section	.text.EVENT_USB_Device_ConfigurationChanged,"ax",@progbits
.global	EVENT_USB_Device_ConfigurationChanged
	.type	EVENT_USB_Device_ConfigurationChanged, @function
EVENT_USB_Device_ConfigurationChanged:
.LFB105:
	.loc 1 340 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 341 0
	ldi r24,lo8(HID_KeyboardInterface)
	ldi r25,hi8(HID_KeyboardInterface)
	call HID_Device_ConfigureEndpoints
.LVL51:
	.loc 1 342 0
	ldi r24,lo8(HID_MediaInterface)
	ldi r25,hi8(HID_MediaInterface)
	call HID_Device_ConfigureEndpoints
.LVL52:
.LBB130:
.LBB131:
	.file 6 "./LUFA/Drivers/USB/HighLevel/../LowLevel/Device.h"
	.loc 6 150 0
	ldi r30,lo8(-30)
	ldi r31,0
	ld r24,Z
	ori r24,lo8(4)
	st Z,r24
/* epilogue start */
.LBE131:
.LBE130:
	.loc 1 345 0
	ret
	.cfi_endproc
.LFE105:
	.size	EVENT_USB_Device_ConfigurationChanged, .-EVENT_USB_Device_ConfigurationChanged
	.section	.text.EVENT_USB_Device_UnhandledControlRequest,"ax",@progbits
.global	EVENT_USB_Device_UnhandledControlRequest
	.type	EVENT_USB_Device_UnhandledControlRequest, @function
EVENT_USB_Device_UnhandledControlRequest:
.LFB106:
	.loc 1 349 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.loc 1 350 0
	ldi r24,lo8(HID_KeyboardInterface)
	ldi r25,hi8(HID_KeyboardInterface)
	call HID_Device_ProcessControlRequest
.LVL53:
	.loc 1 351 0
	ldi r24,lo8(HID_MediaInterface)
	ldi r25,hi8(HID_MediaInterface)
	jmp HID_Device_ProcessControlRequest
.LVL54:
	.cfi_endproc
.LFE106:
	.size	EVENT_USB_Device_UnhandledControlRequest, .-EVENT_USB_Device_UnhandledControlRequest
	.section	.text.EVENT_USB_Device_StartOfFrame,"ax",@progbits
.global	EVENT_USB_Device_StartOfFrame
	.type	EVENT_USB_Device_StartOfFrame, @function
EVENT_USB_Device_StartOfFrame:
.LFB107:
	.loc 1 356 0
	.cfi_startproc
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.LVL55:
.LBB132:
.LBB133:
	.file 7 "./LUFA/Drivers/USB/Class/Device/HID.h"
	.loc 7 201 0
	lds r24,HID_KeyboardInterface+11
	lds r25,HID_KeyboardInterface+11+1
	sbiw r24,0
	breq .L37
	.loc 7 202 0
	sbiw r24,1
	sts HID_KeyboardInterface+11+1,r25
	sts HID_KeyboardInterface+11,r24
.L37:
.LVL56:
.LBE133:
.LBE132:
.LBB134:
.LBB135:
	.loc 7 201 0
	lds r24,HID_MediaInterface+11
	lds r25,HID_MediaInterface+11+1
	sbiw r24,0
	breq .L36
	.loc 7 202 0
	sbiw r24,1
	sts HID_MediaInterface+11+1,r25
	sts HID_MediaInterface+11,r24
.LVL57:
.L36:
/* epilogue start */
.LBE135:
.LBE134:
	.loc 1 359 0
	ret
	.cfi_endproc
.LFE107:
	.size	EVENT_USB_Device_StartOfFrame, .-EVENT_USB_Device_StartOfFrame
	.section	.text.CALLBACK_HID_Device_CreateHIDReport,"ax",@progbits
.global	CALLBACK_HID_Device_CreateHIDReport
	.type	CALLBACK_HID_Device_CreateHIDReport, @function
CALLBACK_HID_Device_CreateHIDReport:
.LFB108:
	.loc 1 378 0
	.cfi_startproc
.LVL58:
	push r14
.LCFI13:
	.cfi_def_cfa_offset 3
	.cfi_offset 14, -2
	push r15
.LCFI14:
	.cfi_def_cfa_offset 4
	.cfi_offset 15, -3
	push r16
.LCFI15:
	.cfi_def_cfa_offset 5
	.cfi_offset 16, -4
	push r17
.LCFI16:
	.cfi_def_cfa_offset 6
	.cfi_offset 17, -5
	push r28
.LCFI17:
	.cfi_def_cfa_offset 7
	.cfi_offset 28, -6
	push r29
.LCFI18:
	.cfi_def_cfa_offset 8
	.cfi_offset 29, -7
	rcall .
.LCFI19:
	.cfi_def_cfa_offset 10
	in r28,__SP_L__
	in r29,__SP_H__
.LCFI20:
	.cfi_def_cfa_register 28
/* prologue: function */
/* frame size = 2 */
/* stack size = 8 */
.L__stack_usage = 8
	movw r30,r16
	.loc 1 379 0
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	.loc 1 384 0
	ldi r20,hi8(HID_KeyboardInterface)
	cpi r24,lo8(HID_KeyboardInterface)
	cpc r25,r20
.LVL59:
	brne .L46
.LVL60:
.LBB142:
.LBB143:
.LBB144:
.LBB145:
.LBB146:
	.loc 1 174 0
	lds r24,KeyboardHead
.LVL61:
.LBE146:
.LBE145:
	.loc 1 195 0
	lds r25,KeyboardTail
	cpse r24,r25
	rjmp .L47
.LVL62:
.L50:
.LBE144:
.LBE143:
.LBE142:
	.loc 1 425 0
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	.loc 1 426 0
	rjmp .L49
.LVL63:
.L47:
.LBB149:
.LBB148:
.LBB147:
	.loc 1 198 0
	ldi r25,0
	movw r26,r24
	lsl r26
	rol r27
	subi r26,lo8(-(KeyboardQueue))
	sbci r27,hi8(-(KeyboardQueue))
	ld r20,X+
	ld r21,X
.LVL64:
	.loc 1 200 0
	adiw r24,1
	andi r24,7
	clr r25
	sts KeyboardHead,r24
.LVL65:
.LBE147:
.LBE148:
	.loc 1 390 0
	movw r26,r18
	st X+,r20
	st X,r21
	.loc 1 391 0
	ldi r24,lo8(8)
	ldi r25,0
.LVL66:
.L55:
.LBE149:
.LBB150:
	.loc 1 421 0
	std Z+1,r25
	st Z,r24
.L49:
.LBE150:
	.loc 1 427 0 discriminator 1
	ldi r24,0
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
.LVL67:
	pop r15
	pop r14
	ret
.LVL68:
.L46:
	.loc 1 402 0
	subi r24,lo8(HID_MediaInterface)
	sbci r25,hi8(HID_MediaInterface)
	brne .L50
	movw r14,r18
.LVL69:
.LBB151:
	.loc 1 405 0
	movw r30,r18
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	.loc 1 407 0
	lds r24,MediaState
.LVL70:
	cpse r24,__zero_reg__
	rjmp .L51
.LVL71:
	.loc 1 409 0
	movw r24,r28
	adiw r24,1
	call MediaQueue_Pop
.LVL72:
	tst r24
	breq .L53
	.loc 1 411 0
	ldd r24,Y+1
	ldd r25,Y+2
	movw r26,r14
	st X+,r24
	st X,r25
	.loc 1 412 0
	ldi r24,lo8(1)
	sts MediaState,r24
.L53:
	.loc 1 421 0
	ldi r24,lo8(2)
	ldi r25,0
	movw r30,r16
	rjmp .L55
.LVL73:
.L51:
	.loc 1 415 0
	cpi r24,lo8(1)
	brne .L53
	.loc 1 418 0
	sts MediaState,__zero_reg__
	rjmp .L53
.LBE151:
	.cfi_endproc
.LFE108:
	.size	CALLBACK_HID_Device_CreateHIDReport, .-CALLBACK_HID_Device_CreateHIDReport
	.section	.text.CALLBACK_HID_Device_ProcessHIDReport,"ax",@progbits
.global	CALLBACK_HID_Device_ProcessHIDReport
	.type	CALLBACK_HID_Device_ProcessHIDReport, @function
CALLBACK_HID_Device_ProcessHIDReport:
.LFB109:
	.loc 1 443 0
	.cfi_startproc
.LVL74:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* epilogue start */
	.loc 1 443 0
	ret
	.cfi_endproc
.LFE109:
	.size	CALLBACK_HID_Device_ProcessHIDReport, .-CALLBACK_HID_Device_ProcessHIDReport
	.section	.text.__vector_23,"ax",@progbits
.global	__vector_23
	.type	__vector_23, @function
__vector_23:
.LFB110:
	.loc 1 456 0
	.cfi_startproc
	push r1
.LCFI21:
	.cfi_def_cfa_offset 3
	.cfi_offset 1, -2
	push r0
.LCFI22:
	.cfi_def_cfa_offset 4
	.cfi_offset 0, -3
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r14
.LCFI23:
	.cfi_def_cfa_offset 5
	.cfi_offset 14, -4
	push r15
.LCFI24:
	.cfi_def_cfa_offset 6
	.cfi_offset 15, -5
	push r16
.LCFI25:
	.cfi_def_cfa_offset 7
	.cfi_offset 16, -6
	push r17
.LCFI26:
	.cfi_def_cfa_offset 8
	.cfi_offset 17, -7
	push r18
.LCFI27:
	.cfi_def_cfa_offset 9
	.cfi_offset 18, -8
	push r19
.LCFI28:
	.cfi_def_cfa_offset 10
	.cfi_offset 19, -9
	push r20
.LCFI29:
	.cfi_def_cfa_offset 11
	.cfi_offset 20, -10
	push r21
.LCFI30:
	.cfi_def_cfa_offset 12
	.cfi_offset 21, -11
	push r22
.LCFI31:
	.cfi_def_cfa_offset 13
	.cfi_offset 22, -12
	push r23
.LCFI32:
	.cfi_def_cfa_offset 14
	.cfi_offset 23, -13
	push r24
.LCFI33:
	.cfi_def_cfa_offset 15
	.cfi_offset 24, -14
	push r25
.LCFI34:
	.cfi_def_cfa_offset 16
	.cfi_offset 25, -15
	push r26
.LCFI35:
	.cfi_def_cfa_offset 17
	.cfi_offset 26, -16
	push r27
.LCFI36:
	.cfi_def_cfa_offset 18
	.cfi_offset 27, -17
	push r30
.LCFI37:
	.cfi_def_cfa_offset 19
	.cfi_offset 30, -18
	push r31
.LCFI38:
	.cfi_def_cfa_offset 20
	.cfi_offset 31, -19
	push r28
.LCFI39:
	.cfi_def_cfa_offset 21
	.cfi_offset 28, -20
	push r29
.LCFI40:
	.cfi_def_cfa_offset 22
	.cfi_offset 29, -21
	in r28,__SP_L__
	in r29,__SP_H__
.LCFI41:
	.cfi_def_cfa_register 28
	sbiw r28,8
.LCFI42:
	.cfi_def_cfa_offset 30
	out __SP_H__,r29
	out __SP_L__,r28
/* prologue: Signal */
/* frame size = 8 */
/* stack size = 29 */
.L__stack_usage = 29
	.loc 1 457 0
	lds r19,206
.LVL75:
	.loc 1 459 0
	in r24,0x1e
	cpi r24,lo8(4)
	brne .L57
	.loc 1 463 0
	lds r18,parserCount
	cpi r18,lo8(32)
	brsh .L59
	.loc 1 465 0
	lds r24,parserHead
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(parserBuffer))
	sbci r31,hi8(-(parserBuffer))
	st Z,r19
	.loc 1 466 0
	adiw r24,1
	andi r24,31
	clr r25
	sts parserHead,r24
	.loc 1 467 0
	subi r18,lo8(-(1))
	sts parserCount,r18
.L59:
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	movw r14,r28
	ldi r24,9
	add r14,r24
	adc r15,__zero_reg__
.LVL76:
.L60:
	.loc 1 471 0
	lds r25,parserCount
	cpi r25,lo8(9)
	brsh .L67
.L57:
/* epilogue start */
	.loc 1 534 0
	adiw r28,8
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r17
	pop r16
	pop r15
	pop r14
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
.L67:
.LBB161:
	.loc 1 473 0
	lds r18,parserTail
	ldi r19,0
	movw r30,r18
	subi r30,lo8(-(parserBuffer))
	sbci r31,hi8(-(parserBuffer))
	ld r24,Z
.LVL77:
	subi r18,-1
	sbci r19,-1
	andi r18,31
	clr r19
	.loc 1 475 0
	cpi r24,lo8(1)
	breq .+2
	rjmp .L61
.LBB162:
	.loc 1 483 0
	movw r30,r18
	subi r30,lo8(-(parserBuffer))
	sbci r31,hi8(-(parserBuffer))
	ld r24,Z
.LVL78:
	std Y+1,r24
	.loc 1 484 0
	subi r18,-1
	sbci r19,-1
	andi r18,31
	clr r19
	.loc 1 487 0
	movw r30,r18
	subi r30,lo8(-(parserBuffer))
	sbci r31,hi8(-(parserBuffer))
	ld r24,Z
	std Y+2,r24
	.loc 1 488 0
	subi r18,-1
	sbci r19,-1
	andi r18,lo8(31)
.LVL79:
	movw r30,r28
	adiw r30,3
.LVL80:
.L62:
.LBB163:
	.loc 1 493 0 discriminator 3
	ldi r19,0
	movw r26,r18
	subi r26,lo8(-(parserBuffer))
	sbci r27,hi8(-(parserBuffer))
	ld r24,X
	st Z+,r24
	.loc 1 494 0 discriminator 3
	subi r18,-1
	sbci r19,-1
	movw r20,r18
	andi r20,31
	clr r21
	mov r18,r20
	.loc 1 491 0 discriminator 3
	cp r14,r30
	cpc r15,r31
	brne .L62
	sts parserTail,r20
	subi r25,lo8(-(-9))
	sts parserCount,r25
.LBE163:
.LBB164:
.LBB165:
.LBB166:
.LBB167:
	.loc 1 179 0
	lds r24,KeyboardTail
	ldi r25,0
	movw r18,r24
	subi r18,-1
	sbci r19,-1
	andi r18,7
	clr r19
	lds r20,KeyboardHead
.LBE167:
.LBE166:
	.loc 1 184 0
	cp r20,r18
	cpc __zero_reg__,r19
	brne .+2
	rjmp .L60
	.loc 1 187 0
	lsl r24
	rol r25
	movw r30,r24
	subi r30,lo8(-(KeyboardQueue))
	sbci r31,hi8(-(KeyboardQueue))
	std Z+1,r17
	st Z,r16
	.loc 1 188 0
	sts KeyboardTail,r18
	rjmp .L60
.LVL81:
.L61:
.LBE165:
.LBE164:
.LBE162:
	.loc 1 501 0
	cpi r24,lo8(2)
	brne .L65
.LVL82:
.LBB168:
	.loc 1 508 0
	movw r20,r18
	subi r20,-1
	sbci r21,-1
	andi r20,31
	clr r21
.LVL83:
	.loc 1 512 0
	movw r22,r20
	subi r22,-1
	sbci r23,-1
	andi r22,lo8(31)
	.loc 1 511 0
	subi r20,lo8(-(parserBuffer))
	sbci r21,hi8(-(parserBuffer))
.LVL84:
	.loc 1 515 0
	movw r30,r20
	ld r20,Z
.LVL85:
	.loc 1 507 0
	subi r18,lo8(-(parserBuffer))
	sbci r19,hi8(-(parserBuffer))
.LVL86:
	.loc 1 515 0
	movw r30,r18
	ld r24,Z
.LVL87:
	mov r21,r20
	mov r20,r24
.LVL88:
	ldi r30,lo8(6)
	ldi r31,0
.LVL89:
.L66:
.LBB169:
	.loc 1 520 0 discriminator 3
	mov r18,r22
	ldi r19,0
	subi r18,-1
	sbci r19,-1
	andi r18,31
	clr r19
	mov r22,r18
.LVL90:
	sbiw r30,1
.LVL91:
	.loc 1 518 0 discriminator 3
	brne .L66
	sts parserTail,r18
	subi r25,lo8(-(-9))
	sts parserCount,r25
.LBE169:
	.loc 1 525 0
	movw r24,r20
	call MediaQueue_Push
.LVL92:
.LBE168:
	rjmp .L60
.LVL93:
.L65:
	.loc 1 530 0
	sts parserTail,r18
	.loc 1 531 0
	subi r25,lo8(-(-1))
	sts parserCount,r25
	rjmp .L60
.LBE161:
	.cfi_endproc
.LFE110:
	.size	__vector_23, .-__vector_23
	.section	.rodata
	.type	CSWTCH.79, @object
	.size	CSWTCH.79, 54
CSWTCH.79:
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
	.local	partial_wait.3143
	.comm	partial_wait.3143,1,1
	.local	parserCount
	.comm	parserCount,1,1
	.local	parserTail
	.comm	parserTail,1,1
	.local	parserHead
	.comm	parserHead,1,1
	.local	parserBuffer
	.comm	parserBuffer,32,1
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
	.comm	KeyboardQueue,16,1
	.local	keyboardData
	.comm	keyboardData,8,1
	.comm	USARTtoUSB_Buffer,133,1
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
	.file 8 "/usr/lib/avr/include/stdint.h"
	.file 9 "./LUFA/Drivers/USB/HighLevel/../LowLevel/../HighLevel/StdRequestType.h"
	.file 10 "./LUFA/Drivers/USB/HighLevel/../LowLevel/../HighLevel/DeviceStandardReq.h"
	.file 11 "./LUFA/Drivers/USB/HighLevel/USBTask.h"
	.file 12 "./LUFA/Drivers/USB/Class/Device/../Common/HID.h"
	.file 13 "Descriptors.h"
	.file 14 "/usr/lib/avr/include/stdio.h"
	.file 15 "Arduino-keyboard.h"
	.file 16 "./LUFA/Drivers/USB/HighLevel/../LowLevel/USBController.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xfa0
	.word	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF131
	.byte	0xc
	.long	.LASF132
	.long	.LASF133
	.long	.Ldebug_ranges0+0x78
	.long	0
	.long	0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF0
	.uleb128 0x3
	.long	.LASF2
	.byte	0x8
	.byte	0x7e
	.long	0x40
	.uleb128 0x4
	.long	0x30
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x5
	.byte	0x2
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.long	.LASF3
	.byte	0x8
	.byte	0x80
	.long	0x5e
	.uleb128 0x4
	.long	0x4e
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
	.byte	0x8
	.byte	0x82
	.long	0x7c
	.uleb128 0x4
	.long	0x6c
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
	.uleb128 0x6
	.long	.LASF134
	.byte	0x7
	.byte	0x1
	.long	0x40
	.byte	0x6
	.byte	0x72
	.long	0xc7
	.uleb128 0x7
	.long	.LASF10
	.byte	0
	.uleb128 0x7
	.long	.LASF11
	.byte	0x1
	.uleb128 0x7
	.long	.LASF12
	.byte	0x2
	.uleb128 0x7
	.long	.LASF13
	.byte	0x3
	.uleb128 0x7
	.long	.LASF14
	.byte	0x4
	.uleb128 0x7
	.long	.LASF15
	.byte	0x5
	.byte	0
	.uleb128 0x8
	.byte	0x8
	.byte	0x9
	.byte	0xa2
	.long	0x116
	.uleb128 0x9
	.long	.LASF16
	.byte	0x9
	.byte	0xa4
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x9
	.long	.LASF17
	.byte	0x9
	.byte	0xa5
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0x9
	.long	.LASF18
	.byte	0x9
	.byte	0xa6
	.long	0x4e
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x9
	.long	.LASF19
	.byte	0x9
	.byte	0xa7
	.long	0x4e
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x9
	.long	.LASF20
	.byte	0x9
	.byte	0xa8
	.long	0x4e
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.byte	0
	.uleb128 0x3
	.long	.LASF21
	.byte	0x9
	.byte	0xa9
	.long	0xc7
	.uleb128 0xa
	.long	.LASF22
	.byte	0xa
	.byte	0x64
	.long	0x30
	.byte	0x1
	.byte	0x1
	.uleb128 0xa
	.long	.LASF23
	.byte	0xb
	.byte	0x53
	.long	0x142
	.byte	0x1
	.byte	0x1
	.uleb128 0x2
	.byte	0x1
	.byte	0x2
	.long	.LASF24
	.uleb128 0xb
	.long	0x13b
	.uleb128 0x4
	.long	0x13b
	.uleb128 0xa
	.long	.LASF25
	.byte	0xb
	.byte	0x5b
	.long	0x116
	.byte	0x1
	.byte	0x1
	.uleb128 0xc
	.byte	0x2
	.uleb128 0x8
	.byte	0x8
	.byte	0xc
	.byte	0xb5
	.long	0x18e
	.uleb128 0x9
	.long	.LASF26
	.byte	0xc
	.byte	0xb7
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x9
	.long	.LASF27
	.byte	0xc
	.byte	0xba
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0x9
	.long	.LASF28
	.byte	0xc
	.byte	0xbb
	.long	0x18e
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0
	.uleb128 0xd
	.long	0x30
	.long	0x19e
	.uleb128 0xe
	.long	0x5e
	.byte	0x5
	.byte	0
	.uleb128 0x3
	.long	.LASF29
	.byte	0xc
	.byte	0xbc
	.long	0x15b
	.uleb128 0x8
	.byte	0x8
	.byte	0x7
	.byte	0x56
	.long	0x206
	.uleb128 0x9
	.long	.LASF30
	.byte	0x7
	.byte	0x58
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x9
	.long	.LASF31
	.byte	0x7
	.byte	0x5a
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0x9
	.long	.LASF32
	.byte	0x7
	.byte	0x5b
	.long	0x4e
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x9
	.long	.LASF33
	.byte	0x7
	.byte	0x5c
	.long	0x13b
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x9
	.long	.LASF34
	.byte	0x7
	.byte	0x5e
	.long	0x159
	.byte	0x2
	.byte	0x23
	.uleb128 0x5
	.uleb128 0x9
	.long	.LASF35
	.byte	0x7
	.byte	0x6a
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x7
	.byte	0
	.uleb128 0x4
	.long	0x1a9
	.uleb128 0x8
	.byte	0x5
	.byte	0x7
	.byte	0x73
	.long	0x23e
	.uleb128 0x9
	.long	.LASF36
	.byte	0x7
	.byte	0x75
	.long	0x13b
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x9
	.long	.LASF37
	.byte	0x7
	.byte	0x76
	.long	0x4e
	.byte	0x2
	.byte	0x23
	.uleb128 0x1
	.uleb128 0x9
	.long	.LASF38
	.byte	0x7
	.byte	0x77
	.long	0x4e
	.byte	0x2
	.byte	0x23
	.uleb128 0x3
	.byte	0
	.uleb128 0x8
	.byte	0xd
	.byte	0x7
	.byte	0x54
	.long	0x263
	.uleb128 0x9
	.long	.LASF39
	.byte	0x7
	.byte	0x70
	.long	0x206
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x9
	.long	.LASF40
	.byte	0x7
	.byte	0x79
	.long	0x20b
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0
	.uleb128 0x3
	.long	.LASF41
	.byte	0x7
	.byte	0x7c
	.long	0x23e
	.uleb128 0xf
	.long	.LASF47
	.byte	0x2
	.byte	0xd
	.byte	0x32
	.long	0x289
	.uleb128 0x9
	.long	.LASF42
	.byte	0xd
	.byte	0x34
	.long	0x4e
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.byte	0
	.uleb128 0x3
	.long	.LASF43
	.byte	0xd
	.byte	0x35
	.long	0x26e
	.uleb128 0x8
	.byte	0x85
	.byte	0x2
	.byte	0x46
	.long	0x2d7
	.uleb128 0x9
	.long	.LASF44
	.byte	0x2
	.byte	0x48
	.long	0x2d7
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x10
	.string	"In"
	.byte	0x2
	.byte	0x49
	.long	0x2e7
	.byte	0x3
	.byte	0x23
	.uleb128 0x80
	.uleb128 0x10
	.string	"Out"
	.byte	0x2
	.byte	0x4a
	.long	0x2e7
	.byte	0x3
	.byte	0x23
	.uleb128 0x82
	.uleb128 0x9
	.long	.LASF45
	.byte	0x2
	.byte	0x4b
	.long	0x30
	.byte	0x3
	.byte	0x23
	.uleb128 0x84
	.byte	0
	.uleb128 0xd
	.long	0x30
	.long	0x2e7
	.uleb128 0xe
	.long	0x5e
	.byte	0x7f
	.byte	0
	.uleb128 0x11
	.byte	0x2
	.long	0x30
	.uleb128 0x4
	.long	0x2e7
	.uleb128 0x3
	.long	.LASF46
	.byte	0x2
	.byte	0x4c
	.long	0x294
	.uleb128 0xf
	.long	.LASF48
	.byte	0xe
	.byte	0xe
	.byte	0xf4
	.long	0x37f
	.uleb128 0x10
	.string	"buf"
	.byte	0xe
	.byte	0xf5
	.long	0x37f
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x9
	.long	.LASF49
	.byte	0xe
	.byte	0xf6
	.long	0x40
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x9
	.long	.LASF50
	.byte	0xe
	.byte	0xf7
	.long	0x30
	.byte	0x2
	.byte	0x23
	.uleb128 0x3
	.uleb128 0x12
	.long	.LASF51
	.byte	0xe
	.word	0x107
	.long	0x47
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x13
	.string	"len"
	.byte	0xe
	.word	0x108
	.long	0x47
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0x13
	.string	"put"
	.byte	0xe
	.word	0x109
	.long	0x3a7
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x13
	.string	"get"
	.byte	0xe
	.word	0x10a
	.long	0x3bd
	.byte	0x2
	.byte	0x23
	.uleb128 0xa
	.uleb128 0x12
	.long	.LASF52
	.byte	0xe
	.word	0x10b
	.long	0x159
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.byte	0
	.uleb128 0x11
	.byte	0x2
	.long	0x385
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF53
	.uleb128 0x14
	.byte	0x1
	.long	0x47
	.long	0x3a1
	.uleb128 0x15
	.long	0x385
	.uleb128 0x15
	.long	0x3a1
	.byte	0
	.uleb128 0x11
	.byte	0x2
	.long	0x2fd
	.uleb128 0x11
	.byte	0x2
	.long	0x38c
	.uleb128 0x14
	.byte	0x1
	.long	0x47
	.long	0x3bd
	.uleb128 0x15
	.long	0x3a1
	.byte	0
	.uleb128 0x11
	.byte	0x2
	.long	0x3ad
	.uleb128 0xd
	.long	0x3a1
	.long	0x3ce
	.uleb128 0x16
	.byte	0
	.uleb128 0x17
	.long	.LASF54
	.byte	0xe
	.word	0x197
	.long	0x3c3
	.byte	0x1
	.byte	0x1
	.uleb128 0xa
	.long	.LASF55
	.byte	0xf
	.byte	0x5c
	.long	0x263
	.byte	0x1
	.byte	0x1
	.uleb128 0xa
	.long	.LASF56
	.byte	0xf
	.byte	0x5d
	.long	0x263
	.byte	0x1
	.byte	0x1
	.uleb128 0xd
	.long	0x30
	.long	0x406
	.uleb128 0xe
	.long	0x5e
	.byte	0x7
	.byte	0
	.uleb128 0x18
	.long	.LASF57
	.byte	0x1
	.byte	0x4c
	.long	0x3f6
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	PrevKeyboardHIDReportBuffer
	.uleb128 0xd
	.long	0x30
	.long	0x428
	.uleb128 0xe
	.long	0x5e
	.byte	0x1
	.byte	0
	.uleb128 0x18
	.long	.LASF58
	.byte	0x1
	.byte	0x4d
	.long	0x418
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	PrevMediaHIDReportBuffer
	.uleb128 0x19
	.long	0x3dc
	.byte	0x1
	.byte	0x53
	.byte	0x5
	.byte	0x3
	.long	HID_KeyboardInterface
	.uleb128 0x19
	.long	0x3e9
	.byte	0x1
	.byte	0x62
	.byte	0x5
	.byte	0x3
	.long	HID_MediaInterface
	.uleb128 0x18
	.long	.LASF59
	.byte	0x1
	.byte	0x76
	.long	0x2f2
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	USARTtoUSB_Buffer
	.uleb128 0x1a
	.long	.LASF60
	.byte	0x1
	.byte	0x78
	.long	0x3f6
	.byte	0x5
	.byte	0x3
	.long	keyboardData
	.uleb128 0x1b
	.long	.LASF61
	.byte	0x1
	.byte	0x79
	.long	0x4e
	.byte	0
	.uleb128 0xd
	.long	0x4e
	.long	0x493
	.uleb128 0xe
	.long	0x5e
	.byte	0x7
	.byte	0
	.uleb128 0x1a
	.long	.LASF62
	.byte	0x1
	.byte	0x7e
	.long	0x483
	.byte	0x5
	.byte	0x3
	.long	KeyboardQueue
	.uleb128 0x1a
	.long	.LASF63
	.byte	0x1
	.byte	0x7f
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	KeyboardHead
	.uleb128 0x1a
	.long	.LASF64
	.byte	0x1
	.byte	0x80
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	KeyboardTail
	.uleb128 0x1c
	.long	.LASF65
	.byte	0x1
	.byte	0x82
	.long	0x19e
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xd
	.long	0x4e
	.long	0x4ea
	.uleb128 0xe
	.long	0x5e
	.byte	0xf
	.byte	0
	.uleb128 0x1a
	.long	.LASF66
	.byte	0x1
	.byte	0x86
	.long	0x4da
	.byte	0x5
	.byte	0x3
	.long	MediaQueue
	.uleb128 0x1a
	.long	.LASF67
	.byte	0x1
	.byte	0x87
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	MediaHead
	.uleb128 0x1a
	.long	.LASF68
	.byte	0x1
	.byte	0x88
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	MediaTail
	.uleb128 0x1d
	.byte	0x7
	.byte	0x1
	.long	0x40
	.byte	0x1
	.byte	0x8b
	.long	0x537
	.uleb128 0x7
	.long	.LASF69
	.byte	0
	.uleb128 0x7
	.long	.LASF70
	.byte	0x1
	.byte	0
	.uleb128 0x3
	.long	.LASF71
	.byte	0x1
	.byte	0x8e
	.long	0x51d
	.uleb128 0x1a
	.long	.LASF72
	.byte	0x1
	.byte	0x90
	.long	0x537
	.byte	0x5
	.byte	0x3
	.long	MediaState
	.uleb128 0xd
	.long	0x30
	.long	0x563
	.uleb128 0xe
	.long	0x5e
	.byte	0x1f
	.byte	0
	.uleb128 0x1e
	.long	.LASF73
	.byte	0x1
	.word	0x1bf
	.long	0x553
	.byte	0x5
	.byte	0x3
	.long	parserBuffer
	.uleb128 0x1e
	.long	.LASF74
	.byte	0x1
	.word	0x1c0
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	parserHead
	.uleb128 0x1e
	.long	.LASF75
	.byte	0x1
	.word	0x1c1
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	parserTail
	.uleb128 0x1e
	.long	.LASF76
	.byte	0x1
	.word	0x1c2
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	parserCount
	.uleb128 0x1f
	.byte	0x1
	.long	.LASF83
	.byte	0x1
	.word	0x1c7
	.byte	0x1
	.long	.LFB110
	.long	.LFE110
	.long	.LLST30
	.byte	0x1
	.long	0x6b2
	.uleb128 0x20
	.long	.LASF77
	.byte	0x1
	.word	0x1c9
	.long	0x30
	.long	.LLST31
	.uleb128 0x21
	.long	.LBB161
	.long	.LBE161
	.uleb128 0x20
	.long	.LASF78
	.byte	0x1
	.word	0x1d9
	.long	0x30
	.long	.LLST32
	.uleb128 0x22
	.long	.LBB162
	.long	.LBE162
	.long	0x64f
	.uleb128 0x1e
	.long	.LASF79
	.byte	0x1
	.word	0x1dd
	.long	0x19e
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x22
	.long	.LBB163
	.long	.LBE163
	.long	0x629
	.uleb128 0x23
	.string	"ind"
	.byte	0x1
	.word	0x1eb
	.long	0x47
	.long	.LLST33
	.byte	0
	.uleb128 0x24
	.long	0xd0f
	.long	.LBB164
	.long	.LBE164
	.byte	0x1
	.word	0x1f3
	.uleb128 0x25
	.long	0xd20
	.uleb128 0x26
	.long	0xd2c
	.long	.LBB166
	.long	.LBE166
	.byte	0x1
	.byte	0xb8
	.byte	0
	.byte	0
	.uleb128 0x21
	.long	.LBB168
	.long	.LBE168
	.uleb128 0x20
	.long	.LASF80
	.byte	0x1
	.word	0x1fb
	.long	0x30
	.long	.LLST34
	.uleb128 0x20
	.long	.LASF81
	.byte	0x1
	.word	0x1ff
	.long	0x30
	.long	.LLST35
	.uleb128 0x20
	.long	.LASF82
	.byte	0x1
	.word	0x203
	.long	0x4e
	.long	.LLST36
	.uleb128 0x22
	.long	.LBB169
	.long	.LBE169
	.long	0x6a6
	.uleb128 0x23
	.string	"ind"
	.byte	0x1
	.word	0x206
	.long	0x47
	.long	.LLST37
	.byte	0
	.uleb128 0x27
	.long	.LVL92
	.long	0xc9c
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x28
	.byte	0x1
	.long	.LASF84
	.byte	0x1
	.word	0x1b6
	.byte	0x1
	.long	.LFB109
	.long	.LFE109
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x723
	.uleb128 0x29
	.long	.LASF85
	.byte	0x1
	.word	0x1b6
	.long	0x729
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.uleb128 0x29
	.long	.LASF86
	.byte	0x1
	.word	0x1b7
	.long	0x3b
	.byte	0x1
	.byte	0x66
	.uleb128 0x29
	.long	.LASF87
	.byte	0x1
	.word	0x1b8
	.long	0x3b
	.byte	0x1
	.byte	0x64
	.uleb128 0x29
	.long	.LASF88
	.byte	0x1
	.word	0x1b9
	.long	0x72e
	.byte	0x6
	.byte	0x62
	.byte	0x93
	.uleb128 0x1
	.byte	0x63
	.byte	0x93
	.uleb128 0x1
	.uleb128 0x29
	.long	.LASF89
	.byte	0x1
	.word	0x1ba
	.long	0x59
	.byte	0x6
	.byte	0x60
	.byte	0x93
	.uleb128 0x1
	.byte	0x61
	.byte	0x93
	.uleb128 0x1
	.byte	0
	.uleb128 0x11
	.byte	0x2
	.long	0x263
	.uleb128 0x4
	.long	0x723
	.uleb128 0x11
	.byte	0x2
	.long	0x734
	.uleb128 0x2a
	.uleb128 0x2b
	.byte	0x1
	.long	.LASF97
	.byte	0x1
	.word	0x174
	.byte	0x1
	.long	0x13b
	.long	.LFB108
	.long	.LFE108
	.long	.LLST22
	.byte	0x1
	.long	0x825
	.uleb128 0x2c
	.long	.LASF85
	.byte	0x1
	.word	0x175
	.long	0x729
	.long	.LLST23
	.uleb128 0x2c
	.long	.LASF86
	.byte	0x1
	.word	0x176
	.long	0x2ed
	.long	.LLST24
	.uleb128 0x2c
	.long	.LASF87
	.byte	0x1
	.word	0x177
	.long	0x3b
	.long	.LLST25
	.uleb128 0x2c
	.long	.LASF88
	.byte	0x1
	.word	0x178
	.long	0x159
	.long	.LLST26
	.uleb128 0x2c
	.long	.LASF89
	.byte	0x1
	.word	0x179
	.long	0x82b
	.long	.LLST27
	.uleb128 0x1e
	.long	.LASF90
	.byte	0x1
	.word	0x17b
	.long	0x4e
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x2d
	.long	.Ldebug_ranges0+0x30
	.long	0x7f6
	.uleb128 0x20
	.long	.LASF91
	.byte	0x1
	.word	0x182
	.long	0x19e
	.long	.LLST28
	.uleb128 0x2e
	.long	0xcf2
	.long	.LBB143
	.long	.Ldebug_ranges0+0x48
	.byte	0x1
	.word	0x184
	.uleb128 0x2f
	.long	0xd03
	.long	.LLST29
	.uleb128 0x26
	.long	0xd39
	.long	.LBB145
	.long	.LBE145
	.byte	0x1
	.byte	0xc3
	.byte	0
	.byte	0
	.uleb128 0x30
	.long	.Ldebug_ranges0+0x60
	.uleb128 0x1e
	.long	.LASF92
	.byte	0x1
	.word	0x194
	.long	0x830
	.byte	0x6
	.byte	0x5e
	.byte	0x93
	.uleb128 0x1
	.byte	0x5f
	.byte	0x93
	.uleb128 0x1
	.uleb128 0x31
	.long	.LVL72
	.long	0xc60
	.uleb128 0x32
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x11
	.byte	0x2
	.long	0x4e
	.uleb128 0x4
	.long	0x825
	.uleb128 0x11
	.byte	0x2
	.long	0x289
	.uleb128 0x28
	.byte	0x1
	.long	.LASF93
	.byte	0x1
	.word	0x163
	.byte	0x1
	.long	.LFB107
	.long	.LFE107
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x882
	.uleb128 0x33
	.long	0xe60
	.long	.LBB132
	.long	.LBE132
	.byte	0x1
	.word	0x165
	.long	0x86b
	.uleb128 0x25
	.long	0xe6d
	.byte	0
	.uleb128 0x24
	.long	0xe60
	.long	.LBB134
	.long	.LBE134
	.byte	0x1
	.word	0x166
	.uleb128 0x25
	.long	0xe6d
	.byte	0
	.byte	0
	.uleb128 0x28
	.byte	0x1
	.long	.LASF94
	.byte	0x1
	.word	0x15c
	.byte	0x1
	.long	.LFB106
	.long	.LFE106
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x8d3
	.uleb128 0x34
	.long	.LVL53
	.long	0xf61
	.long	0x8b9
	.uleb128 0x32
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
	.uleb128 0x35
	.long	.LVL54
	.byte	0x1
	.long	0xf61
	.uleb128 0x32
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
	.uleb128 0x28
	.byte	0x1
	.long	.LASF95
	.byte	0x1
	.word	0x153
	.byte	0x1
	.long	.LFB105
	.long	.LFE105
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0x933
	.uleb128 0x36
	.long	0xe79
	.long	.LBB130
	.long	.LBE130
	.byte	0x1
	.word	0x158
	.uleb128 0x34
	.long	.LVL51
	.long	0xf6e
	.long	0x91a
	.uleb128 0x32
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
	.uleb128 0x31
	.long	.LVL52
	.long	0xf6e
	.uleb128 0x32
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
	.uleb128 0x37
	.byte	0x1
	.long	.LASF135
	.byte	0x1
	.word	0x14d
	.byte	0x1
	.uleb128 0x38
	.byte	0x1
	.long	.LASF136
	.byte	0x1
	.word	0x147
	.byte	0x1
	.byte	0x1
	.uleb128 0x1f
	.byte	0x1
	.long	.LASF96
	.byte	0x1
	.word	0x128
	.byte	0x1
	.long	.LFB102
	.long	.LFE102
	.long	.LLST5
	.byte	0x1
	.long	0x9bc
	.uleb128 0x33
	.long	0xeae
	.long	.LBB63
	.long	.LBE63
	.byte	0x1
	.word	0x12c
	.long	0x98b
	.uleb128 0x39
	.long	0xece
	.long	.LBB64
	.long	.LBE64
	.uleb128 0x3a
	.long	0xecf
	.byte	0
	.byte	0
	.uleb128 0x33
	.long	0xd80
	.long	.LBB65
	.long	.LBE65
	.byte	0x1
	.word	0x12f
	.long	0x9b2
	.uleb128 0x2f
	.long	0xd8d
	.long	.LLST6
	.uleb128 0x2f
	.long	0xd98
	.long	.LLST7
	.byte	0
	.uleb128 0x27
	.long	.LVL17
	.long	0xf7b
	.byte	0
	.uleb128 0x2b
	.byte	0x1
	.long	.LASF98
	.byte	0x1
	.word	0x113
	.byte	0x1
	.long	0x47
	.long	.LFB101
	.long	.LFE101
	.long	.LLST8
	.byte	0x1
	.long	0xc25
	.uleb128 0x33
	.long	0xe2f
	.long	.LBB98
	.long	.LBE98
	.byte	0x1
	.word	0x117
	.long	0xa3d
	.uleb128 0x25
	.long	0xe3c
	.uleb128 0x39
	.long	0xe47
	.long	.LBB99
	.long	.LBE99
	.uleb128 0x3b
	.long	0xe48
	.long	.LLST9
	.uleb128 0x3b
	.long	0xe53
	.long	.LLST10
	.uleb128 0x26
	.long	0xea1
	.long	.LBB100
	.long	.LBE100
	.byte	0x2
	.byte	0x57
	.uleb128 0x3c
	.long	0xe82
	.long	.LBB102
	.long	.LBE102
	.byte	0x2
	.byte	0x57
	.uleb128 0x2f
	.long	0xe8f
	.long	.LLST11
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x3d
	.long	0xc25
	.long	.LBB104
	.long	.Ldebug_ranges0+0
	.byte	0x1
	.word	0x11e
	.long	0xbda
	.uleb128 0x30
	.long	.Ldebug_ranges0+0
	.uleb128 0x3e
	.long	0xdef
	.long	.LBB106
	.long	.LBE106
	.byte	0x1
	.byte	0xf2
	.long	0xad1
	.uleb128 0x3f
	.long	0xe00
	.byte	0x6
	.byte	0x3
	.long	USARTtoUSB_Buffer
	.byte	0x9f
	.uleb128 0x21
	.long	.LBB107
	.long	.LBE107
	.uleb128 0x3b
	.long	0xe0b
	.long	.LLST12
	.uleb128 0x39
	.long	0xe16
	.long	.LBB108
	.long	.LBE108
	.uleb128 0x3b
	.long	0xe17
	.long	.LLST13
	.uleb128 0x3b
	.long	0xe22
	.long	.LLST14
	.uleb128 0x26
	.long	0xea1
	.long	.LBB109
	.long	.LBE109
	.byte	0x2
	.byte	0x6f
	.uleb128 0x3c
	.long	0xe82
	.long	.LBB111
	.long	.LBE111
	.byte	0x2
	.byte	0x6f
	.uleb128 0x2f
	.long	0xe8f
	.long	.LLST15
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x3e
	.long	0xdef
	.long	.LBB113
	.long	.LBE113
	.byte	0x1
	.byte	0xf6
	.long	0xb45
	.uleb128 0x25
	.long	0xe00
	.uleb128 0x21
	.long	.LBB114
	.long	.LBE114
	.uleb128 0x3b
	.long	0xe0b
	.long	.LLST16
	.uleb128 0x39
	.long	0xe16
	.long	.LBB115
	.long	.LBE115
	.uleb128 0x3b
	.long	0xe17
	.long	.LLST17
	.uleb128 0x3b
	.long	0xe22
	.long	.LLST18
	.uleb128 0x26
	.long	0xea1
	.long	.LBB116
	.long	.LBE116
	.byte	0x2
	.byte	0x6f
	.uleb128 0x3c
	.long	0xe82
	.long	.LBB118
	.long	.LBE118
	.byte	0x2
	.byte	0x6f
	.uleb128 0x2f
	.long	0xe8f
	.long	.LLST19
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x40
	.long	0xc42
	.long	.LBB120
	.long	.LBE120
	.long	0xb69
	.uleb128 0x3b
	.long	0xc47
	.long	.LLST20
	.uleb128 0x27
	.long	.LVL41
	.long	0xedd
	.byte	0
	.uleb128 0x3d
	.long	0xd63
	.long	.LBB121
	.long	.Ldebug_ranges0+0x18
	.byte	0x1
	.word	0x103
	.long	0xb87
	.uleb128 0x2f
	.long	0xd74
	.long	.LLST21
	.byte	0
	.uleb128 0x36
	.long	0xcd8
	.long	.LBB124
	.long	.LBE124
	.byte	0x1
	.word	0x105
	.uleb128 0x40
	.long	0xc51
	.long	.LBB126
	.long	.LBE126
	.long	0xbc6
	.uleb128 0x41
	.long	0xc52
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.uleb128 0x31
	.long	.LVL46
	.long	0xc60
	.uleb128 0x32
	.byte	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.byte	0x2
	.byte	0x8c
	.sleb128 1
	.byte	0
	.byte	0
	.uleb128 0x27
	.long	.LVL33
	.long	0xedd
	.uleb128 0x27
	.long	.LVL48
	.long	0xc9c
	.byte	0
	.byte	0
	.uleb128 0x27
	.long	.LVL18
	.long	0x948
	.uleb128 0x34
	.long	.LVL29
	.long	0xf89
	.long	0xbff
	.uleb128 0x32
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
	.uleb128 0x34
	.long	.LVL30
	.long	0xf89
	.long	0xc1b
	.uleb128 0x32
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
	.uleb128 0x27
	.long	.LVL31
	.long	0xf96
	.byte	0
	.uleb128 0x42
	.long	.LASF137
	.byte	0x1
	.byte	0xee
	.byte	0x1
	.long	0xc60
	.uleb128 0x1a
	.long	.LASF99
	.byte	0x1
	.byte	0xf0
	.long	0x30
	.byte	0x5
	.byte	0x3
	.long	partial_wait.3143
	.uleb128 0x43
	.long	0xc51
	.uleb128 0x44
	.string	"i"
	.byte	0x1
	.byte	0xfe
	.long	0x30
	.byte	0
	.uleb128 0x45
	.uleb128 0x46
	.long	.LASF100
	.byte	0x1
	.word	0x107
	.long	0x4e
	.byte	0
	.byte	0
	.uleb128 0x47
	.long	.LASF101
	.byte	0x1
	.byte	0xe2
	.byte	0x1
	.long	0x13b
	.long	.LFB99
	.long	.LFE99
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0xc9c
	.uleb128 0x48
	.long	.LASF42
	.byte	0x1
	.byte	0xe2
	.long	0x825
	.long	.LLST1
	.uleb128 0x26
	.long	0xce5
	.long	.LBB52
	.long	.LBE52
	.byte	0x1
	.byte	0xe4
	.byte	0
	.uleb128 0x47
	.long	.LASF102
	.byte	0x1
	.byte	0xd7
	.byte	0x1
	.long	0x13b
	.long	.LFB98
	.long	.LFE98
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0xcd8
	.uleb128 0x48
	.long	.LASF42
	.byte	0x1
	.byte	0xd7
	.long	0x4e
	.long	.LLST0
	.uleb128 0x26
	.long	0xcd8
	.long	.LBB48
	.long	.LBE48
	.byte	0x1
	.byte	0xd9
	.byte	0
	.uleb128 0x49
	.long	.LASF103
	.byte	0x1
	.byte	0xd2
	.byte	0x1
	.long	0x13b
	.byte	0x1
	.uleb128 0x49
	.long	.LASF104
	.byte	0x1
	.byte	0xcd
	.byte	0x1
	.long	0x13b
	.byte	0x1
	.uleb128 0x4a
	.long	.LASF105
	.byte	0x1
	.byte	0xc1
	.byte	0x1
	.long	0x13b
	.byte	0x1
	.long	0xd0f
	.uleb128 0x4b
	.long	.LASF42
	.byte	0x1
	.byte	0xc1
	.long	0x825
	.byte	0
	.uleb128 0x4a
	.long	.LASF106
	.byte	0x1
	.byte	0xb6
	.byte	0x1
	.long	0x13b
	.byte	0x1
	.long	0xd2c
	.uleb128 0x4b
	.long	.LASF42
	.byte	0x1
	.byte	0xb6
	.long	0x4e
	.byte	0
	.uleb128 0x49
	.long	.LASF107
	.byte	0x1
	.byte	0xb1
	.byte	0x1
	.long	0x13b
	.byte	0x1
	.uleb128 0x49
	.long	.LASF108
	.byte	0x1
	.byte	0xac
	.byte	0x1
	.long	0x13b
	.byte	0x1
	.uleb128 0x4a
	.long	.LASF109
	.byte	0x1
	.byte	0x9d
	.byte	0x1
	.long	0x4e
	.byte	0x3
	.long	0xd63
	.uleb128 0x4b
	.long	.LASF110
	.byte	0x1
	.byte	0x9d
	.long	0x30
	.byte	0
	.uleb128 0x4a
	.long	.LASF111
	.byte	0x1
	.byte	0x92
	.byte	0x1
	.long	0x13b
	.byte	0x3
	.long	0xd80
	.uleb128 0x4b
	.long	.LASF110
	.byte	0x1
	.byte	0x92
	.long	0x30
	.byte	0
	.uleb128 0x4c
	.long	.LASF119
	.byte	0x5
	.byte	0x63
	.byte	0x1
	.byte	0x3
	.long	0xda4
	.uleb128 0x4b
	.long	.LASF112
	.byte	0x5
	.byte	0x63
	.long	0x77
	.uleb128 0x4b
	.long	.LASF113
	.byte	0x5
	.byte	0x64
	.long	0x147
	.byte	0
	.uleb128 0x4a
	.long	.LASF114
	.byte	0x2
	.byte	0xb6
	.byte	0x1
	.long	0x30
	.byte	0x3
	.long	0xde4
	.uleb128 0x4b
	.long	.LASF44
	.byte	0x2
	.byte	0xb6
	.long	0xdea
	.uleb128 0x4d
	.long	.LASF115
	.byte	0x2
	.byte	0xb8
	.long	0x30
	.uleb128 0x45
	.uleb128 0x4d
	.long	.LASF116
	.byte	0x2
	.byte	0xbd
	.long	0x30
	.uleb128 0x4d
	.long	.LASF117
	.byte	0x2
	.byte	0xbd
	.long	0x30
	.byte	0
	.byte	0
	.uleb128 0x11
	.byte	0x2
	.long	0x2f2
	.uleb128 0x4
	.long	0xde4
	.uleb128 0x4a
	.long	.LASF118
	.byte	0x2
	.byte	0x6b
	.byte	0x1
	.long	0x30
	.byte	0x3
	.long	0xe2f
	.uleb128 0x4b
	.long	.LASF44
	.byte	0x2
	.byte	0x6b
	.long	0xdea
	.uleb128 0x4d
	.long	.LASF45
	.byte	0x2
	.byte	0x6d
	.long	0x30
	.uleb128 0x45
	.uleb128 0x4d
	.long	.LASF116
	.byte	0x2
	.byte	0x6f
	.long	0x30
	.uleb128 0x4d
	.long	.LASF117
	.byte	0x2
	.byte	0x6f
	.long	0x30
	.byte	0
	.byte	0
	.uleb128 0x4c
	.long	.LASF120
	.byte	0x2
	.byte	0x55
	.byte	0x1
	.byte	0x3
	.long	0xe60
	.uleb128 0x4b
	.long	.LASF44
	.byte	0x2
	.byte	0x55
	.long	0xdea
	.uleb128 0x45
	.uleb128 0x4d
	.long	.LASF116
	.byte	0x2
	.byte	0x57
	.long	0x30
	.uleb128 0x4d
	.long	.LASF117
	.byte	0x2
	.byte	0x57
	.long	0x30
	.byte	0
	.byte	0
	.uleb128 0x4c
	.long	.LASF121
	.byte	0x7
	.byte	0xc7
	.byte	0x1
	.byte	0x3
	.long	0xe79
	.uleb128 0x4b
	.long	.LASF85
	.byte	0x7
	.byte	0xc7
	.long	0x729
	.byte	0
	.uleb128 0x4e
	.long	.LASF138
	.byte	0x6
	.byte	0x94
	.byte	0x1
	.byte	0x3
	.uleb128 0x4c
	.long	.LASF122
	.byte	0x3
	.byte	0x44
	.byte	0x1
	.byte	0x3
	.long	0xe9b
	.uleb128 0x4f
	.string	"__s"
	.byte	0x3
	.byte	0x44
	.long	0xe9b
	.byte	0
	.uleb128 0x11
	.byte	0x2
	.long	0x3b
	.uleb128 0x49
	.long	.LASF123
	.byte	0x3
	.byte	0x30
	.byte	0x1
	.long	0x30
	.byte	0x3
	.uleb128 0x50
	.long	.LASF124
	.byte	0x4
	.word	0x1ec
	.byte	0x1
	.byte	0x3
	.long	0xedd
	.uleb128 0x43
	.long	0xece
	.uleb128 0x46
	.long	.LASF125
	.byte	0x4
	.word	0x1f0
	.long	0x30
	.byte	0
	.uleb128 0x45
	.uleb128 0x46
	.long	.LASF125
	.byte	0x4
	.word	0x202
	.long	0x30
	.byte	0
	.byte	0
	.uleb128 0x51
	.long	0xda4
	.long	.LFB117
	.long	.LFE117
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.long	0xf4f
	.uleb128 0x41
	.long	0xdc0
	.byte	0x1
	.byte	0x68
	.uleb128 0x3f
	.long	0xdb5
	.byte	0x6
	.byte	0x3
	.long	USARTtoUSB_Buffer
	.byte	0x9f
	.uleb128 0x39
	.long	0xdcb
	.long	.LBB54
	.long	.LBE54
	.uleb128 0x3b
	.long	0xdcc
	.long	.LLST2
	.uleb128 0x3b
	.long	0xdd7
	.long	.LLST3
	.uleb128 0x26
	.long	0xea1
	.long	.LBB55
	.long	.LBE55
	.byte	0x2
	.byte	0xbd
	.uleb128 0x3c
	.long	0xe82
	.long	.LBB57
	.long	.LBE57
	.byte	0x2
	.byte	0xbd
	.uleb128 0x2f
	.long	0xe8f
	.long	.LLST4
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x52
	.long	0x93d
	.long	.LFB103
	.long	.LFE103
	.byte	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.byte	0x1
	.uleb128 0x53
	.byte	0x1
	.byte	0x1
	.long	.LASF126
	.long	.LASF126
	.byte	0x7
	.byte	0x8e
	.uleb128 0x53
	.byte	0x1
	.byte	0x1
	.long	.LASF127
	.long	.LASF127
	.byte	0x7
	.byte	0x87
	.uleb128 0x54
	.byte	0x1
	.byte	0x1
	.long	.LASF128
	.long	.LASF128
	.byte	0x10
	.word	0x123
	.uleb128 0x53
	.byte	0x1
	.byte	0x1
	.long	.LASF129
	.long	.LASF129
	.byte	0x7
	.byte	0x95
	.uleb128 0x53
	.byte	0x1
	.byte	0x1
	.long	.LASF130
	.long	.LASF130
	.byte	0xb
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
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
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
	.uleb128 0x6
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
	.uleb128 0x7
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xb
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x11
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1c
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
	.uleb128 0x1c
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x1d
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
	.uleb128 0x1e
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
	.uleb128 0x1f
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
	.uleb128 0x20
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
	.uleb128 0x21
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x22
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
	.uleb128 0x23
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
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
	.uleb128 0x24
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
	.uleb128 0x25
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
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
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
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
	.uleb128 0x29
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
	.uleb128 0x2a
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2b
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
	.uleb128 0x2c
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
	.uleb128 0x2d
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2e
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
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x30
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x33
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
	.uleb128 0x34
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
	.uleb128 0x35
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
	.uleb128 0x36
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
	.uleb128 0x37
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
	.uleb128 0x38
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
	.uleb128 0x39
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
	.uleb128 0x3a
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
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
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x3d
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
	.uleb128 0x3e
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
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3f
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x40
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x41
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
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
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x43
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x44
	.uleb128 0x34
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
	.uleb128 0x45
	.uleb128 0xb
	.byte	0x1
	.byte	0
	.byte	0
	.uleb128 0x46
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
	.uleb128 0x47
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
	.uleb128 0x48
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
	.uleb128 0x49
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
	.uleb128 0x4a
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
	.uleb128 0x4b
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
	.uleb128 0x4c
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
	.uleb128 0x4d
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
	.uleb128 0x4e
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
	.uleb128 0x4f
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
	.uleb128 0x50
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
	.uleb128 0x51
	.uleb128 0x2e
	.byte	0x1
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
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x52
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
	.uleb128 0x53
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
	.uleb128 0x54
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
.LLST30:
	.long	.LFB110
	.long	.LCFI21
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI21
	.long	.LCFI22
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI22
	.long	.LCFI23
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI23
	.long	.LCFI24
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI24
	.long	.LCFI25
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI25
	.long	.LCFI26
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI26
	.long	.LCFI27
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 8
	.long	.LCFI27
	.long	.LCFI28
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 9
	.long	.LCFI28
	.long	.LCFI29
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 10
	.long	.LCFI29
	.long	.LCFI30
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 11
	.long	.LCFI30
	.long	.LCFI31
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 12
	.long	.LCFI31
	.long	.LCFI32
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 13
	.long	.LCFI32
	.long	.LCFI33
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 14
	.long	.LCFI33
	.long	.LCFI34
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 15
	.long	.LCFI34
	.long	.LCFI35
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 16
	.long	.LCFI35
	.long	.LCFI36
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 17
	.long	.LCFI36
	.long	.LCFI37
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 18
	.long	.LCFI37
	.long	.LCFI38
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 19
	.long	.LCFI38
	.long	.LCFI39
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 20
	.long	.LCFI39
	.long	.LCFI40
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 21
	.long	.LCFI40
	.long	.LCFI41
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 22
	.long	.LCFI41
	.long	.LCFI42
	.word	0x2
	.byte	0x8c
	.sleb128 22
	.long	.LCFI42
	.long	.LFE110
	.word	0x2
	.byte	0x8c
	.sleb128 30
	.long	0
	.long	0
.LLST31:
	.long	.LVL75
	.long	.LVL76
	.word	0x1
	.byte	0x63
	.long	0
	.long	0
.LLST32:
	.long	.LVL77
	.long	.LVL78
	.word	0x1
	.byte	0x68
	.long	.LVL81
	.long	.LVL87
	.word	0x1
	.byte	0x68
	.long	.LVL93
	.long	.LFE110
	.word	0x1
	.byte	0x68
	.long	0
	.long	0
.LLST33:
	.long	.LVL79
	.long	.LVL80
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST34:
	.long	.LVL82
	.long	.LVL86
	.word	0x8
	.byte	0x82
	.sleb128 0
	.byte	0x3
	.long	parserBuffer
	.byte	0x22
	.long	.LVL86
	.long	.LVL89
	.word	0x2
	.byte	0x82
	.sleb128 0
	.long	.LVL89
	.long	.LVL92-1
	.word	0x1
	.byte	0x64
	.long	0
	.long	0
.LLST35:
	.long	.LVL83
	.long	.LVL84
	.word	0x8
	.byte	0x84
	.sleb128 0
	.byte	0x3
	.long	parserBuffer
	.byte	0x22
	.long	.LVL84
	.long	.LVL85
	.word	0x2
	.byte	0x84
	.sleb128 0
	.long	.LVL85
	.long	.LVL88
	.word	0x1
	.byte	0x64
	.long	.LVL88
	.long	.LVL92-1
	.word	0x1
	.byte	0x65
	.long	0
	.long	0
.LLST36:
	.long	.LVL88
	.long	.LVL92-1
	.word	0x6
	.byte	0x64
	.byte	0x93
	.uleb128 0x1
	.byte	0x65
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST37:
	.long	.LVL88
	.long	.LVL89
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL89
	.long	.LVL90
	.word	0x5
	.byte	0x36
	.byte	0x8e
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.long	.LVL90
	.long	.LVL91
	.word	0x5
	.byte	0x37
	.byte	0x8e
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.long	.LVL91
	.long	.LVL92-1
	.word	0x5
	.byte	0x36
	.byte	0x8e
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.long	0
	.long	0
.LLST22:
	.long	.LFB108
	.long	.LCFI13
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI13
	.long	.LCFI14
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI14
	.long	.LCFI15
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI15
	.long	.LCFI16
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI16
	.long	.LCFI17
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI17
	.long	.LCFI18
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI18
	.long	.LCFI19
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 8
	.long	.LCFI19
	.long	.LCFI20
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 10
	.long	.LCFI20
	.long	.LFE108
	.word	0x2
	.byte	0x8c
	.sleb128 10
	.long	0
	.long	0
.LLST23:
	.long	.LVL58
	.long	.LVL61
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL61
	.long	.LVL68
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	.LVL68
	.long	.LVL70
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL70
	.long	.LFE108
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST24:
	.long	.LVL58
	.long	.LVL66
	.word	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.long	.LVL66
	.long	.LVL68
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0x9f
	.long	.LVL68
	.long	.LVL72-1
	.word	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.long	.LVL72-1
	.long	.LVL73
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x66
	.byte	0x9f
	.long	.LVL73
	.long	.LFE108
	.word	0x6
	.byte	0x66
	.byte	0x93
	.uleb128 0x1
	.byte	0x67
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST25:
	.long	.LVL58
	.long	.LVL59
	.word	0x1
	.byte	0x64
	.long	.LVL59
	.long	.LFE108
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x64
	.byte	0x9f
	.long	0
	.long	0
.LLST26:
	.long	.LVL58
	.long	.LVL66
	.word	0x6
	.byte	0x62
	.byte	0x93
	.uleb128 0x1
	.byte	0x63
	.byte	0x93
	.uleb128 0x1
	.long	.LVL66
	.long	.LVL68
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x62
	.byte	0x9f
	.long	.LVL68
	.long	.LVL71
	.word	0x6
	.byte	0x62
	.byte	0x93
	.uleb128 0x1
	.byte	0x63
	.byte	0x93
	.uleb128 0x1
	.long	.LVL71
	.long	.LFE108
	.word	0x6
	.byte	0x5e
	.byte	0x93
	.uleb128 0x1
	.byte	0x5f
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST27:
	.long	.LVL58
	.long	.LVL67
	.word	0x6
	.byte	0x60
	.byte	0x93
	.uleb128 0x1
	.byte	0x61
	.byte	0x93
	.uleb128 0x1
	.long	.LVL67
	.long	.LVL68
	.word	0x6
	.byte	0x6e
	.byte	0x93
	.uleb128 0x1
	.byte	0x6f
	.byte	0x93
	.uleb128 0x1
	.long	.LVL68
	.long	.LFE108
	.word	0x6
	.byte	0x60
	.byte	0x93
	.uleb128 0x1
	.byte	0x61
	.byte	0x93
	.uleb128 0x1
	.long	0
	.long	0
.LLST28:
	.long	.LVL64
	.long	.LVL66
	.word	0x8
	.byte	0x64
	.byte	0x93
	.uleb128 0x1
	.byte	0x65
	.byte	0x93
	.uleb128 0x1
	.byte	0x93
	.uleb128 0x6
	.long	0
	.long	0
.LLST29:
	.long	.LVL60
	.long	.LVL62
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+1980
	.sleb128 0
	.long	.LVL63
	.long	.LVL65
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+1980
	.sleb128 0
	.long	0
	.long	0
.LLST5:
	.long	.LFB102
	.long	.LCFI0
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI0
	.long	.LCFI1
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI1
	.long	.LCFI2
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI2
	.long	.LCFI3
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 5
	.long	.LCFI3
	.long	.LCFI4
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI4
	.long	.LCFI5
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 7
	.long	.LCFI5
	.long	.LCFI6
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 8
	.long	.LCFI6
	.long	.LCFI7
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 9
	.long	.LCFI7
	.long	.LCFI8
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 10
	.long	.LCFI8
	.long	.LFE102
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 11
	.long	0
	.long	0
.LLST6:
	.long	.LVL15
	.long	.LVL16
	.word	0x4
	.byte	0xa
	.word	0x2580
	.byte	0x9f
	.long	0
	.long	0
.LLST7:
	.long	.LVL15
	.long	.LVL16
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST8:
	.long	.LFB101
	.long	.LCFI9
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 2
	.long	.LCFI9
	.long	.LCFI10
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 3
	.long	.LCFI10
	.long	.LCFI11
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 4
	.long	.LCFI11
	.long	.LCFI12
	.word	0x3
	.byte	0x92
	.uleb128 0x20
	.sleb128 6
	.long	.LCFI12
	.long	.LFE101
	.word	0x2
	.byte	0x8c
	.sleb128 6
	.long	0
	.long	0
.LLST9:
	.long	.LVL19
	.long	.LVL22
	.word	0x1
	.byte	0x62
	.long	0
	.long	0
.LLST10:
	.long	.LVL20
	.long	.LVL21
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.long	.LVL21
	.long	.LFE101
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST11:
	.long	.LVL21
	.long	.LVL23
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2561
	.sleb128 0
	.long	.LVL26
	.long	.LVL28
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2708
	.sleb128 0
	.long	.LVL32
	.long	.LVL33
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2824
	.sleb128 0
	.long	.LVL36
	.long	.LVL38
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2824
	.sleb128 0
	.long	.LVL38
	.long	.LFE101
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2708
	.sleb128 0
	.long	0
	.long	0
.LLST12:
	.long	.LVL26
	.long	.LVL27
	.word	0x1
	.byte	0x68
	.long	0
	.long	0
.LLST13:
	.long	.LVL24
	.long	.LVL27
	.word	0x1
	.byte	0x69
	.long	0
	.long	0
.LLST14:
	.long	.LVL25
	.long	.LVL26
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.long	.LVL26
	.long	.LFE101
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST15:
	.long	.LVL26
	.long	.LVL28
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2708
	.sleb128 0
	.long	.LVL32
	.long	.LVL33
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2824
	.sleb128 0
	.long	.LVL36
	.long	.LVL38
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2824
	.sleb128 0
	.long	.LVL38
	.long	.LFE101
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2708
	.sleb128 0
	.long	0
	.long	0
.LLST16:
	.long	.LVL36
	.long	.LVL37
	.word	0x1
	.byte	0x68
	.long	0
	.long	0
.LLST17:
	.long	.LVL34
	.long	.LVL37
	.word	0x1
	.byte	0x69
	.long	0
	.long	0
.LLST18:
	.long	.LVL32
	.long	.LVL33
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL35
	.long	.LVL36
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.long	.LVL36
	.long	.LVL38
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST19:
	.long	.LVL32
	.long	.LVL33
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2824
	.sleb128 0
	.long	.LVL36
	.long	.LVL38
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2824
	.sleb128 0
	.long	0
	.long	0
.LLST20:
	.long	.LVL39
	.long	.LVL40
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL40
	.long	.LFE101
	.word	0x9
	.byte	0x7c
	.sleb128 0
	.byte	0x3
	.long	keyboardData
	.byte	0x1c
	.byte	0x9f
	.long	0
	.long	0
.LLST21:
	.long	.LVL43
	.long	.LVL44
	.word	0x1
	.byte	0x68
	.long	.LVL44
	.long	.LVL45
	.word	0x5
	.byte	0x3
	.long	keyboardData+2
	.long	.LVL49
	.long	.LVL50
	.word	0x1
	.byte	0x68
	.long	.LVL50
	.long	.LFE101
	.word	0x5
	.byte	0x3
	.long	keyboardData+2
	.long	0
	.long	0
.LLST1:
	.long	.LVL4
	.long	.LVL5
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL5
	.long	.LVL6
	.word	0x6
	.byte	0x6e
	.byte	0x93
	.uleb128 0x1
	.byte	0x6f
	.byte	0x93
	.uleb128 0x1
	.long	.LVL6
	.long	.LVL7
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL7
	.long	.LFE99
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST0:
	.long	.LVL0
	.long	.LVL1
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL1
	.long	.LVL2
	.word	0x2
	.byte	0x8e
	.sleb128 0
	.long	.LVL2
	.long	.LVL3
	.word	0x6
	.byte	0x68
	.byte	0x93
	.uleb128 0x1
	.byte	0x69
	.byte	0x93
	.uleb128 0x1
	.long	.LVL3
	.long	.LFE98
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x68
	.byte	0x9f
	.long	0
	.long	0
.LLST2:
	.long	.LVL10
	.long	.LVL13
	.word	0x1
	.byte	0x62
	.long	0
	.long	0
.LLST3:
	.long	.LVL11
	.long	.LVL12
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.long	.LVL12
	.long	.LVL14
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST4:
	.long	.LVL12
	.long	.LVL14
	.word	0x6
	.byte	0xf2
	.long	.Ldebug_info0+3859
	.sleb128 0
	.long	0
	.long	0
	.section	.debug_aranges,"",@progbits
	.long	0x74
	.word	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.word	0
	.word	0
	.long	.LFB98
	.long	.LFE98-.LFB98
	.long	.LFB99
	.long	.LFE99-.LFB99
	.long	.LFB117
	.long	.LFE117-.LFB117
	.long	.LFB102
	.long	.LFE102-.LFB102
	.long	.LFB101
	.long	.LFE101-.LFB101
	.long	.LFB103
	.long	.LFE103-.LFB103
	.long	.LFB105
	.long	.LFE105-.LFB105
	.long	.LFB106
	.long	.LFE106-.LFB106
	.long	.LFB107
	.long	.LFE107-.LFB107
	.long	.LFB108
	.long	.LFE108-.LFB108
	.long	.LFB109
	.long	.LFE109-.LFB109
	.long	.LFB110
	.long	.LFE110-.LFB110
	.long	0
	.long	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.LBB104
	.long	.LBE104
	.long	.LBB129
	.long	.LBE129
	.long	0
	.long	0
	.long	.LBB121
	.long	.LBE121
	.long	.LBB127
	.long	.LBE127
	.long	0
	.long	0
	.long	.LBB142
	.long	.LBE142
	.long	.LBB149
	.long	.LBE149
	.long	0
	.long	0
	.long	.LBB143
	.long	.LBE143
	.long	.LBB148
	.long	.LBE148
	.long	0
	.long	0
	.long	.LBB150
	.long	.LBE150
	.long	.LBB151
	.long	.LBE151
	.long	0
	.long	0
	.long	.LFB98
	.long	.LFE98
	.long	.LFB99
	.long	.LFE99
	.long	.LFB117
	.long	.LFE117
	.long	.LFB102
	.long	.LFE102
	.long	.LFB101
	.long	.LFE101
	.long	.LFB103
	.long	.LFE103
	.long	.LFB105
	.long	.LFE105
	.long	.LFB106
	.long	.LFE106
	.long	.LFB107
	.long	.LFE107
	.long	.LFB108
	.long	.LFE108
	.long	.LFB109
	.long	.LFE109
	.long	.LFB110
	.long	.LFE110
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF19:
	.string	"wIndex"
.LASF92:
	.string	"MediaReport"
.LASF42:
	.string	"Usage"
.LASF81:
	.string	"mHigh"
.LASF112:
	.string	"BaudRate"
.LASF95:
	.string	"EVENT_USB_Device_ConfigurationChanged"
.LASF60:
	.string	"keyboardData"
.LASF41:
	.string	"USB_ClassInfo_HID_Device_t"
.LASF57:
	.string	"PrevKeyboardHIDReportBuffer"
.LASF50:
	.string	"flags"
.LASF14:
	.string	"DEVICE_STATE_Configured"
.LASF90:
	.string	"currentMediaUsage"
.LASF37:
	.string	"IdleCount"
.LASF85:
	.string	"HIDInterfaceInfo"
.LASF4:
	.string	"unsigned int"
.LASF46:
	.string	"RingBuff_t"
.LASF16:
	.string	"bmRequestType"
.LASF69:
	.string	"MEDIA_IDLE"
.LASF33:
	.string	"ReportINEndpointDoubleBank"
.LASF105:
	.string	"KeyboardQueue_Pop"
.LASF73:
	.string	"parserBuffer"
.LASF29:
	.string	"USB_KeyboardReport_Data_t"
.LASF132:
	.string	"Arduino-keyboard.c"
.LASF104:
	.string	"MediaQueue_IsEmpty"
.LASF49:
	.string	"unget"
.LASF120:
	.string	"RingBuffer_InitBuffer"
.LASF40:
	.string	"State"
.LASF131:
	.string	"GNU C99 7.3.0 -mn-flash=1 -mno-skip-bug -mmcu=avr35 -gdwarf-2 -Os -std=gnu99 -funsigned-char -funsigned-bitfields -ffunction-sections -fno-inline-small-functions -fpack-struct -fshort-enums -fno-strict-aliasing"
.LASF47:
	.string	"ATTR_PACKED"
.LASF108:
	.string	"KeyboardQueue_IsEmpty"
.LASF18:
	.string	"wValue"
.LASF13:
	.string	"DEVICE_STATE_Addressed"
.LASF138:
	.string	"USB_Device_EnableSOFEvents"
.LASF6:
	.string	"uint32_t"
.LASF106:
	.string	"KeyboardQueue_Push"
.LASF94:
	.string	"EVENT_USB_Device_UnhandledControlRequest"
.LASF133:
	.string	"/sdb1/My Job/Bluetooth-HID-Keyboard-ArduinoUnoR3/My-HID-Arduino-Keyboard/arduino-keyboard-0.3"
.LASF68:
	.string	"MediaTail"
.LASF78:
	.string	"reportType"
.LASF9:
	.string	"long long unsigned int"
.LASF12:
	.string	"DEVICE_STATE_Default"
.LASF82:
	.string	"mediaUsage"
.LASF66:
	.string	"MediaQueue"
.LASF136:
	.string	"EVENT_USB_Device_Connect"
.LASF100:
	.string	"Dummy"
.LASF88:
	.string	"ReportData"
.LASF128:
	.string	"USB_Init"
.LASF64:
	.string	"KeyboardTail"
.LASF39:
	.string	"Config"
.LASF86:
	.string	"ReportID"
.LASF127:
	.string	"HID_Device_ConfigureEndpoints"
.LASF70:
	.string	"MEDIA_SEND_RELEASE"
.LASF72:
	.string	"MediaState"
.LASF119:
	.string	"Serial_Init"
.LASF22:
	.string	"USB_ConfigurationNumber"
.LASF24:
	.string	"_Bool"
.LASF101:
	.string	"MediaQueue_Pop"
.LASF97:
	.string	"CALLBACK_HID_Device_CreateHIDReport"
.LASF67:
	.string	"MediaHead"
.LASF113:
	.string	"DoubleSpeed"
.LASF45:
	.string	"Count"
.LASF134:
	.string	"USB_Device_States_t"
.LASF63:
	.string	"KeyboardHead"
.LASF53:
	.string	"char"
.LASF35:
	.string	"PrevReportINBufferSize"
.LASF71:
	.string	"media_state_t"
.LASF2:
	.string	"uint8_t"
.LASF110:
	.string	"usage"
.LASF23:
	.string	"USB_IsInitialized"
.LASF59:
	.string	"USARTtoUSB_Buffer"
.LASF89:
	.string	"ReportSize"
.LASF75:
	.string	"parserTail"
.LASF130:
	.string	"USB_USBTask"
.LASF8:
	.string	"long long int"
.LASF135:
	.string	"EVENT_USB_Device_Disconnect"
.LASF26:
	.string	"Modifier"
.LASF62:
	.string	"KeyboardQueue"
.LASF79:
	.string	"rawKeyboardFrame"
.LASF84:
	.string	"CALLBACK_HID_Device_ProcessHIDReport"
.LASF122:
	.string	"__iRestore"
.LASF118:
	.string	"RingBuffer_GetCount"
.LASF38:
	.string	"IdleMSRemaining"
.LASF126:
	.string	"HID_Device_ProcessControlRequest"
.LASF10:
	.string	"DEVICE_STATE_Unattached"
.LASF48:
	.string	"__file"
.LASF51:
	.string	"size"
.LASF129:
	.string	"HID_Device_USBTask"
.LASF125:
	.string	"temp_reg"
.LASF107:
	.string	"KeyboardQueue_IsFull"
.LASF43:
	.string	"USB_MediaReport_Data_t"
.LASF99:
	.string	"partial_wait"
.LASF74:
	.string	"parserHead"
.LASF3:
	.string	"uint16_t"
.LASF103:
	.string	"MediaQueue_IsFull"
.LASF137:
	.string	"LoadNextSerialFrameIfAvailable"
.LASF28:
	.string	"KeyCode"
.LASF55:
	.string	"HID_KeyboardInterface"
.LASF54:
	.string	"__iob"
.LASF44:
	.string	"Buffer"
.LASF5:
	.string	"long int"
.LASF76:
	.string	"parserCount"
.LASF121:
	.string	"HID_Device_MillisecondElapsed"
.LASF11:
	.string	"DEVICE_STATE_Powered"
.LASF20:
	.string	"wLength"
.LASF93:
	.string	"EVENT_USB_Device_StartOfFrame"
.LASF36:
	.string	"UsingReportProtocol"
.LASF114:
	.string	"RingBuffer_Remove"
.LASF56:
	.string	"HID_MediaInterface"
.LASF17:
	.string	"bRequest"
.LASF91:
	.string	"activeBufferFrame"
.LASF87:
	.string	"ReportType"
.LASF96:
	.string	"SetupHardware"
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
.LASF116:
	.string	"sreg_save"
.LASF1:
	.string	"unsigned char"
.LASF15:
	.string	"DEVICE_STATE_Suspended"
.LASF30:
	.string	"InterfaceNumber"
.LASF58:
	.string	"PrevMediaHIDReportBuffer"
.LASF61:
	.string	"mediaData"
.LASF77:
	.string	"ReceivedByte"
.LASF0:
	.string	"signed char"
.LASF98:
	.string	"main"
.LASF21:
	.string	"USB_Request_Header_t"
.LASF27:
	.string	"Reserved"
.LASF34:
	.string	"PrevReportINBuffer"
.LASF123:
	.string	"__iCliRetVal"
.LASF117:
	.string	"__ToDo"
.LASF52:
	.string	"udata"
.LASF109:
	.string	"MapMediaUsage"
.LASF124:
	.string	"wdt_disable"
.LASF83:
	.string	"__vector_23"
.LASF115:
	.string	"Data"
.LASF65:
	.string	"CurrentKeyboardState"
.LASF102:
	.string	"MediaQueue_Push"
.LASF80:
	.string	"mLow"
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
