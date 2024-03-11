
#include "common/register_addr.h"
#include "common/os_config.h"

        .global _start
        .extern irq_handler
        .extern os_init
        .extern  OSRunning
        .extern  OSTCBCur
        .extern  OSTCBHighRdy
        .extern  OSPrioCur
        .extern  OSPrioHighRdy
        .extern  OSIntCtxSwFlag

        .extern  OSIntEnter
        .extern  OSIntExit

        .extern  OSTaskSwHook

        .extern OSTimeTick 


        .global  OSStartHighRdy 
        .global  OSCtxSw
        .global  OS_IntCtxSw
        .global  OS_CPU_SaveSR
        .global  OS_CPU_RestoreSR

    .text

_start:
    mov r1, pc;
    ldr pc, [r1, r0, lsl#2]

    @ @异常任务分发数组，顺序固定
    .word   _os_init    @reset 异常
    .word   _undef_handler
    .word   _swi_handler
    .word   _prefetch_abort_handler
    .word   _data_abort_handler
    .word   _irq_handler
    .word   _fiq_handler


 



_os_init:
    mov r0, #0
    mov r1, r0
    mov r2, r0
    mov r3, r0
    mov r4, r0
    mov r5, r0
    mov r6, r0
    mov r7, r0
    mov r8, r0
    mov r9, r0
    mov r10, r0
    mov r11, r0
    mov r12, r0
    mov r14, r0

    bl os_init





_irq_handler:
    @ 告知ucos系统进入中断,以增加一次中断记录次数
    bl  OSIntEnter                      
    
    @打开中断
@     msr cpsr_c, #CPU_MODE_IRQ

    @执行中断服务程序
    bl irq_handler
    
    @关闭中断
@     msr cpsr_c, #(CPU_MASK_IRQ | CPU_MODE_IRQ)

    @告知ucos系统离开中断,以取消一次中断记录次数
    bl   OSIntExit           
    
    @判断是否需要进行任务切换
    @当完成所有中断服务程序时才判断是否执行任务切换
    ldr     R0,=OSIntCtxSwFlag              
    ldr     R1,[R0]
    cmp     R1,#1
    beq     OS_IntCtxSw                     
    
    @恢复cpu上下文
    pop {r0}
    msr spsr, r0    @恢复进入当前中断服务程序的任务的cpsr到irq的spsr
    ldmfd sp!, {r0-r12, pc}^    @恢复任务寄存器组或返回到上一次的中断服务程序


OS_IntCtxSw:
    @重置中断上下文切换标志
    ldr r0, =OSIntCtxSwFlag
    mov r1, #0
    str r1, [r0]

    @切换到svc模式获取任务栈指针
    mrs r0, cpsr
    msr cpsr_c, (CPU_MASK_IRQ | CPU_MODE_SVC)
    mov r1, sp
    msr cpsr, r0

    @将中断保存的上下文环境保存到任务栈中
    add r0, sp, #40 @r0->{r9, r10, r11, r12, pc}，r1指向当前任务的栈顶
    ldmfd r0!, {r3-r7} @保存中断栈中的寄存器
    stmfd r1!, {r3-r7} @保存到任务栈中
    add r0, sp, #20 @r0->{r4, r5, r6, r7, r8}，r1指向当前任务的栈顶
    ldmfd r0!, {r3-r7} @保存中断栈中的寄存器
    stmfd r1!, {r3-r7} @保存到任务栈中
    add r0, sp, #0 @r0->{spsr, r0, r1, r2, r3}，r1指向当前任务的栈顶
    ldmfd r0!, {r3-r7} @保存中断栈中的寄存器
    stmfd r1!, {r3-r7} @保存到任务栈中

    @清空当前irq栈中的内容
    add sp, #60

    @获取当前任务的TCB地址
    ldr r3, =OSTCBCur @OSTCBCur 符号的地址存储的是当前任务的TCB的地址
    ldr r0, [r3] @加载当前任务的TCB结构地址
    str r1, [r0] @更新当前任务的栈指针，(栈指针是TCB结构的第一个成员)

    @调用OSTaskSwHook函数,以在任务切换时执行一些特定的操作
    @必须在切换为svc模式前调用，不然之后的压栈会覆盖之前在svc中保存的上下文
@     bl      OSTaskSwHook

    @切换cpu模式为svc模式，并保持中断关闭,准备进行任务返回
    msr cpsr_c, (CPU_MASK_IRQ | CPU_MODE_SVC)   

    @更新当前任务优先级标志
    ldr r0,=OSPrioCur
    ldr r1,=OSPrioHighRdy
    ldrb r1,[r1]
    strb r1,[r0]

    @获取最高优先级任务的TCB地址
    ldr r0, =OSTCBHighRdy
    ldr r0, [r0] @加载最高优先级任务的TCB结构地址
    ldr sp, [r0] @加载最高优先级任务的栈顶指针

    @更换当前任务TCB为最高优先级TCB
    str r0, [r3] 

    @恢复cpu上下文
    pop {r0}
    msr spsr, r0    @恢复spsr,在最后模式返回的时候再将其拷贝到cpsr
    ldmfd sp!, {r0-r12, pc}^    @任务寄存器恢复，并将spsr拷贝到cpsr以回到之前的任务状态



OS_CPU_SaveSR:
        @保存cpsr到r0中，作为返回值传递给外部函数
        mrs r0, cpsr

        @关闭中断，进入临界区
        orr r1, r0, #CPU_MASK_IRQ
        msr cpsr_c, r1

        @读取cpsr判断中断是否关闭成功,不成功则重新执行
        mrs r1, cpsr
        and r1, r1, #CPU_MASK_IRQ
        cmp r1, #CPU_MASK_IRQ
        bne OS_CPU_SaveSR

        @关闭成功，直接返回
        mov pc, lr
                     

OS_CPU_RestoreSR:
        msr     cpsr,r0
        mov     pc,lr   


@外部调用者已做了临界区保护，关闭了中断
OSCtxSw:    @在svc模式中直接进行任务切换
        @保存当前任务的上下文环境到当前任务栈中
        stmfd   sp!,{r0-r12,lr}
        mrs r0, cpsr
        push {r0}

        
        @获取当前任务的TCB地址
        ldr r3, =OSTCBCur @OSTCBCur 符号的地址存储的是当前任务的TCB的地址
        ldr r0, [r3] @加载当前任务的TCB结构地址
        str sp, [r0] @更新当前任务的栈指针，(栈指针是TCB结构的第一个成员)


        @调用OSTaskSwHook函数,以在任务切换时执行一些特定的操作
        @ bl      OSTaskSwHook


        @更新当前任务优先级标志
        ldr r0,=OSPrioCur
        ldr r1,=OSPrioHighRdy
        ldrb r1,[r1]
        strb r1,[r0]

        @获取最高优先级任务的TCB地址
        ldr r0, =OSTCBHighRdy
        ldr r0, [r0] @加载最高优先级任务的TCB结构地址
        ldr sp, [r0] @加载最高优先级任务的栈顶指针

        @更新最高优先级任务TCB为当前任务TCB
        str r0, [r3]


        @恢复cpu上下文
        pop {r0}
        @将要调度的任务可能未关闭中断，所以要确保任务返回时中断关闭，
        @主要是系统自己的三个任务在初始化的时候cpsr没有关中断，但却在
        @此处调度，外部环境是
        @ orr r0, #CPU_MASK_IRQ   
        msr spsr, r0    @恢复spsr,在最后模式返回的时候再将其拷贝到cpsr
        ldmfd sp!, {r0-r12, pc}^    @任务寄存器恢复，并将spsr拷贝到cpsr以回到之前的任务状态


@进行第一个任务的上下文加载
OSStartHighRdy:

        @进行上下文切换的钩子函数调用
        bl      OSTaskSwHook                   

        @设置OSRunning标志，标志多任务已启动
        ldr     r0,=OSRunning                   
        mov     r1,#1
        strb    r1,[r0]

        @获取最高优先级任务的TCB地址
        ldr     r0,=OSTCBHighRdy               
        ldr r0, [r0] @加载最高优先级任务的TCB结构地址
        ldr sp, [r0] @加载最高优先级任务的栈顶指针

        @恢复cpu上下文，第一个任务被调度即会打开中断
        pop {r0}
        msr spsr, r0    @恢复spsr,在最后模式返回的时候再将其拷贝到cpsr
        ldmfd sp!, {r0-r12, pc}^    @任务寄存器恢复，并将spsr拷贝到cpsr以回到之前的任务状态
                     

_undef_handler:
        bl _undef_handler
_swi_handler:
        bl _swi_handler

_prefetch_abort_handler:
        bl _prefetch_abort_handler

_data_abort_handler:
        bl _data_abort_handler

_fiq_handler:
        bl _fiq_handler
