@Spur Skl: adjacent allies gain +4 luck in combat.
.equ SpurSklID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@ mov r0, r5       @Move defender data into r1.
@ mov r1, #0x50    @Move to the defender's weapon type.
@ ldrb r1, [r0,r1]
@ cmp     r1,#0x03    @physical weapon?
@ bgt     Done

@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, SpurSklID
mov r2, #0 @can_trade
mov r3, #1 @range
.short 0xf800
cmp r0, #0
beq Done

mov		r0,#0x60	@hit
ldrh	r1,[r4,r0]
add		r1,#12
strh	r1,[r4,r0]
mov		r0,#0x66	@crit
ldrh	r1,[r4,r0]
add		r1,#3
strh	r1,[r4,r0]
ldrb	r0,[r4,#0x15]
add		r0,#6
strb	r0,[r4,#0x15]

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD SpurSklID
