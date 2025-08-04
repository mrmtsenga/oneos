[BITS 16]
[ORG 0x7C00]


start:
    cli ; Clear interrupts
    mov ax, 0x00 ; Set up segment registers to zero
    mov ds, ax ; Set data segment to zero
    mov es, ax ; Set data segment to zero
    mov ss, ax ; Set stack segment to zero
    mov sp, 0x7c00 ; Set stack pointer to the top of the boot sector
    sti ; Enable interrupts
    mov si, msg ; Load address of message into SI


print:
    lodsb ; Load byte from DS:SI into AL and increment SI
    cmp al, 0 ; Check for null terminator
    je done ; If null, jump to done
    mov ah, 0x0E ; BIOS teletype output function
    int 0x10 ; Call BIOS interrupt to print character
    jmp print ; Jump back to print

done:
    cli
    hlt ; Halt the CPU


msg: db 'Welcome to oneOS', 0

times 510 - ($ - $$) db 0 ; Fill the rest of the boot sector with zeros


dw 0xAA55 ; Boot sector signature