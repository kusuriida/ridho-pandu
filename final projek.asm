                        .model small 
                        org 100h 
.data
    buffer db 36,?,36 dup(?)
    kal0 db '    =========================================$'
    KAL1 DB 13,10,'*<< APA YANG ANDA PESAN >>* $'
    KAL2 DB 13,10,'========================================================$'
    KAL3 DB 13,10, '$'
    KAL4 DB 13,10, '1. PAKET NASIGORENG $'
    KAL5 DB 13,10, '2. PAKET AYAM $'
    KAL6 DB 13,10, '3. PAKET SOP $'  
    KAL8 DB 13,10, 'MENU APA YANG TUAN INGINKAN  [1...3] :$'
    KAL9 DB '$',13,10,
    kata1 DB 13,10,'======= PAKET NASI GORENG   RP.15.000,- =========',13,10,'$'
    kata2 DB 13,10,'======= PAKET AYAM GORENG  RP.15.000,- ==========',13,10,'$'
    kata3 DB 13,10,'======= PAKET SOP  RP.17.000,- ==========',13,10,'$'
    KALa DB 13,10,'A. NASI GORENG SEAFOOD',13,10,'B. NASI GORENG AYAM$' 
    KALb DB 13,10,'B. AYAM GEPREK',13,10,'B. AYAM SAOS$'
    KALc DB 13,10,'C. SOP IGA',13,10,'SOP BUNTUT$'
    KALd DB '$',13,10,
    KALi DB 13,10,'MAKANAN APA YANG TUAN PILIH :$'
    kalsalah db 13,10,'MAAF PILIHAN TUAN TIDAK ADA DI MENU ',13,10,'$'
    kembali DB 13,10,'tekan B/b untuk memesan kembali, atau tekan sembarang key untuk keluar :$'
    Kale DB 13,10,'===============================$'
    KALf DB 13,10,'*  SILAHKAN DITUNGGU * $'
    KALg DB 13,10,'*  MAKANAN AKAN KAMI ANTAR *$'
    KALh DB 13,10,'============================== $'

.code


POSISI macro baris, kolom
    mov ah,02h
    mov dh,baris
    mov dl,kolom
    mov bh,00h
    int 10h
endm

cetak_klm macro klm
    mov ah,09
    lea dx,klm 
    int 21h
endm

buffernya macro buf
    mov ah,0Ah
    lea dx,buffer
    int 21h
    
    lea bx,buffer +2 
endm

cls proc near
    mov ah,06h
    mov cx,0000h
    mov dh,24
    mov dl,79
    mov al,00
    mov bh,11010111b
    int 10h
    jmp p1
    POSISI 0,0
    cls endp

Tdata:
POSISI 0,0
jmp cls

p1:
cetak_klm kal0 
cetak_klm kal1
cetak_klm kal2
cetak_klm kal3
cetak_klm kal4
cetak_klm kal5
cetak_klm kal6
cetak_klm kal8
cetak_klm kal9
buffernya 
jmp pilihan

pilihan:
cmp byte ptr [bx],'1'
je paket1
cmp byte ptr [bx],'2'
je paket2
cmp byte ptr [bx],'3'
je paket3
jmp salah

paket1:
cetak_klm kata1 
cetak_klm KALa
cetak_klm KALd
cetak_klm KALi
buffernya 
jmp makanan 

paket2:
cetak_klm kata2 
cetak_klm KALb
cetak_klm KALd
cetak_klm KALi
buffernya 
jmp makanan 

paket3:
cetak_klm kata3 
cetak_klm KALc
cetak_klm KALd
cetak_klm KALi
buffernya 
jmp makanan 

makanan: 
cmp byte ptr [bx],'A'
je makasih 
cmp byte ptr [bx],'B'
je makasih 
jmp salah

makasih: 
cetak_klm KALe 
cetak_klm KALf
cetak_klm KALg
cetak_klm KALh 
buffernya 
jmp cetakback

salah:
cetak_klm kalsalah
jmp cetakback

cetakback:
cetak_klm kembali 
jmp coice

coice:
mov ah,01
int 21h
mov bh,al
cmp bh,'B'
je TData 
jmp exit

exit: 
int 20h
end Tdata
