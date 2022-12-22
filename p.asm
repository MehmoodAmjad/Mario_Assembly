include \DISPLAYT.inc
.model small
.stack 100h

.data

;====== to get out of procedures ===================
pointer dw ?		
pointerObs1 dw ?	
pointerObs2 dw ?
pointerObs3 dw ?
pointerChar dw ?
pointerFlag dw ?
pointerMenu dw ?
pointerFloor dw ?
pointerBack dw ?
pointerMenuDisplay dw ?
pointerCastle dw ?
pointerMonster dw ?
pointerLife dw ?
pointerBomb1 dw ?
pointerBomb2 dw ?
pointerBomb3 dw ?
enemy1Pointer dw ?
enemy2Pointer dw ?
;===================================================

;===========Bool for jumping and Falling============
jumpBool dw 0
fallBool dw 0
jumpMode dw 0
;===================================================

;======Enemy1===============
enemy1x db 22
enemy1y db 23
enemy1width db 2
enemy1Dir db 1
;========================

;======Enemy2===============
enemy2x db 40
enemy2y db 23
enemy2width db 2
enemy2Dir db 1
;========================

;======Dragon============
dragonX db 37
dragonY db 0
dragonDir db 1		; direction of dragon
bombContain1 db 1
bombContain2 db 1
bombContain3 db 1
;========================

;======Bomb 1===========
bomb1X db 18
bomb1Y db 3
bomb1Exist db 0		; if bomb is dropped or not
bomb1freeze db 0 	; variable to slow the speed of bomb, (freezeframe)
;=======================

;======Bomb 2===========
bomb2X db 39
bomb2Y db 3
bomb2Exist db 0		; if bomb is dropped or not
bomb2freeze db 0 	; variable to slow the speed of bomb, (freezeframe)
;=======================

;======Bomb 3===========
bomb3X db 59
bomb3Y db 3
bomb3Exist db 0		; if bomb is dropped or not
bomb3freeze db 0 	; variable to slow the speed of bomb, (freezeframe)
;=======================

;=======================
lifemsg db 10,13,"Lives : ",10,13,10,13,10,13,10,13,10,13,10,13,10,13,10,13,'$'		; msg for lives remaining
lifeCount db 3										; lifeCount
;=======================

;=======level==============
level db 1										; count for level
;==========================

;===Jump Count for jumping (7 in this case)=========
jumpCount db 0										; Jump count variable  (for one up , 7 jump increments)
;===================================================

;=============Menu==================================
menuChoice db 1										; Menu choice for line under choice
gameStart db 0										; if game starts, gameStart=1

msg1 db 10,13,10,13,10,13,10,13,10,13,10,13,10,13,10,13,10,13,10,13,"                                ",'$'		;
msg2 db 10,13,10,13,10,13,10,13,10,13,10,13,"                                  start game",10,13,'$'				
msg3 db 10,13,10,13,10,13,10,13,"                                  Exit Game",10,13,'$'				;	strings 
msg4 db 10,13,10,13,10,13,'$'							;
msg5 db "Created by: Sher Ali, Faizan ul Hassan , Mehmod Amjad ",'$'							;
;===================================================

;============Bricks for floor ======================
floorBrick1 db 0
floor1num db 10
floor1numExtra db 10
;===================================================

;==============Char Head============================
xHead db 5
yHead db 18
widthHead db ?
;===================================================
;==============Character Neck=======================
xNeck db 6
yNeck db 19
widthNeck db ?
;===================================================

;=============Character Chest=======================
xChest db 5
yChest db 20
widthChest db ?
heightChest db ?
;===================================================

;==============Character left leg==================
xLeg1 db 5
yLeg1 db 22
;===================================================

;============Character right leg====================
xLeg2 db 7
yLeg2 db 22
;===================================================

;============Gameover variables=====================
endColor db 0
endx1 db 0
endx2 db 0
endy1 db 0
endy2 db 0
;===================================================

;==================================================================================================
;==================================================================================================
;===================================Start of Code segment==========================================
;==================================================================================================
;==================================================================================================
;==================================================================================================

.code		;====Code Segment=======

jmp start			;====Jump to main proc skipping all procedures====


;==========Start of Delay Procedure=================
delay proc

push ax
push bx
push cx
push dx

mov cx,2000
mydelay:

mov bx,50    ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.

mydelay1:
dec bx
jnz mydelay1
loop mydelay

pop dx
pop cx
pop bx
pop ax

ret
delay endp
;==========End of Delay Procedure===================

;===========Start of backGround proc================
background proc
pop pointerBack


mov ah,6		
mov al,0
mov bh,00110000b
mov ch,0
mov cl, 0
mov dh,25
mov dl,180
int 10h

push pointerBack
ret 
background endp
;===========End of BackGround proc

;===========Floor==================================
floor proc
pop pointerFloor


mov ah,6		
mov al,0
mov bh,10000000b		; black for background of bricks
mov ch,23
mov cl, 0
mov dh,25
mov dl,180
int 10h


mov floorbrick1,0
mov bl,floor1numExtra 
mov floor1num,25

;=========================== Start of uper  level
l1:				
cmp floor1num,0
je endl1

mov ah,6		
mov al,0
mov bh,11000000b
mov ch,23
mov cl, floorbrick1
mov dh,23
mov bl,floorbrick1
add bl,2
mov dl,bl
int 10h

add floorbrick1,5
dec floor1num
jmp l1

endl1:
;========================== End of upper level ===
;=========================== Start of lower  level
mov floorbrick1,2
mov bl,floor1numExtra 
mov floor1num,25

l2:
cmp floor1num,0
je endl2

mov ah,6		
mov al,0
mov bh,11000000b
mov ch,24
mov cl, floorbrick1
mov dh,24
mov bl,floorbrick1
add bl,2
mov dl,bl
int 10h

add floorbrick1,5
dec floor1num
jmp l2

endl2:
;========================== End of lower level ===
push pointerFloor
ret
floor endp
;=============================End of floor procedure=============================

;=========Start of Displaying Character=============
character proc		
pop pointerChar 

mov ah,6		; head
mov al,0
mov bh,11000000b
mov ch,yHead
mov cl,xHead
sub cl,1
sub ch,2
mov dh,yHead
mov widthHead,cl
add widthHead,4
mov dl,widthHead
int 10h

mov ah,6		; face
mov al,0
mov bh,01100000b
mov ch,yHead
sub ch,1
mov cl, xHead
sub cl,1
mov dh,yHead
mov widthHead,cl
add widthHead,4
mov dl,widthHead
int 10h


mov ah,6		; right eye
mov al,0
mov bh,00000000b
mov ch,yHead
sub ch,1
mov cl, xHead
add cl,2
mov dh,yHead
sub dh,1
mov dl,xHead
add dl,2
int 10h

mov ah,6		; right eye
mov al,0
mov bh,00000000b
mov ch,yHead
sub ch,1
mov cl, xHead
mov dh,yHead
sub dh,1
mov dl,xHead
int 10h

mov ah,6		; mouth
mov al,0
mov bh,11110000b
mov ch,yHead
mov cl, xHead
add cl,1
mov dh,yHead
mov dl,xHead
add dl,1
int 10h

mov ah,6		; neck
mov al,0
mov bh,01100000b
mov ch,yNeck
mov cl, xNeck
mov dh,yNeck
mov dl,xNEck
int 10h

mov ah,6		; chest
mov al,0
mov bh,00010000b
mov ch,yChest
mov cl,xChest
mov heightChest,ch
inc heightChest
mov dh,heightChest
mov widthChest,cl
add widthChest,2
mov dl,widthChest
int 10h

mov ah,6		; left arm
mov al,0
mov bh,01100000b
mov ch,yChest
mov cl,xChest
mov dh,yChest
mov dl,xChest
int 10h


mov ah,6		; right arm
mov al,0
mov bh,01100000b
mov ch,yChest
mov cl,xChest
add cl,2
mov dh,yChest
mov dl,xChest
add dl,2
int 10h

mov ah,6		; leftLeg
mov al,0
mov bh,01100000b
mov ch,yLeg1
mov cl,xLeg1
mov dh,yLeg1
mov dl,xLeg1
int 10h

mov ah,6		; rightLeg
mov al,0
mov bh,01100000b
mov ch,yLeg2
mov cl,xLeg2
mov dh,yLeg2
mov dl,xLeg2
int 10h

push pointerChar
ret
character endp
;===============End of displaying Character==============

;==============Display  Menu===========================
displayMenu proc
pop pointerMenuDisplay


mov ah,02h  ;setting cursor position
mov dh,10    ;row 
mov dl,35     ;column
int 10h

mov dx,offset msg1	
mov ah,09h
int 21h

mov dx,offset msg2
mov ah,09h
int 21h

mov dx,offset msg3
mov ah,09h
int 21h

mov dx,offset msg4
mov ah,09h
int 21h

mov dx,offset msg5
mov ah,09h
int 21h
 

cmp menuChoice,1
je upperLine
cmp menuChoice,2
je lowerLine

upperLine:				; if line is under start game
mov ah,02h  
mov dh,16    ;row 
mov dl,34     ;column
int 10h

mov ah,09h
mov bl,0eh   ;colour
mov cx,11      ;no.of times
mov al,'_'      ;print _
int 10h 
jmp here	

lowerLine:				; if line is under exit game
mov ah,02h  
mov dh,21    ;row 
mov dl,34     ;column
int 10h

mov ah,09h
mov bl,0eh   ;colour
mov cx,11      ;no.of times
mov al,'_'      ;print B
int 10h 



here:

push pointerMenuDisplay
ret
displayMenu endp
;====================================================

;===============Start of Menu============================
mainMenu proc
pop pointerMenu

repeat1:

mov ax,03h 			;====== clear screen
int 10h

displayTitle ali		; display title from macro display

call displayMenu		; display start and exit game


; Get keystroke
mov ah,0
int 16h
; AH = BIOS scan code
cmp ah,48h
je up
cmp ah,50h
je down

cmp al,0Dh			; up key
je EnterKey
cmp ah,20h			; down key
je EnterKey
cmp ah,1
jne repeat1 			 ; loop until enter is pressed
mov ah,4ch
int 21h

up:				; up key condition
mov menuChoice,1
jmp repeat1

down:				; down key condition
mov menuChoice,2
jmp repeat1


EnterKey:			; Enter key condition

cmp menuChoice,1
je startGame
mov ah,4ch
int 21h

startGame:

call display		;================Calling display function (all game) 

push pointerMenu
ret
mainMenu endp
;===============End of Menu==============================

;=============Start of enemy============================
enemy1 proc
pop enemy1Pointer

mov ah,6		;upper part
mov al,0
mov bh,11100000b
mov ch,20
mov cl,enemy1x
mov dh,20
mov dl,enemy1width
add dl,enemy1x
int 10h
 
mov ah,6		;middle part
mov al,0
mov bh,11100000b
mov ch,21
mov cl,enemy1x
sub cl,1 
mov dh,21
mov dl,enemy1width
add dl,enemy1x
inc dl
int 10h


mov ah,6		;lower part
mov al,0
mov bh,11110000b
mov ch,22
mov cl,enemy1x 
mov dh,22
mov dl,enemy1width
add dl,enemy1x
int 10h


mov ah,6		;left eye
mov al,0
mov bh,00000000b
mov ch,21
mov cl,enemy1x
mov dh,21
mov dl,enemy1width
add dl,enemy1x
sub dl,2
int 10h


mov ah,6		;right eye
mov al,0
mov bh,00000000b
mov ch,21
mov cl,enemy1x
add cl,2
mov dh,21
mov dl,enemy1width
add dl,enemy1x
int 10h


push enemy1Pointer 
ret 
enemy1 endp
;============end of enemy============================

;=============Start of enemy2============================
enemy2 proc
pop enemy2Pointer 

mov ah,6		;upper part
mov al,0
mov bh,11100000b
mov ch,20
mov cl,enemy2x
mov dh,20
mov dl,enemy2width
add dl,enemy2x
int 10h
 
mov ah,6		;middle part 
mov al,0
mov bh,11100000b
mov ch,21
mov cl,enemy2x
sub cl,1 
mov dh,21
mov dl,enemy2width
add dl,enemy2x
inc dl
int 10h


mov ah,6		;lower part
mov al,0
mov bh,11110000b
mov ch,22
mov cl,enemy2x 
mov dh,22
mov dl,enemy2width
add dl,enemy2x
int 10h

mov ah,6		;left eye
mov al,0
mov bh,00000000b
mov ch,21
mov cl,enemy2x
mov dh,21
mov dl,enemy2width
add dl,enemy2x
sub dl,2
int 10h


mov ah,6		;right eye
mov al,0
mov bh,00000000b
mov ch,21
mov cl,enemy2x
add cl,2
mov dh,21
mov dl,enemy2width
add dl,enemy2x
int 10h

push enemy2Pointer 
ret 
enemy2 endp
;============end of enemy============================

;===============Start of Displaying Third obstacle=======
thirdObs proc		; third obstacle
pop pointerObs3

mov ah,6		;lower part
mov al,0
mov bh,00000000b
mov ch,20
mov cl,58
mov dh,23
mov dl,60
int 10h

mov ah,6		; upper part
mov al,0
mov bh,00100000b
mov ch,19
mov cl,56
mov dh,19
mov dl,62
int 10h

push pointerObs3
ret
thirdObs endp
;===============End of Displaying Third obs==============


;===========Start of displaying second obs===============
secondObs proc		; second obstacle
pop pointerObs2

mov ah,6
mov al,0
mov bh,00000000b	; lower
mov ch,21
mov cl,38
mov dh,23
mov dl,39
int 10h

mov ah,6
mov al,0
mov bh,00100000b	; upper
mov ch,20
mov cl,37
mov dh,20
mov dl,40
int 10h

push pointerObs2
ret
secondObs endp
;==================End of Displaying second obs=======================


;===========Start of displaying first obs===========================
firstObs proc		; first obstacle
pop pointerObs1

mov ah,6
mov al,0
mov bh,00000000b		; lower
mov ch,19
mov cl,17
mov dh,23
mov dl,19
int 10h

mov ah,6
mov al,0
mov bh,00100000b		; upper
mov ch,18
mov cl,14
mov dh,18
mov dl,22
int 10h

push pointerObs1
ret
firstObs endp
;=========End of displaying first obs========================

flagPole proc		; flag pole
pop pointerFlag

mov ah,6	;pole
mov al,0
mov bh,01100000b
mov ch,0
mov cl,78
mov dh,22
mov dl,78
int 10h

mov ah,6	; flag
mov al,0
mov bh,00100000b
mov ch,0
mov cl,55
mov dh,5
mov dl,78
int 10h

mov ah,6	; flag
mov al,0
mov bh,11110000b
mov ch,0
mov cl,73
mov dh,5
mov dl,78
int 10h

mov ah,6	; flag
mov al,0
mov bh,11110000b
mov ch,1
mov cl,61
mov dh,1
mov dl,61
int 10h

mov ah,6	; flag
mov al,0
mov bh,11110000b
mov ch,2
mov cl,60
mov dh,2
mov dl,60
int 10h

mov ah,6	; flag
mov al,0
mov bh,11110000b
mov ch,3
mov cl,61
mov dh,3
mov dl,61
int 10h

mov ah,6	; flag
mov al,0
mov bh,11110000b
mov ch,0
mov cl,62
mov dh,0
mov dl,63
int 10h

mov ah,6	; flag
mov al,0
mov bh,11110000b
mov ch,4
mov cl,62
mov dh,4
mov dl,63
int 10h

mov ah,6	; flag
mov al,0
mov bh,11110000b
mov ch,2
mov cl,66
mov dh,2
mov dl,68
int 10h

mov ah,6	; flag
mov al,0
mov bh,11110000b
mov ch,1
mov cl,67
mov dh,3
mov dl,67
int 10h

push pointerFlag
ret
flagPole endp
;=============End of displaying flag pole================
;=============Start of printing Castle===================
castle proc
pop pointerCastle

mov ah,6
mov al,0
mov bh,01100000b
mov ch,19
mov cl,69
mov dh,22
mov dl,79
int 10h

mov al,0
mov bh,11110000b
mov ch,11
mov cl,74
mov dh,22
mov dl,74
int 10h

mov al,0
mov bh,01000000b
mov ch,16
mov cl,70
mov dh,18
mov dl,78
int 10h


mov al,0
mov bh,00000000b
mov ch,15
mov cl,73
mov dh,22
mov dl,75
int 10h

mov al,0
mov bh,01000000b
mov ch,21
mov cl,74
mov dh,22
mov dl,74
int 10h

mov al,0
mov bh,00000000b
mov ch,20
mov cl,77
mov dh,21
mov dl,78
int 10h

mov al,0
mov bh,00000000b
mov ch,20
mov cl,70
mov dh,21
mov dl,71
int 10h

mov al,0
mov bh,01100000b
mov ch,15
mov cl,72
mov dh,15
mov dl,76
int 10h

mov al,0
mov bh,00010000b
mov ch,11
mov cl,74
mov dh,11
mov dl,78
int 10h

push pointerCastle
ret
castle endp
;==============End of castle print==================

;==============Start of printing Monster=============
monster proc
pop pointerMonster
;Monster
mov al,0
mov bh,01000000b
mov ch,dragonY
mov cl,dragonX
mov dh,dragony
add dh,4
mov dl,dragonX
add dl,13
int 10h

mov al,0
mov bh,11110000b
mov ch,dragonY
add ch,1
mov cl,dragonX
add cl,2
mov dh,dragonY
add dh,2
mov dl,DragonX
add dl,4
int 10h

mov al,0
mov bh,0
mov ch,dragonY
add ch,2
mov cl,dragonX
add cl,3
mov dh,dragonY
add dh,2
mov dl,dragonX
add dl,4
int 10h

mov al,0
mov bh,11110000b
mov ch,dragonY
add ch,1
mov cl,dragonX
add cl,9
mov dh,dragonY
add dh,2
mov dl,dragonX
add dl,11
int 10h

mov al,0
mov bh,0
mov ch,dragonY
add ch,2
mov cl,dragonX
add cl,9
mov dh,dragonY
add dh,2
mov dl,dragonX
add dl,10
int 10h

mov al,0
mov bh,11110000b
mov ch,dragonY
add ch,4
mov cl,dragonX
add cl,6
mov dh,dragonY
add dh,4
mov dl,dragonX
add dl,7

int 10h

push pointerMonster
ret 
monster endp
;===========End of printing dragon=================

;============Bomb 1 proc========================
bomb1 proc
pop pointerBomb1

mov ah,6
mov al,0
mov bh,00000000b
mov ch,bomb1Y
mov cl,bomb1X
mov dh,bomb1Y
add dh,1
mov dl,bomb1X
add dl,1
int 10h

push pointerBomb1
ret
bomb1 endp
;============end of Bomb 1 proc========================

;============Bomb 2 proc===========================
bomb2 proc
pop pointerBomb2

mov ah,6
mov al,0
mov bh,00000000b
mov ch,bomb2Y
mov cl,bomb2X
mov dh,bomb2Y
add dh,1
mov dl,bomb2X
add dl,1
int 10h

push pointerBomb2
ret
bomb2 endp
;=============end of Bomb2 proc======================

;============Bomb 3 proc===========================
bomb3 proc
pop pointerBomb3

mov ah,6
mov al,0
mov bh,00000000b
mov ch,bomb3Y
mov cl,bomb3X
mov dh,bomb3Y
add dh,1
mov dl,bomb3X
add dl,1
int 10h

push pointerBomb3
ret
bomb3 endp
;==============end of Bomb3 proc===================

;==============life Count=============================
life proc
pop pointerLife

mov ah,6
mov al,0
mov bh,00000000b	; Red boundry
mov ch,0
mov cl,0
mov dh,8
mov dl,7
int 10h

mov ah,6
mov al,0	
mov bh,11110000b	; white inner
mov ch,1
mov cl,0
mov dh,7
mov dl,6
int 10h


cmp lifeCount,1
jge display1life
jmp noLife

display1Life:		; one life
mov ah,6
mov al,0
mov bh,11000000b		
mov ch,2
mov cl,2
mov dh,2
mov dl,3
int 10h

cmp lifeCount,2
jge display2life
jmp nolife

display2life:		; two life
mov ah,6
mov al,0
mov bh,11000000b
mov ch,4
mov cl,2
mov dh,4
mov dl,3
int 10h

cmp lifeCount,3
jge display3life
jmp nolife

display3life:		; three life
mov ah,6
mov al,0
mov bh,11000000b
mov ch,6
mov cl,2
mov dh,6
mov dl,3
int 10h

nolife:
push pointerLife
ret
life endp
;==================================================

;=============Start of Main procedure for Game====================
display proc
pop pointer

repeat1:			;======loop to call display functions and implementation of game

mov ah,0Ch
mov al,0
int 21h

call delay

mov ax,03h 			;====== clear screen
int 10h

cmp level,4			;=====Condition for Winning game if level 4
je endGame
			

call background			;
call firstObs			;
call secondObs			;
call thirdObs			;	Calling Display functions 
call floor			;
call character			;
call life			;


mov dx,offset lifemsg 		; remaing life msg
mov ah,09
int 21h


cmp level,2			; if less tham or equal to 2 print flag 
jle printFlag
jmp printCastleAndDragon	; if level==3 , print monster and castle

printFlag:			; print flag if level <3
call flagPole
jmp afterCastle

printCastleAndDragon:		; printing castle level>3
call castle
call monster

afterCastle:	

cmp level,3			; if level 3 then monster is formed and will start to move
je dragonMovement
jmp noDragon			; no dragon or after dragon movement

dragonMovement:			
cmp dragonDir,1
je leftMovement
cmp dragonDir,2
je rightMovement


leftMovement:			; left movement 
cmp dragonX,9
jg decDragonX
cmp dragonX,9
je changeDragonDirRight

rightMovement:			; right movement
cmp dragonX,61
jl incDragonX
cmp dragonX,61
je changDragonDirLeft

incDragonX:			;moving dragon right
inc dragonX
jmp noDragon

decDragonX:			; moving dragon left
dec dragonX
jmp noDragon

changDragonDirLeft:		; changing direction 
mov dragonDir,1
jmp noDragon

changeDragonDirRight:		
mov dragonDir,2

noDragon:			; skipping dragon

cmp level,3
je bombCheck			; check if bomb should be dropped
jmp noDragonNoBomb

bombCheck:
cmp dragonX,12
je checkBomb1
cmp dragonX,33
je checkBomb2
cmp dragonX,53
je checkBomb3
jmp noDragonNoBomb

checkBomb1:
cmp bombContain1,1		; if dragon contains bomb drop
je DropBomb1
jmp noDragonNoBomb

DropBomb1:
mov bombContain1,0
mov bomb1Exist,1 		; form bomb
jmp noDragonNoBomb

checkBomb2:
cmp bombContain2,1		; if dragon contains bomb drop
je DropBomb2
jmp noDragonNoBomb

DropBomb2:
mov bombContain2,0
mov bomb2Exist,1 		; form bomb
jmp noDragonNoBomb

checkBomb3:
cmp bombContain3,1		; if dragon contains bomb drop
je DropBomb3
jmp noDragonNoBomb

DropBomb3:
mov bombContain3,0
mov bomb3Exist,1  		; form bomb
jmp noDragonNoBomb

noDragonNoBomb:

;===================Drawing bombs==============================
cmp bomb1Exist,1	
je DrawBomb1
jmp dontDrawBomb1

DrawBomb1:
cmp bomb1Y,16		; if bomb reaches 16 , un form
jl keepDropingBomb1
jmp stopDroppingBomb1

keepDropingBomb1:

cmp bomb1freeze,1	; freeze frame for one sec and star again	
je bomb1FreezeFrame
jmp noBomb1freeze

bomb1FreezeFrame:
call bomb1 		; drawing bomb
mov bomb1freeze,0
jmp dontDrawBomb1

noBomb1freeze:
inc bomb1Y		; moving bomb
call bomb1
mov bomb1freeze,1

jmp dontDrawBomb1

stopDroppingBomb1:	
mov bomb1Exist,0
mov bombContain1,1
mov bomb1Y,3

dontDrawBomb1:		; 	

cmp bomb2Exist,1	
je DrawBomb2
jmp dontDrawBomb2

DrawBomb2:
cmp bomb2Y,18		; if bomb reaches 18 , un form
jl keepDropingBomb2
jmp stopDroppingBomb2

keepDropingBomb2:

cmp bomb2freeze,1	; freeze frame for one sec and star again
je bomb2FreezeFrame
jmp noBomb2freeze

bomb2FreezeFrame:
call bomb2 		; drawing bomb
mov bomb2freeze,0
jmp dontDrawBomb2

noBomb2freeze:
inc bomb2Y
call bomb2
mov bomb2freeze,1
jmp dontDrawBomb2

stopDroppingBomb2:
mov bomb2Exist,0
mov bombContain2,1
mov bomb2Y,3

dontDrawBomb2:

cmp bomb3Exist,1
je DrawBomb3
jmp dontDrawBomb3

DrawBomb3:
cmp bomb3Y,17		; if bomb reaches 17 , un form
jl keepDropingBomb3
jmp stopDroppingBomb3

keepDropingBomb3:

cmp bomb3freeze,1	; freeze frame for one sec and star again
je bomb3FreezeFrame
jmp noBomb3freeze

bomb3FreezeFrame:
call bomb3 		; drawing bomb
mov bomb3freeze,0
jmp dontDrawBomb3

noBomb3freeze:
inc bomb3Y
call bomb3
mov bomb3freeze,1
jmp dontDrawBomb3

stopDroppingBomb3:
mov bomb3Exist,0
mov bombContain3,1
mov bomb3Y,3

dontDrawBomb3:
;=========================bomb implementation====================

;=========================Collision with bombs===================

cmp xleg2,17
jge bomb1Checkleg1
jmp nocollisionWithBombs

bomb1Checkleg1:
cmp xleg1,20
jle checkBomb1y
cmp xleg2,39
jge bomb2Checkleg1
jmp nocollisionWithBombs

bomb2Checkleg1:
cmp xleg1,40
jle checkBomb2y
cmp xleg2,59
jge bomb3Checkleg2
jmp nocollisionWithBombs

bomb3checkleg2:
cmp xleg1,60
jle checkBomb3Y
jmp nocollisionWithBombs

checkBomb1Y:
cmp bomb1Y,9
jge endlife
jmp nocollisionWithBombs

checkBomb2Y:
cmp bomb2y,13
jge endlife
jmp nocollisionWithBombs

checkBomb3Y:
cmp bomb3y,12
jge endlife
jmp nocollisionWithBombs

;============================Ending collision with bombs================

nocollisionWithBombs:

cmp level,2		
jge cEnemies1
jmp cmpLevel

cEnemies1:	; creating enemies
call enemy1
call enemy2

;=================moving enemies==============================

cmp enemy1dir,1
je rightMov1
cmp enemy1dir,2
je leftMov1

leftMov1:
cmp enemy1X,22
jg decEnemy1X
cmp enemy1X,22
je changeDirection1inc
 
rightMov1:
cmp enemy1X,33
jl incEnemy1X
cmp enemy1X,30
je changeDirection1dec

changeDirection1dec:
mov enemy1Dir,2
jmp enemy2All

changeDirection1inc:
mov enemy1Dir,1
jmp enemy2All

 decEnemy1X:
dec enemy1X
jmp enemy2All

incEnemy1X:
inc enemy1X


enemy2All:

cmp enemy2dir,1
je rightMov2
cmp enemy2dir,2
je leftMov2

leftMov2:
cmp enemy2X,42
jg decEnemy2X
cmp enemy2X,42
je changeDirection2inc
 
rightMov2:
cmp enemy2X,54
jl incEnemy2X
cmp enemy2X,54
je changeDirection2dec

changeDirection2dec:
mov enemy2Dir,2
jmp cmplevel

changeDirection2inc:
mov enemy2Dir,1
jmp cmplevel

decEnemy2X:
dec enemy2X
jmp cmplevel

incEnemy2X:
inc enemy2X

;=================end of moving enemies==============================

; =================Level up=======================================
cmpLevel:
cmp xleg2,78
je levelup
jmp sameLevel

levelup:
mov xHead,5
mov yHead,18
mov xNeck,6
mov yNeck,19
mov xChest,5
mov yChest,20
mov xLeg1,5
mov yLeg1,22
mov xLeg2,7
mov yLeg2,22
inc level

;=================end of level up====================================
samelevel:

cmp level,2
jge enemiesCanColide
jmp enemCantCollide

;=================enemies colliding ==================================
enemiesCanColide:

cmp yleg2,22
jle collfirstchecky1
jmp nocollisionForOne

collfirstchecky1:
cmp yleg2,19
jge collfirstCheckx1
jmp nocollisionForOne

collfirstCheckx1:
mov al,enemy1X
cmp xleg2,al
jge collfirstCheckx2
jmp nocollisionForOne

collfirstCheckx2:
mov al,enemy1X
add al,2
cmp xleg1,al
jle endlife
jmp nocollisionForOne

endlife:
dec lifeCount
cmp lifeCount,0
jg lifeRemaining
jmp endGame

lifeRemaining:
mov xHead,5
mov yHead,18
mov xNeck,6
mov yNeck,19
mov xChest,5
mov yChest,20
mov xLeg1,5
mov yLeg1,22
mov xLeg2,7
mov yLeg2,22
jmp repeat1



endGame:			;====================================  Game Over===========================
call gameover
mov ah,4ch 
int 21h

nocollisionForOne:


cmp yleg2,22
jle collsecondchecky1
jmp nocollisionFortwo

collsecondchecky1:
cmp yleg2,20
jge collsecondCheckx1
jmp nocollisionFortwo

collsecondCheckx1:
mov al,enemy2X
cmp xleg2,al
jge collsecondCheckx2
jmp nocollisionFortwo

collsecondCheckx2:
mov al,enemy2X
add al,2
cmp xleg1,al
jle endlife
jmp nocollisionFortwo

nocollisionFortwo:

;===========================End of colliding with enemies===========================

enemCantCollide:

cmp jumpBool,1			;=======Checking if in process of jumping  ,(1 = jumping,	0 = not jumping or falling)
je jumping
jmp notjumping			;if not jumping, skip 

jumping:			; if jumpCount < 7 , move up one pixel
cmp jumpCount,7
jl moveUp
cmp jumpCount,7
je jumpEqual			;if jumpCount equal to 1 , stop jumping

moveUp:				; Dec the character's y , (dec=up , inc =down) , moving up
dec yHead
dec yNeck
dec yChest
dec yLeg1
dec yLeg2
inc jumpCount			; incrementing jumpCount

jmp notjumping

jumpEqual:			; if jumpcountEqual to 1 , make jumpBool =0 , stop jumping  and make fallBool=1
mov jumpCount,0
mov jumpBool,0
mov jumpMode,0
mov fallBool,1

notjumping:


cmp jumpMode,1	; check if jumping then cna not fall
je jumpModeIs1

;====================Falling ==============================

cmp fallBool,1			;=======Checking if falling bool=1 , (1= falling 	, 	0= not falling)
je falling
cmp xleg2,14
jl checky1
cmp xleg2,24
jg checkNormal1
jmp notFalling

checkNormal1:
cmp xleg2,37
jl normalFall
cmp xleg2,41
jg checkx2Second
jmp notFalling

checkx2Second:
cmp xleg2,56
jl checky2
cmp xleg2,65
jge normalFall
jmp notFalling

checky2:
cmp yleg2,22
jl falling
jmp notfalling

checky1:
cmp yleg2,22
jl falling
jmp notfalling

falling:			;=======Comparing leg of character  

cmp xleg2,14
jl normalFall
cmp xleg2,14
jge obstacleJumpCheckx1

normalFall:
cmp yleg2,22
jl moveDown
cmp yleg2,22			; if equal to 24 , stop falling, character is on ground
je fallEqual

obstacleJumpCheckx1:
cmp xleg2,24
jle obstaclefall1
cmp xleg2,37
jge obstacleJumpCheckx2
jmp normalfall

obstacleJumpCheckx2:
cmp xleg2,42
jle obstaclefall2
cmp xleg2,56
jge obsrackeJumpCheckx3
jmp normalfall

obsrackeJumpCheckx3:
cmp xleg2,64
jle obstaclefall3
jmp normalfall

obstaclefall3:
cmp yleg2,18
jl moveDown
cmp yleg2,18
je fallEqual


obstaclefall2:
cmp yleg2,19
jl moveDown
cmp yleg2,19
je fallEqual

obstaclefall1:
cmp yleg1,17
jl moveDown
cmp yleg1,17
je fallEqual

moveDown:			; will increment the character y , and character will move down
inc yHead
inc yNeck
inc yChest
inc yLeg1
inc yLeg2

;=================================Enmd of falling proced===============================

jmp notFalling


fallEqual:			; if character is not falling make fallbool=0 
mov fallBool,0

notFalling:

jumpModeIs1:

call delay			;=============Calling Delay==================

;========Can input keys, without stopping the program==============(important)
mov ah,0bh
int 21h
cmp al,0	; if no button press skip next
je after


mov ah,0	;==== if button pressed, getting button information
int 16h

; AH = BIOS scan code
cmp ah,48h	;==UP
je up
cmp ah,4Bh	;==left
je left
cmp ah,4Dh	;==Right
je right

cmp ah,1
jne repeat1  	;==loop until Esc is pressed
jmp endAli 

up:				;====implementation if key == UP, This will set the jumpBool=1 and character will start jumping
mov jumpBool,1
mov jumpMode,1
jmp repeat1

left:				; ==Implemetation if Key==Left, this will dec character x axis=====(move left)

cmp xleg1,36
jg secondCollisonLeft

;======Checking for first obstacle collision (Left move)====================
cmp xleg1,23		; Checking for first obstacle
jg canMoveLeft
cmp xleg1,23
jl canMoveLeft
cmp xleg1,23
je canNotMoveLeftChecky1

canNotMoveLeftChecky1:	; jump and then you can move, if leg y is less than 20
cmp yleg1,18
jge repeat1
jmp canMoveLeftChecky1

canNotMoveLeft1:	; if y is greator than 20 
jmp repeat1

canMoveLeftChecky1:	; checking if y is less than  20
cmp yleg1,17
jle canMoveLeft
;========End of first obstacle collision (Left move)===========================

secondCollisonLeft:
cmp xleg1,56
jg thirdCollisonLeft

;======Checking for Second obstacle collision (Left move)====================
cmp xleg1,41		; Checking for Second obstacle
jg canMoveLeft
cmp xleg1,41
jl canMoveLeft
cmp xleg1,41
je canNotMoveLeftChecky2

canNotMoveLeftChecky2:	; jump and then you can move, if leg y is less than 21
cmp yleg1,19
jge repeat1
jmp canMoveLeftChecky2

canNotMoveLeft2:	; if y is less than 22 
jmp repeat1

canMoveLeftChecky2:	; checking if y is less than  22
cmp yleg1,19
jl canMoveLeft
;========End of Second obstacle collision (Left move)===========================

thirdCollisonLeft:
;======Checking for Third obstacle collision (Left move)====================
cmp xleg1,63		; Checking for Third obstacle
jg canMoveLeft
cmp xleg1,63
jl canMoveLeft
cmp xleg1,63
je canNotMoveLeftChecky3

canNotMoveLeftChecky3:	; jump and then you can move, if leg y is less than 21
cmp yleg1,18
jge repeat1
jmp canMoveLeftChecky3

canNotMoveLeft3:	; if y is les than 21 
jmp repeat1

canMoveLeftChecky3:	; checking if y is less than  21
cmp yleg1,17
jle canMoveLeft
;========End of Third obstacle collision (Left move)===========================



canMoveleft:
dec xHead
dec xNeck
dec xChest
dec xLeg1
dec xLeg2
jmp repeat1

right:				;==Implementation if key==right, this will inc character x axis===(move right)

cmp xleg2,23
jg secondCollision

;======Checking for first obstacle collision (Right move)====================
cmp xleg2,13		; Checking for first obstacle
jge canNotMoveRightChecky1
cmp xleg2,13
jl canMoveRight
cmp xleg2,13
je canNotMoveRightChecky1

canNotMoveRightChecky1:	; jump and then you can move, if leg y is greator than 20
cmp yleg2,18
jge repeat1
jmp canMoveRightChecky1

canNotMoveRight1:	; if y is greator than 20 
jmp repeat1

canMoveRightChecky1:	; checking if y is less than  21
cmp yleg2,17
jle canMoveRight
;========End of first obstacle collision (Right move)===========================

secondCollision:
cmp xleg2,40
jg thirdCollision

;======Checking for Second obstacle collision (Right move)====================
cmp xleg2,36		; Checking for first obstacle
jg canMoveRight
cmp xleg2,36
jl canMoveRight
cmp xleg2,36
je canNotMoveRightChecky2

canNotMoveRightChecky2:	; jump and then you can move, if leg y is greator than 20
cmp yleg2,19
jge repeat1
jmp canMoveRightChecky2

canNotMoveRight2:	; if y is greator than 20 
jmp repeat1

canMoveRightChecky2:	; checking if y is less than  20
cmp yleg2,18
jle canMoveRight
;========End of Second obstacle collision (Right move)===========================

thirdCollision:
;======Checking for Third obstacle collision (Right move)====================
cmp xleg2,55		; Checking for first obstacle
jg canMoveRight
cmp xleg2,55
jl canMoveRight
cmp xleg2,55
je canNotMoveRightChecky3

canNotMoveRightChecky3:	; jump and then you can move, if leg y is greator than 20
cmp yleg2,18
jge repeat1
jmp canMoveRightChecky3

canNotMoveRight3:	; if y is greator than 20 
jmp repeat1

canMoveRightChecky3:	; checking if y is less than  20
cmp yleg2,17
jle canMoveRight
;========End of Third obstacle collision (Right move)===========================


canMoveRight:
inc xHead
inc xNeck
inc xChest
inc xLeg1
inc xLeg2
jmp repeat1

after:				;=====if no button pressed , come here=====
jmp repeat1


endAli:				;=====if Escape key is pressed , get out of the repeat loop


push pointer
ret 
display endp
;======End of Main procedure for displaying Game===============


;=================================================================
;=================================================================
;===================Start ========================================
;=================================================================
;=================================================================

start:
;========Start of Main proc=================================
main proc

mov ax,@data
mov ds,ax


call mainMenu               


;call display	;================Calling display function (all game) 

mov ah,4ch 
int 21h

main endp


;=======================Gameover display screen============
gameover proc
	mov ah,03h 			;====== clear screen
	int 10h
	mov ah,0h
	mov al,12h
	int 10h
	;G
	mov endColor,6
	mov endx1,22
	mov endx2,27
	mov endy1,3
	mov endy2,3
	call drawRect
	mov endy1,8
	mov endy2,8
	call drawRect
	mov endx1,21
	mov endx2,22
	mov endy1,3
	mov endy2,8
	call drawRect
	mov endx1,26
	mov endx2,27
	mov endy1,6
	mov endy2,8
	call drawRect
	mov endx1,24
	mov endx2,26
	mov endy1,6
	mov endy2,6
	call drawRect
	;A
	mov endColor,4
	mov endx1,30
	mov endx2,31
	mov endy1,3
	mov endy2,8
	call drawRect
	mov endx1,30
	mov endx2,35
	mov endy1,3
	mov endy2,3
	call drawRect
	mov endx1,34
	mov endx2,35
	mov endy1,3
	mov endy2,8
	call drawRect
	mov endx1,31
	mov endx2,35
	mov endy1,5
	mov endy2,5
	call drawRect

	;M
	mov endColor,2
	mov endx1,38
	mov endx2,39
	mov endy1,3
	mov endy2,8
	call drawRect
	mov endx1,43
	mov endx2,44
	mov endy1,3
	mov endy2,8
	call drawRect
	mov endx1,48
	mov endx2,49
	mov endy1,3
	mov endy2,8
	call drawRect
	mov endx1,38
	mov endx2,43
	mov endy1,3
	mov endy2,3
	call drawRect
	mov endx1,44
	mov endx2,49
	mov endy1,3
	mov endy2,3
	call drawRect

	;E
	mov endColor,1
	mov endx1,51
	mov endx2,52
	mov endy1,3
	mov endy2,8
	call drawRect
	mov endx1,52
	mov endx2,57
	mov endy1,3
	mov endy2,3
	call drawRect
	mov endx1,52
	mov endx2,57
	mov endy1,5
	mov endy2,5
	call drawRect
	mov endx1,52
	mov endx2,57
	mov endy1,8
	mov endy2,8
	call drawRect

	;O
	mov endColor,6
	mov endx1,22
	mov endx2,23
	mov endy1,10
	mov endy2,15
	call drawRect
	mov endx1,22
	mov endx2,27
	mov endy1,10
	mov endy2,10
	call drawRect
	mov endx1,28
	mov endx2,29
	mov endy1,10
	mov endy2,15
	call drawRect
	mov endx1,22
	mov endx2,27
	mov endy1,15
	mov endy2,15
	call drawRect

	;V
	mov endColor,4
	mov endx1,31
	mov endx2,32
	mov endy1,10
	mov endy2,13
	call drawRect
	mov endx1,35
	mov endx2,36
	mov endy1,10
	mov endy2,13
	call drawRect
	mov endx1,33
	mov endx2,34
	mov endy1,14
	mov endy2,15
	call drawRect

	;E
	mov endColor,2
	mov endx1,38
	mov endx2,39
	mov endy1,10
	mov endy2,15
	call drawRect
	mov endx1,39
	mov endx2,44
	mov endy1,10
	mov endy2,10
	call drawRect
	mov endx1,39
	mov endx2,44
	mov endy1,12
	mov endy2,12
	call drawRect
	mov endx1,39
	mov endx2,44
	mov endy1,15
	mov endy2,15
	call drawRect

	;R
	mov endColor,1
	mov endx1,46
	mov endx2,47
	mov endy1,10
	mov endy2,15
	call drawRect
	mov endx1,47
	mov endx2,52
	mov endy1,10
	mov endy2,10
	call drawRect
	mov endx1,47
	mov endx2,52
	mov endy1,12
	mov endy2,12
	call drawRect
	mov endx1,51
	mov endx2,52
	mov endy1,10
	mov endy2,12
	call drawRect
	mov endx1,48
	mov endx2,49
	mov endy1,13
	mov endy2,13
	call drawRect
	mov endx1,50
	mov endx2,51
	mov endy1,14
	mov endy2,14
	call drawRect
	mov endx1,51
	mov endx2,52
	mov endy1,15
	mov endy2,15
	call drawRect

	;Y
	mov endColor,4
	mov endx1,13
	mov endx2,13
	mov endy1,21
	mov endy2,22
	call drawRect
	mov endx1,14
	mov endx2,14
	mov endy1,22
	mov endy2,24
	call drawRect
	mov endx1,15
	mov endx2,15
	mov endy1,21
	mov endy2,22
	call drawRect

	;O
	mov endColor,6
	mov endx1,17
	mov endx2,17
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,17
	mov endx2,20
	mov endy1,21
	mov endy2,21
	call drawRect
	mov endx1,20
	mov endx2,20
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,17
	mov endx2,20
	mov endy1,24
	mov endy2,24
	call drawRect

	;U
	mov endColor,1
	mov endx1,22
	mov endx2,22
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,22
	mov endx2,25
	mov endy1,24
	mov endy2,24
	call drawRect
	mov endx1,25
	mov endx2,25
	mov endy1,21
	mov endy2,24
	call drawRect

	cmp lifeCount,0
	je Lost
	;W
	mov endColor,8
	mov endx1,38
	mov endx2,38
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,40
	mov endx2,40
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,42
	mov endx2,42
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,39
	mov endx2,39
	mov endy1,24
	mov endy2,24
	call drawRect
	mov endx1,41
	mov endx2,41
	mov endy1,24
	mov endy2,24
	call drawRect

	;O
	mov endColor,3
	mov endx1,44
	mov endx2,44
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,44
	mov endx2,47
	mov endy1,21
	mov endy2,21
	call drawRect
	mov endx1,48
	mov endx2,48
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,44
	mov endx2,47
	mov endy1,24
	mov endy2,24
	call drawRect

	;N
	mov endColor,2
	mov endx1,50
	mov endx2,50
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,51
	mov endx2,51
	mov endy1,21
	mov endy2,21
	call drawRect
	mov endx1,52
	mov endx2,52
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,53
	mov endx2,53
	mov endy1,24
	mov endy2,24
	call drawRect
	mov endx1,54
	mov endx2,54
	mov endy1,21
	mov endy2,24
	call drawRect
	ret
	Lost:
	;L
	mov endColor,8
	mov endx1,38
	mov endx2,39
	mov endy1,20
	mov endy2,24
	call drawRect
	mov endx1,39
	mov endx2,42
	mov endy1,24
	mov endy2,24
	call drawRect

	;O
	mov endColor,3
	mov endx1,44
	mov endx2,44
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,44
	mov endx2,48
	mov endy1,20
	mov endy2,20
	call drawRect
	mov endx1,48
	mov endx2,48
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,44
	mov endx2,47
	mov endy1,24
	mov endy2,24
	call drawRect

	;S
	mov endColor,4
	mov endx1,50
	mov endx2,50
	mov endy1,21
	mov endy2,22
	call drawRect
	mov endx1,51
	mov endx2,53
	mov endy1,22
	mov endy2,22
	call drawRect
	mov endx1,54
	mov endx2,54
	mov endy1,22
	mov endy2,24
	call drawRect
	mov endx1,50
	mov endx2,54
	mov endy1,24
	mov endy2,24
	call drawRect
	mov endx1,50
	mov endx2,54
	mov endy1,20
	mov endy2,20
	call drawRect

	;T
	mov endColor,2
	mov endx1,58
	mov endx2,59
	mov endy1,21
	mov endy2,24
	call drawRect
	mov endx1,56
	mov endx2,61
	mov endy1,20
	mov endy2,20
	call drawRect
	ret
	drawRect proc
		mov ah,6
		mov al,0
		mov bh,endColor
		mov ch,endy1
		mov cl,endx1
		mov dh,endy2
		mov dl,endx2
		int 10h
		ret
	drawRect endp
gameover endp
end start